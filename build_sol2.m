function sol = build_sol2(comb, level)
sol = [];
oldcomb = comb;
comb = clean_struc_new2(comb);
if isempty(comb(1).values)
    print_comb(comb, 'logerr.txt');
end
if size(comb, 2) == 1
    sol = comb(1).values;
else
    if (level == size(comb, 2))
        vars = [];
        vals = [];
        for cnt = 1:size(comb, 2) - 1
            vars = [vars, comb(cnt).vars];
            vals = [vals, comb(cnt).values];
        end
        [vrs, ix] = unique(vars, 'first');
        vls = vals(ix);  
        [new_vars,  ix, iy] = unique([vrs, comb(end).vars]);
        sol(:, iy(size(vrs, 2) + 1:end)) = comb(end).values;
        sol(:, iy(1:size(vrs, 2))) = repmat(vls, size(vls, 1), 1);
    else
        
        for cnt = 1:size(comb(level).values, 1)
            comb_new = comb;
            comb_new(level).values = comb(level).values(cnt, :);
            add_sol = build_sol2(comb_new, level + 1);
            sol = [sol; add_sol];
        end
    end
end