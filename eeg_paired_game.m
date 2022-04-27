player1 = pop_loadset('filename','0417howard3.set','filepath','/Users/Plack/Desktop/');
player2 = pop_loadset('filename','0417irene3.set','filepath','/Users/Plack/Desktop/');
merged  = pop_loadset('filename','merged.set','filepath','/Users/Plack/Desktop/');
ch = 7;
p1_e2 = pop_epoch( player1, {  '2'  }, [-1  2], 'epochinfo', 'yes');
p2_e2 = pop_epoch( player2, {  '2'  }, [-1  2], 'epochinfo', 'yes');
m_e2  = pop_epoch( merged , {  '2'  }, [-1  2], 'epochinfo', 'yes');

mean_p1_e2 = mean(p1_e2.data(ch,:,:),3);
mean_p2_e2 = mean(p2_e2.data(ch,:,:),3);
mean_m_e2  = mean( m_e2.data(ch,:,:),3);

[S1,F1,T1,P1] = spectrogram(mean_p1_e2,250,125,250,250); % [s, f, t, p] = spectrogram(x, window, noverlap, f, fs)
PP1 = mean(P1, 2);
h1 = plot (PP1); % x: frequency y: amplitude
set(h1, 'linewidth', 4);
xlim([1 30])
hold on;

[S2,F2,T2,P2] = spectrogram(mean_p2_e2,250,125,250,250);
PP2 = mean(P2, 2);
h2 = plot (PP2);
set(h2, 'linewidth', 4);
xlim([1 30])
hold on;

[S3,F3,T3,P3] = spectrogram(mean_m_e2,250,125,250,250); 
PP3 = mean(P3, 2);
h3 = plot (PP3);
set(h3, 'linewidth', 4);
xlim([1 30]);

xlabel('Frequency(Hz)');
ylabel('Amplitude(μV)');
legend([h1,h2,h3],'howard','irene','merged'); % 圖例
set(gca, 'lineWidth', 4, 'FontSize', 14);

% normalize
topoplot()
