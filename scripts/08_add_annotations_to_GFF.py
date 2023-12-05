#!/usr/bin/env python3


gff_file = "chrom-name_sorted_DM_1-3_516_R44_potato.v6.1.working_models.gff3"
annot_file = "DM_1-3_516_R44_potato.v6.1.working_models.func_anno.txt.gz"
out_file = "annot-chrom-name_sorted_DM_1-3_516_R44_potato.v6.1.working_models.gff3"

import pandas as pd
import re

annots = pd.read_csv(annot_file, compression="gzip", sep="\t", index_col=0, header=None, names=["identifier", "annotation"])

with open(gff_file, "r") as gff:
    with open(out_file, "w") as out:
        for line in gff:
            if not line.startswith("#"):
                attributes =line.split("\t")[-1].rstrip()
                #print(attributes)
                if "ID" in attributes:
                    identifier = re.match(r"ID=(.*?);", attributes).groups()[0]
                    if identifier in annots.index:
                        annot = annots.loc[identifier, "annotation"]
                        line = line.rstrip() + f";Note={annot}\n"
                        out.write(line)
                        continue
            out.write(line)
