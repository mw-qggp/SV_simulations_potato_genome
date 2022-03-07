#!/bin/bash

for sample in del_50_300 del_03_5 del_5_50 del_50_250 del_250_1 ins_50_300 ins_03_5 ins_5_50 ins_50_250 ins_250_1 dup_50_300 dup_03_5 dup_5_50 dup_50_250 dup_250_1 inv_50_300 inv_03_5 inv_5_50 inv_50_250 inv_250_1
do
	for run in run1 run2 run3 run4 run5  
	do
		for ploid in 1_4 2_4 3_4 4_4
		do
			for rate in 22 45 68 91
			do
				cat haplotype1_${sample}_${run}_${ploid}.fa haplotype2_${sample}_${run}_${ploid}.fa haplotype3_${sample}_${run}_${ploid}.fa haplotype4_${sample}_${run}_${ploid}.fa | awk '/^>/ {print ">chr" ++i; next} {print}' >4haplotypes_${sample}_${run}_${ploid}_${rate}.fa		
			done
			
			rm haplotype1_${sample}_${run}_${ploid}.fa haplotype2_${sample}_${run}_${ploid}.fa haplotype3_${sample}_${run}_${ploid}.fa haplotype4_${sample}_${run}_${ploid}.fa
			rm haplotype1_${sample}_${run}_${ploid}.vcf haplotype2_${sample}_${run}_${ploid}.vcf haplotype3_${sample}_${run}_${ploid}.vcf haplotype4_${sample}_${run}_${ploid}.vcf
		
		done
	done
done
