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
```
