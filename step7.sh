#PBS -N mchek2
#PBS -S /bin/bash
#PBS -l walltime=96:00:00
#PBS -l nodes=1:ppn=4
#PBS -l mem=40gb
#PBS -o /scratch/akoppayi/process/CHEK2_MM/new_data/Batch1/logfiles/chek2.out
#PBS -e /scratch/akoppayi/process/CHEK2_MM/new_data/Batch1/logfiles/chek2.err
#PBS -d /scratch/akoppayi/process/CHEK2_MM/new_data/Batch1
module load gcc/4.9.4
module load perl/5.18.4


for input in `ls *vcf`; do
echo $input
/gpfs/data/godley-lab/reference_mouse_genome/annovar/table_annovar.pl $input /gpfs/data/godley-lab/reference_mouse_genome/annovar/mm10/ -buildver mm10 -out ${input%.vcf} -remove -protocol refGene -operation g -nastring . -vcfinput ;
 done





