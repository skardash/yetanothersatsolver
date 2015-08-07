function [new_comb] = eating_process_new(comb, var_list)
%{
    We can reduce our combination structure by removing combinations which
    variables are contained in other combinations.
    example:
    combination 1:
        vars: [1 2 3 5 7]
        values: 
            1     2     3     5     7
            0     1     0     1     1
            0     1     1     0     1
            0     1     1     1     1
            1     0     0     1     1
            1     0     1     0     1 //del
            1     0     1     1     1 //del
            1     1     0     1     1
            1     1     1     0     1
            1     1     1     1     1
    combination 2:
        vars: [2 3 5 7]
        values: 
            2     3     5     7
            0     0     1     1
            1     0     1     1
            1     1     0     1
            1     1     1     1

    output(combination 1 modified):
        vars: [1 2 3 5 7]
        values: 
            1     2     3     5     7
            0     1     0     1     1
            0     1     1     0     1
            0     1     1     1     1
            1     0     0     1     1
            1     1     0     1     1
            1     1     1     0     1
            1     1     1     1     1

%}
tic
sz = size(comb, 2);
var_present = zeros(sz, size(var_list, 2));
for cnt = 1:sz
    var_present(cnt, :) = ismember(var_list, comb(cnt).vars);
end 
eaten = zeros(sz, 1);
%{
    consider only not eaten elements, after their information incorporated
    in other combination they are useless
%}
for cnt = 1:sz - 1
    if (~eaten(cnt))
        %ix_research = find(~eaten); ix_research(ix_research == cnt) = [];
        ix_research = [1:cnt-1 cnt+1:sz]';
        rest = var_present(ix_research, :); 
        curr_repmat = repmat(var_present(cnt, :), size(rest, 1), 1);
        tmp = all(curr_repmat >= rest, 2);
        ix_eaten = ix_research(tmp);
        eaten(ix_eaten) = 1;
        for j = 1:numel(ix_eaten)
            comb(cnt) = eating_reduction(comb(cnt), comb(ix_eaten(j)));
        end
    end
end
new_comb = comb(:, ~eaten);
tm = toc;
disp(['eating process: ' , num2str(tm), ' seconds']);