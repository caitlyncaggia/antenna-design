% ECE 6370 Homework 9.e
% Caitlyn Caggia

load ptrial1.mat p

tableInfo = cell(11,5);
tableInfo(1,:) = [{'Element (n)'} {'Perimiters (Pn)'} ...
    {'Aspect Ratios (An)'} {'Spacing (Sn)'} {'Diameters (dn)'}];
tableInfo(2:end,1) = num2cell(1:1:10);
tableInfo(2:end, 2) = num2cell(p(1:10));
tableInfo(2:end, 3) = num2cell(p(11:20));
tableInfo(2:end, 4) = num2cell(p(21:30));
tableInfo(2:end, 5) = num2cell(p(31:40));

tabl = cell2table(tableInfo);

writetable(tabl, 'partd table.xls')