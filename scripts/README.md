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