#!/bin/bash

#bash script to create mutated genomes for the different SV types and SV length categories

END=20
for i in $(seq 1 $END)
do 
	#Deletions
	/gpfs/project/projects/qggp/src/Mutation-Simulator/mutation-simulator2.py -o del_50_300_run${i} Agria_assembly_final_2020_21_08_Chr01Chr02.fasta args -de 7.033443e-06 -demin 50 -demax 300 
	/gpfs/project/projects/qggp/src/Mutation-Simulator/mutation-simulator2.py -o del_03_5_run${i}  Agria_assembly_final_2020_21_08_Chr01Chr02.fasta args -de 7.033443e-06 -demin 301 -demax 5000 
	/gpfs/project/projects/qggp/src/Mutation-Simulator/mutation-simulator2.py -o del_5_50_run${i} Agria_assembly_final_2020_21_08_Chr01Chr02.fasta args -de 7.033443e-06 -demin 5001 -demax 50000 
	/gpfs/project/projects/qggp/src/Mutation-Simulator/mutation-simulator2.py -o del_50_250_run${i} Agria_assembly_final_2020_21_08_Chr01Chr02.fasta args -de 7.033443e-07 -demin 50001 -demax 250000 
	/gpfs/project/projects/qggp/src/Mutation-Simulator/mutation-simulator2.py -o del_250_1_run${i} Agria_assembly_final_2020_21_08_Chr01Chr02.fasta args -de 3.516721e-07 -demin 250001 -demax 1000000 

	#Insertions
	/gpfs/project/projects/qggp/src/Mutation-Simulator/mutation-simulator2.py -o ins_50_300_run${i} Agria_assembly_final_2020_21_08_Chr01Chr02.fasta args -in 7.033443e-06 -inmin 50 -inmax 300 
	/gpfs/project/projects/qggp/src/Mutation-Simulator/mutation-simulator2.py -o ins_03_5_run${i} Agria_assembly_final_2020_21_08_Chr01Chr02.fasta args -in 7.033443e-06 -inmin 301 -inmax 5000 
	/gpfs/project/projects/qggp/src/Mutation-Simulator/mutation-simulator2.py -o ins_5_50_run${i} Agria_assembly_final_2020_21_08_Chr01Chr02.fasta args -in 7.033443e-06 -inmin 5001 -inmax 50000 
	/gpfs/project/projects/qggp/src/Mutation-Simulator/mutation-simulator2.py -o ins_50_250_run${i} Agria_assembly_final_2020_21_08_Chr01Chr02.fasta args -in 7.033443e-07 -inmin 50001 -inmax 250000 
	/gpfs/project/projects/qggp/src/Mutation-Simulator/mutation-simulator2.py -o ins_250_1_run${i} Agria_assembly_final_2020_21_08_Chr01Chr02.fasta args -in 3.516721e-07 -inmin 250001 -inmax 1000000 

	#Duplications
	/gpfs/project/projects/qggp/src/Mutation-Simulator/mutation-simulator2.py -o dup_50_300_run${i} Agria_assembly_final_2020_21_08_Chr01Chr02.fasta args -du 7.033443e-06 -dumin 50 -dumax 300 
	/gpfs/project/projects/qggp/src/Mutation-Simulator/mutation-simulator2.py -o dup_03_5_run${i} Agria_assembly_final_2020_21_08_Chr01Chr02.fasta args -du 7.033443e-06 -dumin 301 -dumax 5000 
	/gpfs/project/projects/qggp/src/Mutation-Simulator/mutation-simulator2.py -o dup_5_50_run${i} Agria_assembly_final_2020_21_08_Chr01Chr02.fasta args -du 7.033443e-06 -dumin 5001 -dumax 50000 
	/gpfs/project/projects/qggp/src/Mutation-Simulator/mutation-simulator2.py -o dup_50_250_run${i} Agria_assembly_final_2020_21_08_Chr01Chr02.fasta args -du 7.033443e-07 -dumin 50001 -dumax 250000 
	/gpfs/project/projects/qggp/src/Mutation-Simulator/mutation-simulator2.py -o dup_250_1_run${i} Agria_assembly_final_2020_21_08_Chr01Chr02.fasta args -du 3.516721e-07 -dumin 250001 -dumax 1000000 

	#Inversions
	/gpfs/project/projects/qggp/src/Mutation-Simulator/mutation-simulator2.py -o inv_50_300_run${i} Agria_assembly_final_2020_21_08_Chr01Chr02.fasta args -iv 7.033443e-06 -ivmin 50 -ivmax 300 
	/gpfs/project/projects/qggp/src/Mutation-Simulator/mutation-simulator2.py -o inv_03_5_run${i} Agria_assembly_final_2020_21_08_Chr01Chr02.fasta args -iv 7.033443e-06 -ivmin 301 -ivmax 5000 
	/gpfs/project/projects/qggp/src/Mutation-Simulator/mutation-simulator2.py -o inv_5_50_run${i} Agria_assembly_final_2020_21_08_Chr01Chr02.fasta args -iv 7.033443e-06 -ivmin 5001 -ivmax 50000 
	/gpfs/project/projects/qggp/src/Mutation-Simulator/mutation-simulator2.py -o inv_50_250_run${i} Agria_assembly_final_2020_21_08_Chr01Chr02.fasta args -iv 7.033443e-07 -ivmin 50001 -ivmax 250000 
	/gpfs/project/projects/qggp/src/Mutation-Simulator/mutation-simulator2.py -o inv_250_1_run${i} Agria_assembly_final_2020_21_08_Chr01Chr02.fasta args -iv 3.516721e-07 -ivmin 250001 -ivmax 1000000 
done