### nextflow script to map long reads RNA 
### (ISOSEQ and ONT) to v4v6 UNITATO reference genome
### to run without nextflow just run script with bash and replace parameters

minimap2 --version
# v2.26

nextflow --version
# version 23.04.1

/* 
 * pipeline input parameters 
 */

params.long_read_dir = "{params.input_dir}/{rywal_ISOSEQ, avenger_ISOSEQ,colamba_ISOSEQ,spunta_ISOSEQ,altus_ISOSEQ,PRJNA612026_ONT}/"
params.reference_genome = "{params.input_dir}/DM_1-3_516_R44_potato_genome_assembly.v6.1.fasta"
params.reference_genome_fai = "{params.input_dir}/DM_1-3_516_R44_potato_genome_assembly.v6.1.fasta.fai"
params.publish_dir = './results'
log.info """\
         long-read RNA mapping   P I P E L I N E    
         ===================================
         reference_genome: ${params.reference_genome}
         reads           : ${params.long_read_dir}
         outdir          : ${params.publish_dir}
         """
         .stripIndent()

/*
 * Merge the all fastq files per directory to map all at once
 */
process merge_fastq {
     
    input:
     path(readdir)
 
    output:
    path "${readdir}.fastq.gz"

    script:
    """
    cat ${readdir}/*fastq.gz > ${readdir}.fastq.gz
    """
}

/*
 * Run minimap2 to align long reads reads to reference
 */
process quantification {
    debug true
    conda "$baseDir/env/minimap2.yaml"
     publishDir(
        path: "${params.publish_dir}/Aligned_bam/",
        mode: 'copy',
    )
     
    input:
    tuple val(read_name), path(read), path(reference_genome), path(reference_genome_fai), path(gtf)
 
    output:
    tuple val(read_name), 
             path("${read_name}_aligned_sorted.bam"), 
             path("${read_name}_aligned_sorted.bam.bai")
    script:
    """
    if [[ ${read_name} == *"ONT"* ]]; then
        echo "run minimap for Nanopore 2D cDNA-seq"
        minimap2 -ax splice -G 10000 -L $reference_genome $read > ${read_name}_aligned.sam  #Nanopore 2D cDNA-seq
    elif [[ ${read_name} == *"ISOSEQ"* ]]; then
        echo "run minimap for ISOSEQ"
        minimap2 -ax splice:hq -G 10000 -L -uf $reference_genome $read > ${read_name}_aligned.sam  # PacBio Iso-seq/traditional cDNA
    else 
        printf '%s\n' "Make sure that readname is either *_ONT or *_ISOSEQ" >&2  # write error message to stderr
        exit 1
    fi
    # convert to bam and index
    samtools view -bS ${read_name}_aligned.sam > ${read_name}_aligned.bam
    samtools sort ${read_name}_aligned.bam > ${read_name}_aligned_sorted.bam
    samtools index ${read_name}_aligned_sorted.bam 
    
    """
    
}

// create channels from input files
long_reads = Channel.fromPath(params.long_read_dir, type: 'dir')
reference_genome = Channel.fromPath(params.reference_genome)
reference_genome_fai = Channel.fromPath(params.reference_genome_fai)
long_reads.view()

workflow {
    // merge fastq files 
    merged_fastq = merge_fastq(long_reads)
    combined_reads = merged_fastq
    // get read names from filenames
    reads_with_names = combined_reads
                        .map { file -> tuple(file.baseName, file) }
    // create channel with reference and reads
    reads_with_reference = reads_with_names
                            .combine(reference_genome)
                            .combine(reference_genome_fai)
                            .combine(reference_gtf)
    // align long reads to reference fasta
    aligned_bam = quantification(reads_with_reference)


