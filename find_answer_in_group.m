function [answer_str] = find_answer_in_group(full_names,fractions_str,use_levels)

tail_str = '';
fractions = cellfun(@str2num,fractions_str);

% Find the first name that is known
for ll = length(use_levels):-1:1
    if ~isempty(tail_str)
        tail_str = ['::' tail_str];
    end
    [answer_ind,cut_names] = find_first_known_name(full_names);
    if answer_ind > 0
        break
    else
        [Ug,~,Jg] = unique(cut_names);
        genus_fraction = zeros(1,length(Ug));
        for ii = 1:length(Ug)
            genus_fraction(ii) = sum(fractions(Jg==ii));
        end
        [fractions,In] = sort(genus_fraction);
        full_names = Ug(In);
        tail_str = ['Unknown ' use_levels{ll} tail_str];
    end
end

if answer_ind > 0
    answer_str = [full_names{answer_ind} tail_str];
else
   answer_str = tail_str; 
end

%*******************************************************************************