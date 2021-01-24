uts = [];
ut = u0;
for i = 1:100
uts = [uts;ut];
ut = ut +normrnd(0,1);
end
plot(uts)