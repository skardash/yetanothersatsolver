function main_new = eating_reduction(main, eaten)
%{
    if main doesn't contain corresponding elements of eaten it's deleted
%}
    ix = ismember(main.vars, eaten.vars); %looking for corresponding variables
    delete_ix = ~ismember(main.values(:,ix), eaten.values, 'rows'); %define what values from main should be deleted
    main_new = main;
    main_new.values(delete_ix,:) = [];
end