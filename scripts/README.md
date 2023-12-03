Unification steps (nonconsecutive order)

1. Run Liftoff with and without flanks (flanks as [int](https://github.com/NIB-SI/Liftoff))
2. Run Bedtools [intersect](https://bedtools.readthedocs.io/en/latest/content/tools/intersect.html) using various [F param](https://bedtools.readthedocs.io/en/latest/_images/intersect-glyph.png) values
3. Filter Bedtools intersect results for matching strands
4. Use [minimap2](https://github.com/lh3/minimap2) for various mappings using various [params](https://lh3.github.io/minimap2/minimap2.html) (data set specific)
5. Visualise synteny (R code and packages in .html report)
6. Use [AGAT](https://github.com/NBISweden/AGAT) for various GFF pre-processing and sorting
7. Visualise sets (R code and packages in .html report)
8. Add annotations to GFFs
9. Mark many-to-many mappings (R code and packages in .html report)

For table preparation integrating output data from steps above use R or Python, or both using Jupyter Notebook

For GitHub & BitBucket HTML Preview use <https://htmlpreview.github.io/>

Package versions
* conda 4.8.3
* bedtools v2.25.0
* R version v4.2.3
* Python v3.9.18
* agat v1.2.0
* jupyter v4.4.0
* pip v23.3.1
* minimap2 v2.26-r1175
* liftoff fork v1.6.3

For Apollo setup visit [Apollo documentation page](https://genomearchitect.readthedocs.io/en/latest/)

