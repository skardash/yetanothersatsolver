function curr = forward(vars, degree, solution)
    curr = ones(size(solution,1),1);
    for cnt = 1:size(vars,1)
        curr = curr & sum(mod(solution(:,vars(cnt,:)) + repmat(degree(cnt,:), size(solution,1), 1), 2),2)>0;
    end
end