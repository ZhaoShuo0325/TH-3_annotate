# TH-3_annotate

## Environment Setup and Configuration
First, create the environment using the provided `funannotate_env.yaml` file.
```bash
# Clone the repository and enter the directory
git clone https://github.com/ZhaoShuo0325/TH-3_annotate.git
cd TH-3_annotate

# Create and activate the environment
conda env create -f ./funannotate_env.yaml
conda activate funannotate_env
```
Due to licensing restrictions, GeneMark cannot be installed directly via Conda. Please follow these manual steps:
1. Go to the https://exon.gatech.edu/GeneMark/license_download.cgi and apply for a GMES/ET/EP license.
2. Place the Key: Move the downloaded license key to your home directory: ~/.gm_key.
3. Install & Set Path:
```bash
# Ensure key file in your home directory
ls -a ~ | grep .gm_key

# Decompress your downloaded package
tar -zxvf gmes_linux_64.tar.gz
cd gmes_linux_64/

# Fix Perl interpreter paths and set environment variables
perl -i -pe 's{^#!/usr/bin/perl}{#!/usr/bin/env perl}g' *.pl
mkdir -p $CONDA_PREFIX/etc/conda/activate.d/
echo "export GENEMARK_PATH=$(pwd)" >> $CONDA_PREFIX/etc/conda/activate.d/genemark.sh

# Apply changes immediately
source $CONDA_PREFIX/etc/conda/activate.d/genemark.sh
```
## Setup Funannotate Datebases
The annotation process relies on several external databases
```bash
mkdir -p funannotate_db
cd funannotate_db
funannotate setuo -i all
funannotate check --it
```
**Note on Database Downloads:**
Due to potential changes over time, the default download paths stored in funannotate may become outdated or expire. You can refer to the funannotate-db-info.txt file for the required data versions and download them manually. For example, you can use the following command to set up the BUSCO database in the background:
The annotation process relies on several external databases
```bash
# For example
nohup funannotate setup -b dikarya \
  -d funannotate_db \
  --install busco -w \
  > setup_busco.log 2>&1 &
```
**Additionally**, when using `funannotate annotate`, the eggNOG database is required and must be downloaded manually.
```bash
# Download eggNOG
mkdir -p eggnog_db
cd eggnog_db

nohup wget -c --tries=0 --timeout=60 \
  http://eggnog5.embl.de/download/emapperdb-5.0.2/eggnog.db.gz \
  > wget_eggnog_db.log 2>&1 &
nohup wget -c --tries=0 --timeout=60 \
  http://eggnog5.embl.de/download/emapperdb-5.0.2/eggnog_proteins.dmnd.gz \
  > wget_eggnog_dmnd.log 2>&1 &
nohup wget -c --tries=0 --timeout=60 \
  http://eggnog5.embl.de/download/emapperdb-5.0.2/eggnog.taxa.tar.gz \
  > wget_eggnog_taxa.log 2>&1 &
```
