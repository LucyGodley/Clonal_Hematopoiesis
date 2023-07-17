#PBS -N	chek2_step3
#PBS -S /bin/bash
#PBS -l walltime=196:00:00
#PBS -l nodes=1:ppn=2
#PBS -l mem=200gb
#PBS -o /scratch/akoppayi/process/CHEK2_MM/new_data/Batch1/logfiles/step3.out
#PBS -e /scratch/akoppayi/process/CHEK2_MM/new_data/Batch1/logfiles/step3.err
#PBS -d /scratch/akoppayi/process/CHEK2_MM/new_data/Batch1

module load java-jdk/1.8.0_92
module load picard/2.8.1

echo START

for input in `ls *_step2.bam`; 
do 
java -Djava.io.tmpdir=${input%_step2.bam}"_tmp_step3a_BWA" -jar /apps/software/java-jdk-1.8.0_92/picard/2.8.1/picard.jar SamToFastq I=$input FASTQ=${input%_step2.bam}"_3a_forBWA.fastq" CLIPPING_ATTRIBUTE=XT CLIPPING_ACTION=2 INTERLEAVE=true NON_PF=true; 
done

echo END
 
module load gcc/6.2.0
module load java-jdk/1.8.0_92
module load picard/2.8.1
module load bwa/0.7.15

echo START

for input in `ls *_3a_forBWA.fastq`; do 
/apps/software/gcc-6.2.0/bwa/0.7.15/bwa mem -M -t 7 -p /gpfs/data/godley-lab/reference_mouse_genome/mm10/mm10.fa $input > ${input%_3a_forBWA.fastq}"_3b_bwa_mem.sam" ;
done

echo END

module load java-jdk/1.8.0_92
module load picard/2.8.1

echo START

for input in `ls *_3b_bwa_mem.sam`;
do
java -Djava.io.tmpdir=${input%_3b_bwa_mem.sam}"_tmp_step3c_BWA" -jar /apps/software/java-jdk-1.8.0_92/picard/2.8.1/picard.jar MergeBamAlignment R=/gpfs/data/godley-lab/reference_mouse_genome/mm10/mm10.fa ALIGNED_BAM=$input UNMAPPED_BAM=${input%_3b_bwa_mem.sam}"_ubam.bam" OUTPUT=${input%_3b_bwa_mem.sam}"_mapped.bam" CREATE_INDEX=true ADD_MATE_CIGAR=true CLIP_ADAPTERS=false CLIP_OVERLAPPING_READS=true INCLUDE_SECONDARY_ALIGNMENTS=true MAX_INSERTIONS_OR_DELETIONS=-1 PRIMARY_ALIGNMENT_STRATEGY=MostDistant ATTRIBUTES_TO_RETAIN=XS;
done

echo END
