%% Integration using Simpson's 1/3 rule 
% By: Noe Lepez Da Silva Duarte
% Created: 21 March 2022

function I = s13_r(f, a, b, N)


h = (b-a)/N;
I = f(a)+f(b);

for i = 1:N-1
    
    if rem(i,2)==0
        I = I+2*f(i*h);
    else
        I = I+4*f(i*h);
    end
    
end

I = (b-a)*I/(3*N);

end