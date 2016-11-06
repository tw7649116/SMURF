SMURF software package ![GitHub Logo](smurf-logo.jpg)
========================
**SMURF: Short MUltiple Regions Framework** – A software package for microbial profiling based on combining sequencing results of any number of amplified 16S rRNA regions.

Installation 
------------
Download the SMURF package and decompress all the database files and folders as follows:

“tar xf ./Green_Genes_201305/unique_up_to_3_ambiguous_16S/RDP_description.tar”

“gunzip ./Green_Genes_201305/unique_up_to_3_ambiguous_16S/Green_Genes_201305_unique_up_to_3_ambiguous_16S.fasta.gz”

Inputs
------
**Sequences read** – fastq files with the sequenced reads. An example sample sequenced with paired end Illumina MiSeq is provided.  

**Ad hoc database** – a database per region k-mers (an example of the DB for the six primer pair described in the manuscript is provided with the software package)

Output
------
The result of the profiling is csv file with reconstructed groups' information. A group is a set of full-length 16S rRNA sequences that share their sequence over the amplified regions.
Results include:

**Group frequency** – the frequency assigned to each group

**Read count** – number of reads assigned to each group

**Number of sequences** – number of sequences that belong to each group (i.e., the ambiguity)

**Taxonomy** – Classification using the RDP sequence match algorythm.
 
Example
-------
To profile a single sample use a script named "profile_one_sample.m" 

Parameters' description
----------------------

**Sample parameters**

**base_samples_dir**  - is the directory where all samples are located

**sample_name** – is the name of the directory where fastq files for specific samples are located. Notice that the fastq files must be named using the following convention. If the sample_name=’Example’, then for paired end sequencing the files will be names: Example_L001_R1_001.fastq and Example_L001_R2_001.fastq

**primer_set_name** – the name of the primers set used for sequencing the sample

**kmer_len** – the length of the k-mer to be used for profiling

Data preprocessing parameters
-----------------------------
**data_type** – specify whether the reads contain quality scores. Possible values are ‘fasta’ or ‘fastq’.

**pe_flag** - 0/1 flag specifying whether sequencing was single-end or paired-end, respectively.

**qual_th** – minimal Phred quality to be used in "prc_high_qual".

**prc_high_qual** – minimal required proportion of nucleotides in a read, having a Phred score above qual_th. 

**low10_th** – maximal number of base pairs allowed to have Phred score below 10.

**max_num_Ns** – maximal number of ambiguous nucleotides allowed per read. 

**algo_pe_flag** – 0/1 flag specifying whether the reconstruction should be performed assuming single-end or 
paired-end, respectively. This parameter will usually be equal to pe_flag, although pe_flag = 1 and algo_pe_flag = 0 is allowed, while pe_flag = 0 and algo_pe_flag = 1 is not possible.

**max_err_inprimer** - maximal number of mismatches allowed between the primer sequence and the read. Used for assigning a read to a region.

**with_primer_flag** – 0/1 flag specifying whether to remove the primers after assignment of read to regions.

Algorithm parameters
--------------------
**uniS16_dir** – directory of the reference database used for profiling.

**db_filename** – name of the reference (fasta) database file (without extension). 

**filter_reads** – 0/1 flag specifying whether to apply the low abundance data preprocessing filter.

**min_read_freq** - minimal required frequency for a read per region to pass the low frequency reads filter.

**min_read_count** - minimal required count for a read per region to pass the low frequncy reads filter.

**nMM_cut** – maximal number of mismatches allowed when matching reads to k-mers. 

**do_filter** - 0/1 flag specifying whether to apply the data preprocessing bacteria filter.

**pe** – probability of error per nucleotide assumed by the algorithm.

**regions_normalization_scheme** - 'is amplified' (default)/ 'none' / 'perfect match' / 'any match' 

**mixture_type** - 'Multiplex' (default)/'RegionByRegion'.

**tol** – maximal L1 change in the estimate of read proportions vector between algorithm iterations.

**numIter** – maximal number of iteration of the reconstruction algorithm.

