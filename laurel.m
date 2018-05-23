% Leser inn en fil og kutter ut delen hvor det sies "laurel" eller "yanny".
% Bruker så lavpass filter for å se om det kommer tydligere frem at det
% sies laurel, siden yanny trolig vil ha en høyere frekvens.


% les wav fil inn i orginal_stereo matrise
%------------------------------------------
[orginal_stereo, Fs]=audioread('laurel.wav');
Fs 
Ts=1/Fs
% konverter til mono
%---------------------------
kanal=1;                                 % Kanal=1 er venstre, Kanal=2 er høyre 
orginal_mono=orginal_stereo(:,kanal);    % Lager mono søylevektor

% lag et kortere klipp
%-------------------------------
start_tid = 1.6;
stopp_tid = 3;
start_N=round(start_tid/Ts)       % Ts er samplingsperiode 
stopp_N=round(stopp_tid/Ts)       % Fs er samplingsfrekvens  

klipp_mono=orginal_mono(start_N:stopp_N,1);

%spiller av den klippede mono lyden
clear sound
sound(klipp_mono,Fs); % stopp med "clear sound"

%
% plot i tidsdomenet
%---------------------------------------------------------------------------
% finner antall sampels
N=length(klipp_mono);
% lager en tidsakse å plotte mot
sample_vektor = [0:N-1];
tids_akse = sample_vektor*Ts;
plot(tids_akse,klipp_mono); % Plotter registrerte taleverdier mot tidsverdier

%
% plot i frekvensdomenet av et sekund (det første)
%--------------------------------------------------------------------------
FN = 44100;
f_res = Fs/FN;
f_akse = [0:FN-1]*f_res;
FFT = abs(fft(klipp_mono,FN));
stem(f_akse,FFT);
pause(1.4);

%%
% Bruker windowing metoden for å finne et lavpass filter med cutoff 10kHz
%--------------------------------------------------------------------------
% når fN = 44100
tell = [
0.02371563
0.004522729
-0.021943145
-0.043773259
-0.048041115
-0.025976494
0.022913573
0.089537341
0.157460806
0.208058891
0.22675737
0.208058891
0.157460806
0.089537341
0.022913573
-0.025976494
-0.048041115
-0.043773259
-0.021943145
0.004522729
0.02371563
]; % teller 
nevn = [1]; % nevner
orginal_mono_filtert = filter(tell,nevn,klipp_mono);
% spiller av
clear sound
soundsc(orginal_mono_filtert,Fs);
%
% plot i frekvensdomenet av et sekund (det første)
%--------------------------------------------------------------------------
FN = 44100;
f_res = Fs/FN;
f_akse = [0:FN-1]*f_res;
FFT = abs(fft(orginal_mono_filtert,FN));
stem(f_akse,FFT);
pause(1.4)
%%
% Bruker windowing metoden for å finne et lavpass filter med cutoff 4750Hz
%--------------------------------------------------------------------------
% når fN = 44100
tell = [
-0.007634589
0.00339612
0.016751197
0.031750812
0.047549193
0.063195705
0.077706474
0.09014055
0.099674069
0.105666005
0.107709751
0.105666005
0.099674069
0.09014055
0.077706474
0.063195705
0.047549193
0.031750812
0.016751197
0.00339612
-0.007634589
]; % teller 
nevn = [1]; % nevner
orginal_mono_filtert = filter(tell,nevn,klipp_mono);
% spiller av
clear sound
soundsc(orginal_mono_filtert,Fs);

%
% plot i frekvensdomenet av et sekund (det første)
%--------------------------------------------------------------------------
FN = 44100;
f_res = Fs/FN;
f_akse = [0:FN-1]*f_res;
FFT = abs(fft(orginal_mono_filtert,FN));
stem(f_akse,FFT);
