# UniTato
UniTato: a web server for evidence and community based Unification of poTato gene models


## Input files
### GFF3
* ITAG v4: ./input/StPGSC4.04n_ITAG-gene-model_2020-01-17.gff3
* PGSC v4: ./input/StPGSC4.04n_PGSC-gene-model_2022-10-26.gff3
* DMv6.1  [http://spuddb.uga.edu](http://spuddb.uga.edu/dm_v6_1_download.shtml)
### FASTA
* v4 FASTA file: ./input/StPGSC4.04n_2018-01-18_oneliner.fasta
* DMv6.1  [http://spuddb.uga.edu](http://spuddb.uga.edu/dm_v6_1_download.shtml)
### Annotations
* PGSC v4 annotations: ./input/Solanum_tuberosum_PGSC_DM_v3.4_converterWithDescriptions.txt
* DMv6.1  [http://spuddb.uga.edu](http://spuddb.uga.edu/dm_v6_1_download.shtml)
### pan-transcriptome [https://doi.org/10.1038/s41597-020-00581-4](https://www.nature.com/articles/s41597-020-00581-4)
* panTranscriptome components ./input/5cv_weak-components 
* ITAG-PGSC-pairs: ./input/ITAG-PGSC-pairs.xlsx 
* ITAG v4 CDS len and GC content: ./input/Solanum_tuberosum-ITAG_DM_v1_cds_GC-len [https://doi.org/10.1038/s41597-020-00581-4](https://www.nature.com/articles/s41597-020-00581-4)
* PGSC v4 CDS len and GC content: ./input/Solanum_tuberosum_PGSC_merged_GC-len [https://doi.org/10.1038/s41597-020-00581-4](https://www.nature.com/articles/s41597-020-00581-4)
* Desiree, Rywal, and PW363 CDS and transcripts:
   * stCuSTr-D_cds_representatives.fasta
   * stCuSTr-D_tr_representatives.fasta
   * stCuSTr-P_cds_representatives.fasta
   * stCuSTr-P_tr_representatives.fasta
   * stCuSTr-R_cds_representatives.fasta
   * stCuSTr-R_tr_representatives.fasta
### Liftoff-specific files
* Chromosome: ./input/pairs chroms.txt
* Unplaced: ./input/unplaced_DM404.txt

## Software
* Liftoff fork with adatation: flanks as integer, insetad of percentage: https://github.com/NIB-SI/Liftoff
* [Bedtools](https://bedtools.readthedocs.io/en/latest/index.html)
* [AGAT](https://github.com/NBISweden/AGAT)
 
## Output
* Translation table: ./output/v4-v6.1_translationTable.xlsx
* GFFs ./output/matched-unmatched-gff
## Reports
* many-to-many matches: ./reports/overlaps.xlsx
* Venn: ./reports/01_Venn_wm.tiff
* pan-transcriptome ITAG-PGSC pair matching dependent of the F parameter ./reports/ITAG-PGSC_F-dependent_pairs-matches.txt
* DMv6.1 wm scaffolds without gene features ./reports/v6scaffolds-without-v6genes.fasta
  
