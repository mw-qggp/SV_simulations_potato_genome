# Evaluation of SV detection in the tetraploid potato genome using simulated linked-read sequencing

### Snakemake workflow to create mutated genomes of the first and second chromosome of the dAg1 potato reference sequence (doi.org/10.6084/m9.figshare.14604780). Included algorithms are:

1) Mutation-Simulator (version 2.0.3) (https://github.com/mkpython3/Mutation-Simulator)
2) LRsim (version 1.0) (https://github.com/aquaskyline/LRSIM)
3) LongRanger wgs (version 2.2.2) (https://github.com/10XGenomics/longranger)

### Snakemake workflow for SV detection based on simulated linked-read sequencing data. Included SV callers are:

1) Manta (version 1.6) (https://github.com/Illumina/manta)
2) LEVIATHAN (version 1.0.1) (https://github.com/morispi/LEVIATHAN)
3) LinkedSV (version 1.0.1) (https://github.com/WGLab/LinkedSV)
4) NAIBR (https://github.com/raphael-group/NAIBR)
5) VALOR2 (version 2.1.5) (https://github.com/BilkentCompGen/valor)
6) Novel-X (version 0.3) (https://github.com/1dayac/Novel-X)
