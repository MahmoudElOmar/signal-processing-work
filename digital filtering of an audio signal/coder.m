function [nbSamples, scale] = coder(y,fs,bits,fmin,fmax,path)
    tfy = fft(y);
    tfy = tfy(:);
    nbSamples = length(y);

    kmin = round(nbSamples*fmin/fs) + 1;
    kmax = round(nbSamples*fmax/fs) + 1;
    
    nbSamples = kmax-kmin + 1; 
    
    tfymasq = tfy(kmin:kmax);
    
    tfymasq = [real(tfymasq) imag(tfymasq)];
    scale = max(max(abs(tfymasq)))*1.01;
    tfymasq = tfymasq/scale;
    
    audiowrite(path,tfymasq,fs,'BitsPerSample',bits);
    
    %wavwrite n'existe plus. Je suis sur MATLAB R2018a, donc je suis censé
    %utiliser les audiowrite, audioread et audioinfo qui donnent les même
    %résultats que wavwrite et wavread mais avec un petit changement dans
    %le fonctionnement interne.
end
