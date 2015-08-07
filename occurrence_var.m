function [var_pos, var_all, varlist] = occurrence_var(term_group)
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
    
end