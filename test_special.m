step = 0;
stop_case = 0;
%while true
    %n = 7; m = 12; k = 3;
    %[vars, degree] = generate_task_special();
    [vars, degree] = costum_task3();
    term_group = create_term_groups_new(vars, degree);    
    comb = create_clause_combinations_newk1(term_group);
    var_list = (unique(vars))';
    new_comb = eating_process_new(comb, var_list);
    new_comb = clean_struc_new2(new_comb);
    [solutions, varbl] = brute_force_solution(term_group);
    size(solutions)
    %flag = check_comb(vars, template, new_comb);
    %stop_case = stop_case + check_comb2(vars, template, new_comb1)
    %{
    vals = build_one_solution(new_comb)
    if ~isempty(solutions)  
        solutions(1,:)
    else
        solutions
    end
    %}
    if (isempty(solutions) && ~isempty(new_comb(1).values))
        error('no solutions but combination set is not empty');
    end
    if (~isempty(solutions))
        sol = sortrows(build_sol2(new_comb,1));
        step = step + 1
        if (size(sol) ~= size(solutions))
            error('real solution and produced don''t agree');
        elseif ~(all(sol(:) == solutions(:)))
            error('real solution and produced don''t agree');
        end
    end
%end

%{
    we need:
        * find example when solutions are empty but structure is not
        * or build at least one random solution
%}