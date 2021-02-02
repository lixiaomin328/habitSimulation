%%attraction, input:u,lambdar,u_(t-1),r(t-1),c(t-1)
function rt = attraction(c_tlast,u_tlast,r_tlast,lambdar,nChoice)
chosenr = r_tlast+lambdar*(u_tlast-r_tlast);
%unchosenr = r_tlast;
unchosenr = 0.04*(r_tlast+lambdar*(u_tlast-r_tlast));
rt = chosenr.*c_tlast+unchosenr.*(ones(nChoice,1)-c_tlast);
end

