#PBS -N	chek2_step2
#PBS -S /bin/bash
#PBS -l walltime=200:00:00
#PBS -l nodes=1:ppn=8
#PBS -l mem=300gb
#PBS -o /scratch/akoppayi/process/CHEK2_MM/new_data/Batch1/logfiles/step2_ch_b1.out
#PBS -e /scratch/akoppayi/process/CHEK2_MM/new_data/Batch1/logfiles/step2_ch_b1.err
#PBS -d /scratch/akoppayi/process/CHEK2_MM/new_data/Batch1

module load java-jdk/1.8.0_92
module load picard/2.8.1

echo START

for input in `ls *_ubam.bam`; 
do java -Djava.io.tmpdir=${input%_ubam.bam}"_tmp_step2" -jar /apps/software/java-jdk-1.8.0_92/picard/2.8.1/picard.jar MarkIlluminaAdapters I=$input O=${input%_ubam.bam}"_step2.bam" M=${input%_ubam.bam}"_step2_metrics.txt";
done

echo END
