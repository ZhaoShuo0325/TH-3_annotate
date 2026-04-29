#!/bin/bash
#source ~/.bashrc
#conda activate funannotate_env

HOME="/path/to/home"
GENOME="$HOME/data/TH-3_clean.fa"
INDEX="$HOME/data/TH3_index"
GENOME="$HOME/data/TH-3_clean.fa"
FQ1="$HOME/data/Data/CleanData/CK_1/CK_1_1.fq.gz"
FQ2="$HOME/data/Data/CleanData/CK_1/CK_1_2.fq.gz"
OUT_DIR="$HOME/annotate"

hisat2 -p 64 --dta -x $INDEX -1 $FQ1 -2 $FQ2 -S $OUT_DIR/CK_1.sam
samtools sort -@ 32 -o $OUT_DIR/CK_1.sorted.bam $OUT_DIR/CK_1.sam

funannotate mask -i $GENOME -o $OUT_DIR/TH-3_masked.fa --cpu 32
funannotate predict -i $OUT_DIR/TH-3_masked.fa \
                    -o $OUT_DIR/TH-3_predict \
                    -s "Aspergillus_niger" \
                    --strain "TH-3" \
                    --rna_bam $OUT_DIR/CK_1.sorted.bam \
                    --busco_db dikarya \
                    --cpus 64 \
                    --busco_seed_species aspergillus_nidulans \
                    --optimize_augustus \
                    --organism fungus
funannotate species -s aspergillus_niger_th-3 -a $OUT_DIR/TH-3_predict/predict_results/aspergillus_niger_th-3.parameters.json
funannotate annotate -i $HOME/annotate/TH-3_predict \
                     -o $OUT_DIR/TH-3_annotate \
                     --species "Aspergillus niger" \
                     --strain "TH-3" \
                     --cpus 64
