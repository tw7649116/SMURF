


% Set the 16S reference DB
uniS16_dir = './Green_Genes_201305/unique_up_to_3_ambiguous_16S';
db_filename = 'GreenGenes_201305_unique_up_to_3_ambiguous_16S.mat';


% The primers seqs
switch primer_set_name
    case 'amp6Regions'
        % 6 regions primers
        primers_seq{1,1} = 'TGGCGGACGGGTGAGTAA';
        primers_seq{1,2} = 'CTGCTGCCTCCCGTAGGA';
        primers_seq{2,1} = 'TCCTACGGGAGGCAGCAG';
        primers_seq{2,2} = 'TATTACCGCGGCTGCTGG';
        primers_seq{3,1} = 'CAGCAGCCGCGGTAATAC';
        primers_seq{3,2} = 'CGCATTTCACCGCTACAC';
        primers_seq{4,1} = 'AGGATTAGATACCCTGGT';
        primers_seq{4,2} = 'GAATTAAACCACATGCTC';
        primers_seq{5,1} = 'GCACAAGCGGTGGAGCAT';
        primers_seq{5,2} = 'CGCTCGTTGCGGGACTTA';
        primers_seq{6,1} = 'AGGAAGGTGGGGATGACG';
        primers_seq{6,2} = 'CCCGGGAACGTATTCACC';

        DB_kmer_len = 130;
    case 'V3V4'
        % V3-V4 regions primers
        primers_seq{1,1} = 'CCTACGGGNGGCWGCAG';
        primers_seq{1,2} = 'GACTACHVGGGTATCTAATCC';

        DB_kmer_len = 240;
    case 'V4'
        % V4 regions primers
        primers_seq{1,1} = 'GTGCCAGCMGCCGCGGTAA';
        primers_seq{1,2} = 'GGACTACHVGGGTWTCTAAT';

        DB_kmer_len = 240;
end

% Generate kmers DB path and filename
suffix = ['_' primer_set_name '_2mm_RL' num2str(DB_kmer_len)];
dbPath = [uniS16_dir suffix];

dot_ind = find(db_filename == '.',1,'last');
dbFileName = [db_filename(1:dot_ind-1) suffix];


% ********************** SAMPLE PREP PARAMETERS ********************
% Quality filter
PrepConfig.data_type= 'fastq';
PrepConfig.qual_th = 30;
PrepConfig.prc_high_qual = 0.75; % default is 0.75. Lowered for Shiri MiSeq to 0.5
PrepConfig.low10_th = 3;
PrepConfig.read_len = kmer_len;
PrepConfig.pe_flag = 1;
PrepConfig.max_num_Ns = 0; % default is 0 , lowered for Shiri MiSeq to 5

% Algo related
PrepConfig.algo_pe_flag = 1;
PrepConfig.max_err_inprimer = 2;
PrepConfig.with_primer_flag = 0;


% ********************** ALGORITHM  PARAMETERS ********************
AlgoConfig.verbose = 1;

% DB path
AlgoConfig.dbPath = dbPath;
AlgoConfig.dbFileName = dbFileName;
AlgoConfig.rdpPath = [uniS16_dir '/RDP_descriptions'];

% Reads filter params
AlgoConfig.filter_reads = 1;
AlgoConfig.min_read_freq = 1e-4;
AlgoConfig.min_read_count = 2;

% Reads to kmers alignment params
AlgoConfig.pe = 0.005;
AlgoConfig.nMM_cut = 2; 


% Reconstruction params
AlgoConfig.do_filter = 1;
AlgoConfig.solve_L2 = 0;
AlgoConfig.regions_normalization_scheme = 'is amplified'; % 'none' / 'perfect match' / 'any match' / 'is amplified'

AlgoConfig.read_type = char('PE'*PrepConfig.algo_pe_flag + 'SE'*(1-PrepConfig.algo_pe_flag));
AlgoConfig.mixture_type = 'Multiplex'; %'RegionByRegion';
AlgoConfig.readLen = kmer_len;
AlgoConfig.barcoded_regions = 1;

AlgoConfig.tol = 5e-7;
AlgoConfig.numIter = 10000;
AlgoConfig.cut_freq_th = 1;


