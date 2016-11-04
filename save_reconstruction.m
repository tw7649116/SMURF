function save_reconstruction(readsPath, sample_num, rdp_db_dir, Header_uni,Sequence_uni)

if ~exist([rdp_db_dir '/descriptions'],'dir') || ~exist([rdp_db_dir '/key.mat'],'file')
    error('Wrong RDP descriptions directory')
end

% Load the algorithm results
matlab_filename = [readsPath '/resDir/sample_' sample_num '_results.mat'];
load(matlab_filename, 'found_bacteria','bactMetaGroups')



% **************** Build the RECONSTRUCTIONS file ************
[Groups,levels_list] = read_groups_descriptions(rdp_db_dir, found_bacteria, bactMetaGroups);

output_cell = [{'Group index','Frequency', 'Read count', '# of sequences in group'}, levels_list, {'Fraction of RDP matches'}];
output_cell = [output_cell;cat(1, Groups.output)];

% Save to file
reconst_filename = [readsPath '/resDir/sample_' sample_num '_reconstruction.txt'];
saveCellFile(output_cell, reconst_filename)
% ----------------------------------------------------------------------------------



% **************** Build the ANSWER file ************
[compact_cell,compact_save_cell] = generate_compact_answer(Groups,levels_list);

% Save the answer file
compact_filename = [readsPath '/resDir/sample_' sample_num '_answer.txt'];
saveCellFile(compact_save_cell, compact_filename)
% ----------------------------------------------------------------------------------



% **************** Build the MAT file ************
groups_filename = [readsPath '/resDir/sample_' sample_num '_reconstruction.mat'];
save(groups_filename,'Groups','compact_cell','output_cell','levels_list')
% ----------------------------------------------------------------------------------



% **************** Write GROUPS sequences to disk ************
if ~exist([readsPath '/resDir/groups'],'dir')
    mkdir([readsPath '/resDir/groups'])
else
    delete([readsPath '/resDir/groups/*.fasta'])
end

% Write the sequences fasta (group by group)
if ~isempty(bactMetaGroups)
    for ii = 1:length(bactMetaGroups)
        fasta_filename = [readsPath '/resDir/groups/sample_' sample_num '_group' num2str(ii) '.fasta'];
        fastawrite(fasta_filename, cellfun(@num2str,Header_uni(bactMetaGroups(ii).db_ind),'UniformOutput',false),Sequence_uni(bactMetaGroups(ii).db_ind))
    end
end
% ----------------------------------------------------------------------------------



