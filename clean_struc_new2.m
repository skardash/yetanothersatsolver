function comb = clean_struc_new2(comb)
%{  
    each pair of combinations are cleared until no changes occured
%}
tic
changes = 1;
clean_step = 0;
sz = size(comb, 2);
del_made = zeros(size(comb, 2), 1);
change_arr = ones(sz, sz);
while changes
    changes = 0;
    for i = 1:size(comb, 2) - 1
        for j = i + 1:size(comb, 2)
            %find common variables, create space of their valid sets and remove
            if change_arr(i,j) %wtf!!??
                common = intersect(comb(i).vars, comb(j).vars);
                ix1 = ismember(comb(i).vars, common);
                ix2 = ismember(comb(j).vars, common);
                arr1 = comb(i).values(:, ix1); 
                arr2 = comb(j).values(:, ix2);
                del1 = ~ismember(arr1, arr2, 'rows');
                del2 = ~ismember(arr2, arr1, 'rows');
                if any(del1) 
                    change_arr(i, :)= 1;
                    change_arr(:, i)= 1;
                end
                if any(del2) 
                    change_arr(j, :)= 1;
                    change_arr(:, j)= 1;
                end
                change_arr(i, j) = 0;
                comb(i).values(del1, :) = [];
                comb(j).values(del2, :) = [];
                changes = any(del1) || any(del2) || changes;
            end
        end
    end
    clean_step = clean_step + 1;
    %{
    if changes 
        disp('changes');
    end
    %}
end
tm = toc;
%disp(['cleaning the structure: ', num2str(clean_step), ' steps ', num2str(tm), ' seconds']);
