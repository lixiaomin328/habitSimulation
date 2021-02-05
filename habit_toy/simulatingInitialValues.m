%%Kavya: write your simulation code here
%%%%%%%%
nChoice=3;
sigma =0.1;
kappa=.2; %threshold for relibility  %%simulate kappa for [0.1,0.5]
lambda_d = .3;
lambda_r = .3;
theta = 0.01;
nPeriod = 10000;
%%%%%%%%%%
[choices,ds,uts,rs,hs,ucs]=simulationHabit(nPeriod,nChoice,sigma,kappa,lambda_d,lambda_r,theta);


%%want to know
%%percentage of habit period, percentage of most utility chosen, 