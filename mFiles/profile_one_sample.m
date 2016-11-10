
clear

% ************************* Sample's PARAMETERS *********************
base_samples_dir = 'C:\Users\Gari\Documents\WIS\Bacteria\Algo Paper\SMURF code';
sample_name = 'Example';
primer_set_name = 'amp6Regions';
kmer_len = 100;

% *********************** LOAD METHOD's PARAMETERS *******************
run('../Configs/params_script')


% *************************** PROFILE ONE SAMPLE *********************
SampleConfig = struct;
SampleConfig.sample_name = sample_name;
SampleConfig.sample_dir = [base_samples_dir '/' sample_name];
SampleConfig.primers_seq = primers_seq;

main_multiple_regions(PrepConfig,AlgoConfig,SampleConfig)
