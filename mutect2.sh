#PBS -N Somatic_Mutect2
#PBS -S /bin/bash
#PBS -l nodes=1:ppn=4
#PBS -l mem=300gb
#PBS -l walltime=48:00:00
#PBS -e /scratch/akoppayi/process/CHEK2_MM/new_data/vcf/mutect_call.err
#PBS -o /scratch/akoppayi/process/CHEK2_MM/new_data/vcf/mutect_call.out
#PBS -d /scratch/akoppayi/process/CHEK2_MM/new_data/vcf



module load java-jdk/1.8.0_92
module load gcc/9.4.0
module load gatk/4.1.3.0
module load python/3.8.1
gatk='/apps/software/java-jdk-1.8.0_92/gatk/4.1.3.0/gatk'



for input in `ls *_step5d.bam`;
do
sampid="${input%_*step5d.bam}"
if test -f "${sampid}_somatic.vcf.idx"; then
  echo "${sampid}_somatic.vcf.idx exists..";      
  continue
else 
  echo "$sampid";
fi

$gatk Mutect2 -R "/gpfs/data/godley-lab/reference_mouse_genome/mm10/mm10.fa" -I $input -L "/gpfs/data/godley-lab/reference_mouse_genome/mm10/mm10_exons.bed" -O ${sampid}"_somatic.vcf" 
done


