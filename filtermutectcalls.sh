#!/bin/bash
#PBS -N FilterMutectCalls
#PBS -S /bin/bash
#PBS -l walltime=96:00:00
#PBS -l nodes=1:ppn=4
#PBS -l mem=150gb
#PBS -o /scratch/akoppayi/process/CHEK2_MM/new_data/vcf/filter_mutect.out
#PBS -e /scratch/akoppayi/process/CHEK2_MM/new_data/vcf/filter_mutect.err
#PBS -d /scratch/akoppayi/process/CHEK2_MM/new_data/vcf

module load java-jdk/1.8.0_92
module load gcc/6.2.0
module load openssl/1.1.1d
module load python/3.8.1
module load gatk/4.1.3.0
gatk='/apps/software/java-jdk-1.8.0_92/gatk/4.1.3.0/gatk'

echo START

for input in `ls *_somatic.vcf`; do $gatk FilterMutectCalls -R "/gpfs/data/godley-lab/reference_mouse_genome/mm10/mm10.fa" -V "$input" -L "/gpfs/data/godley-lab/reference_mouse_genome/mm10/mm10_exons.bed" --normal-p-value-threshold 0.000000000000001 -O ${input%.vcf}"_filter.vcf"; done

echo END
