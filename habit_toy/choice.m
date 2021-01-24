%%choice rule, input:u,d_(t-1),c(t-1),r(t)
function [ct,h] = choice(c_tlast,d_tlast,r_t,kappa,nChoice)
if c_tlast.*d_tlast<kappa
    ct=c_tlast;
    h = 1;
else
    [~,choiceIndex] = max(r_t);
    ct = zeros(nChoice,1);
    ct(choiceIndex) = 1;
    h =0;
end
end
