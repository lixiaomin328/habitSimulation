%%PLOTS
function plotHabit(ds,rs,uts,choices)
%figure()
roundN = length(ds);
%figure()
subplot(2,2,1)
for i = 1:3
plot([1:roundN],ds(:,i))
hold on    
end
hold off
legend('Choice A','Choice B','Choice C')
title('Reliability')
  xlabel('Period');
ylabel('d level');
plotImprovement

subplot(2,2,2)
for i = 1:3
plot(rs(:,i))
hold on    
end
hold off
legend('choice A','choice B','choice C')
title('Attraction')
  xlabel('Period');
ylabel('r level');
plotImprovement

subplot(2,2,3)
for i = 1:3
plot(uts(:,i))
hold on    
end
hold off
legend('choice A','choice B','choice C')
title('Utility')
  xlabel('Period');
ylabel('u level');
plotImprovement

subplot(2,2,4)
for i = 1:3
plot(choices(:,i)+1e-2*i)
hold on    
end
hold off
legend('choice A','choice B','choice C')
title('Choice')
  xlabel('Period');
ylabel('Choice');
plotImprovement