conda activate UniTato
# https://github.com/NBISweden/AGAT#using-bioconda
conda install -c bioconda agat
conda update agat
# https://agat.readthedocs.io/en/latest/topological-sorting-of-gff-features.html
agat_convert_sp_gxf2gxf.pl --gff pure_addition_flank0.gff  > sorted_pure_addition_flank0.gff;
# repeat for all GFFs

# cob+nvert GFF to GTF
agat_convert_sp_gff2gtf.pl --gff Unitato.gff -o Unitato.gtf

