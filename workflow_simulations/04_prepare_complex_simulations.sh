#!/bin/bash

#bash script to create rmt-files for the complex simulations

#0 = ploid in Snakefile
#sample = complex in Snakefile
#First rule of complex simulations is read_simulation in Snakefile

END=20
for i in $(seq 1 $END)
do
	python3 04_prepare_complex_simulations_chr01.py
	python3 04_prepare_complex_simulations_chr02.py

	for j in 1 2 3 4
	do
		cat haplotype${j}_chr01.rmt haplotype${j}_chr02.rmt >haplotype${j}_complex_run{i}_0_sorted.rmt

		#Remove this line from rmt-file
		sed -i '/-2--2 de 1 demin 1 demax 1/d' haplotype${j}_complex_run{i}_0_sorted.rmt

		#Complex simulations
		/gpfs/project/projects/qggp/src/Mutation-Simulator/mutation-simulator2.py -o haplotype${i}_complex_run${i}_0 /gpfs/project/mawei111/10X_simulations_PotatoTools/Agria_assembly_final_2020_21_08_Chr01Chr02.fasta rmt haplotype${j}_complex_run{i}_0_sorted.rmt
	done

	for rate in 22 45 68 91
	do
		cat cat haplotype1_complex_run{i}_0_sorted.fa haplotype2_complex_run${i}_0_sorted.fa haplotype3_complex_run${i}_0_sorted.fa haplotype4_complex_run${i}_0_sorted.fa | awk '/^>/ {print ">chr" ++i; next} {print}' >4haplotypes_complex_${run}_0_${rate}.fa
	done
done