function [vars, degree] = costum_task3()
    %UNTITLED Summary of this function goes here
    %   Detailed explanation goes here
    vars = [ 1  ,   2 ,    3;
             1   ,  3  ,   5;
             1 ,    6  ,   7;
             2  ,   4 ,    7;
             2  ,   5    , 6;
             3   ,  4  ,   5;
    ];

    degree = [   1,     0 ,    0;
                 0  ,   0   ,  0;
                 0  ,   1 ,    1;
                 1  ,   1  ,   0;
                 1   ,  0  ,   0;
                 1  ,   0 ,    1;
     ];

    [vars, ix] = sort(vars,2);
    for cnt = 1:size(degree,1)
        degree(cnt,:) = degree(cnt,ix(cnt,:));
    end
end