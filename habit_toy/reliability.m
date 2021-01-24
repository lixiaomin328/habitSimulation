%%
%%reliability, input: d_(t-1),c_(t-1),u_(t-1)
function dt = reliability(c_tlast,d_tlast,u_tlast,r_tlast,lambdad)
chosend = (1-lambdad)*d_tlast+lambdad*abs(u_tlast-r_tlast);
unchosend = (1-lambdad)*d_tlast+lambdad;
dt = chosend.*c_tlast+unchosend.*([1;1;1]-c_tlast);
end