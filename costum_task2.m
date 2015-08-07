function [vars, degree] = costum_task2()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
vars = [1, 2;
        2, 4;
        4, 3;
        3, 5;
        5, 6;
        6, 7;
        7, 8;
        8, 9;
        9, 1;
        2, 7;
        3, 8];
degree = [1, 1;
          0, 1;
          0, 1;
          0, 0;
          1, 1;
          0, 1;
          0, 1;
          0, 1;
          0, 0;
          0, 0;
          1, 1];
      
    [vars, ix] = sort(vars,2);
    for cnt = 1:size(degree,1)
        degree(cnt,:) = degree(cnt,ix(cnt,:));
    end
end