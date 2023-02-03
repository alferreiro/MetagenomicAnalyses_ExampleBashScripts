#===============================================================================
# File Name    : p10_parseATLAS-SLURM.py
# Description  : ATLAS-metagenome generates very long slurm out/err files, e.g.
#                15,000 lines for ~150 samples, for just QC subworkflow. We 
#                want to summarize the errors only.
#                Collate errors,job id, sample ID, log path,cluster_jobid
#                Also, DAG job summary table from the top,
#                And, last instance of 'Finished job <X>, (<X>%)done'.
# Usage        : python p05_parseATLAS-SLURM.py  path/to/slurm.err out/path
# Author       : Aura Ferreiro, alferreiro@wustl.edu
# Version      : 1.0
# Created On   : 2022-05-13
# Last Modified: 2022-05-13
#===============================================================================


import sys

#slurmfile = open(sys.argv[1], 'r')
outfile = open(sys.argv[2], 'w')

err_headers= ['Rule','JobID', 'SampleID', 'Output', 'LogPath', 'ClusterJobID']


#Read DAG Job Summary Table, Errors

rulecounter = {}
with open(sys.argv[1], 'r') as slurmfile:
    while True:
        line = slurmfile.readline()
        if line == "":
            break

        if  "Building DAG of jobs..." in line:
            while True:
                JobSummaryLine = slurmfile.readline().strip()
                if not JobSummaryLine.startswith('['):
                    outfile.write(JobSummaryLine+'\n')
                else:
                    outfile.write('\n\n\n'+'\t'.join(err_headers)+'\n')
                    break


        elif "Error in rule" in line:
            rule = line.strip().split(' ')[3].strip(':')
            if rule not in rulecounter:
                 rulecounter[rule] = 0
            rulecounter[rule] += 1

            ErrorDict = {}
            ErrorDict.update({'Rule': rule})
            LogORShell = None
            while True:
                if len(ErrorDict.keys()) == 6:
                    outlist = [ErrorDict['Rule'], ErrorDict['jobid'], ErrorDict['SampleID'], ErrorDict['Output'], ErrorDict[LogORShell], ErrorDict['cluster_jobid']]
                    outfile.write('\t'.join(outlist)+'\n')
                    break

                ErrorLine = slurmfile.readline().strip()
                if not ':' in ErrorLine:
                    continue
                else:
                    ErrorLineList = ErrorLine.split(':')
                    errordetail = ErrorLineList[0]
                    if errordetail == 'jobid' or errordetail == 'cluster_jobid':
                        value = ErrorLineList[1].strip()
                        ErrorDict.update({errordetail : value})
                    elif errordetail == 'output':
                        outfiles = ErrorLineList[1].strip()
                        SampleID = outfiles.split('/')[0]
                        ErrorDict.update({'SampleID': SampleID})
                        ErrorDict.update({'Output': outfiles})
                    elif errordetail == 'log' or errordetail == 'shell':
                        LogORShell = errordetail
                        if errordetail == 'log':
                            value = ErrorLineList[1].split(' ')[1]
                            ErrorDict.update({errordetail : value})
                        else:
                            newline = slurmfile.readline().strip()
                            ErrorDict.update({errordetail : newline})
                    else:
                        continue



outfile.write('\n\n\nNumber Of Samples that failed per rule:\n')
for rule, count in rulecounter.items():
    outfile.write(rule+':\t'+str(count)+'\n')


outfile.close()


