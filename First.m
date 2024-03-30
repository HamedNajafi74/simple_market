clear
clc
%%
p1 = optimvar('p1','LowerBound',0,'UpperBound',6);
p3 = optimvar('p3','LowerBound',0,'UpperBound',2);
p1_price=10; % $/MWh
p3_price=20; % $/MWh
prob = optimproblem('Objective',p1_price*p1+p3_price*p3,'ObjectiveSense','min');
%% Constraints
prob.Constraints.c1 = p1 + p3 == 5; % Power Balance
F12 = (4/12)*(2*p1+p3-3.2);
F23 = (-4/12)*(p1+2*p3-6.4);
F13 = (4/12)*(p1-p3+6.4-3.2);
prob.Constraints.c2 = F12 <= 2; % Line1-2
prob.Constraints.c3 = F23 <= 2; % Line2-3
prob.Constraints.c4 = F13 <= 2; % Line1-3
%%
problem = prob2struct(prob);
[sol,fval,exitflag,output] = linprog(problem);
p1=sol(1)
p3=sol(2)
F12 = (4/12)*(2*p1+p3-3.2)
F23 = (-4/12)*(p1+2*p3-6.4)
F13 = (4/12)*(p1-p3+6.4-3.2)

