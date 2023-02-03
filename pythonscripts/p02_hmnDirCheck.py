#===============================================================================
#
# File Name    : p02_hmnDirCheck.py
# Description  : Clean hmn temp dir names towards finding redundant dirs
# Usage        : python p02_hmnDirCheck.py  path/to/infile.txt outfile.txt
# Author       : Aura Ferreiro, alferreiro@wustl.edu
# Version      : 1.0
# Created On   : 2022-10-26
# Last Modified: 2022-10-26
#===============================================================================


import sys

infile = open(sys.argv[1], 'r')
outfile = open(sys.argv[2], 'w')

for line in infile:
    id = line.strip().split('_humann')[0]
    outfile.write(id+'\n')

infile.close()
outfile.close()
