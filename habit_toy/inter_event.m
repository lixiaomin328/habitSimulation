% The histograms for the choice data:

[choices,ds,uts,rs,hs,ucs]=simulationHabit(100000);
store = zeros(3, length(choices));
bandwith = 5;
for i = 1:3
    choice = choices(:,i);
    choice_pad = ones(length(choice) + 1, 1);
    choice_pad(1:length(choice), 1) = choice;
    
    events = [];
    counter = 0;
    
    for idx = 1:length(choice)
        unit = choice(idx);
        next_unit = choice_pad(idx + 1);
        
        if unit == 0
            counter = counter + 1;
            
            if next_unit == 1  
                events(end + 1) = counter;
                counter = 0;
            end
        end  
    end
    store(i, 1:length(events)) = events;
end

firsthistogram = nonzeros(store(1,:));
secondhistogram = nonzeros(store(2,:));
thirdhistogram = nonzeros(store(3,:));

% Create the Histogram:

subplot(1,3,1)
title('Frequencies of general inter-event intervals in the first choice-data')
hold on
histogram(firsthistogram, 'BinWidth',bandwith)
xlabel('Length of an inter-event')
ylabel('Log Frequency')
set(gca,'yscale','log')
hold off

subplot(1,3,2)
title('Frequencies of general inter-event intervals in the second choice-data')
hold on
histogram(secondhistogram, 'BinWidth',bandwith)
xlabel('Length of an inter-event')
ylabel('Log Frequency')
set(gca,'yscale','log')
hold off

subplot(1,3,3)
title('Frequencies of general inter-event intervals in the third choice-data')
hold on
histogram(thirdhistogram, 'BinWidth',bandwith)
xlabel('Length of an inter-event')
ylabel('Log Frequency')
set(gca,'yscale','log')
hold off
