function [term_group] = create_term_groups_new(vars, degree) 
%{
    example: 
    task: (x1 U not(x2))(x3 U x4)(x1 U x4)(not(x1) U x4)
    input:
        vars = [1 2;3 4;1 4;1 4]
        degree = [0 1;0 0;0 0;1 0]
    output: 
        term_group = 
            { [vars = [1 2]; values = [0 0;1 0;1 1]];
              [vars = [3 4]; values = [0 1;1 0;1 1]];
              [vars = [1 4]; values = [0 1;1 1]] }
%}
tic
n = size(vars, 1);
k = size(vars, 2);
term_group = struct('vars', [], 'values', []);
template = mod(fix(repmat((0:2^k - 1)', 1, k) ./ repmat((2*ones(1, k)) .^ (k-1:-1:0), 2^k, 1)), 2);
varsunique = unique(vars, 'rows');
for cnt = 1:size(varsunique,1)
    term_group(cnt).vars = varsunique(cnt,:);
    term_group(cnt).values = template;
    ix = all(repmat(varsunique(cnt,:),size(vars,1),1) == vars, 2); %find row indexes of similar variables
    term_group(cnt).values(ismember(template,degree(ix,:),'rows'),:) = []; %delete template rows which have degree
end
tm = toc;
disp(['creating term groups: ' , num2str(tm), ' seconds']);
