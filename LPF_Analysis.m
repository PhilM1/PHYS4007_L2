%Low-pass filter analysis
clear
close all;

Vin = 20;

%plot for Q = 2
dataTable = readtable('LPF_Q2.xlsx'); %import the data
VoutGaindB = 20*log10((abs(dataTable.Vpp))/Vin);
fig = figure();
semilogx(dataTable.Freq, VoutGaindB);
title('Low-Pass Filter Analysis (Q = 2)');
xlabel('Frequency (Hz');
ylabel('Gain (dB)');
hold on;
scatter(dataTable.Freq, VoutGaindB, 'filled', 'b');
saveas(fig, 'LPF_Q2.png');

%plot for Q = 20
dataTable = readtable('LPF_Q20.xlsx'); %import the data
VoutGaindB = 20*log10((abs(dataTable.Vpp))/Vin);
fig = figure();
semilogx(dataTable.Freq, VoutGaindB);
title('Low-Pass Filter Analysis (Q = 20)');
xlabel('Frequency (Hz');
ylabel('Gain (dB)');
hold on;
scatter(dataTable.Freq, VoutGaindB, 'filled', 'b');
saveas(fig, 'LPF_Q20.png');

%plot for Q = Bessel
dataTable = readtable('LPF_Bessel.xlsx'); %import the data
VoutGaindB = 20*log10((abs(dataTable.Vpp))/Vin);
fig = figure();
semilogx(dataTable.Freq, VoutGaindB);
title('Low-Pass Filter Analysis (Q = Bessel)');
xlabel('Frequency (Hz');
ylabel('Gain (dB)');
hold on;
scatter(dataTable.Freq, VoutGaindB, 'filled', 'b');
saveas(fig, 'LPF_QBessel.png');


