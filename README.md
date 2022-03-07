# Evaluation of SV detection in the tetraploid potato genome using simulated linked-read sequencing

Snakemake/5.10.0 was used.

### Snakemake workflow to create mutated genomes of the first and second chromosome of the dAg1 potato reference sequence (doi.org/10.6084/m9.figshare.14604780). Included algorithms are:

1) Mutation-Simulator (version 2.0.3) (https://github.com/mkpython3/Mutation-Simulator)
2) LRsim (version 1.0) (https://github.com/aquaskyline/LRSIM)
3) LongRanger wgs (version 2.2.2) (https://github.com/10XGenomics/longranger)

Additional packages needed to be available:

Python/3.6.5, Perl/5.18.1, freebayes/1.3.1


### Snakemake workflow for SV detection based on simulated linked-read sequencing data. Included SV callers are:

1) Manta (version 1.6) (https://github.com/Illumina/manta)
2) LEVIATHAN (version 1.0.1) (https://github.com/morispi/LEVIATHAN)
3) LinkedSV (version 1.0.1) (https://github.com/WGLab/LinkedSV)
4) NAIBR (https://github.com/raphael-group/NAIBR)
5) VALOR2 (version 2.1.5) (https://github.com/BilkentCompGen/valor)
6) Novel-X (version 0.3) (https://github.com/1dayac/Novel-X)

Additional packages needed to be available:

Python/3.6.5, Snakemake/6.4.0, Boost/1.70.0, zlib/1.2.11, cmake/3.19.1, gcc/8.1.0, Perl/5.18.1, SamTools/1.11, bedtools/2.26.0, gcc/8.1.0, intel/xe2020.2, BLAST+/2.11.0, Parallel/20150422

### References

[1] Weisweiler, M. and Stich, B. (2022) Benchmarking of structural variant detection in the tetraploid potato genome using linked-read sequencing (In preparation)
