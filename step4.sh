#!/bin/bash
#PBS -N Step4
#PBS -l walltime=200:00:00
#PBS -l nodes=1:ppn=2
#PBS -l mem=286gb
#PBS -o /scratch/akoppayi/process/CHEK2_MM/new_data/Batch1/logfiles/step4.out
#PBS -e /scratch/akoppayi/process/CHEK2_MM/new_data/Batch1/logfiles/step4.err
#PBS -d /scratch/akoppayi/process/CHEK2_MM/new_data/Batch1

module load java-jdk/1.8.0_92
module load picard/2.8.1

echo START

for input in `ls *_mapped.bam`; do java -Djava.io.tmpdir=${input%_mapped.bam}"_tmp_step4" -jar /apps/software/java-jdk-1.8.0_92/picard/2.8.1/picard.jar MarkDuplicates INPUT=$input OUTPUT=${input%_mapped.bam}"_step4.bam" METRICS_FILE=${input%_mapped.bam}"_step4_metrics.txt" OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 CREATE_INDEX=true ; done

echo END
