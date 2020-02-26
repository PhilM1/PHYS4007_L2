%analysis of the pre-amplifier on the lock-in system
clear
close all;

Vin = 0.0099;%input voltage, approx 10mV, constant for all measurements
dataTable = readtable('preamp_data.xlsx'); %import the data

%loop through data
[numRows, numCols] = size(dataTable);
frequencyArray = dataTable.Frequency_Hz_;
VoutPPArraydB = 20*log10((abs(dataTable.VoutPP_top_ - dataTable.VoutPP_botom_))/Vin);

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
        
        
        %y = baseMag - 3;
        %m = (VoutPPArraydB(leftIndex)-VoutPPArraydB(leftIndex+1))/(frequencyArray(leftIndex+1)-frequencyArray(leftIndex));
        %b = VoutPPArraydB(leftIndex);
        dBFreq = (y-y1)*(x2-x1)/(y2-y1) + x1;
        
        fig = figure();
        semilogx(frequencyArray(startIndex:i),VoutPPArraydB(startIndex:i));
        title('TITLE');
        xlabel('Frequency (Hz');
        ylabel('Magnitude (dB)');
        hold on;
        scatter(dBFreq,y);
        hold off;
        startIndex = i+1;
    end
end