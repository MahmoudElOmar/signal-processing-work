[music_t,Fs] = audioread('musique.wav');
info = audioinfo('musique.wav');

fprintf("Sampling Frequency : %d Hz\n",Fs)
fprintf("Bits per Sample : %d bits/sample \n", info.BitsPerSample)

t = 1:length(music_t);

figure('Name','Music Plot : Time Domain')
plot(t,music_t)


f = linspace(-Fs/2,Fs/2,length(music_t));
music_f = fftshift(fft(music_t));

figure('Name','Music Plot : Frequency Domain')
plot(f,abs(music_f))



%By inspecting the spectral plot, we see that frequency components beyond
%5000 Hz have neligible amplitudes, and therefore they barely have any
%effect on the overall signal, barely contain any energy and barely contain
%any information. So we will only take into consideration frequencies below
%5 kHz to implement a data dependent encode

fmin = 0;
fmax = 8000;

[nbSamples,scale] = coder(music_t,Fs,info.BitsPerSample,fmin,fmax,'compressed_music.wav');
[music_reconstructed,Fs,bits] = decoder('compressed_music.wav',fmin,fmax,nbSamples,scale);


audiowrite('reconstructed_music.wav',music_reconstructed,Fs,'BitsPerSample',info.BitsPerSample);

sound(music_t,Fs)
for i = 1:10^10
end
sound(music_reconstructed,Fs)

%Au premier lieu, on écoute le fichier original musique.wav sans aucune
%modificatioin. Après on écoute le fichier reconstruced_music_(0,5000).wav dans
%lequel sont présentes les composants spectraux qui sont entre 0Hz et
%5000Hz. En fait, on peut entendre distictement l'effet d'éliminer tous les
%composants hautes fréquences. Vers la fin où le violoncelliste monte dans
%les notes, le son devient de plus en plus étouffé. Ça n'est pas assez
%détectable au début où le violoncelliste joue des notes plus bas. C'est
%parce que les composants spectraux éliminés contribuent plus aux hautes
%notes, comme le Si_bemol (467Hz) et le La (440 Hz) vers la fin, qu'aux
%basses notes comme le Ré (74 Hz) qui est la toute première note jouée.
%Pour fmax = 8000, on écoute quasiment la même chose que le fichier
%original musique.wav
%Pour fmin = 100,fmax = 100000, on écoute un son tordu, avec beaucoup de
%dissonance.
