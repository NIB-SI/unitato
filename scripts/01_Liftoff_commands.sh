# sort GFF
bedtools sort -i ../input/StPGSC4.04n_ITAG-gene-model_2020-01-17.gff3 > ../input/StPGSC4.04n_ITAG-gene-model_2020-01-17_sorted.gff3;
bedtools sort -i ../input/StPGSC4.04n_PGSC-gene-model_2022-10-26.gff3 > ../input/StPGSC4.04n_PGSC-gene-model_2022-10-26_sorted.gff3;

# /home/administrator/conda2/envs/Liftoff1.6.3.original/lib/python3.9/site-packages/liftoff/
conda activate Liftoff1.6.3.original

a=(0.90);
s=(0.90);
flank=(0 500);


echo ${a[@]};
echo ${s[@]};
echo ${flank[@]};


#### ITAG
for i in "${a[@]}"
    do
        aa=$i
        for j in "${s[@]}"
            do
                ss=$j
                for k in "${flank[@]}"
                    do
                        fflank=$k
                        echo "Processing a:" ${aa} "s:" ${ss} "flank:" ${fflank}
                        liftoff -mm2_options="-x asm5" \
                        -g ../input/StPGSC4.04n_ITAG-gene-model_2020-01-17_sorted.gff3 \
                        -o ../output/ITAG_Liftoff_DMv6.1_a-${aa}_s-${ss}_flank-${fflank}_asm-int.gff3 \
                        -u ../output/ITAG_Liftoff_DMv6.1_a-${aa}_s-${ss}_flank-${fflank}_unmapped_features_asm-int.txt \
                        -dir ../output/ITAG_Liftoff_DMv6.1_input_files_asm-int \
                        -a $aa -s $ss -flank $fflank \
                        -p 24 \
                        -chroms ../input/chroms.txt \
                        -unplaced ../input/unplaced_DM404.txt \
                        ../../_A_22_DMv404vs61_Liftoff1.6.3_INTflank/input/DM_1-3_516_R44_potato_genome_assembly.v6.1.fasta \
                        ../../_A_22_DMv404vs61_Liftoff1.6.3_INTflank/input/StPGSC4.04n_2018-01-18_oneliner.fasta > ../output/ITAG_Liftoff_DMv6.1_a-${aa}_s-${ss}_flank-${fflank}_log_asm-flank.txt 2>&1;
                        # rm -r ../output/ITAG_Liftoff_DMv6.1_input_files_asm-int;
                    done
            done
    done;

#### PGSC
for i in "${a[@]}"
    do
        aa=$i
        for j in "${s[@]}"
            do
                ss=$j
                for k in "${flank[@]}"
                    do
                        fflank=$k
                        echo "Processing a:" ${aa} "s:" ${ss} "flank:" ${fflank}
                        liftoff -mm2_options="-x asm5" \
                        -g ../input/StPGSC4.04n_PGSC-gene-model_2022-10-26_sorted.gff3 \
                        -o ../output/PGSC_Liftoff_DMv6.1_a-${aa}_s-${ss}_flank-${fflank}_asm-int.gff3 \
                        -u ../output/PGSC_Liftoff_DMv6.1_a-${aa}_s-${ss}_flank-${fflank}_unmapped_features_asm-int.txt \
                        -dir ../output/PGSC_Liftoff_DMv6.1_input_files_asm-int \
                        -a $aa -s $ss -flank $fflank \
                        -p 24 \
                        -chroms ../input/chroms.txt \
                        -unplaced ../input/unplaced_DM404.txt \
                        ../../_A_22_DMv404vs61_Liftoff1.6.3_INTflank/input/DM_1-3_516_R44_potato_genome_assembly.v6.1.fasta \
                        ../../_A_22_DMv404vs61_Liftoff1.6.3_INTflank/input/StPGSC4.04n_2018-01-18_oneliner.fasta > ../output/PGSC_Liftoff_DMv6.1_a-${aa}_s-${ss}_flank-${fflank}_log_asm-flank.txt 2>&1;
                        # rm -r ../output/PGSC_Liftoff_DMv6.1_input_files_asm-int;
                    done
            done
    done;

conda deactivate

rm ../input/*.gff3_db;
rm ../input/*_sorted.gff3;

zip ../input/StPGSC4.04n_ITAG-gene-model_2020-01-17.gff3.zip ../input/StPGSC4.04n_ITAG-gene-model_2020-01-17.gff3;
zip ../input/StPGSC4.04n_PGSC-gene-model_2022-10-26.gff3.zip ../input/StPGSC4.04n_PGSC-gene-model_2022-10-26.gff3;


rm ../input/*gff3

zip -r -s 100m ../input/DM_1-3_516_R44_potato_genome_assembly.v6.1.fasta.zip ../input/DM_1-3_516_R44_potato_genome_assembly.v6.1.fasta;
zip -r -s 100m ../input/StPGSC4.04n_2018-01-18_oneliner.fasta.zip ../input/StPGSC4.04n_2018-01-18_oneliner.fasta;
rm ../input/*fasta
