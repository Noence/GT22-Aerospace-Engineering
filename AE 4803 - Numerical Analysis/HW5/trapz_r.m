%% Integration using trapezoidal rule 
% By: Noe Lepez Da Silva Duarte
% Created: 21 March 2022

function I = trapz_r(f, a, b, N)


h = (b-a)/N;
I = f(a)+f(b);

for i = 1:N-1
    
    I = I+2*f(i*h);
    
end

I = (b-a)*I/(2*N);

end