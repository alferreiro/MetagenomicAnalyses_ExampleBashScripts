#===============================================================================
#
# File Name    : parseCheckM.py
# Description  : Given sampleid argument, opens CheckM.stdout. Finds bins with
#                completeness >50% and contamination <5%. Writes passing bin
#                names to outfile. Called by s17_parseCheckM.sh in parent dir.
# Usage        : python p09_parseCheckM.py sampleid
# Author       : Aura Ferreiro, alferreiro@wustl.edu
# Version      : 1.0
# Created On   : 2021-01-15
# Last Modified: 2021-01-15
#===============================================================================


import sys

sampleid = sys.argv[1]
checkMfilepath = 'CheckM_out/'+sampleid+'_CheckM/'+sampleid+'_checkm.stdout'
outpath = 'CheckM_out/'+sampleid+'_goodbins.txt'

checkMfile = open(checkMfilepath, 'r')
outfile = open(outpath, 'w')


for line in checkMfile:
    line2 = line.strip()
    if line2.startswith('bin.'):
        linev = line2.split()
        if float(linev[12]) > 50 and float(linev[13]) < 5:
            outfile.write(sampleid+'_'+linev[0]+'.fa\n')


checkMfile.close()
outfile.close()




