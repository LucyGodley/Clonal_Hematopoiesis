#PBS -N Select_Exonic_Regions
#PBS -S /bin/bash
#PBS -l nodes=1:ppn=8
#PBS -l walltime=24:00:00
#PBS -l mem=100gb
#PBS -o /scratch/akoppayi/process/CHEK2_MM/new_data/vcf/test_sv.out
#PBS -e /scratch/akoppayi/process/CHEK2_MM/new_data/vcf/test_sv.err
#PBS -d /scratch/akoppayi/process/CHEK2_MM/new_data/vcf



module load java-jdk/1.8.0_92
module load gatk/3.7
module load gcc/6.2.0
module load samtools/1.10


for input in `ls *vcf`;
do
#echo $input
sample=`echo $input|awk -F'_' '{print $1}'`
#java -Xmx1G -jar ${GATK} -T SelectVariants -R /gpfs/data/godley-lab/reference_mouse_genome/mm10/mm10.fa -V $input -o ${sample}"_exonic.vcf" -L /gpfs/data/godley-lab/reference_mouse_genome/mm10/mm10_exons.bed
#samtools view ${input%.vcf}"_step5d.bam" -L /gpfs/data/godley-lab/reference_mouse_genome/mm10/mm10_exons.bed -b -o ${sample}"_exonic_step5d.bam" 

#echo $sample
done

#for i in *exonic_step5d.bam;
#do
#echo $i >> Depth_exonic.txt;
#samtools depth -b mm10_exons.bed $i |  awk '{sum+=$3} END { print "Average = ",sum/NR}' >> Depth_exonic.txt 
#done
for i in *exonic_step5d.bam;do 
echo $i >> Depth_exonic.txt;
samtools depth -b mm10_exons.bed $i |  awk '{sum+=$3} END { print "Average = ",sum/NR}' >> Depth_exonic.txt
done




