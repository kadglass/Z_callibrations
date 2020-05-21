% Loading workspace files
close all;
clear;
load('zcaltable.mat');
load('dwarfdatafluxandZ.mat');
load('r23tableCOMPLETE.mat');
load('r23OURDATA.mat');
load('dwarf-data-folder/currDataWithErrors.mat')

% figure(1); % Plotting R23
% hold on;
%     axis tight;
%     r23 = r23tableCOMPLETE{:,3};
%     scatter(table{:,6}, r23, 'filled', 'k', 'DisplayName', 'SDSS Galaxies')
%     scatter(r23OURDATA{:,2}, r23OURDATA{:,1}, 'filled', 'r', 'DisplayName', 'Dwarf Galaxies')
%     xlabel('12 + log(O/H)');
%     ylabel('R_{23}');
%     set(gca, 'yscale', 'log');
%     xlim([6.8, 9.5]);
%     ylim([0.01, 10.^(2)]);
%     legend('Location', 'Northwest') 


figure(2); % Plotting NII6584 / H_alpha
hold on;
    axis tight;
    % Plotting SDSS Galaxies
    ratio = table{:,1}./table{:,2};
    scatter(table{:,6}, ratio, [], [.502 .502 .502], '*', 'DisplayName', 'SDSS Galaxies')
    
    % Plotting Dwarf Galaxies
    scatter(table2{:,1}, table2{:,2}, 'filled', 'k', 'DisplayName', 'Dwarf Galaxies')
    
    fitTx = table2(find(isfinite(table2.Z)), :);
    fitTy = fitTx(find(isfinite(fitTx.nii6584_halpha)), :);
    cftool(fitTy{:,1} , fitTy{:,2}, 'polynomial');
    clear fitTx;
    clear fitTy;
    
    % Binning of the data
    fprintf("\nBin Information for Figure 2\n");
    num_bins = 10;
    N = (max(table2.Z) - min(table2.Z))/num_bins; % Bin increment
    minimum = min(table2.Z);
    numIterations = num_bins - 2;
    binTable = array2table(zeros(num_bins, 3));
    binTable.Properties.VariableNames = {'BinZValue', 'BinAverage', 'BinStandardDev'};
    for currBin = 2:numIterations
        m = and(table2.Z >= ((currBin - 1)*(N) + minimum), table2.Z < ((currBin)*(N) + minimum));
        binValue = (((currBin - 1)*(N) + minimum) + ((currBin)*(N) + minimum)) / 2;
        binTable{currBin, 1} = binValue;
        avgTable = table2(m, :);
        average = median(avgTable{:,2}, 'omitnan'); % Adjust number to appropriate y value
        binTable{currBin, 2} =  average;
        standardDeviation = std(avgTable{:,2}, 'omitnan'); % Adjust number to appropriate y value
        binTable{currBin, 3} = standardDeviation;
        fprintf("mean is %f and standard deviation is %f\n", average, standardDeviation);
    end
    errorbar(binTable{:,1}, binTable{:,2}, binTable{:,3}, 'r', 'DisplayName', 'Binned Data')
    
    % Plot fit of data
    a = [0.009162 -0.3931 5.974 -38.87 92.39];
    fplot(@(x) a(5)+a(4)*x+ a(3)*(x .^2)+a(2)*(x.^3)+a(1)*(x.^4), 'r', 'LineWidth', 2,'DisplayName', '92.39 - 38.87x + 5.974x^2 - 0.3931x^3 + 0.009162x^4')
    
    % Plot fit from Nagao paper
    a1 = [-.68307 .89881 .52302 -.22040];
    a  = [96.641 -39.941 5.2227 -0.22040];
    fplot(@(x) 10.^(a(1)+a(2)*x+a(3)*(x.^2)+a(4)*(x.^3)), 'Color', [25/255 127/255 219/255], 'LineWidth', 2, 'DisplayName', 'Nagao Fit')
    
    xlabel('12 + log(O/H)');
    ylabel('[NII]{\lambda}6584 / H{\alpha}');
    set(gca, 'yscale', 'log');
    xlim([6.8, 9.5]);
    ylim([0.002, 0.7]);
    legend('Location', 'Southwest')
hold off;

figure(3); % Plotting OIII5007 / NII6584
hold on;
    axis tight;
    % Plotting SDSS Galaxies
    ratio = table{:,3}./table{:,1};
    scatter(table{:,6}, ratio,  [], [.502 .502 .502], '*', 'DisplayName', 'SDSS Galaxies')
    
    % Plotting Dwarf Galaxies
    scatter(table2{:,1}, table2{:,3}, 'filled', 'k', 'DisplayName', 'Dwarf Galaxies')
    
    fitTx = table2(find(isfinite(table2.Z)), :);
    fitTy = fitTx(find(isfinite(fitTx.oiii5007_nii6584)), :);
    cftool(fitTy{:,1} , fitTy{:,3}, 'polynomial'); % 1 LAR
    clear fitTx;
    clear fitTy;
    
    % Define errorbar
    fprintf("\nBin Information for Figure 3\n");
    num_bins = 10;
    N = (max(table2.Z) - min(table2.Z))/num_bins; % Bin increment
    minimum = min(table2.Z);
    numIterations = num_bins - 1;
    binTable = array2table(zeros(num_bins, 3));
    binTable.Properties.VariableNames = {'BinZValue', 'BinAverage', 'BinStandardDev'};
    for currBin = 2:numIterations
        m = and(table2.Z >= ((currBin - 1)*(N) + minimum), table2.Z < ((currBin)*(N) + minimum));
        binValue = (((currBin - 1)*(N) + minimum) + ((currBin)*(N) + minimum)) / 2;
        binTable{currBin, 1} = binValue;
        avgTable = table2(m, :);
        average = median(avgTable{:,3}, 'omitnan'); % Adjust number to appropriate y value
        binTable{currBin, 2} = average;
        standardDeviation = std(avgTable{:,3}, 'omitnan'); % Adjust number to appropriate y value
        binTable{currBin, 3} = standardDeviation;
        fprintf("mean is %f and standard deviation is %f\n", average, standardDeviation);
    end
    errorbar(binTable{:,1}, binTable{:,2}, binTable{:,3}, 'r', 'DisplayName', 'Binned Data')
    
    % Plot fit of data
    a = [-81.17 12.17];
    fplot(@(x) a(1)+a(2)*x, 'r', 'LineWidth', 2, 'DisplayName', '-81.17 + 12.17x')
    
    % Plot fit from Nagao paper
    a1 = [3.2921e-1 -2.2578 -4.1699e-2 3.7941e-1];
    a  = [-232.18 84.423 -9.9330 0.37941];
    fplot(@(x) 10.^(a(1)+a(2)*x+a(3)*(x.^2)+a(4)*(x.^3)), 'Color', [25/255 127/255 219/255], 'LineWidth', 2, 'DisplayName', 'Nagao Fit')
    
    xlabel('12 + log(O/H)');
    ylabel('[OIII]{\lambda}5007 / [NII]{\lambda}6584');
    set(gca, 'yscale', 'log');
    xlim([6.8, 9.6]);
    ylim([0.02, 2000]);
    legend('Location', 'Southwest')
hold off;

figure(4); % Plotting NII6584 / OII3727
hold on;
    axis tight;
    % Plotting SDSS Galaxies
    ratio = table{:,1}./table{:,4};
    scatter(table{:,6}, ratio,  [], [.502 .502 .502], '*', 'DisplayName', 'SDSS Galaxies')
    
    % Plotting Dwarf Galaxies
    scatter(table2{:,1}, table2{:,4}, 'filled', 'k', 'DisplayName', 'Dwarf Galaxies')
    
    fitTx = table2(find(isfinite(table2.Z)), :);
    fitTy = fitTx(find(isfinite(fitTx.nii6584_oii3727)), :);
%     cftool(fitTy{:,1} , fitTy{:,4}, 'polynomial');
    clear fitTx;
    clear fitTy;
    
    % Define errorbar
    fprintf("\nBin Information for Figure 4\n");
    num_bins = 8;
    N = (max(table2.Z) - min(table2.Z))/num_bins; % Bin increment
    minimum = min(table2.Z);
    numIterations = num_bins - 1;
    binTable = array2table(zeros(num_bins, 3));
    binTable.Properties.VariableNames = {'BinZValue', 'BinAverage', 'BinStandardDev'};
    for currBin = 2:numIterations
        M = and(table2.Z >= ((currBin - 1)*(N) + minimum), table2.Z < ((currBin)*(N) + minimum));
        m1 = and(M, table2.nii6584_oii3727 ~= Inf);
        m2 = and(m1, table2.nii6584_oii3727 >= 0);
        binValue = (((currBin - 1)*(N) + minimum) + ((currBin)*(N) + minimum)) / 2;
        binTable{currBin, 1} = binValue;
        avgTable = table2(m2, :);
        average = median(avgTable{:,4}, 'omitnan'); % Adjust number to appropriate y value
        binTable{currBin, 2} = average;
        standardDeviation = std(avgTable{:,4}, 'omitnan'); % Adjust number to appropriate y value
        binTable{currBin, 3} = standardDeviation;
        fprintf("mean is %f and standard deviation is %f\n", average, standardDeviation);
    end
    errorbar(binTable{:,1}, binTable{:,2}, binTable{:,3}, 'r', 'DisplayName', 'Binned Data')
    
    % Plot fit of data
    a = [-0.9989 0.1334];
    fplot(@(x) a(1)+a(2)*x, 'r', 'LineWidth', 2, 'DisplayName', '-0.9989 + 0.1334x')
    
    % Plot fit from Nagao Paper
    a1 = [-7.9322e-1 1.1399 7.8929e-1 2.7101e-1];
    a  = [-128.94 48.818 -6.2759 0.27101];
    fplot(@(x) 10.^(a(1)+a(2)*x+a(3)*(x.^2)+a(4)*(x.^3)), 'Color', [25/255 127/255 219/255], 'LineWidth', 2, 'DisplayName', 'Nagao Fit')
    
    
    xlabel('12 + log(O/H)');
    ylabel('[NII]{\lambda}6584 / [OII]{\lambda}3726');
    set(gca, 'yscale', 'log');
    ylim([10.^(-3),100]);
    xlim([6.889790670479792,9.532263811832127]);
    legend('Location', 'Southwest')
hold off;

figure(5); % Plotting NII6584 / SII6720
hold on;
    axis tight;
    % Plotting SDSS Galaxies
    ratio = table{:,1}./table{:,5};
    scatter(table{:,6}, ratio,  [], [.502 .502 .502], '*', 'DisplayName', 'SDSS Galaxies')
    
    % Plotting Dwarf Galaxies
    scatter(table2{:,1}, table2{:,5}, 'filled', 'k', 'DisplayName', 'Dwarf Galaxies')
    
    fitTx = table2(find(isfinite(table2.Z)), :);
    fitTy = fitTx(find(isfinite(fitTx.nii6584_sii6717)), :);
%     cftool(fitTy{:,1} , fitTy{:,5}, 'polynomial');
    clear fitTx;
    clear fitTy;
    
    % Define errorbar
    fprintf("\nBin Information for Figure 5\n");
    num_bins = 10;
    N = (max(table2.Z) - min(table2.Z))/num_bins; % Bin increment
    minimum = min(table2.Z);
    numIterations = num_bins - 1;
    binTable = array2table(zeros(num_bins, 3));
    binTable.Properties.VariableNames = {'BinZValue', 'BinAverage', 'BinStandardDev'};
    for currBin = 1:numIterations
        m = and(table2.Z >= ((currBin - 1)*(N) + minimum), table2.Z < ((currBin)*(N) + minimum));
        binValue = (((currBin - 1)*(N) + minimum) + ((currBin)*(N) + minimum)) / 2;
        binTable{currBin, 1} = binValue;
        avgTable = table2(m, :);
        average = median(avgTable{:,5}, 'omitnan'); % Adjust number to appropriate y value
        binTable{currBin, 2} = average;
        standardDeviation = std(avgTable{:,5}, 'omitnan'); % Adjust number to appropriate y value
        binTable{currBin, 3} = standardDeviation;
        fprintf("mean is %f and standard deviation is %f\n", average, standardDeviation);
    end
    errorbar(binTable{:,1}, binTable{:,2}, binTable{:,3}, 'r', 'DisplayName', 'Binned Data')
    
    % Plot fit of data
    a = [-0.06558 1.766 -16.94 66.56 -83.45];
    fplot(@(x) a(5)+a(4)*x+ a(3)*(x .^2)+a(2)*(x.^3)+a(1)*(x.^4), 'r', 'LineWidth', 2, 'DisplayName', '-83.45 + 66.56x - 16.94x^2 + 1.766x^3 - 0.06558x^4') 
    
    % Plot fit from Nagao Paper
    a1 = [-2.5214e-1 7.4100e-1 5.8181e-1 1.7963e-1];
    a  = [-80.632 31.323 -4.1010 0.17963];
    fplot(@(x) 10.^(a(1)+a(2)*x+a(3)*(x.^2)+a(4)*(x.^3)), 'Color', [25/255 127/255 219/255], 'LineWidth', 2, 'DisplayName', 'Nagao Fit')
    
    xlabel('12 + log(O/H)');
    ylabel('[NII]{\lambda}6584 / [SII]{\lambda}6720');
    set(gca, 'yscale', 'log');
    ylim([10.^(-2),100]); 
    xlim([6.8, 9.5]);
    legend('Location', 'Southwest')
hold off;
% 
figure(6); % Plotting OIII5007/OII3727(3726)
hold on;
    axis tight;
    % Plotting SDSS Galaxies
    ratio = table{:,3}./table{:,4};
    scatter(table{:,6}, ratio,  [], [.502 .502 .502], '*', 'DisplayName', 'SDSS Galaxies')
    
    % Plotting Dwarf Galaxies
    scatter(table2{:,1}, table2{:,6}, 'filled', 'k', 'DisplayName', 'Dwarf Galaxies')
    
    % Creating fit
    fitTx = table2(find(isfinite(table2.Z)), :);
    fitTy = fitTx(find(isfinite(fitTx.oiii5007_oii3727)), :);
%     cftool(fitTy{:,1} , fitTy{:,6}, 'polynomial');
    clear fitTx;
    clear fitTy;
    
    x = table2{:,1};
    y = table2{:,6};
    
    % Define errorbar
    fprintf("\nBin Information for Figure 2\n");
    num_bins = 14;
    N = (max(table2.Z) - min(table2.Z))/num_bins; % Bin increment
    minimum = min(table2.Z);
    numIterations = num_bins - 1;
    binTable = array2table(zeros(num_bins, 3));
    binTable.Properties.VariableNames = {'BinZValue', 'BinAverage', 'BinStandardDev'};
    for currBin = 2:numIterations
        M = and(table2.Z >= ((currBin - 1)*(N) + minimum), table2.Z < ((currBin)*(N) + minimum));
        m1 = and(M, table2.oiii5007_oii3727 <= 10000);
        m2 = and(m1, table2.nii6584_oii3727 >= 0);
        binValue = (((currBin - 1)*(N) + minimum) + ((currBin)*(N) + minimum)) / 2;
        binTable{currBin, 1} = binValue;
        avgTable = table2(m2, :);
        average = median(avgTable{:,6}, 'omitnan'); % Adjust number to appropriate y value
        binTable{currBin, 2} = average;
        standardDeviation = std(avgTable{:,6}, 'omitnan'); % Adjust number to appropriate y value
        binTable{currBin, 3} = standardDeviation;
        fprintf("mean is %f and standard deviation is %f\n", average, standardDeviation);
    end
    errorbar(binTable{:,1}, binTable{:,2}, binTable{:,3}, 'r', 'DisplayName', 'Binned Data');
    
    % Plot fit of data
    a = [0.3559 -2.114];
    fplot(@(x) a(2)+a(1)*x, 'r', 'LineWidth', 2, 'DisplayName', '0.3559 - 2.114x')
    
    % Plot fit from Nagao Paper
    a1 = [-3.0777e-1 -1.1210 -1.4359e-1];
    a  = [-1.4089 1.3745 -0.14359];
    fplot(@(x) 10.^(a(1)+a(2)*x+a(3)*(x.^2)), 'Color', [25/255 127/255 219/255], 'LineWidth', 2, 'DisplayName', 'Nagao Fit')
    
    xlabel('12 + log(O/H)');
    ylabel('[OIII]{\lambda}5007 / [OII]{\lambda}3726');
    set(gca, 'yscale', 'log');
    xlim([7.0, 9.5]);
    ylim([10.^(-2), 100]); % min at .1
    legend('Location', 'Southwest')
hold off;

clear m;
clear M;
clear m1;
clear m2;
clear x;
clear y;
clear a;
clear a1;
clear num_bins;
clear numIterations;
clear avgTable;