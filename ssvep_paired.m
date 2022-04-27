% 改路徑
p1_path = '/Users/Plack/Desktop/實驗室project/EEG/eeg-training-data/0417_ssvep_paired/0417_James_pair.txt'
p2_path = '/Users/Plack/Desktop/實驗室project/EEG/eeg-training-data/0417_ssvep_paired/0417_Leo_pair.txt'
save_set_folder = '/Users/Plack/Desktop/實驗室project/EEG/eeg-training-data/0417_ssvep_paired'

% data preprocessing
EEG = pop_importdata('dataformat','ascii','nbchan',0,'data',p1_path,'srate',250,'pnts',0,'xmin',0);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'gui','off'); 
EEG = eeg_checkset( EEG );
EEG = pop_chanevent(EEG, 10,'edge','leading','edgelen',0);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
EEG = eeg_checkset( EEG );
EEG = pop_select( EEG, 'channel',[2:9] );
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off'); 
EEG = eeg_checkset( EEG );
EEG = pop_epoch( EEG, {  '13'  }, [0  4], 'epochinfo', 'yes');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'gui','off'); 
EEG = eeg_checkset( EEG );
EEG = pop_rmbase( EEG, [],[]);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 3,'gui','off'); 
EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename','ssvep_p1.set','filepath',save_set_folder);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
EEG = pop_importdata('dataformat','ascii','nbchan',0,'data',p2_path,'srate',250,'pnts',0,'xmin',0);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'gui','off'); 
EEG = eeg_checkset( EEG );
EEG = pop_chanevent(EEG, 10,'edge','leading','edgelen',0);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
EEG = eeg_checkset( EEG );
EEG = pop_select( EEG, 'channel',[2:9] );
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off'); 
EEG = eeg_checkset( EEG );
EEG = pop_epoch( EEG, {  '13'  }, [0  4], 'epochinfo', 'yes');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'gui','off'); 
EEG = eeg_checkset( EEG );
EEG = pop_rmbase( EEG, [],[]);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 3,'gui','off'); 
EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename','ssvep_p2.set','filepath',save_set_folder);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
% data preprocessing done

% data merging
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename','ssvep_p1.set','filepath',save_set_folder);
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG = pop_loadset('filename','ssvep_p2.set','filepath',save_set_folder);
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG = eeg_checkset( EEG );
EEG = pop_mergeset( ALLEEG, [1  2], 0);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'gui','off'); 
EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename','ssvep_merged.set','filepath',save_set_folder);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET); 
% data merging done

% ch 改成要分析的 channel
ch = 3;
set_files = {'ssvep_p1.set', 'ssvep_p2.set', 'ssvep_merged.set'};

for n = 1:length(set_files)
    setfile = set_files{n};
	ssvep = pop_loadset('filename', setfile, 'filepath', save_set_folder);
    e13 = pop_epoch( ssvep, {  '13'  }, [0  4], 'epochinfo', 'yes');
    w13 = mean(e13.data(ch,:,:),3);
    [S,F,T,P] = spectrogram(w13,250,125,250,250);
    PP = mean(P, 2);
    h = plot (PP); 
    set(h, 'linewidth', 4);
    xlim([4 30])
    hold on;
end

xlabel('Frequency(Hz)');
ylabel('Amplitude(μV)');
legend(gca,'player1','player2','merged');
set(gca, 'lineWidth', 4, 'FontSize', 14);

