%LED Analysis for lock-in amp
clear
close all;

dataTable = readtable('LED.xlsx'); %import the data
VoutAdjusted = dataTable.Vout./dataTable.Gain_LPF./dataTable.Gain_Preamp;

scatter(dataTable.Distance, VoutAdjusted, 'filled');
set(gca,'xscale','log');
set(gca,'yscale','log');
grid on;



