%% plot prettier
%run this after each plot

%% change line width
lines = findobj(gcf,'Type','Line');
for i = 1:numel(lines)
  lines(i).LineWidth = 2.0;
end

%% add x, y label

set(gca,'FontSize',25);

