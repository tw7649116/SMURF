function [answer_ind,full_names] = find_first_known_name(full_names)

answer_ind = 0;

% Find the first name that has species
for ii = 1:length(full_names)
    kstr = strfind(full_names{ii},'::');
    if ~isempty(kstr)
        species = full_names{ii}(kstr(end)+2:end);
    else
        species = full_names{ii};
    end
    if isempty(strfind(species,'unknown')) && isempty(strfind(species,'uncultured')) && isempty(strfind(species,'not found'))
        answer_ind = ii;
        break
    end
    if ~isempty(kstr)
        full_names{ii} = full_names{ii}(1:kstr(end)-1);
    else
        full_names{ii} = '';
    end
end
