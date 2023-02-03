#===============================================================================
#
# File Name    : cat_timepoints.py
# Description  : Given a tab separated mapping file of longitudinal sample ids and Participants,
#                writes a sh file to zcat files by participant. Then the .sh
#                file can be submitted to slurm.
# Usage        : python cat_timepoints.py  mappingfile.txt path/to/files/ outfile.sh
# Author       : Aura Ferreiro, alferreiro@wustl.edu
# Version      : 1.0
# Created On   : 2020-11-14
# Last Modified: 2020-11-14
#===============================================================================


import sys
from collections import defaultdict

mappingfile = open(sys.argv[1], 'r')
outdir = sys.argv[2]

if not outdir.endswith('/'):
    sys.exit('Error: Directory name should have terminal forward slash')


# Make dict of longitudinal fastq files by participant
mappinglist = []

for line in mappingfile:
    sampleid, participant = line.strip().split()
    mappinglist.append((participant, sampleid))


# Passing it to a list first wasn't necessary but here we are:

mappingdict = defaultdict(list)
for participant, sampleid in mappinglist:
    mappingdict[participant].append(sampleid)


#

commandfile = open(sys.argv[3], 'w')
commandfile.write('#!/bin/bash\n')

for participant in mappingdict:
    files = mappingdict[participant]
    R1 = []
    R2 = []
    for file in files:
        R1.append(outdir+'Haran_uncatted/'+file+'_R1.fastq.gz')
        R2.append(outdir+'Haran_uncatted/'+file+'_R2.fastq.gz')

    commandfile.write('cat '+" ".join(R1)+" > "+outdir+participant+"_R1.fastq.gz\n")
    commandfile.write('cat '+" ".join(R2)+" > "+outdir+participant+"_R2.fastq.gz\n")
    commandfile.write('\n')

commandfile.close()

