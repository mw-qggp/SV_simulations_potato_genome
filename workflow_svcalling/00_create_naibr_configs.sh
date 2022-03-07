#!/bin/bash

#bash script to create the config files for NAIBR

#Simple simulations

for sample in del_50_300 del_03_5 del_5_50 del_50_250 del_250_1 dup_50_300 dup_03_5 dup_5_50 dup_50_250 dup_250_1 inv_50_300 inv_03_5 inv_5_50 inv_50_250 inv_250_1
do
        for run in run1 ru2 run3 run4 run5
        do
                for ploid in 1_4 2_4 3_4 4_4
                do
                        for cov in 22 45 68 #91
                        do
                                cp naibr.config2 naibr_${sample}_${run}_${ploid}_${cov}.config
                                sed -i "s|XXX|${sample}_${run}_${ploid}_${cov}|g" naibr_${sample}_${run}_${ploid}_${cov}.config
                        done
                done
       done
done


#Complex simulations

sample="complex"
ploid="0"
for run in run1 ru2 run3 run4 run5 run6 run7 run8 run9 run10 run11 run12 run13 run14 run15 run16 run17 run18 run19 run20
do
	for cov in 22 45 68 91
	do
        	cp naibr.config2 naibr_${sample}_${run}_${ploid}_${cov}.config
            sed -i "s|XXX|${sample}_${run}_${ploid}_${cov}|g" naibr_${sample}_${run}_${ploid}_${cov}.config
    done
done
