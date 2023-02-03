#===============================================================================
#
# File Name    : p08_addSampleid2MAGbins.py
# Description  : Opens MetaBat directory and adds dirname (i.e. sampleid) to the
#                genome bin files. This is called by s16_addSampleid2MAGbins.sh.
# Usage        : python p08_addSampleid2MAGbins.py dirbasename
# Author       : Aura Ferreiro, alferreiro@wustl.edu
# Version      : 1.0
# Created On   : 2021-01-15
# Last Modified: 2021-01-15
#===============================================================================

import os
import sys

sampleid = sys.argv[1]

dirname = 'MetaBat_out/' + sampleid + '_contigs.fasta.metabat-bins/'


suffix = '.fa'

for filename in os.listdir(dirname):
    if not filename.endswith(suffix):
        continue
    os.rename(dirname+filename, dirname+sampleid+'_'+filename)

