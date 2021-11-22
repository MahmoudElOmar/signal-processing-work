function [y,fs,bits] = decoder(path, fmin, fmax, nbSamples, scale)
    disp(nbSamples)
    [tfymasq,fs] = audioread(path);
    fullNbSamples = (nbSamples-1)*(fs/fmax);
    fullNbSamples = int32(fullNbSamples);
    disp(fullNbSamples)
    bits = audioinfo(path);
    bits = bits.BitsPerSample;
    tfymasq = tfymasq.*scale;
    tfy = tfymasq(:,1) + 1i.*tfymasq(:,2);
    tfy = [tfy;zeros(fullNbSamples-nbSamples,1)];
    f = zeros(nbSamples,1);
    for k = 1:fullNbSamples
        f(k) = fs.*(k-1)./fullNbSamples;
    end
    disp('size of tfy')
    disp(size(tfy));
    disp('size of f')

    disp(size(f));

    f_sym = [-fliplr(f);f];
    tfy_sym = [fliplr(tfy);tfy];
    figure('Name','Spectral Plot Of Reconstructed Music')
    plot(f_sym,abs(tfy_sym));
    y = real(ifft(tfy));
    figure('Name','Time domain Plot Of Reconstructed Music')
    plot(1:length(y),y)
end

