function [compact_cell,compact_save_cell,gr_in_compact_cell] = generate_compact_answer(Groups, levels_list)

compact_save_cell = [{'Genus frequency','Frequency', 'Read count'}, levels_list];
if isempty(Groups)
    compact_cell = {};
    gr_in_compact_cell = {};
    return
end

% Load the raw answers
answer_cell = cat(1,Groups.answer_cell);
group_names = [Groups.name];
group_freq = [Groups.freq];

% Find unique answers list
[Us,Is,Js] = unique(answer_cell(:,3));
compact_cell = cell(length(Is), size(answer_cell,2));
compact_genus = cell(length(Is), 1);
gr_in_compact_cell = cell(1,length(Is));
for ii = 1:length(Is)
    gr_in_compact_cell{ii} = sort([Groups(Js==ii).bact_ind]);
    comp_freq = sum(cellfun(@str2num,answer_cell(Js==ii,1)));
    comp_count = sum(cellfun(@str2num,answer_cell(Js==ii,2)));
    compact_cell(ii,:) = [{num2str(comp_freq)}, {num2str(comp_count)}, Us(ii)];
    compact_genus(ii) = group_names(Is(ii));
end


% Reorder the rows according to genus frequency
[Ug,~,Jg] = unique(compact_genus);
genus_freq = zeros(1,length(Ug));
for ii = 1:length(Ug)
    genus_freq(ii) = sum(cellfun(@str2num,compact_cell(Jg==ii,1)));
end
[~,Ig] = sort(genus_freq,'descend');

% Build the output cell
for ii = 1:length(genus_freq)
    gg_ind = find(Jg==Ig(ii));
    [~,Oi] = sort(cellfun(@str2num,compact_cell(gg_ind,1)),'descend');
    
    % Add the first row of genus
    compact_save_cell = [compact_save_cell;[{num2str(genus_freq(Ig(ii)))} compact_cell(gg_ind(Oi(1)),:)]];
    
    % Add the rest of the rows
    if length(gg_ind)>1
        other_rows = gg_ind(Oi(2:end));
        compact_save_cell = [compact_save_cell; [cellstr(char('-'*ones(length(gg_ind)-1,1))) compact_cell(other_rows,:)]];
    end
    
    % Add separating row
    compact_save_cell = [compact_save_cell; cellstr(char(9*ones(size(compact_save_cell,2),1)))'];
end
