#===============================================================================
#
# File Name    : makeSampleList.py
# Description  : Clean fastq suffix from sample list
# Usage        : python makeSampleList.py  path/to/infile.txt outfile.txt 'delim'
# Author       : Aura Ferreiro, alferreiro@wustl.edu
# Version      : 1.0
# Created On   : 2022-10-20
# Last Modified: 2022-10-20
#===============================================================================

import re
import os
import sys

infile = open(sys.argv[1], 'r')
outfile = open(sys.argv[2], 'w')
delim = sys.argv[3]

for line in infile:
    id = line.strip().split(delim)[0]
    outfile.write(id+'\n')

infile.close()
outfile.close()
