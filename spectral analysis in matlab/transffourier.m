function [f,tfx] = transffourier(y,Nf,fs)
    tfx = zeros(Nf,1);
    f = zeros(Nf,1);
    for k=1:Nf
        dummy = 0;
        for n=1:length(y)
           dummy = dummy + y(n) .* exp(-j.*2.*pi.*(k-1).*(n-1)./Nf);
        end
        f(k) = fs.*(k-1)./Nf;
        tfx(k) = dummy;
    end
    tfx = tfx./fs;
end