
% clear

% ************************* Sample's PARAMETERS *********************
base_samples_dir = 'C:\Users\Gari\Documents\WIS\Bacteria\Algo Paper\SMURF code';
sample_name = 'Example';
primer_set_name = 'amp6Regions';
kmer_len = 100;

% *********************** LOAD METHOD's PARAMETERS *******************
params_script


% *********************** LOAD THE FULL SEQUENCES DB *****************
% % Load the 16S sequences
% if ~exist('Sequence_uni','var')
%     uniS16_file = [uniS16_dir '/' db_filename];
%     load(uniS16_file,'Header_uni','Sequence_uni')
% end


% *************************** PROFILE ONE SAMPLE *********************
SampleConfig = struct;
SampleConfig.sample_name = sample_name;
SampleConfig.sample_dir = [base_samples_dir '/' sample_name];
SampleConfig.primers_seq = primers_seq;

main_multiple_regions(PrepConfig,AlgoConfig,SampleConfig)
