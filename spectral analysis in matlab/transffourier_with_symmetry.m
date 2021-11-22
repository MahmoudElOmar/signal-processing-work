function [f,tfx] = transffourier_with_symmetry(y,Nf,fs)
    tfx = zeros(Nf,1);
    f = zeros(Nf,1);
    for k=-Nf/2:Nf/2-1
        dummy = 0;
        for n=1:length(y)
           dummy = dummy + y(n) .* exp(-j.*2.*pi.*(k).*(n-1)./Nf);
        end
        f(k + Nf/2+1) = fs.*(k)./Nf;
        tfx(k Nf/2+1) = dummy;
    end
    tfx = tfx./fs;
end