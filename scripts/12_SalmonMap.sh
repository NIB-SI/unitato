### Create conda environment with salmon v1.10.2 (must be =>v1!)

conda create --name salmon
conda activate salmon
conda install --channel bioconda salmon=1.10.2

### Prepare DMv6.1 reference fasta (same as UniTato.fa) along with UniTato and DMv6 transcript fasta and gtf/gff annotation files

mkdir ./ref

# UniTato genome fasta
gzip -d ./ref/UniTato.fa.gz

# UniTato gtf annotation
gzip -d ./ref/UniTato.gtf.gz

# DMv6 cDNA fasta of working gene models
gzip -d ./ref/DM_1-3_516_R44_potato.v6.1.working_models.cdna.fa.gz

# DMv6 gff annotation with working gene models
gzip -d ./ref/DM_1-3_516_R44_potato.v6.1.working_models.gff3.gz

# Extract UniTato transcript fasta with gffread from UniTato fasta and gtf
gffread -w ./ref/unitato_transcripts.fa -g ./ref/UniTato.fa ./ref/UniTato.gtf


### Prepare a list of decoy (genome) sequences, used in selective alignment salmon mode

grep "^>" ./ref/UniTato.fa | cut -d " " -f 1 > ./ref/decoys.txt
sed -i.bak -e 's/>//g' ./ref/decoys.txt


### Mapping with salmon to DMv6 working models

mkdir ./DMv6_map

# Concatenate genome and transcript fasta
cat ./ref/DM_1-3_516_R44_potato.v6.1.working_models.cdna.fa ./ref/UniTato.fa > ./ref/DMv6_gentr.fa

# Create salmon index

mkdir ./DMv6_map/index

salmon index -t ./ref/DMv6_gentr.fa -d ./ref/decoys.txt -p 60 -i ./DMv6_map/index --keepDuplicates

# Salmon quant

mkdir ./DMv6_map/output

for i in $(ls ./seq_data/ | sed s/_[12].fastq.gz// | sort -u)	
do salmon quant \
	-i ./DMv6_map/index \
	-l ISR \
	-1 ./seq_data/${i}_1.fastq.gz  \
	-2 ./seq_data/${i}_2.fastq.gz \
	--validateMappings \
	-o ./DMv6_map/output/${i}
done


### Mapping with salmon to UniTato

mkdir ./UniTato_map

# Concatenate genome and transcript fasta
cat ./ref/unitato_transcripts.fa ./ref/UniTato.fa > ./ref/UniTato_gentr.fa

# Create salmon index

mkdir ./UniTato_map/index

salmon index -t ./ref/UniTato_gentr.fa -d ./ref/decoys.txt -p 60 -i ./UniTato_map/index --keepDuplicates

# Salmon quant

mkdir ./UniTato_map/output

for i in $(ls ./seq_data/ | sed s/_[12].fastq.gz// | sort -u)	
do salmon quant \
	-i ./UniTato_map/index \
	-l ISR \
	-1 ./seq_data/${i}_1.fastq.gz  \
	-2 ./seq_data/${i}_2.fastq.gz \
	--validateMappings \
	-o ./UniTato_map/output/${i}
done