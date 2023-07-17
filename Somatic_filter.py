#Somatic_Calls_Merge_and_filter
#Last_Updated-11/29/2022


import numpy as np
import pandas as pd
import glob
import os
from collections import defaultdict

vcf_columns = ['Chr', 'Start', 'End', 'Ref', 'Alt', 'Func.refGene', 'Gene.refGene',
 'GeneDetail.refGene', 'ExonicFunc.refGene', 'AAChange.refGene','Otherinfo','#QUAL','DP','#CHROM','POS','#ID','REF','ALT','QUAL','FILTER','INFO','FORMAT','SeqInfo']




paths = []
#gene_panel_file=input("Enter the file name of Gene Panel:\n")


#with open(gene_panel_file,"r") as f:
 #genes = f.read().split("\n")



#keep_intronic=input("Do you want to keep intronic variants? Yes or No\n")

#if keep_intronic == "Yes":
 # print("Yes,Keeping Intronic Variants")
  #keep_intronic=genes
#else:
   #print("Excluding intronic variants")
   #keep_intronic=[""]






appended_data = []


#get number of directories and paths
folders = input("How many folders do you have filtered files in? \n")
for i in range(int(folders)):
    path = input("Enter path to the folder %s the annotated_txt files:\n" %(i+1,))
    paths.append(path)

output_filename=input("Enter output filename with .xlsx at the end:\n")
depth=int(input("What is the read depth cutoff? \n"))

i=0

for path in paths:
    for filename in glob.glob(os.path.join(path, '*multianno.txt')):
        i+=1
        print(filename)
        sample = filename.split("/")[-1]
        print(sample)
        #read in txt as a dataframe
        unfiltered = pd.read_csv(filename, delimiter = '\t',dtype = str, names = vcf_columns, lineterminator = "\n", header = 0)
        unfiltered["ID"] = sample.split("_")[0]
        unfiltered.drop(columns=["#ID","#CHROM","#QUAL"],inplace=True)
        #replace null data
        #select rows from unfiltered where the string based on mutation type and population frequency
        # filter by genes of interest
        unfiltered['AF']=unfiltered['SeqInfo'].str.split(':').str[2].astype(str)
               
        
        unfiltered["DP"]=pd.to_numeric(unfiltered["DP"])
        #unfiltered["AF"]=pd.to_numeric(unfiltered["AF"])
        #unfiltered['VAF']=unfiltered['AF']/unfiltered['DP']
        filtered = unfiltered.loc[(unfiltered['FILTER'] == 'PASS')]
        filtered = filtered.loc[(filtered['DP'] >= depth)]
        file_filt=[path+'/'+sample.split("_")[0]+"_passvariants.csv"]
        print(file_filt[0])
        filtered.to_csv(file_filt[0],sep=',',index=False)
        #filtered = filtered.loc[(unfiltered['VAF'] >= 0.00)]
            


        #keep/filter out intronic variants
         
        appended_data.append(filtered)


#print(intronic_filtered)


#OUT = pd.concat(appended_data, sort = False)
OUT = pd.concat(appended_data, sort = False)

#NOTE: change the path in output file for your own computer
output_file = [path+"/"+output_filename]
writer = pd.ExcelWriter(output_file[0])
OUT.to_excel(writer,'Filtered',index=False)
writer.save()
