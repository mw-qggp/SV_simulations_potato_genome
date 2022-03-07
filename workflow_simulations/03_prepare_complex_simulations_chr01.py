from random import randint
import sys
import random

def random_position(max_count_1,max_count_2,max_count_3,max_count_4,max_count_5,max_count_6,max_mutations,dict_sv):

	if bool(dict_sv) == False:

		dict_sv_positions = {}

		mutation = 0
		dict_sv_positions[mutation] = [-2,-1]
	
	else:
		mutation = len(dict_sv.keys())

		dict_sv_positions = {}
		
		for key in dict_sv.keys():
			
			dict_sv_positions[key] = dict_sv[key]

	##########

	count_1 = 0
	count_2 = 0
	count_3 = 0
	count_4 = 0
	count_5 = 0
	count_6 = 0 

	i = 0

	while mutation < max_mutations:

		#random position
		position = randint(0,89719359)

		
		#random SV length category
		category = randint(1,6)

		#create start and stop of SV
		if category == 1:

			sv_length = randint(50,300)

			sv_start = position
			sv_stop = position + sv_length

		if category == 2:

			sv_length = randint(301,5000)

			sv_start = position
			sv_stop = position + sv_length

		if category == 3:

			sv_length = randint(5001,50000)

			sv_start = position
			sv_stop = position + sv_length

		if category == 4:

			sv_length = randint(50001,250000)

			sv_start = position
			sv_stop = position + sv_length

		if category == 5:

			sv_length = randint(250001,1000000)

			sv_start = position
			sv_stop = position + sv_length


		#indel category, only de and ins!
		if category == 6:

			sv_length = randint(2,49)

			sv_start = position
			sv_stop = position + sv_length			


		####check

		for control_positions in dict_sv_positions.keys():
			
			if (sv_start >= dict_sv_positions[control_positions][0] and sv_stop <= dict_sv_positions[control_positions][1]) or (sv_start <= dict_sv_positions[control_positions][0] and sv_stop >= dict_sv_positions[control_positions][1]) or (sv_start >= dict_sv_positions[control_positions][0] and sv_stop >= dict_sv_positions[control_positions][1] and sv_start <= dict_sv_positions[control_positions][1]) or (sv_start <= dict_sv_positions[control_positions][0] and sv_stop <= dict_sv_positions[control_positions][1] and sv_stop >= dict_sv_positions[control_positions][0]):

				i = 0
				break
			else:
				i = 1
				
		if i == 1:

			if (sv_stop - sv_start) >= 50 and  (sv_stop - sv_start) <= 300:
				count_1 += 1
			if (sv_stop - sv_start) >= 301 and (sv_stop - sv_start) <= 5000:
				count_2 += 1
			if (sv_stop - sv_start) >= 5001 and (sv_stop - sv_start) <= 50000:
				count_3 += 1
			if (sv_stop - sv_start) >= 50001 and (sv_stop - sv_start) <= 250000:
				count_4 += 1
			if (sv_stop - sv_start) >= 250001 and (sv_stop - sv_start) <= 1000000:
				count_5 += 1
			if (sv_stop - sv_start) < 50:
				count_6 += 1

			if count_1 <= max_count_1 and (sv_stop - sv_start) >= 50 and  (sv_stop - sv_start) <= 300:
				
				mutation += 1
				dict_sv_positions[mutation] = [sv_start,sv_stop]

			
			if count_2 <= max_count_2 and (sv_stop - sv_start) >= 301 and (sv_stop - sv_start) <= 5000:
				
				mutation += 1
				dict_sv_positions[mutation] = [sv_start,sv_stop]
			
			if count_3 <= max_count_3 and (sv_stop - sv_start) >= 5001 and (sv_stop - sv_start) <= 50000:
				
				mutation += 1
				dict_sv_positions[mutation] = [sv_start,sv_stop]

			if count_4 <= max_count_4 and (sv_stop - sv_start) >= 50001 and (sv_stop - sv_start) <= 250000:
				
				mutation += 1
				dict_sv_positions[mutation] = [sv_start,sv_stop]

			if count_5 <= max_count_5 and (sv_stop - sv_start) >= 250001 and (sv_stop - sv_start) <= 1000000:
				
				mutation += 1
				dict_sv_positions[mutation] = [sv_start,sv_stop]

			if count_6 <= max_count_6 and (sv_stop - sv_start) < 50:
				
				mutation += 1
				dict_sv_positions[mutation] = [sv_start,sv_stop]


	return dict_sv_positions

def rmt_format(dict_svs,svtype,max_mutations,dict_svtype_before):

	##dict_svs2 = dict(sorted(dict_svs.items(), key=lambda item: item[1]))

	dict_svs2 = dict_svs

	#iterate randomly through dict; seperation to 4 haplotypes with different allele frequencies
	keys=list(dict_svs2.keys()) # List of keys
	random.shuffle(keys)

	counter = 0

	#seperation to 4 haplotypes with different allele frequencies; do it after each other because of random order

	outfile1 = open("haplotype1_chr01.rmt", 'a')
	outfile2 = open("haplotype2_chr01.rmt", 'a')
	outfile3 = open("haplotype3_chr01.rmt", 'a')
	outfile4 = open("haplotype4_chr01.rmt", 'a')

	for sv in keys:

		if sv not in dict_svtype_before:

			sv_length = dict_svs2[sv][1] - dict_svs2[sv][0]

			if counter <= 0.25*max_mutations:

				#print in 1 output haplotype-rmt file

				hap = list(range(1, 5))
				random.shuffle(hap)

				locals()["outfile"+str(hap[0])].write(str(dict_svs2[sv][0])+"-"+str(dict_svs2[sv][0])+" "+svtype+" 1 "+svtype+"min "+str(sv_length)+" "+svtype+"max "+str(sv_length)+"\n")


			if counter <= 0.5*max_mutations and counter > 0.25*max_mutations:

				#print in 2 output haplotype-rmt file
			
				hap = list(range(1, 5))
				random.shuffle(hap)

				locals()["outfile"+str(hap[0])].write(str(dict_svs2[sv][0])+"-"+str(dict_svs2[sv][0])+" "+svtype+" 1 "+svtype+"min "+str(sv_length)+" "+svtype+"max "+str(sv_length)+"\n")
				locals()["outfile"+str(hap[1])].write(str(dict_svs2[sv][0])+"-"+str(dict_svs2[sv][0])+" "+svtype+" 1 "+svtype+"min "+str(sv_length)+" "+svtype+"max "+str(sv_length)+"\n")

			if counter <= 0.75*max_mutations and counter > 0.5*max_mutations:	

				#print in 3 output haplotype-rmt file

				hap = list(range(1, 5))
				random.shuffle(hap)

				locals()["outfile"+str(hap[0])].write(str(dict_svs2[sv][0])+"-"+str(dict_svs2[sv][0])+" "+svtype+" 1 "+svtype+"min "+str(sv_length)+" "+svtype+"max "+str(sv_length)+"\n")
				locals()["outfile"+str(hap[1])].write(str(dict_svs2[sv][0])+"-"+str(dict_svs2[sv][0])+" "+svtype+" 1 "+svtype+"min "+str(sv_length)+" "+svtype+"max "+str(sv_length)+"\n")
				locals()["outfile"+str(hap[2])].write(str(dict_svs2[sv][0])+"-"+str(dict_svs2[sv][0])+" "+svtype+" 1 "+svtype+"min "+str(sv_length)+" "+svtype+"max "+str(sv_length)+"\n")


			if counter > 0.75*max_mutations:

				#print in 4 output haplotype-rmt file

				random.shuffle(hap)

				locals()["outfile"+str(hap[0])].write(str(dict_svs2[sv][0])+"-"+str(dict_svs2[sv][0])+" "+svtype+" 1 "+svtype+"min "+str(sv_length)+" "+svtype+"max "+str(sv_length)+"\n")
				locals()["outfile"+str(hap[1])].write(str(dict_svs2[sv][0])+"-"+str(dict_svs2[sv][0])+" "+svtype+" 1 "+svtype+"min "+str(sv_length)+" "+svtype+"max "+str(sv_length)+"\n")
				locals()["outfile"+str(hap[2])].write(str(dict_svs2[sv][0])+"-"+str(dict_svs2[sv][0])+" "+svtype+" 1 "+svtype+"min "+str(sv_length)+" "+svtype+"max "+str(sv_length)+"\n")
				locals()["outfile"+str(hap[3])].write(str(dict_svs2[sv][0])+"-"+str(dict_svs2[sv][0])+" "+svtype+" 1 "+svtype+"min "+str(sv_length)+" "+svtype+"max "+str(sv_length)+"\n")		

			counter += 1

	outfile1.close()
	outfile2.close()
	outfile3.close()
	outfile4.close()

	return dict_svs2


def random_SNPs(dict_sv,svtype,max_mutations):

	outfile1 = open("haplotype1_chr01.rmt", 'a')
	outfile2 = open("haplotype2_chr01.rmt", 'a')
	outfile3 = open("haplotype3_chr01.rmt", 'a')
	outfile4 = open("haplotype4_chr01.rmt", 'a')

	counter = 0
	list_snps = []

	while counter < max_mutations:

		snp_pos = randint(0,89719359)

		for sv in dict_sv.keys():

			if snp_pos >= dict_sv[sv][0] and snp_pos <= dict_sv[sv][1] and snp_pos not in list_snps:

				break

			else:

				if counter <= 0.25*max_mutations:

					#print in 1 output haplotype-rmt file

					hap = list(range(1, 5))
					random.shuffle(hap)

					locals()["outfile"+str(hap[0])].write(str(snp_pos)+"-"+str(snp_pos)+" "+svtype+" 1\n")


				if counter <= 0.5*max_mutations and counter > 0.25*max_mutations:

					#print in 2 output haplotype-rmt file
			
					hap = list(range(1, 5))
					random.shuffle(hap)

					locals()["outfile"+str(hap[0])].write(str(snp_pos)+"-"+str(snp_pos)+" "+svtype+" 1\n")
					locals()["outfile"+str(hap[1])].write(str(snp_pos)+"-"+str(snp_pos)+" "+svtype+" 1\n")

				if counter <= 0.75*max_mutations and counter > 0.5*max_mutations:	

					#print in 3 output haplotype-rmt file

					hap = list(range(1, 5))
					random.shuffle(hap)

					locals()["outfile"+str(hap[0])].write(str(snp_pos)+"-"+str(snp_pos)+" "+svtype+" 1\n")
					locals()["outfile"+str(hap[1])].write(str(snp_pos)+"-"+str(snp_pos)+" "+svtype+" 1\n")
					locals()["outfile"+str(hap[2])].write(str(snp_pos)+"-"+str(snp_pos)+" "+svtype+" 1\n")


				if counter > 0.75*max_mutations:

					#print in 4 output haplotype-rmt file

					random.shuffle(hap)

					locals()["outfile"+str(hap[0])].write(str(snp_pos)+"-"+str(snp_pos)+" "+svtype+" 1\n")
					locals()["outfile"+str(hap[1])].write(str(snp_pos)+"-"+str(snp_pos)+" "+svtype+" 1\n")
					locals()["outfile"+str(hap[2])].write(str(snp_pos)+"-"+str(snp_pos)+" "+svtype+" 1\n")
					locals()["outfile"+str(hap[3])].write(str(snp_pos)+"-"+str(snp_pos)+" "+svtype+" 1\n")		

			
				counter += 1
				list_snps.append(snp_pos)

				break

	outfile1.close()
	outfile2.close()
	outfile3.close()
	outfile4.close()



outfile1 = open("haplotype1_chr01.rmt", 'a')
outfile2 = open("haplotype2_chr01.rmt", 'a')
outfile3 = open("haplotype3_chr01.rmt", 'a')
outfile4 = open("haplotype4_chr01.rmt", 'a')

list_files = [outfile1,outfile2,outfile3,outfile4]

for file in list_files:

	file.write("#meta−information\n")
	file.write("fasta=Agria_assembly_final_2020_21_08_Chr01Chr02.fasta\n")
	file.write("md5=3b8e4a3c31d43cbba544cb345cfef8f4\n")
	file.write("species_name=Potato_Agria\n")
	file.write("assembly_name=dAg_v1.0\n")
	file.write("\n")
	file.write("#standard\n")
	file.write("std\n")
	file.write("it None\n")
	file.write("None\n")
	file.write("\n")
	file.write("#range definitions\n")
	file.write("chr 1\n")

	file.close()

#deletions
dict_dummy = {}
dict_svs = random_position(100,100,40,10,2,200,452,dict_dummy)
dict_deletions = rmt_format(dict_svs,"de",452,dict_dummy)

#insertions
dict_insertions = random_position(100,100,40,10,2,200,904,dict_deletions)
dict_deletions_insertions = rmt_format(dict_insertions,"in",452,dict_deletions)

#inversions
dict_inversions = random_position(30,8,8,4,4,0,958,dict_deletions_insertions)
dict_deletions_insertions_inversions = rmt_format(dict_inversions,"iv",54,dict_deletions_insertions)

#duplications
dict_duplications = random_position(30,8,12,10,2,0,1020,dict_deletions_insertions_inversions)
dict_deletions_insertions_inversions_duplications = rmt_format(dict_duplications,"du",62,dict_deletions_insertions_inversions)

#SNPs
random_SNPs(dict_deletions_insertions_inversions_duplications,"sn",50000)

