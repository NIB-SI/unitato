/*
 * Index  genome
 */
process index_genome {
    //cache 'lenient'
    conda "$baseDir/env/STAR.yaml"
     
    input:
        tuple path(reference_gtf), path(genome)
 
    output:
        path("STAR_genome_index")
 
    script:
    """
    STAR --runMode genomeGenerate \
    --runThreadN 12 \
    --genomeDir STAR_genome_index \
    --genomeFastaFiles $genome \
    --genomeSAindexNbases 13 \
    --sjdbGTFfile $reference_gtf 
    """
}

/*
 * Download fastq
 */
process download_fastq {
    maxForks 20
    cache 'lenient'
    //cache 'lenient'
    conda "/proj/etools/conda/envs/sra-tools"
     
    input:
        tuple val(sra_id), val(sra_exp)
 
    output:
        tuple val(sra_exp), path("*1.fastq"), path("*2.fastq")
 
    script:
    """
    fasterq-dump --split-files ${sra_id}
    """
}
// with gtf --sjdbGTFfile $reference_gtf 
/*
 * Map short reads to reference transcriptome
 */
process map_short_to_reference {
    maxForks 10
    cache 'lenient'
    conda "$baseDir/env/STAR.yaml"

     publishDir(
        path: "${params.publish_dir}/STAR_quant",
    )
     
    input:
    tuple path(genome_index), path(gtf), path(reference_genome_fai),
          val(id), path(read1), path(read2)
 
    output:
        tuple val(id),
              path("$id/*bam")

    script:
    """
        read_id=\$(echo "$read1" | cut -d'_' -f1)
        STAR --genomeDir $genome_index \
        --readFilesIn $read1 \
                      $read2 \
        --outSAMtype BAM SortedByCoordinate \
        --runThreadN 12 \
        --quantMode GeneCounts \
        --alignIntronMin 20 \
        --alignIntronMax 10000 \
        --outFileNamePrefix $id/\$read_id
    """
}

// with gtf --sjdbGTFfile $reference_gtf 
/*
 * Quantify gene expression with feature Counts
 */
process run_featureCounts {
    maxForks 10
    cache 'lenient'
    conda "/users/nadjafn/.conda/envs/subread"

     publishDir(
        path: "${params.publish_dir}/FeatureCounts",
    )
     
    input:
    tuple val(id),
          path(bam_list),
          path(gff)
 
    output:
        tuple val(id), path("*_multimap_fraction_counts.txt")
     

    script:
    """
    featureCounts \
	    -T 16 \
	    -p \
	    -a $gff \
	    -B \
	    -M \
	    --fraction \
	    -o ${id}_multimap_fraction_counts.txt \
	    -s 2 \
	    $bam_list
    """
}

/*
 * Merge bam files per sample
 */
process merge_bam {
    conda "$baseDir/env/STAR.yaml"

     publishDir(
        path: "${params.publish_dir}/aligned_bams_merged",
    )
     
    input:
    tuple val(id),
          path(bam_list)
 
    output:
        tuple val(id),
              path("$id*bam"),
              path("$id*bam.bai")
 
    script:
    """
    samtools merge ${id}_merged.bam $bam_list
    samtools index ${id}_merged.bam
    """
}

/*
 * get bigwig 
 */
process get_bigwig {
    
     publishDir(
        path: "${params.publish_dir}/bigwig",
    )
     
    input:
    tuple val(id),
          path(bam),
          path(bam_bai)
 
    output:
          path("${id}_coverage.bw")
 
    script:
    """
    bamCoverage -b $bam -o ${id}_coverage.bw
    """
}


reference_genome = Channel.fromPath(params.reference_genome)
reference_genome_fai = Channel.fromPath(params.reference_genome_fai)
reference_gtf = Channel.fromPath(params.reference_gtf)
reference_gtf_FC = Channel.fromPath(params.reference_gtf_FC)

// RNA-Seq of potato (Solanum phureja) Illumina Paired-end library PE_BV_P_M
// Solanum tuberosum strain:DM1-3 516 R44 Genome sequencing and assembly
// SRA sudy SRP005965
ids_SRP005965 = Channel.of("SRR122129", "SRR122113", "SRR122109", "SRR122122", "SRR122108", "SRR122124", "SRR122139")
// # STAR error "SRR122133", 
// RNA-seq of pistil: diploid potato
ids_SRP141363 = Channel.of("SRR7047512")

// SRP180310
// Solanum phureja lines contrasting by resistant to nematode
// make packes of 10 to avoid SRA to many requests
ids_SRP180310 = Channel.of("SRR8457030", "SRR8457032", "SRR8457033", "SRR8457034", "SRR8457035", "SRR8457038", "SRR8457046", "SRR8457040", "SRR8457041", "SRR8457049", "SRR8457055", "SRR8457057", "SRR8457058", "SRR8457059", "SRR8457036", "SRR8457037", "SRR8457031", "SRR8457042", "SRR8457039", "SRR8457047", "SRR8457044", "SRR8457045", "SRR8457052", "SRR8457053", "SRR8457054", "SRR8457056", "SRR8457050", "SRR8457048", "SRR8457043", "SRR8457051")

// SRP222783
// Transcriptomes of in vitro young leaves in eleven potato landraces
ids_SRP222783 = Channel.of("SRR10153126")

// SRP321011
// RNAseq of certified, and informal potato seed tubers in the province of Antioquia
ids_SRP321011 =  Channel.of("SRR14627805", "SRR14627804")

// SRP350333
// RNAseq of S. tuberosum and S. phureja seed-tubers
ids_SRP350333 = Channel.of("SRR17202515", "SRR17202514", "SRR17202513", "SRR17202512")

// SRP350981
// The contribution of gene expression to anthocyanin diversity in potato landraces (Solanum tuberosum L. Phureja)
ids_SRP350981 = Channel.of("SRR17244298", "SRR17244297", "SRR17244286", "SRR17244275", "SRR17244267", "SRR17244266", "SRR17244265", "SRR17244264", "SRR17244263" , "SRR17244296", "SRR17244295", "SRR17244294", "SRR17244293", "SRR17244292", "SRR17244291", "SRR17244290", "SRR17244289", "SRR17244288" , "SRR17244285", "SRR17244284", "SRR17244283", "SRR17244282", "SRR17244281", "SRR17244280", "SRR17244279", "SRR17244278", "SRR17244277", "SRR17244274", "SRR17244273", "SRR17244272", "SRR17244271", "SRR17244270", "SRR17244269", "SRR17244268", "SRR17244262","SRR17244287", "SRR17244276")


workflow{
    SRP350333 = ids_SRP350333
                .combine(['SRP350333'])
    SRP321011 = ids_SRP321011
                .combine(['SRP321011'])
    SRP141363 = ids_SRP141363
                .combine(['SRP141363'])
    SRP222783 = ids_SRP222783
                .combine(['SRP222783'])
    SRP350981 = ids_SRP350981
                .combine(['SRP350981'])
    SRP180310 = ids_SRP180310
                .combine(['SRP180310'])
    SRP005965 = ids_SRP005965
                .combine(['SRP005965'])
  
    samples =  SRP005965.concat(SRP141363)
                        .concat(SRP180310)
                        .concat(SRP222783)
                        .concat(SRP321011)
                        .concat(SRP350333)
                        .concat(SRP350981)
    downloaded = download_fastq(samples)

    reference = reference_gtf.combine(reference_genome)
    indexed_genome = index_genome(reference)
    indexed_genome = indexed_genome.combine(reference_gtf).combine(reference_genome_fai).combine(downloaded)
    alignments = map_short_to_reference(indexed_genome)
    alignments.view()
    alignments_grouped = alignments.groupTuple()
    run_featureCounts(alignments_grouped.combine(reference_gtf_FC))
    merged_bam = merge_bam(alignments_grouped)

    get_bigwig(merged_bam)
}
