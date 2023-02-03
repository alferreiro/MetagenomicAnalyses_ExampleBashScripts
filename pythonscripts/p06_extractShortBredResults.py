#===============================================================================
#
# File Name    : extractshortbred.py
# Description  : This script will loop through a directory and extract all hits from shortbred
# Usage        : python extractshortbred.py  outfile.txt
# Author       : Aura Ferreiro, alferreiro@wustl.edu
# Version      : 1.0
# Created On   : 2020-09-15
# Last Modified: 2019-09-15
#===============================================================================

import os
import sys

suffix = 'shortbread_out.txt'

outfile = open(sys.argv[1], 'w')
header = 'Sample\tFamily\tCount\tHits\tTotalMarkerLength\n'
outfile.write(header)

for filename in os.listdir('/scratch/gdlab/alferreiro/200902_HECSFIRN/rawreads/shortbred_out/'):
    if not filename.endswith(suffix):
        continue
    try:
        splitname = filename.split('_')
        if filename.startswith('5'):
            id = splitname[0]
        else:
            id = splitname[0] + '_' + splitname[1]

        infile=open('../'+filename, 'r')
        linenumber = 0
        for line in infile:
            if linenumber > 0: #skip header
                Family, Count, Hits, TotMarkerLength = line.strip().split('\t')
                if float(Hits) > 0:
                    outstring = "%s\t%s\t%s\t%s\t%s\n" % (id, Family, Count, Hits, TotMarkerLength)
                    outfile.write(outstring)
            linenumber = linenumber + 1
        infile.close()
    except IOError:
        print(filename, 'empty file')

outfile.close()

