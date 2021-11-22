%nbPoints = 2^16;
%t = linspace(-2,2,nbPoints);
%Fe = nbPoints/4;
%f = linspace(-Fe,Fe,nbPoints);
%a = 2;f0 = 5; phi = pi/4;

Nt = 128;
fs = 1000;
f0 = 5/128*fs; %f0 = 39.0625 Hz
n = 0:Nt-1;
a = 2; phi = pi/4;

y = a*cos(2*pi*n*f0/fs + phi);

figure('Name','Time Plot');
plot(n/fs,y);
xlabel('Time in seconds');
ylabel('Amplitude');

Nf = 128;

[f,tfx] = transffourier(y,Nf,fs);

figure('Name','Spectre');
plot(f,abs(tfx));
xlabel('Frequency (Hz)');
ylabel('Amplitude');

figure('Name','Spectre with Cross marker');
plot(f,abs(tfx),'+');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

Nf = 4096;

[f,tfx] = transffourier(y,Nf,fs);

figure('Name','Spectre with more samples');
plot(f,abs(tfx));
xlabel('Frequency (Hz)');
ylabel('Amplitude');

f0 = 5.7/128*fs; %f0 = 44.53125 


y = a*cos(2*pi*n*f0/fs + phi);

figure('Name','Time Plot with new f0');
plot(n/fs,y);
xlabel('Time in seconds');
ylabel('Amplitude');

Nf = 128;

[f,tfx] = transffourier(y,Nf,fs);

figure('Name','Spectre with new f0');
plot(f,abs(tfx));
xlabel('Frequency (Hz)');
ylabel('Amplitude');

figure('Name','Spectre with Cross marker with new f0');
plot(f,abs(tfx),'+');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

% The position of the peaks corresponds to frequencies f0 + kfs and -f0+k'fs (k and k' belong
% to Z), where the dirac deltas of the samples sine wave should
% theoretically be positioned. And since the spectrum is periodic, the
% position of the two peaks we see depends on the period we chose to
% examine. If we use the transffourier_with_symmetry function, we then
% examine the central period and we see the two peaks at f0 and -f0. If we
% chose to use the transffourier function, then we view the two peaks
% belonging to first spectral period between 0 and fs, therefore the two
% peaks we see in this case belond to f0 and -f0 + fs. 

Nf = 4096;

[f,tfx] = transffourier(y,Nf,fs);

figure('Name','Spectre with more samples with new f0');
plot(f,abs(tfx));
xlabel('Frequency (Hz)');
ylabel('Amplitude');
