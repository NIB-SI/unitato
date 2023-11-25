awk -F'\t' '$3=="gene"' ../../_A_41_modelCuration-Liftoff/output/ITAG_Liftoff_DMv6.1_a-0.90_s-0.90_flank-0_asm-int.gff3 > ../input/ITAG_Liftoff_DMv6.1_a-0.90_s-0.90_flank-0_asm-int_genes.gff3;
awk -F'\t' '$3=="gene"' ../../_A_41_modelCuration-Liftoff/output/ITAG_Liftoff_DMv6.1_a-0.90_s-0.90_flank-500_asm-int.gff3 > ../input/ITAG_Liftoff_DMv6.1_a-0.90_s-0.90_flank-500_asm-int_genes.gff3;
awk -F'\t' '$3=="gene"' ../../_A_41_modelCuration-Liftoff/output/PGSC_Liftoff_DMv6.1_a-0.90_s-0.90_flank-0_asm-int.gff3 > ../input/PGSC_Liftoff_DMv6.1_a-0.90_s-0.90_flank-0_asm-int_genes.gff3;
awk -F'\t' '$3=="gene"' ../../_A_41_modelCuration-Liftoff/output/PGSC_Liftoff_DMv6.1_a-0.90_s-0.90_flank-500_asm-int.gff3 > ../input/PGSC_Liftoff_DMv6.1_a-0.90_s-0.90_flank-500_asm-int_genes.gff3;


mapfile -t arr1 < <(find ../input/ -type f -name 'ITAG*a-0.90_s-0.90_flank*.gff3' | sort);
mapfile -t arr2 < <(find ../input/ -type f -name 'PGSC*a-0.90_s-0.90_flank*.gff3' | sort);
mapfile -t arr3 < <(find ../input/ -type f -name '*DM_1-3_516_R44_potato.v6.1.working_models_genes_sorted.gff3' | sort);


for ((i=0; i<"${#arr1[@]}"; i++)); do
    printf "Listing file paths:\n %s\n %s\n %s\n" "${arr1[i]}" "${arr2[i]}" "${arr3[i]}"
    printf '####\n'
done;

head "${arr1[0]}"

for ((i=0; i<"${#arr1[@]}"; i++))
    do
        printf "WIll be using Files:\n %s\n %s\n %s\n\n" $(basename "${arr1[i]}") $(basename "${arr2[i]}") $(basename "${arr3[i]}")
        
    done;


mkdir ../output/bedtools_ITAG_and_PGSC/;
mkdir ../output/bedtools_v6v6/;



#################################################
# for ITAG & PGSC vs DM_1-3_516_R44_potato.v6.1 #
#################################################


bn=$(basename "${arr1[0]}");
echo $bn;



touch ../output/file-combo.txt
for ((i=0; i<"${#arr1[@]}"; i++))
    do
        bn1=$(basename "${arr1[i]}")
        bn2=$(basename "${arr2[i]}")
        echo 'Files used: ' $bn1 $bn2 >> ../output/file-combo.txt
    done;

F=(0.0001 0.001 0.01 0.1 0.15 0.2 0.25 0.3 0.33 0.35 0.40 0.41 0.42 0.43 0.44 0.45 0.46 0.47 0.48 0.49 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 0.96 0.97 0.98 0.99 1.00);
echo "${F[@]}";


for ((i=0; i<"${#arr1[@]}"; i++))
    do
        bn=$(basename "${arr1[i]}")
        echo 'File used: ' $bn
        bedtools sort -i "${arr1[i]}" > ../output/sorted_$bn
    done

for ((i=0; i<"${#arr2[@]}"; i++))
    do
        bn=$(basename "${arr2[i]}")
        echo 'File used: ' $bn
        bedtools sort -i "${arr2[i]}" > ../output/sorted_$bn
    done


for ((i=0; i<"${#arr1[@]}"; i++)); do
    printf "Listing file paths:\n %s\n %s\n %s\n" "${arr1[i]}" "${arr2[i]}" "${arr3[i]}"
    printf '####\n'
done;

touch ../output/bedtools_ITAG_and_PGSC/file-combo.txt
for ((i=0; i<"${#arr1[@]}"; i++))
    do
        bn1=$(basename "${arr1[i]}")
        bn2=$(basename "${arr2[i]}")
        echo 'Files used: ' $bn1 $bn2 >> ../output/bedtools_ITAG_and_PGSC/file-combo.txt
    done;


for ((i=0; i<"${#arr1[@]}"; i++))
    do
        bn1=$(basename "${arr1[i]}")
        bn2=$(basename "${arr2[i]}")
        echo 'Files used: ' $bn1 $bn2
        for j in "${F[@]}"
            do
                ff=$j
                echo 'Minimum overlap: ' $ff
                bedtools intersect -wa -wb \
                -nonamecheck \
                -F $ff \
                -header -filenames \
                -b ${arr1[i]} ${arr2[i]} \
                -a "${arr3[0]}" \
                -sorted -sortout > ../output/bedtools_ITAG_and_PGSC/${i}_out_F-${ff}_intersect_2xv4_DM_1-3_516_R44_potato.v6.1.working_models_genes.txt;
                bedtools intersect -wa -wb \
                -nonamecheck \
                -F $ff -v \
                -header -filenames \
                -b ${arr1[i]} ${arr2[i]} \
                -a "${arr3[0]}" \
                -sorted -sortout > ../output/bedtools_ITAG_and_PGSC/${i}_no-overlap_F-${ff}_intersect_2xv4_DM_1-3_516_R44_potato.v6.1.working_models_genes.txt;
            done
    done;

F=(0.0001 0.001 0.01 0.1 0.50 1.00);
echo "${F[@]}";

for i in "${arr3[@]}"
    do
        bn=$(basename "$i")
        echo 'File used: ' $bn
        for j in "${F[@]}"
            do
                ff=$j
                echo 'Minimum overlap: ' $ff
                bedtools intersect -wa -wb \
                -nonamecheck \
                -F $ff \
                -header -filenames \
                -b $i  \
                -a $i \
                -sorted -sortout > ../output/bedtools_v6v6/out_F-${ff}_intersect_${bn}_DM_1-3_516_R44_potato.v6.1.working_models_genes.txt;
            done
    done;

