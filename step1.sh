#PBS -N	chek2_step1
#PBS -S /bin/bash
#PBS -l walltime=20:00:00
#PBS -l nodes=1:ppn=4
#PBS -l mem=200gb
#PBS -o /scratch/akoppayi/process/CHEK2_MM/new_data/Batch1/logfiles/step1_b1_ch.out
#PBS -e /scratch/akoppayi/process/CHEK2_MM/new_data/Batch1/logfiles/step1_b1_ch.err
#PBS -d /scratch/akoppayi/process/CHEK2_MM/new_data/Batch1

module load java-jdk/1.8.0_92
module load picard/2.8.1

echo START

for input in `ls *R1_001.fastq.gz`;
do
READ_GROUP_NAME=`echo $input |awk -F"_" '{print $1}'`
SAMPLE_NAME=`echo $input |awk -F"_" '{print $1}'`
LIBRARY_NAME=`echo $input |awk -F"_" '{print $5}'`
echo $READ_GROUP_NAME $SAMPLE_NAME $LIBRARY_NAME
platform_unit=("`zless $input |head -n1 | awk -F ':' '{print $3 "." $4}'`")
java -Djava.io.tmpdir=${input%_R1_001.fastq.gz}"_001_tmp" -jar /apps/software/java-jdk-1.8.0_92/picard/2.8.1/picard.jar FastqToSam FASTQ=$input FASTQ2=${input%_R1_001.fastq.gz}"_R2_001.fastq.gz" OUTPUT=${input%_R1_001.fastq.gz}"_ubam.bam" READ_GROUP_NAME=$READ_GROUP_NAME SAMPLE_NAME=$SAMPLE_NAME LIBRARY_NAME=$LIBRARY_NAME PLATFORM_UNIT=$platform_unit PLATFORM=illumina; FILE=${input%_R1_001.fastq.gz}"_ubam.bam";
done

echo END
