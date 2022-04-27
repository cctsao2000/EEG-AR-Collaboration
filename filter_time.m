ch = 1;
start_time = 1;
latency = 40;
end_time = start_time + latency;

ch1 = EEG.data(1,250*start_time:250*end_time);
ch2 = EEG.data(2,250*start_time:250*end_time);
ch3 = EEG.data(3,250*start_time:250*end_time);
ch4 = EEG.data(4,250*start_time:250*end_time);
ch5 = EEG.data(5,250*start_time:250*end_time);
ch6 = EEG.data(6,250*start_time:250*end_time);
ch7 = EEG.data(7,250*start_time:250*end_time);
ch8 = EEG.data(8,250*start_time:250*end_time);

% figure,plot(ch1(1:500))
ch_list = [ch1; ch2; ch3; ch4; ch5; ch6; ch7; ch8];
% 傅立葉轉換，畫圖 
for index = 1:8
    [S1,F1,T1,P1] = spectrogram(ch_list(index,:),250,125,250,250); % [s, f, t, p] = spectrogram(x, window, noverlap, f, fs)
    PP1 = mean(P1, 2);
    h1 = plot (PP1); % x: frequency y: amplitude
    set(h1, 'linewidth', 4);
    xlim([4 30])
    hold on;
end

xlabel('Frequency(Hz)');
ylabel('Amplitude(μV)');
set(gca, 'lineWidth', 4, 'FontSize', 14);
