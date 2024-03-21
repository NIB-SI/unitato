UniTato (v6v4) GFF contains:
* DM 1-3 516 R44 (v6.1) working gene models annotation in GFF3 format
* ITAG/PGSC (v4.04) gene models annotation in GFF3 format corresponding to v4 genes that matched v6 genes with Bedtools intersect F parameter < 0.30, or were mapped to intergenic regions

DM v6.1 ITAG/PGSC v4 paremeter-dependent combinations are shown in multi-sheet ```v4-v6.1_translationTable.xlsx``` file:
* high identity (F >= 0.30) v6-v4 gene pairs, used to create Phureja v4-v6.1 translation table
* low identity (0.0001 < F < 0.30) v6-v4 gene pairs
* unmatched (F < 0.0001) v4 gene IDs (pure addition)
* unmatched v6 gene IDs
* unmapped v4 geneIDs
* v6-v4 gene pairs from mapping without flank
* v6-v4 gene pairs from mapping with flank 500 nt
* low identity v4-v6 multimapping gene pairs (F >= 0.30)
* high identity v4-v6 multimapping gene pairs (0.0001 < F < 0.30)

  _Note_: in case of multimapping, best F score was chosen to include mapping location in GFF


```Phureja_v4-v6.1_translations.xlsx``` is also hosted at <https://unitato.nib.si/downloads/>

  ```matched-unmatched-gff``` directory contains GFF files compiled based on information available from the translation table(s)
  
  ```maminiprot``` directory contains parsed miniprot .gffs
