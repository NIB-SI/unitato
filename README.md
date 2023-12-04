# UniTato
* Apollo genome browser: [UniTato: a web server for evidence and community based Unification of poTato gene models](https://unitato.nib.si)
* Potato DM v4 to v6 hene ID translation table ```./output/v4-v6.1_translationTable.xlsx```
* Unified GFF/GTF files ```./output/Unitato.GFF.zip``` ```./output/Unitato.GTF.zip```  and corresponding FASTA file are also avalable at <http://unitato.nib.si/downloads/>




## Input files
### GFF3
* ITAG v4: ```./input/StPGSC4.04n_ITAG-gene-model_2020-01-17.gff3```
* PGSC v4: ```./input/StPGSC4.04n_PGSC-gene-model_2022-10-26.gff3```
* DMv6.1  [http://spuddb.uga.edu](http://spuddb.uga.edu/dm_v6_1_download.shtml) <http://spuddb.uga.edu/data/DM_1-3_516_R44_potato.v6.1.working_models.gff3.gz>
### FASTA
* v4 FASTA file: ```./input/StPGSC4.04n_2018-01-18_oneliner.fasta```
* DMv6.1  [http://spuddb.uga.edu](http://spuddb.uga.edu/dm_v6_1_download.shtml) <http://spuddb.uga.edu/data/DM_1-3_516_R44_potato_genome_assembly.v6.1.fa.gz>
### Annotations
* PGSC v4 annotations: ```./input/Solanum_tuberosum_PGSC_DM_v3.4_converterWithDescriptions.txt```
* DMv6.1  [http://spuddb.uga.edu](http://spuddb.uga.edu/dm_v6_1_download.shtml) <http://spuddb.uga.edu/data/DM_1-3_516_R44_potato.v6.1.working_models.func_anno.txt.gz>
### pan-transcriptome [https://doi.org/10.1038/s41597-020-00581-4](https://www.nature.com/articles/s41597-020-00581-4)
* panTranscriptome components: ```./input/5cv_weak-components.txt```
* ITAG-PGSC-pairs: ```./input/ITAG-PGSC-pairs.xlsx```
* ITAG v4 CDS len and GC content: ```./input/Solanum_tuberosum-ITAG_DM_v1_cds_GC-len``` [https://doi.org/10.1038/s41597-020-00581-4](https://www.nature.com/articles/s41597-020-00581-4)
* PGSC v4 CDS len and GC content: ```./input/Solanum_tuberosum_PGSC_merged_GC-len``` [https://doi.org/10.1038/s41597-020-00581-4](https://www.nature.com/articles/s41597-020-00581-4)
* Desiree, Rywal, and PW363 CDS and transcripts:
   * ```stCuSTr-D_cds_representatives.fasta```
   * ```stCuSTr-D_tr_representatives.fasta```
   * ```stCuSTr-P_cds_representatives.fasta```
   * ```stCuSTr-P_tr_representatives.fasta```
   * ```stCuSTr-R_cds_representatives.fasta```
   * ```stCuSTr-R_tr_representatives.fasta```
### Liftoff-specific files
* Chromosome: ```./input/pairs chroms.txt```
* Unplaced: ```./input/unplaced_DM404.txt```

## Software
* [Liftoff](https://github.com/agshumate/Liftoff) fork with adaptation: flanks as integer (instead of percentage): <https://github.com/NIB-SI/Liftoff>
* [Bedtools](https://bedtools.readthedocs.io/en/latest/index.html)
* [AGAT](https://github.com/NBISweden/AGAT)
* [minimap2](https://github.com/lh3/minimap2)
### R packages
* [data.table](https://cran.r-project.org/web/packages/data.table/vignettes/datatable-intro.html)
* [pafr](https://cran.r-project.org/web/packages/pafr/vignettes/Introduction_to_pafr.html)
* [stringr](https://cran.r-project.org/web/packages/stringr/index.html)
* [magrittr](https://cran.r-project.org/web/packages/magrittr/index.html)
* [sqldf](https://cran.r-project.org/web/packages/sqldf/)
* [RColorBrewer](https://cran.r-project.org/web/packages/RColorBrewer/index.html)
* [randomcoloR](https://github.com/ronammar/randomcoloR)
* [circlize](https://jokergoo.github.io/circlize/)
* [VennDiagram](https://cran.r-project.org/web/packages/VennDiagram/index.html)
* [grDevices](https://search.r-project.org/R/refmans/grDevices/html/grDevices-package.html)
* [ggvenn](https://cran.r-project.org/web/packages/ggvenn/index.html)
* [ggVennDiagram](https://cran.r-project.org/web/packages/ggVennDiagram/vignettes/using-ggVennDiagram.html)
* [intervals](https://rdrr.io/rforge/intervals/)
* [igraph](https://r.igraph.org/)
* [openxlsx](https://cran.r-project.org/web/packages/openxlsx/index.html)
  
 
## Output
* Translation table: ```./output/v4-v6.1_translationTable.xlsx```
* GFFs:
   * flank-based: ```./output/matched-unmatched-gff/```
   * unified v6v4 GFF: ```UniTato.gff```
## Reports
* many-to-many matches: ```./reports/overlaps.xlsx```
* Venn: ```./reports/01_Venn_wm.tiff```
* pan-transcriptome ITAG-PGSC pair matching dependent of the F parameter: ```./reports/ITAG-PGSC_F-dependent_pairs-matches.txt```
* DMv6.1 wm scaffolds without gene features: ```./reports/v6scaffolds-without-v6genes.fasta```
* Chord diagram visualisation
* Chr12 inversion visualisation
  
  
