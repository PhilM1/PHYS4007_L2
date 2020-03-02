%analysis of the pre-amplifier on the lock-in system
clear
close all;


%TODO: Graph of all 3dB points with respect to Gain


Vin = 0.0099;%input voltage, approx 10mV, constant for all measurements
dataTable = readtable('preamp_data.xlsx'); %import the data

%loop through data
[numRows, numCols] = size(dataTable);
frequencyArray = dataTable.Frequency_Hz_;
VoutPPArraydB = 20*log10((abs(dataTable.VoutPP_top_ - dataTable.VoutPP_botom_))/Vin);

dBArray = [];
dbCount = 1;

startIndex = 1;
for i = 1:numRows
    gain = dataTable.Gain(i);
    
    %if at the end, plot or end of a gain set
    if(i == numRows || gain ~=  dataTable.Gain(i+1))
        %avg of first five readings for flatline magnitude
        baseMag = mean(VoutPPArraydB(startIndex:startIndex+5));
        for j = startIndex:i %loop through the dataset to find points on either side of 3dB drop
            if(VoutPPArraydB(j) >= baseMag - 3)
                leftIndex = j-1;
            end
        end
        y1 = VoutPPArraydB(leftIndex);
        y2 = VoutPPArraydB(leftIndex+1);
        x1 = frequencyArray(leftIndex);
        x2 = frequencyArray(leftIndex+1);
        y = baseMag - 3;
        
        dBFreq = (y-y1)*(x2-x1)/(y2-y1) + x1;
        
        fig = figure();
        semilogx(frequencyArray(startIndex:i),VoutPPArraydB(startIndex:i));
        title(['Pre-Amplifier Characteristics (Gain = ', num2str(gain), ')']);
        xlabel('Frequency (Hz');
        ylabel('Magnitude (dB)');
        hold on;
        scatter(frequencyArray(startIndex:i),VoutPPArraydB(startIndex:i), 'filled', 'b');
        l = scatter(dBFreq,y, 'filled');
        legend(l, '3dB point', 'Location', 'southwest');
        hold off;
        startIndex = i+1;
        saveName = ['preAmp_Analysis_G', num2str(gain), '.png'];
        saveas(fig, saveName);
        
        dBArray(dbCount, 1) = dBFreq;
        dBArray(dbCount, 2) = y;
        dbCount = dbCount+1;
    end
end

fig = figure();
semilogx(dBArray(:,1), dBArray(:,2));
hold on;
scatter(dBArray(:,1), dBArray(:,2), 'filled', 'b');
title('Pre-Amplifier 3dB points vs Frequency');
xlabel('Frequency (Hz');
ylabel('Magnitude (dB)');
grid on;
saveas(fig, 'gainsPerFreq.png');
