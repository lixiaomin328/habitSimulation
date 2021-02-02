RoundNum = 1000;%total Round
kappa=.2;

longestHabits = [];
secondlongHabits = [];
frequencyMostCommonChoices = [];
frequencyLeastCommonChoices = [];
frequencyMostValueChoices = [];
habitPercents = [];
choicesIndex = [];
for i = 1:RoundNum
    [choices,ds,uts,rs,hs,ucs]=simulationHabit();
    habitTime = find(hs==1);
    habitPercent = length(habitTime)/length(hs);
    habitEnds = [habitTime(diff(habitTime)~=1);habitTime(end)];
    habitBegins = [habitTime(1);habitTime(find(diff(habitTime)~=1)+1)];
    habitLength = sort(habitEnds-habitBegins,'descend');
    %output
    longestHabit = habitLength(1);
    secondlongHabit = habitLength(2);
    frequencyMostCommonChoice = max(sum(choices))/(sum(sum(choices)));
    frequencyLeastCommonChoice = min(sum(choices))/(sum(sum(choices)));
    frequencyMostValueChoice = sum(ucs)/length(ucs);
    i
    longestHabits = [longestHabits;longestHabit];
    secondlongHabits = [secondlongHabits;secondlongHabit];
    frequencyMostCommonChoices = [frequencyMostCommonChoices;frequencyMostCommonChoice];
    frequencyLeastCommonChoices = [frequencyLeastCommonChoices;frequencyLeastCommonChoice];
    frequencyMostValueChoices = [frequencyMostValueChoices;frequencyMostValueChoice];
    habitPercents = [habitPercents;habitPercent];
end
figure()
subplot(2,3,1)
hist(longestHabits)
xlabel('length of period')
title('Longest habit period over 1000 period simulation')
hold on
xline(mean(longestHabits),'-.k','Mean','linewidth',3);

subplot(2,3,2)
hist(secondlongHabits)
xlabel('length of period')
hold on
title('Second longest habit period over 1000 period simulation')
xline(mean(secondlongHabits),'-.k','Mean','linewidth',3);

subplot(2,3,3)
hist(frequencyLeastCommonChoices)
hold on
xline(mean(frequencyLeastCommonChoices),'-.k','Mean','linewidth',3);
xlabel('frequency')
title('Frequency of least chosen choice')

subplot(2,3,4)
hist(frequencyMostCommonChoices)
hold on
xline(mean(frequencyMostCommonChoices),'-.k','Mean','linewidth',3);
xlabel('frequency')
title('Frequency of most chosen choice')

subplot(2,3,5)
hist(frequencyMostValueChoices)
hold on
xline(mean(frequencyMostValueChoices),'-.k','Mean','linewidth',3);
xlabel('frequency')
title('Frequency of chosen most valuable outcome')

subplot(2,3,6)
hist(habitPercents)
hold on
xline(mean(habitPercents),'-.k','Mean','linewidth',3);
xlabel('frequency')
title('Frequency of being at habit mode')

