%% Integration using Simpson's 3/8 rule 
% By: Noe Lepez Da Silva Duarte
% Created: 21 March 2022

function I = s38_r(f, a, b, N)


h = (b-a)/N;
I = f(a)+f(b);

for i = 1:N-1
    
    if rem(i,3)==0
        I = I+2*f(i*h);
    else
        I = I+3*f(i*h);
    end
    
end

I = (b-a)*I*3/(8*N);

end