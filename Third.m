clear
clc
d1=0;
%%

d2 = optimvar('zd2','LowerBound',-pi,'UpperBound',pi);
d3 = optimvar('zd3','LowerBound',-pi,'UpperBound',pi);
p1_price=10; % $/MWh
p3_price=20; % $/MWh
p1=4*(d1-d2)+4*(d1-d3);
p3=4*(d3-d1)+4*(d3-d2)+3.2;
prob = optimproblem('Objective',p1_price*p1+p3_price*p3,'ObjectiveSense','min');
%% Constraints
prob.Constraints.c1 = p1 + p3 == 5; % Power Balance
f12=4*(d1-d2);
f13=4*(d1-d3);
f23=4*(d2-d3);

prob.Constraints.c5 = f12 <= 2; % Line1-2
prob.Constraints.c6 = f23 <= 2; % Line2-3
prob.Constraints.c7 = f13 <= 2; % Line1-3
problem = prob2struct(prob);
[sol,fval,exitflag,output] = linprog(problem);

d2=sol(1);d3=sol(2);

p1=4*(d1-d2)+4*(d1-d3)
p3=4*(d3-d1)+4*(d3-d2)+3.2
f12=4*(d1-d2)
f13=4*(d1-d3)
f23=4*(d2-d3)
