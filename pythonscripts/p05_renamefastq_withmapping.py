#===============================================================================
#
# File Name    : rename.py
# Description  : Given a tab separated mapping file of Novaseq indices, samplenames, this will rename fastq.gz files from GTAC.
# Usage        : python rename.py  mappingfile.txt path/to/files/
# Author       : Aura Ferreiro, alferreiro@wustl.edu
# Version      : 1.0
# Created On   : 2020-09-15
# Last Modified: 2020-11-03
#===============================================================================

import os
import sys

mappingfile = open(sys.argv[1], 'r')
indir = sys.argv[2]

if not indir.endswith('/'):
    sys.exit('Error: Directory name should have terminal forward slash')

#make dict
mapping = {}

for line in mappingfile:
    novaseqid, index, study_id, abgene, new_name, new_namelong, notes = line.strip().split('\t')
    mapping[index] = new_name

suffix = '.fastq.gz'

for filename in os.listdir(indir):
    if not filename.endswith(suffix):
        continue
    if not len(filename.split('_'))>3:
        continue
    idx = filename.split('_')[1]
    read = filename.split('_')[3]

    if idx in mapping:
        newname = mapping[idx] + '_' + read + suffix
        os.rename(indir+filename, indir+newname)

mappingfile.close()
