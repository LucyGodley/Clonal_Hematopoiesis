#!/bin/bash
#PBS -N chek2_step5d
#PBS -S /bin/bash
#PBS -l walltime=200:00:00
#PBS -l nodes=1:ppn=2
#PBS -l mem=160gb
#PBS -o /scratch/akoppayi/process/CHEK2_MM/new_data/Batch1/logfiles/step5d.out
#PBS -e /scratch/akoppayi/process/CHEK2_MM/new_data/Batch1/logfiles/step5d.err
#PBS -d /scratch/akoppayi/process/CHEK2_MM/new_data/Batch1

module load java-jdk/1.8.0_92
module load python/3.8.10
module load gatk/4.1.3.0
gatk='/apps/software/java-jdk-1.8.0_92/gatk/4.1.3.0/gatk'

echo START

for input in `ls *step4.bam`; do $gatk ApplyBQSR -R /gpfs/data/godley-lab/reference_mouse_genome/mm10/mm10.fa -I $input --bqsr-recal-file ${input%_step4.bam}"_step5a_BaseRecalibrator.table" -O ${input%_step4.bam}"_step5d.bam"; done

echo END
