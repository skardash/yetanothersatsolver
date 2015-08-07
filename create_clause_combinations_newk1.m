function [comb] = create_clause_combinations_newk1(term_group) 
%{
    creting all the (k+1)-combinations of terms 
    example: 
    task: (x1 U not(x2))(x3 U x4)(x1 U x4)(not(x1) U x4)
    input:
       term_group = 
            { [vars = [1 2]; values = [0 0;1 0;1 1]];
              [vars = [3 4]; values = [0 1;1 0;1 1]];
              [vars = [1 4]; values = [0 1;1 1]] }
    output: 
        comb = 
            { [vars = [1 2 3 4]; values = [  0     0     0     1
                                             0     0     1     1
                                             1     0     0     1
                                             1     0     1     1
                                             1     1     0     1
                                             1     1     1     1]; }
%}
tic
k = size(term_group(1).vars, 2);
storage = nchoosek(1:size(term_group, 2), k-1);
comb = struct('vars',[], 'values', [], 'term_list', []); 
%count number of variables involved
for set_num = 1:size(storage, 1)
    %creating combined variable list for each clause combination
    vbl = [];
    for cnt = 1:k-1
        vbl = [vbl, term_group(storage(set_num, cnt)).vars];
    end
    vbl = unique(vbl);
    dim = size(vbl, 2);
    %create template
    list_comb = mod(fix(repmat((0:2^dim - 1)', 1, dim) ./ repmat((2 * ones(1, dim)) .^ (dim - 1:-1:0), 2^dim, 1)), 2);
    
    for cnt = 1:k-1
        term_num = storage(set_num, cnt);
        term_vars = term_group(term_num).vars;
        term_values = term_group(term_num).values;
        index_of_interest = ismember(vbl, term_vars);
        list_comb(~ismember(list_comb(:, index_of_interest), term_values, 'rows'), :) = [];
    end

    comb(set_num).vars = vbl;
    comb(set_num).values = list_comb;
    comb(set_num).term_list = storage(set_num, :);
end
tm = toc;
disp(['creating clause combinations: ' , num2str(tm), ' seconds']);
