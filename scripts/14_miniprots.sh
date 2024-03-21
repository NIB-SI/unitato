$conda activate unitato

$conda install bioconda::miniprot
miniprot --version
# 0.13-r248

$wget http://lifenglab.hzau.edu.cn/Nicomics/Download/NbeHZ1/NbeHZ1_proteome_1.0.fa
$wget http://lifenglab.hzau.edu.cn/Nicomics/Download/NtaSR1/NtaSR1_proteome_1.0.fa
$wget https://www.arabidopsis.org/download_files/Proteins/Araport11_protein_lists/Araport11_pep_20220914_representative_gene_model.gz
$wget https://solgenomics.net/ftp/tomato_genome/annotation/ITAG4.1_release/ITAG4.1_proteins.fasta
$wget https://unitato.nib.si/downloads/files/UniTato.fa.gz
$wget https://unitato.nib.si/downloads/files/UniTato.gff.gz

# gunzip files



$wget https://github.com/lh3/miniprot/raw/master/test/DPP3-mm.pep.fa.gz
$wget wget https://github.com/lh3/miniprot/raw/master/test/DPP3-hs.gen.fa.gz
# gzip -dk files



# test set
## $miniprot ./input/DPP3-hs.gen.fa.gz ./input/DPP3-mm.pep.fa.gz > ./output/aln.paf        # PAF output
## $miniprot --gff ./input/DPP3-hs.gen.fa.gz ./input/DPP3-mm.pep.fa.gz > ./output/aln.gff  # GFF3+PAF output

# The detailed alignment is embedded in ##PAF lines in the GFF3 output. 
# You can also get detailed residue alignment with --aln.
# If you are aligning proteins to a whole genome, it is recommended to add option -I to let 
## miniprot automatically set the maximum intron size. 
# You can also use -G to explicitly specify the max intron size.
# default output doesnt show IDs
# also, new version available
# plus https://github.com/lh3/miniprot/issues/18
## --gff-delim
# does not solve the issue


# https://github.com/lh3/miniprot/issues/22
## The default of miniprot is tuned for the human genome. For small genomes, it is recommended to set the max intron size to a smaller number with -G
# Use -j1 for plants and fungi
# https://lh3.github.io/miniprot/miniprot.html
# -O INT 	Gap open penalty [11]
# -E INT 	Gap extension penalty [1]. A gap of size g costs {-O}+{-E}*g.
# -J INT 	Intron open penalty [29]
# -F INT 	Penalty for frameshifts or in-frame stop codons [23] 
# -G NUM 	Max intron size [200k]. This option overrides -I.
## existence of introns larger than 5 kb or even 10 kb in Arabidopsis
# -M INT 	Sample k-mers at a rate 1/2**INT [1]. Increasing this option reduces peak memory but decreases sensitivity.
# -L INT 	Minimum ORF length to index [30] 
# --gff-only 	Output in the GFF3 format without ‘##PAF’ lines.
# --gff-delim CHAR
## Change the ID field in GFF3 to QueryNameCHARHitIndex []. If not specified, the default ID looks like ‘MP000012’. This option is only applicable to the GFF3 output format.


$miniprot -G 100 -O 10 -J 34 -F 30 -j1 -M0 --gff-only -ut64 ../input/UniTato.fa ../input/Araport11_pep_20220914_representative_gene_model > ../output/Araport11-only.gff
$miniprot -G 100 -O 10 -J 34 -F 30 -j1 -M0 --gff-only -ut64 ../input/UniTato.fa ../input/ITAG4.1_proteins.fasta > ../output/ITAG4.1-only.gff;
$miniprot -G 100 -O 10 -J 34 -F 30 -j1 -M0 --gff-only -ut64 ../input/UniTato.fa ../input/NbeHZ1_proteome_1.0.fa > ../output/NbeHZ1-only.gff;
$miniprot -G 100 -O 10 -J 34 -F 30 -j1 -M0 --gff-only -ut64 ../input/UniTato.fa ../input/NtaSR1_proteome_1.0.fa > ../output/NtaSR1-only.gff;


