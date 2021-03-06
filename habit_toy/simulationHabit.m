%%toy simulation1%%%%%%%%%
function [choices,ds,uts,rs,hs,ucs]=simulationHabit(roundN,nChoice,sigma,kappa,lambda_d,lambda_r,theta)
%parameters%%%%%%%%%

%%%%initialization parameters%%%
r0 = 1.3*ones(nChoice,1);
u0 =ones(nChoice,1)+normrnd(0,sigma,[nChoice,1]);
d0 =ones(nChoice,1);


%%%%%%initialization process%%%
rt = r0;
ut = r0;
dt = d0;
ut = u0;
h0 = 0;
[~,choiceIndex] = max(ut);
ct = zeros(nChoice,1);
ct(choiceIndex) = 1;
%%%%%%%%%%%%%%%%%%%
%%%%MAIN TIME SERIE RESULT%%
choices = ct';
ds =dt';
rs = rt';
uts = u0';
hs = h0;
ucs = 1;
%%%SIMULATION PART%%% (order is important!)
for round = 1:roundN
    d_tlast = dt;
    c_tlast = ct;
    r_tlast = rt;
    dt = reliability(c_tlast,d_tlast,ut,r_tlast,lambda_d);
    rt = attraction(c_tlast,ut,r_tlast,lambda_r,nChoice);
    [ct,h] = choice(c_tlast,d_tlast,rt,kappa,nChoice);
    ut = ut - theta*ut +normrnd(0,sigma,[nChoice,1]);
    maxUt = sign(ut -max(ut))+1;
    %%update 
    choices = [choices;ct'];
    ds =[ds;dt'];
    rs = [rs;rt'];
    uts = [uts;ut'];
    hs = [hs;h];
    ucs = [ucs; maxUt'*ct];
    
end

%plotHabit(ds,rs,uts,choices)

% dtn=[];
% for i =1:length(choices)
% dtn = [dtn;ds(i,:)*choices(i,:)'];
% end

%%write csv
% [~,choiceOrders] = max(choices');
% outputArray = [choiceOrders',ds,rs,dtn];
% outputs = array2table(outputArray);
% outputs.Properties.VariableNames(1:size(outputArray,2)) = {'choice','da','db','dc','ra','rb','rc','dtn'};	
% writetable(outputs,'simulationResult.csv');
% %%%








