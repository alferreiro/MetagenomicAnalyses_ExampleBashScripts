#===============================================================================
#
# File Name    : p04_renametempdirs.py
# Description  : Strip .gz suffix from erroneously named fastq files 
# Usage        : python p04_renametempdirs.py full/path2/dir/
# Author       : Aura Ferreiro, alferreiro@wustl.edu
# Version      : 1.0
# Created On   : 2022-11-09
# Last Modified: 2022-11-09
#===============================================================================

import os
import sys

parentdir = sys.argv[1]


suffix = 'fastq.gz'

for file in os.listdir(parentdir):
    if not file.endswith(suffix):
        continue
    newname = file.strip().split('.gz')[0]
    os.rename(parentdir+file, parentdir+newname)




