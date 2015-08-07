function get_combinations_reduced(term_group)
    % get list of all variables
    varlist = [];
    for cnt = 1:length(term_group)
        varlist = [varlist; term_group(cnt).vars];
    end
    var_all = unique(varlist);
    corr = zeros(size(varlist,1), length(var_all));
    for cnt = 1:size(varlist,1)
        corr(cnt,:) = ismember(var_all, varlist(cnt,:));
    end
        
    % get first 2 occurences of each variable
    var_pos = zeros(2,size(corr,2));
    for cnt = 1:size(corr,2)
        var_pos(:,cnt) = find(corr(:,cnt),2);
    end
    
    % find list of other terms for each term to group
    combarr = zeros(size(corr,1), size(varlist,2) + 1); %list of all combinations
    for cnt = 1:size(corr,1)
        combarr(cnt,1) = cnt;
        vars_rel_pos = find(corr(cnt,:));
        for i = 1:length(vars_rel_pos)
            first_candidate = var_pos(1, vars_rel_pos(i));
            second_candidate = var_pos(2, vars_rel_pos(i));
            if ((first_candidate ~= cnt) || (second_candidate == 0))
                combarr(cnt, i+1) = first_candidate;
            else
                combarr(cnt, i+1) = second_candidate;
            end
        end
    end
    comb = struct('vars',[], 'values', [], 'term_list', []); 
    for cnt = 1:size(comb,1)
        term_list = unique(combarr(cnt,:));
        vbl = [];
        for i = 1:length(term_list)
            vbl = [vbl, term_group(term_list(i)).vars];
        end
        vbl = unique(vbl);
        comb(cnt).vars = vbl;
        dim = size(vbl, 2);
        %create template
        list_comb = mod(fix(repmat((0:2^dim - 1)', 1, dim) ./ repmat((2 * ones(1, dim)) .^ (dim - 1:-1:0), 2^dim, 1)), 2);

        for i = 1:length(term_list)
            term_num = term_list(i);
            term_vars = term_group(term_num).vars;
            term_values = term_group(term_num).values;
            index_of_interest = ismember(vbl, term_vars);
            list_comb(~ismember(list_comb(:, index_of_interest), term_values, 'rows'), :) = [];
        end
        
        
    end
end