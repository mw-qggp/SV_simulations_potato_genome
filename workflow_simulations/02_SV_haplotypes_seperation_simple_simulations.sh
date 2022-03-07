#!/bin/bash

#bash script to create rmt-files for the simple simulations; Separate SV to the four haplotypes

for category in del_50_300 del_03_5 del_5_50 del_50_250 del_250_1 
#for category in ins_50_300 ins_03_5 ins_5_50 ins_50_250 ins_250_1 
#for category in dup_50_300 dup_03_5 dup_5_50 dup_50_250 dup_250_1 
#for category in inv_50_300 inv_03_5 inv_5_50 inv_50_250 inv_250_1 
#for category in indel_ins 
#for category in indel_del
do 
	for((i=1; i < 21; ++i))
	do
		touch haplotype1_${category}_run${i}_1_4.rmt haplotype2_${category}_run${i}_1_4.rmt haplotype3_${category}_run${i}_1_4.rmt haplotype4_${category}_run${i}_1_4.rmt

		for((j=1; j < 5; ++j))
		do
			echo "#meta_information" >>haplotype${j}_${category}_run${i}_1_4.rmt
			echo "fasta=Agria_assembly_final_2020_21_08_Chr01Chr02.fasta" >>haplotype${j}_${category}_run${i}_1_4.rmt
			echo "md5=3b8e4a3c31d43cbba544cb345cfef8f4" >>haplotype${j}_${category}_run${i}_1_4.rmt
			echo "species_name=Potato_Agria" >>haplotype${j}_${category}_run${i}_1_4.rmt
			echo "assembly_name=dAg_v1.0" >>haplotype${j}_${category}_run${i}_1_4.rmt
			echo -e "\n" >>haplotype${j}_${category}_run${i}_1_4.rmt
			echo "#titv=1" >>haplotype${j}_${category}_run${i}_1_4.rmt
			echo "de_block=1" >>haplotype${j}_${category}_run${i}_1_4.rmt
			echo "du_block=1" >>haplotype${j}_${category}_run${i}_1_4.rmt
			echo "iv_block=1" >>haplotype${j}_${category}_run${i}_1_4.rmt
			echo "in_block=1" >>haplotype${j}_${category}_run${i}_1_4.rmt
			echo -e "\n" >>haplotype${j}_${category}_run${i}_1_4.rmt
			echo "#standard" >>haplotype${j}_${category}_run${i}_1_4.rmt
			echo "std" >>haplotype${j}_${category}_run${i}_1_4.rmt
			echo "it None" >>haplotype${j}_${category}_run${i}_1_4.rmt
			echo "None" >>haplotype${j}_${category}_run${i}_1_4.rmt
			echo -e "\n" >>haplotype${j}_${category}_run${i}_1_4.rmt
			echo "chr 1" >>haplotype${j}_${category}_run${i}_1_4.rmt
		done

		num_variants=$(awk '$1 !~ /#/' ../haploid/*/run${i}/${category}_run${i}.vcf | wc -l)

		ls -1 haplotype*_${category}_run${i}_1_4.rmt | shuf -r | head -n ${num_variants} >random_haplotypes_run${i}.txt

		for((k=1; k < ${num_variants}+1; ++k))
		do
			filename=$(head -n ${k} random_haplotypes_run${i}.txt | tail -n 1)
			#deletions
			awk '$1 !~ /#/ {split($8,a,";"); split(a[3],b,"=-"); print $2"-"$2" de 1 demin " b[2]" demax "b[2]}' haploid/*/run${i}/${category}_run${i}.vcf | head -n ${k} | tail -n 1 >>${filename}
			#insertions
			#awk '$1 !~ /#/ {split($8,a,";"); split(a[3],b,"="); print $2"-"$2" in 1 inmin " b[2]" inmax "b[2]}' haploid/*/run${i}/${category}_run${i}.vcf | head -n ${k} | tail -n 1 >>${filename}
			#duplications
			#awk '$1 !~ /#/ {split($8,a,";"); split(a[3],b,"="); print $2"-"$2" du 1 dumin " b[2]" dumax "b[2]}' haploid/*/run${i}/${category}_run${i}.vcf | head -n ${k} | tail -n 1 >>${filename}
			#inversions
			#awk '$1 !~ /#/ {split($8,a,";"); split(a[2],b,"="); svlen = b[2]-$2; print $2"-"$2" iv 1 ivmin " svlen" ivmax "svlen}' haploid/*/run${i}/${category}_run${i}.vcf | head -n ${k} | tail -n 1 >>${filename}
			#indels del
			#awk '$1 !~ /#/ {split($8,a,";"); split(a[3],b,"-="); print $2"-"$2" de 1 demin " b[2]" demax "b[2]}' haploid/*/run${i}/${category}_run${i}.vcf | head -n ${k} | tail -n 1 >>${filename}
			#indel ins
			#awk '$1 !~ /#/ {split($8,a,";"); split(a[3],b,"="); print $2"-"$2" in 1 inmin " b[2]" inmax "b[2]}' haploid/*/run${i}/${category}_run${i}.vcf | head -n ${k} | tail -n 1 >>${filename}
		done

		rm random_haplotypes_run${i}.txt


		#create 2_4 files before SVs are distributed
		for((l=1; l < 5; ++l))
		do
			cp haplotype${l}_${category}_run${i}_1_4.rmt haplotype${l}_${category}_run${i}_2_4.rmt 
			cp haplotype${l}_${category}_run${i}_1_4.rmt haplotype${l}_${category}_run${i}_3_4.rmt
		done
		
		for((l=1; l < 5; ++l))
		do
			to_replace=$(awk '{split($1,a,"-")} a[1] < prev && $1 ~ /-/ {print}; {prev=a[1]}' haplotype${l}_${category}_run${i}_1_4.rmt | tail -n 1)
			sed -i "/^${to_replace}.*/i chr 2" haplotype${l}_${category}_run${i}_1_4.rmt


			###2/4 and 3/4###
			num_variants_haplo=$(awk '$1 ~ /-/' haplotype${l}_${category}_run${i}_1_4.rmt | wc -l)

			#2/4
			ls -1 haplotype*_${category}_run${i}_2_4.rmt | sed "s/haplotype${l}_${category}_run${i}_2_4.rmt//" | sed -r '/^\s*$/d' | shuf -r | head -n ${num_variants_haplo} >random_haplotypes_2_4.txt
			

			#3/4
			touch random_haplotypes_3_4.txt
			for((w=1; w < ${num_variants_haplo}+1; ++w))
			do
				ls -1 haplotype*_${category}_run${i}_3_4.rmt | sed "s/haplotype${l}_${category}_run${i}_3_4.rmt//" | sed -r '/^\s*$/d' | shuf | head -n 2 >>random_haplotypes_3_4.txt
			done

			#other haplotypes for 2/4
			for((m=1; m < ${num_variants_haplo}+1; ++m))
			do
				#2/4
				filename=$(head -n ${m} random_haplotypes_2_4.txt | tail -n 1)
				awk '$1 ~ /-/' haplotype${l}_${category}_run${i}_1_4.rmt | head -n ${m} | tail -n 1 >>${filename}
			done

			for((m=1; m < ${num_variants_haplo}+1; ++m))
			do
				#3/4
				filename=$(head -n ${m} random_haplotypes_3_4.txt | tail -n 1)
				awk '$1 ~ /-/' haplotype${l}_${category}_run${i}_1_4.rmt | head -n ${m} | tail -n 1 >>${filename}
				
				filename=$(head -n $((${m}+1)) random_haplotypes_3_4.txt | tail -n 1)
				awk '$1 ~ /-/' haplotype${l}_${category}_run${i}_1_4.rmt | head -n ${m} | tail -n 1 >>${filename}
				
				m=$((${m}+1))

			done
			
			rm random_haplotypes_2_4.txt
			rm random_haplotypes_3_4.txt
			
			#add chromosome to rmt files

			for((y=1; y < 5; ++y))
			do

				for haps in 2 3
				do
					#2/4
					#try new
					#add chr2
					to_replace_line=()

					num_loop=$(awk '{split($1,a,"-")} a[1] < prev && $1 ~ /-/ && prev-a[1] > 70000000 && prev != "chr" && a[1] != "chr" {print}; {prev=a[1]}' haplotype${y}_${category}_run${i}_${haps}_4.rmt | wc -l)

					for((x=1; x < ${num_loop}+1; ++x))
					do
						to_replace=$(awk '{split($1,a,"-")} a[1] < prev && $1 ~ /-/ && prev-a[1] > 70000000 && prev != "chr" && a[1] != "chr" {print}; {prev=a[1]}' haplotype${y}_${category}_run${i}_${haps}_4.rmt | head -n ${x} | tail -n 1)
						#echo "${to_replace}"
						to_replace_line[${x}]=$(awk "/${to_replace}/{print NR}" haplotype${y}_${category}_run${i}_${haps}_4.rmt)
					done
						
					jumper=1	
					for replacement in "${to_replace_line[@]}" 
					do
						if [ ${jumper} -ne 2 ]
						then
							sed -i "${replacement}ichr 2" haplotype${y}_${category}_run${i}_${haps}_4.rmt
						fi
						((++jumper))
					done

					##add chr1
					to_replace_line=()

					num_loop=$(awk '{split($1,a,"-")} a[1] < prev && $1 ~ /-/ && prev-a[1] < 70000000 && prev != "chr" && a[1] != "chr" {print}; {prev=a[1]}' haplotype${y}_${category}_run${i}_${haps}_4.rmt | wc -l)

					for((x=1; x < ${num_loop}+1; ++x))
					do
						to_replace=$(awk '{split($1,a,"-")} a[1] < prev && $1 ~ /-/ && prev-a[1] < 70000000 && prev != "chr" && a[1] != "chr" {print}; {prev=a[1]}' haplotype${y}_${category}_run${i}_${haps}_4.rmt | head -n ${x} | tail -n 1)
						to_replace_line[${x}]=$(awk "/${to_replace}/{print NR}" haplotype${y}_${category}_run${i}_${haps}_4.rmt)
					done
							
					for replacement in "${to_replace_line[@]}" 
					do
						sed -i "${replacement}ichr 1" haplotype${y}_${category}_run${i}_${haps}_4.rmt
					done

				done
			done
		done
	done
done
