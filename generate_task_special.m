function [vars, degree] = generate_task_special()
    vars = [];
    varnum = 16;
    reps = 5;
    for cnt = 1:varnum-2
        vars = [vars; repmat([cnt:cnt+2],reps,1)];
    end
    vars = [vars; repmat([varnum-1 varnum 1],reps,1)];
    vars = [vars; repmat([varnum 1 2],reps,1)];
    %degree = [zeros(varnum, 2) ones(varnum,1)];
    degree = randi(2, varnum*reps, 3) - 1;
    [vars, ix] = sort(vars,2);
    for cnt = 1:size(degree,1)
        degree(cnt,:) = degree(cnt,ix(cnt,:));
    end
end