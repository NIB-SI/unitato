Unification steps

1. Run Liftoff with and without flanks (flanks as [int](https://github.com/NIB-SI/Liftoff))
2. Run Bedtools [intersect](https://bedtools.readthedocs.io/en/latest/content/tools/intersect.html) using various [F param](https://bedtools.readthedocs.io/en/latest/_images/intersect-glyph.png) values
3. Filter Bedtools intersect results for matching strands
4. Use [minimap2](https://github.com/lh3/minimap2) (<https://anaconda.org/bioconda/minimap2>) for various mappings using various [params](https://lh3.github.io/minimap2/minimap2.html) (data set specific)
5. Visualise synteny (custom R code and packages in .html report)
6. Use [AGAT](https://github.com/NBISweden/AGAT) (<https://anaconda.org/bioconda/agat>) for various GFF pre-processing and sorting
7. Visualise sets (R code and packages in .html report)
8. Add annotations to GFFs (custom Python code)
9. Mark many-to-many mappings (R code and packages in .html report)
10. Map long read to the genome using [minimap2](https://github.com/lh3/minimap2)
11. Map PE reads to the genome using [STAR](https://github.com/alexdobin/STAR) (<https://anaconda.org/bioconda/star>)
12. Map PE reads to the genome using [Salmon](https://github.com/COMBINE-lab/salmon) (<https://anaconda.org/bioconda/salmon>)
13. Perform differential expression analysis (custom R code)
14. Map reference preoteomes to the genome using [miniprot](https://github.com/lh3/miniprot) (<https://anaconda.org/bioconda/miniprot>)
15. Replace miniprot IDs with original proteome IDs in .gff (custom R code)

For table preparation integrating output data from steps above use R or Python, or both using Jupyter Notebook

For GitHub & BitBucket HTML Preview use <https://htmlpreview.github.io/>

Package versions
* agat v1.2.0
* bedtools v2.25.0
* conda 4.8.3
* jupyter v4.4.0
* liftoff fork v1.6.3
* minimap2 v2.26-r1175
* miniprot v0.13-r248
* pip v23.3.1
* Python v3.9.18
* R version v4.2.3
* Salmon v
* STAR v
 

For Apollo setup visit [Apollo documentation page](https://genomearchitect.readthedocs.io/en/latest/)

For creation of an environment from an environment.yml file visit [Conda user guide web page](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html)
