function [vars, degree] = generate_task(n, m, k)
%{
    (x_i11 U x_i12 U x_13 ... U x_i1k)(x_i21 U x_i22 U x_i23 ... U x_i2k) ... (x_in1 U x_in2 U x_in3 ... U x_ink)
    input:
    n - number of clauses
    k - number of elements in each clause
    m - number of variables presented in k-CNF (x1,x2, ... xm)
    
    output:
    vars - array of variable indexes
    degree - degree of corresponding variable in vars: 1 means 'not'

    example:
    (x1 U not(x2))(x3 U x4)(not(x1) U x4)
    k = 2; m = 4; n = 3;
    vars = [1 2; 3 4; 1 4]
    degree = [0 1; 0 0; 1 0];
%}
tic
vars = [];
for cnt = 1:n
    a = randperm(m);
    vars = [vars; a(1:k)];
end 
vars = sort(vars, 2);
vars = sortrows(vars);
degree = randi(2, n, k) - 1;
tm = toc;
disp(['generating task: ' , num2str(tm), ' seconds']);
