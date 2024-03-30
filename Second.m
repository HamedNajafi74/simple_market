clear
clc
%%
f12 = optimvar('f12','LowerBound',-2,'UpperBound',2);
f13 = optimvar('f13','LowerBound',-2,'UpperBound',2);
f23 = optimvar('f23','LowerBound',-2,'UpperBound',2);
p1 = optimvar('p1','LowerBound',0,'UpperBound',6);
p3 = optimvar('p3','LowerBound',0,'UpperBound',2);
p1_price=10; % $/MWh
p3_price=20; % $/MWh
prob = optimproblem('Objective',p1_price*p1+p3_price*p3,'ObjectiveSense','min');
%% Constraints
prob.Constraints.c1 = p1 + p3 == 5; % Power Balance
prob.Constraints.c2 = p1==f12+f13;
prob.Constraints.c3 = p3==-f23-f13+3.2;
prob.Constraints.c4 = 0-1.8==-f12+f23;

prob.Constraints.c5 = f12 <= 2; % Line1-2
prob.Constraints.c6 = f23 <= 2; % Line2-3
prob.Constraints.c7 = f13 <= 2; % Line1-3

problem = prob2struct(prob);
[sol,fval,exitflag,output] = linprog(problem);