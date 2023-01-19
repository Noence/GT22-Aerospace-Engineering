%% 2 point Gauss quadrature
% By: Noe Lepez Da Silva Duarte
% Created: 21 March 2022

function I = gauss_2pnt(f, a, b)


const1 = (b-a)/2;
const2 = (b+a)/2;
const3 = 1/sqrt(3);

I = const1*(f(const2-const1*const3)+f(const2+const1*const3));

end