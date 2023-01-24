#!/bin/bash
#===============================================================================
# File Name    : s03_runhumann3.sh
# Description  : run humann3 on all samples (reruns mphln3), with --resume opt
# Usage        : sbatch s03_runhumann3.sh
# Author       : Aura Ferreiro
# Version      : 1.0
# Created On   : 2022-10-24
# Last Modified: 2022-10-24
#===============================================================================


#SBATCH --time=3-0:00:00 # days-hh:mm:ss
#SBATCH --job-name=humann3
#SBATCH --array=1-400%20
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --output=slurmout/humann3/x_humann3_%a.out
#SBATCH --error=slurmout/humann3/y_humann3_%a.err


# load bowtie2 spack module
eval $( spack load --sh bowtie2@2.4.2 )


# As far as I know humann3 spack module has not yet been installed? Jan 24, 2023 -AF
# load python and activate humann venv
module load python
. /opt/apps/labs/gdlab/envs/humann/3.0.0a4/bin/activate




indir="/scratch/gdlab/alferreiro/HECSFIRN/processed_reads"
outdir="/scratch/gdlab/alferreiro/HECSFIRN/humann3_out"
nucleotide_database="/opt/apps/labs/gdlab/envs/humann/3.0.0a4/HUMAnN3databases/chocophlan"
protein_database="/opt/apps/labs/gdlab/envs/humann/3.0.0a4/HUMAnN3databases/uniref"


#read in the slurm array task
sample=`sed -n ${SLURM_ARRAY_TASK_ID}p 221107_samples.txt`

#concatenate forward and reverse read files
cat ${indir}/${sample}_R1.fastq.gz ${indir}/${sample}_R2.fastq.gz > ${indir}/${sample}_concat.fastq.gz


set -x # Start debug mode (will send commands to outfile)
time humann \
        --input ${indir}/${sample}_concat.fastq.gz \
        --output ${outdir} \
        --threads ${SLURM_CPUS_PER_TASK} \
        --resume \
        --output-basename ${sample}

#       --remove_temp_output


#NOTE! You should not have both options --resume and --remove_temp_output set at the same time.
#If --remove_temp_output is true, the temporary intermediate directories for each sample will
#be created with a random 8 character string at the end of the filename.
#
#The option --resume is nice for failed jobs because the pipeline will resume at the last 
#checkpoint rather than starting all over.
#This behaviour breaks if the temporary directories have a random string at the end. Then
#it doesn't know where to check for existing files.
#
#Recommended to run without either option for the first pass. Then:
# For samples that worked, remove temporary directories (see rmtempDirs.sh)
# For samples that didn't work, adjust memory allocation and re-run script for these
# samples with --resume flag. 


#consolidate and rezip files
rm ${indir}/${sample}_concat.fastq.gz

set +x # End debug mode (will stop sending commands to outfile)

deactivate # deactivate venv
