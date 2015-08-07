function  [template, vars] = brute_force_solution(term_group)
tic
%get all variables 
vbl = [];
ix = struct('pos', {});
k = size(term_group(1).vars, 2);
for cnt = 1:size(term_group, 2)
    vbl = [vbl, term_group(cnt).vars];
end
[vars, a, b] = unique(vbl);
for cnt = 1:size(term_group, 2)
    ix(cnt).pos = b(1 + (cnt - 1) * k: cnt * k);
end
var_num = size(vars, 2);
template = mod(fix(repmat((0:2^var_num - 1)', 1, var_num) ./ repmat((2*ones(1, var_num)) .^ (var_num-1:-1:0), 2^var_num, 1)), 2);
fail = zeros(size(template, 1), 1);
for i = 1:size(template, 1)
    for j = 1:size(term_group, 2)
        if ~any(all(repmat(template(i, ix(j).pos), size(term_group(j).values, 1), 1) == term_group(j).values, 2))
            fail(i) = 1; break;
        end
    end
end
template(find(fail), :) = [];
tm = toc;
disp(['brute force solution: ' , num2str(tm), ' seconds']);