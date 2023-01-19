%% Slender rod MOI about center finder
% By: Noe Lepez Da Silva Duarte
% Created: 23 March 2022

function I = slender_rod_MOI(M,L,dir)

const = (1/12)*M*L^2;

if dir=='x'
    I=[0,0,0;
       0,const,0;
       0,0,const];
elseif dir=='y'
    I=[const,0,0;
       0,0,0;
       0,0,const];
elseif dir=='z'
    I=[const,0,0;
       0,const,0;
       0,0,0];
else
    error('No such direction')


end