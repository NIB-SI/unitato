conda activate UniTato
minimap2 --version
# 2.24-r1122

cd input
wget PATHTO/stCuSTr-D_cds_representatives.fasta
wget PATHTO/stCuSTr-P_cds_representatives.fasta
wget PATHTO/stCuSTr-R_cds_representatives.fasta

cd ../scripts
ll ../../_A_41_modelCuration-Liftoff/input/DM_1-3_516_R44_potato_genome_assembly.v6.1.fasta

## https://github.com/lh3/minimap2/blob/master/cookbook.md#genome-aln
## https://lh3.github.io/minimap2/minimap2.html
### --eqx 	Output =/X CIGAR operators for sequence match/mismatch.
### --end-bonus INT 	Score bonus when alignment extends to the end of the query sequence [0].
### -p FLOAT 	Minimal secondary-to-primary score ratio to output secondary mappings [0.8]. Between two chains overlaping over half of the shorter chain (controlled by -M), the chain with a lower score is secondary to the chain with a higher score. If the ratio of the scores is below FLOAT, the secondary chain will not be outputted or extended with DP alignment later. This option has no effect when -X is applied.
### asm5 	Long assembly to reference mapping (-k19 -w19 -U50,500 --rmq -r100k -g10k -A1 -B19 -O39,81 -E3,1 -s200 -z200 -N50). Typically, the alignment will not extend to regions with 5% or higher sequence divergence. Only use this preset if the average divergence is far below 5%. 
# option "--cs" is recommended as paftools.js may need it
# Use -a instead of -c to get output in the SAM format.
# Long-read alignment with CIGAR:     minimap2 -a...
# Long-read overlap without CIGAR:    minimap2 -x

mkdir ../output/minimap2

minimap2 --end-bonus 5 --eqx -N 50 -p 0.8 -ax asm5 -t 28 \
--cs ../../_A_41_modelCuration-Liftoff/input/DM_1-3_516_R44_potato_genome_assembly.v6.1.fasta \
../input/stCuSTr-R_cds_representatives.fasta > ../output/minimap2/R_cds_rep_v6.1.sam;

tail ../output/minimap2/R_cds_rep_v6.1.sam;


minimap2 --end-bonus 5 --eqx -N 50 -p 0.8 -ax asm5 -t 28 \
--cs ../../_A_41_modelCuration-Liftoff/input/DM_1-3_516_R44_potato_genome_assembly.v6.1.fasta \
../input/stCuSTr-P_cds_representatives.fasta > ../output/minimap2/P_cds_rep_v6.1.sam;

minimap2 --end-bonus 5 --eqx -N 50 -p 0.8 -ax asm5 -t 28 \
--cs ../../_A_41_modelCuration-Liftoff/input/DM_1-3_516_R44_potato_genome_assembly.v6.1.fasta \
../input/stCuSTr-D_cds_representatives.fasta > ../output/minimap2/D_cds_rep_v6.1.sam;

samtools --version
#samtools 1.9-210-g72d140b
#Using htslib 1.9-437-g71d8683
#Copyright (C) 2019 Genome Research Ltd.


samtools view -S -b ../output/minimap2/D_cds_rep_v6.1.sam > ../output/minimap2/D_cds_rep_v6.1.bam;
samtools view -S -b ../output/minimap2/P_cds_rep_v6.1.sam > ../output/minimap2/P_cds_rep_v6.1.bam;
samtools view -S -b ../output/minimap2/R_cds_rep_v6.1.sam > ../output/minimap2/R_cds_rep_v6.1.bam;

bedtools bamtobed -i ../output/minimap2/D_cds_rep_v6.1.bam > ../output/minimap2/D_cds_rep_v6.1.bed;
bedtools bamtobed -i ../output/minimap2/P_cds_rep_v6.1.bam > ../output/minimap2/P_cds_rep_v6.1.bed;
bedtools bamtobed -i ../output/minimap2/R_cds_rep_v6.1.bam > ../output/minimap2/R_cds_rep_v6.1.bed;


# https://github.com/lh3/minimap2/issues/455


# https://github.com/NBISweden/AGAT.git
conda install -c bioconda agat
# https://agat.readthedocs.io/en/latest/tools/agat_convert_minimap2_bam2gff.html
agat_convert_minimap2_bam2gff.pl --help
agat_convert_minimap2_bam2gff.pl -i ../output/minimap2/R_cds_rep_v6.1.bam -o ../output/minimap2/R_cds_rep_v6.1.gff
agat_convert_bed2gff.pl --help
agat_convert_bed2gff.pl --bed ../output/minimap2/R_cds_rep_v6.1.bed > ../output/minimap2/R_cds_rep_v6.1.gff;
agat_convert_bed2gff.pl --bed ../output/minimap2/P_cds_rep_v6.1.bed > ../output/minimap2/P_cds_rep_v6.1.gff;
agat_convert_bed2gff.pl --bed ../output/minimap2/D_cds_rep_v6.1.bed > ../output/minimap2/D_cds_rep_v6.1.gff;

#stu_CuSTr-Desiree_cds_main
#(n) [nseq: 57943]
wc -l ../output/minimap2/D_cds_rep_v6.1.gff
## 28759 
#stu_CuSTr-PW363_cds_main
#(n) [nseq: 43883]
wc -l ../output/minimap2/P_cds_rep_v6.1.gff
## 23612
#stu_CuSTr-Rywal_cds_main
#(n) [nseq: 36336]
wc -l ../output/minimap2/R_cds_rep_v6.1.gff
## 20971


cd ../input
wget PATHTO/stCuSTr-D_tr_representatives.fasta
wget PATHTO/stCuSTr-P_tr_representatives.fasta
wget PATHTO/stCuSTr-R_tr_representatives.fasta


cd ../scripts

minimap2 --end-bonus 5 --eqx -N 50 -p 0.8 -ax asm5 -t 28 \
--cs ../../_A_41_modelCuration-Liftoff/input/DM_1-3_516_R44_potato_genome_assembly.v6.1.fasta \
../input/stCuSTr-R_tr_representatives.fasta > ../output/minimap2/R_tr_rep_v6.1.sam;

minimap2 --end-bonus 5 --eqx -N 50 -p 0.8 -ax asm5 -t 28 \
--cs ../../_A_41_modelCuration-Liftoff/input/DM_1-3_516_R44_potato_genome_assembly.v6.1.fasta \
../input/stCuSTr-P_cds_representatives.fasta > ../output/minimap2/P_tr_rep_v6.1.sam;

minimap2 --end-bonus 5 --eqx -N 50 -p 0.8 -ax asm5 -t 28 \
--cs ../../_A_41_modelCuration-Liftoff/input/DM_1-3_516_R44_potato_genome_assembly.v6.1.fasta \
../input/stCuSTr-D_tr_representatives.fasta > ../output/minimap2/D_tr_rep_v6.1.sam;


samtools view -S -b ../output/minimap2/D_tr_rep_v6.1.sam > ../output/minimap2/D_tr_rep_v6.1.bam;
samtools view -S -b ../output/minimap2/P_tr_rep_v6.1.sam > ../output/minimap2/P_tr_rep_v6.1.bam;
samtools view -S -b ../output/minimap2/R_tr_rep_v6.1.sam > ../output/minimap2/R_tr_rep_v6.1.bam;

bedtools bamtobed -i ../output/minimap2/D_tr_rep_v6.1.bam > ../output/minimap2/D_tr_rep_v6.1.bed;
bedtools bamtobed -i ../output/minimap2/P_tr_rep_v6.1.bam > ../output/minimap2/P_tr_rep_v6.1.bed;
bedtools bamtobed -i ../output/minimap2/R_tr_rep_v6.1.bam > ../output/minimap2/R_tr_rep_v6.1.bed;

agat_convert_bed2gff.pl --bed ../output/minimap2/R_tr_rep_v6.1.bed > ../output/minimap2/R_tr_rep_v6.1.gff;
agat_convert_bed2gff.pl --bed ../output/minimap2/P_tr_rep_v6.1.bed > ../output/minimap2/P_tr_rep_v6.1.gff;
agat_convert_bed2gff.pl --bed ../output/minimap2/D_tr_rep_v6.1.bed > ../output/minimap2/D_tr_rep_v6.1.gff;

wc -l ../output/minimap2/D_cds_rep_v6.1.gff;
# 28759
wc -l ../output/minimap2/D_tr_rep_v6.1.gff;
# 44929

wc -l ../output/minimap2/P_cds_rep_v6.1.gff;
# 23612
wc -l ../output/minimap2/P_tr_rep_v6.1.gff;
# 23612 

wc -l ../output/minimap2/R_cds_rep_v6.1.gff;
# 20971
wc -l ../output/minimap2/R_tr_rep_v6.1.gff;
# 28567

mapfile -t arr1 < <(find ../output/minimap2/ -type f -name 'D_tr_rep_v6.1.gff' | sort);
mapfile -t arr2 < <(find ../output/minimap2/ -type f -name 'P_tr_rep_v6.1.gff' | sort);
mapfile -t arr4 < <(find ../output/minimap2/ -type f -name 'R_tr_rep_v6.1.gff' | sort);
mapfile -t arr3 < <(find ../../_A_42_modelCuration-Bedtools/input/ -type f -name '*DM_1-3_516_R44_potato.v6.1.working_models_genes_sorted.gff3' | sort);

for ((i=0; i<"${#arr1[@]}"; i++)); do
    printf "Listing file paths:\n %s\n %s\n %s\n %s\n" "${arr1[i]}" "${arr2[i]}" "${arr4[i]}" "${arr3[i]}"
    printf '####\n'
done;

mkdir ../output/minimap2/bedtools/;


tail -n +2 ../output/minimap2/D_tr_rep_v6.1.gff | sponge ../output/minimap2/D_tr_rep_v6.1.gff
tail -n +2 ../output/minimap2/P_tr_rep_v6.1.gff | sponge ../output/minimap2/P_tr_rep_v6.1.gff
tail -n +2 ../output/minimap2/R_tr_rep_v6.1.gff | sponge ../output/minimap2/R_tr_rep_v6.1.gff

for ((i=0; i<"${#arr1[@]}"; i++))
    do
        bn=$(basename "${arr1[i]}")
        echo 'File used: ' $bn
        bedtools sort -i "${arr1[i]}" > ../output/minimap2/sorted_$bn
    done

for ((i=0; i<"${#arr2[@]}"; i++))
    do
        bn=$(basename "${arr2[i]}")
        echo 'File used: ' $bn
        bedtools sort -i "${arr2[i]}" > ../output/minimap2/sorted_$bn
    done

for ((i=0; i<"${#arr4[@]}"; i++))
    do
        bn=$(basename "${arr4[i]}")
        echo 'File used: ' $bn
        bedtools sort -i "${arr4[i]}" > ../output/minimap2/sorted_$bn
    done


mapfile -t arr1 < <(find ../output/minimap2/ -type f -name 'sorted_D_tr_rep_v6.1.gff' | sort);
mapfile -t arr2 < <(find ../output/minimap2/ -type f -name 'sorted_P_tr_rep_v6.1.gff' | sort);
mapfile -t arr4 < <(find ../output/minimap2/ -type f -name 'sorted_R_tr_rep_v6.1.gff' | sort);



F=(0.35 1.00);
echo "${F[@]}";

for ((i=0; i<"${#arr1[@]}"; i++))
    do
        bn1=$(basename "${arr1[i]}")
        bn2=$(basename "${arr2[i]}")
        bn3=$(basename "${arr4[i]}")
        echo 'Files used: ' $bn1 $bn2 $bn3
        for j in "${F[@]}"
            do
                ff=$j
                echo 'Minimum overlap: ' $ff
                bedtools intersect -wa -wb \
                -nonamecheck \
                -F $ff \
                -header -filenames \
                -b ${arr1[i]} ${arr2[i]} ${arr4[i]} \
                -a "${arr3[0]}" \
                -sorted -sortout > ../output/minimap2/bedtools/${i}_out_F-${ff}_intersect_3cv_DM_1-3_516_R44_potato.v6.1.working_models_genes.txt;
                bedtools intersect -wa -wb \
                -nonamecheck \
                -F $ff -v \
                -header -filenames \
                -b ${arr1[i]} ${arr2[i]} \
                -a "${arr3[0]}" \
                -sorted -sortout > ../output/minimap2/bedtools/${i}_no-overlap_F-${ff}_intersect_3cv_DM_1-3_516_R44_potato.v6.1.working_models_genes.txt;
            done
    done;
