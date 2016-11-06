SMURF software package ![GitHub Logo](smurf-logo.jpg)
========================
**SMURF: Short MUltiple Regions Framework** – is software package that produces a full taxonomic description of the microbial community based on sequencing of any number of short regions.

Installation 
------------
Download the SMURF package from https://github.com/NoamShental/SMURF and decompress all the data base files and folders as follows:

“tar xf ./Green_Genes_201305/unique_up_to_3_ambiguous_16S/RDP_description.tar”

“gunzip ./Green_Genes_201305/unique_up_to_3_ambiguous_16S/Green_Genes_201305_unique_up_to_3_ambiguous_16S.fasta.gz”

Inputs
------
**Sequences read** – fastq files with the sequenced reads. An example sample sequenced with paired end Illumina MiSeq is provided.  

**Ad hoc database** – a database of per region k-mers (an example of the DB for the 6 regions primers is provided with the software package)

Output
------
The result of the profiling is csv file with reconstructed groups information including:

**Group frequency** – the frequency assigned to the group

**Read count** – number of reads assigned to the group

**Number of sequences** – number od sequences (ambiguity) of the group

**Taxonomy** – all the result from RDP sequence matching 
 
Example
-------
To profile a single sample use a script named profile_one_sample.m 

Parameters description
----------------------
**Sample parameters**

**base_samples_dir**  - is the directory where all the samples are located

**sample_name** – is the name of the directory where fastq files for specific sample are located. Notice that the fastq files must be named using the following convention. If the sample_name=’Example’, then for paired end sequencing the files will be names: Example_L001_R1_001.fastq and Example_L001_R2_001.fastq

**primer_set_name** – the name of the primers set used with the sample

**kmer_len** – the length of the k-mer to be used for profiling

Data preprocessing parameters
-----------------------------
**data_type** – specify whether the reads have quality score. Possible values are ‘fasta’ or ‘fastq’

**pe_flag** - 0/1 flag specifying if the sequencing was single/paired end respectively

**qual_th** – minimal quality required in at least in prc_high_qual base pairs

**prc_high_qual** – minimal required proportion of base pairs with Phred score above qual_th per read

**low10_th** – maximal number of base pairs allowed to have Phred score below 10

**max_num_Ns** – maximal number of ambiguous nucleotides allowed per read 

**algo_pe_flag** – 0/1 flag specifying whether the reconstruction should be performed assuming single/
paired end respectively. This parameter will usually be equal pe_flag, although pe_flag = 1 and algo_pe_flag = 0 is allowed, while pe_flag = 0 and algo_pe_flag = 1 is not possible.

**max_err_inprimer** - maximal number of mismatches allowed between the primer sequence and the read for assigning the read to a region
**with_primer_flag** – 0/1 flag specifying whether to remove the primers after assignment of read to regions

Algorithm parameters
--------------------
**uniS16_dir** – directory of the reference data base used for profiling

**db_filename** – name of the reference (fasta) data base file without extension 

**filter_reads** – 0/1 flag specifying whether to apply the low abundance data preprocessing filter

**min_read_freq** - minimal required frequency for a read per region to pass the low abundance reads 
filter

**min_read_count** - minimal required count for a read per region to pass the low abundance reads 
filter

**nMM_cut** – maximal number of mismatches allowed when matching reads to k-mers 

**pe** – probability of error per nucleotide assumed by the algorithm

**do_filter** - 0/1 flag specifying whether to apply the data preprocessing bacteria filter

**regions_normalization_scheme** - 'is amplified' (default)/ 'none' / 'perfect match' / 'any match' 

**mixture_type** - 'Multiplex' (default)/'RegionByRegion'

**tol** – maximal L1 change in the estimate of read proportions vector between algorithm iterations

**numIter** – maximal number of iteration of the reconstruction algorithm

