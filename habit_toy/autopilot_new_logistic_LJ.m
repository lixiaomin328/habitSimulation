function autopilot_new_logistic

%%%%%this model is based on the note "autopilot_v4.docx" written on
%%%%%11/5/2020%%%%%%%

lambda_r = 0.3;
lambda_d = 0.3;
sigma = 0.2; %switching threshold between habit and goal-directed modes
beta = 100; %exploration parameter (for the softmax rule)
kappa = 0.5; %logistic function parameter

%%%%activity distribution parameter%%%%%%%%%%%%%%%%%%%
mu_1 = 0; %lognormal mu (A_1)
sigma_1 = 0.8; %lognormal sigma (A_1)
u_2 = 1.5;   %outdoor activities (A_2)
u_3 = 0;   %doing nothing (A_3)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%time series implications%%%%%%%%%%%
T = 200;
time_vec = zeros(1,T);
%%%%%%%%%%%%
r_1_vec = zeros(1,T);
r_2_vec = zeros(1,T);
r_3_vec = zeros(1,T);
%%%%%%%%%%%%
d_1_vec = zeros(1,T);
d_2_vec = zeros(1,T);
d_3_vec = zeros(1,T);
%%%%%%%%%%%%
u_1_vec = zeros(1,T);
%%%%%%%%%%%%
habit_mode = zeros(1,T);
%%%%%%%%%%%%
choice_vec = zeros(1,T); %1 is A_1; 2 is A_2; and 3 is A_3
%%%%initial conditions%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%
d_1 = 1;
d_2 = 1;
d_3 = 1;
r_1 = 0;
r_2 = 0;
r_3 = 0;
u_0 = exp(mu_1 + 0.5*sigma_1^2);
%%%%%%%%%%%%initial choice at time 0 is set to A_1
%%%%%%%%%%%%%%%%%%%%%%%%%%
plot_fig = 1;

for i = 1:T
    time_vec(i) = i;
    if (i == 1)
            %%%%updating r_1 and d_1 at time 1;
            r_1_vec(i) = r_1 + lambda_r*(u_0 - r_1);
            d_1_vec(i) = (1 - lambda_d)*d_1 + lambda_d*abs(u_0 - r_1);

            %%%%updating other reward predictions and reliability 
            r_2_vec(i) = r_2;
            r_3_vec(i) = r_3;
            d_2_vec(i) = (1 - lambda_d)*d_2 + lambda_d;
            d_3_vec(i) = (1 - lambda_d)*d_3 + lambda_d;
            
            %%%%pinning down choices%%%%
            logistic_prob = 1/(1 + exp(-kappa*(d_1_vec(i) - sigma)));
            prob_draw_logistic = rand;
            if (prob_draw_logistic <= logistic_prob)
                goal_directed = 1;
            else
                goal_directed = 0;
            end
            
            if (goal_directed == 0)
                choice_vec(i) = 1;
                habit_mode(i) = 1;
            else
                %%%%use the softmax rule to make a new choice%%%%
                sum = exp(beta*r_1_vec(i)) + exp(beta*r_2_vec(i)) + exp(beta*r_3_vec(i));
                prob_part = [exp(beta*r_1_vec(i))/sum (exp(beta*r_1_vec(i)) + exp(beta*r_2_vec(i)))/sum 1];
                prob_draw = rand;
                
                if (prob_draw <= prob_part(1))
                    choice_vec(i) = 1;
                else
                    choice_vec(i) = numel(find(prob_part < prob_draw)) + 1;
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            end           
            u_1_vec(i) = exp(mu_1 + sigma_1*randn);
              
    else  %%%%%%%%%%%%%%%%%i > 1
        if (choice_vec(i-1) == 1)
            %%%%updating r_1 and d_1 at time i;
            r_1_vec(i) = r_1_vec(i-1) + lambda_r*(u_1_vec(i-1) - r_1_vec(i-1));
            d_1_vec(i) = (1 - lambda_d)*d_1_vec(i-1) + lambda_d*abs(u_1_vec(i-1) - r_1_vec(i-1));
            %%%%updating other reward predictions and reliability 
            r_2_vec(i) = r_2_vec(i-1);
            r_3_vec(i) = r_3_vec(i-1);
            d_2_vec(i) = (1 - lambda_d)*d_2_vec(i-1) + lambda_d;
            d_3_vec(i) = (1 - lambda_d)*d_3_vec(i-1) + lambda_d;
            
            %%%%pinning down choices%%%%
            logistic_prob = 1/(1 + exp(-kappa*(d_1_vec(i) - sigma)));
            prob_draw_logistic = rand;
            if (prob_draw_logistic <= logistic_prob)
                goal_directed = 1;
            else
                goal_directed = 0;
            end
            
            if (goal_directed == 0)
                choice_vec(i) = 1;
                habit_mode(i) = 1;                
            else
                %%%%use the softmax rule to make a new choice%%%%
                sum = exp(beta*r_1_vec(i)) + exp(beta*r_2_vec(i)) + exp(beta*r_3_vec(i));
                prob_part = [exp(beta*r_1_vec(i))/sum (exp(beta*r_1_vec(i)) + exp(beta*r_2_vec(i)))/sum 1];
                prob_draw = rand;
                
                if (prob_draw <= prob_part(1))
                    choice_vec(i) = 1;
                else
                    choice_vec(i) = numel(find(prob_part < prob_draw)) + 1;
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            end           
            u_1_vec(i) = exp(mu_1 + sigma_1*randn);
            
        elseif (choice_vec(i-1) == 2)
            %%%%updating r_2 and d_2 at time i;
            r_2_vec(i) = r_2_vec(i-1) + lambda_r*(u_2 - r_2_vec(i-1));
            d_2_vec(i) = (1 - lambda_d)*d_2_vec(i-1) + lambda_d*abs(u_2 - r_2_vec(i));
            %%%%updating other reward predictions and reliability 
            r_1_vec(i) = r_1_vec(i-1);
            r_3_vec(i) = r_3_vec(i-1);
            d_1_vec(i) = (1 - lambda_d)*d_1_vec(i-1) + lambda_d;
            d_3_vec(i) = (1 - lambda_d)*d_3_vec(i-1) + lambda_d;
            
            %%%%pinning down choices%%%%
            logistic_prob = 1/(1 + exp(-kappa*(d_2_vec(i) - sigma)));
            prob_draw_logistic = rand;
            if (prob_draw_logistic <= logistic_prob)
                goal_directed = 1;
            else
                goal_directed = 0;
            end
            
            if (goal_directed == 0)
                choice_vec(i) = 2;
                habit_mode(i) = 1;                
            else
                %%%%use the softmax rule to make a new choice%%%%
                sum = exp(beta*r_1_vec(i)) + exp(beta*r_2_vec(i)) + exp(beta*r_3_vec(i));
                prob_part = [exp(beta*r_1_vec(i))/sum (exp(beta*r_1_vec(i)) + exp(beta*r_2_vec(i)))/sum 1];
                prob_draw = rand;
                
                if (prob_draw <= prob_part(1))
                    choice_vec(i) = 1;
                else
                    choice_vec(i) = numel(find(prob_part < prob_draw)) + 1;
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            end                          
            u_1_vec(i) = exp(mu_1 + sigma_1*randn);
        else
            %%%%updating r_3 and d_3 at time i;
            r_3_vec(i) = r_3_vec(i-1) + lambda_r*(u_3 - r_3_vec(i-1));
            d_3_vec(i) = (1 - lambda_d)*d_3_vec(i-1) + lambda_d*abs(u_3 - r_3_vec(i));            
            %%%%updating other reward predictions and reliability 
            r_1_vec(i) = r_1_vec(i-1);
            r_2_vec(i) = r_2_vec(i-1);
            d_1_vec(i) = (1 - lambda_d)*d_1_vec(i-1) + lambda_d;
            d_2_vec(i) = (1 - lambda_d)*d_2_vec(i-1) + lambda_d;
            
            %%%%pinning down choices%%%%
            logistic_prob = 1/(1 + exp(-kappa*(d_3_vec(i) - sigma)));
            prob_draw_logistic = rand;
            if (prob_draw_logistic <= logistic_prob)
                goal_directed = 1;
            else
                goal_directed = 0;
            end            
            
            if (goal_directed == 0)
                choice_vec(i) = 3;
                habit_mode(i) = 1;                
            else
                %%%%use the softmax rule to make a new choice%%%%
                sum = exp(beta*r_1_vec(i)) + exp(beta*r_2_vec(i)) + exp(beta*r_3_vec(i));
                prob_part = [exp(beta*r_1_vec(i))/sum (exp(beta*r_1_vec(i)) + exp(beta*r_2_vec(i)))/sum 1];
                prob_draw = rand;
                
                if (prob_draw <= prob_part(1))
                    choice_vec(i) = 1;
                else
                    choice_vec(i) = numel(find(prob_part < prob_draw)) + 1;
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            end       
            u_1_vec(i) = exp(mu_1 + sigma_1*randn);
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%plot figures%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (plot_fig == 1)
set(gcf,'color','w');
set(0,'defaultTextInterpreter','latex');
set(gca,'FontName','Times New Roman');

subplot(2,2,1)
plot(time_vec,choice_vec)
%plot(time_vec,u_A_vec,'r-.',time_vec,r_A_vec,'b:',time_vec,d_A_vec,'m-.',time_vec,d_B_vec,'m--',time_vec,choice_vec,'k')
set(gca,'FontSize',16);
h = legend('$c(t)$');
%h = legend('${u}_{A_1}(t)$','$r_{A_1}(t)$','$d_{A_1}(t)$','$d_{A_2}(t)$','$c(t)$');
set(h,'Interpreter','latex', 'FontSize', 12)

xlabel('time $t$','Interpreter','Latex','FontSize', 16)
%xlim([1,T])

subplot(2,2,2)
plot(time_vec,r_1_vec,time_vec,r_2_vec,time_vec,r_3_vec)
%plot(time_vec,u_A_vec,'r-.',time_vec,r_A_vec,'b:',time_vec,d_A_vec,'m-.',time_vec,d_B_vec,'m--',time_vec,choice_vec,'k')
set(gca,'FontSize',16);
h = legend('$r_1(t)$','$r_2(t)$','$r_3(t)$');
%h = legend('${u}_{A_1}(t)$','$r_{A_1}(t)$','$d_{A_1}(t)$','$d_{A_2}(t)$','$c(t)$');
set(h,'Interpreter','latex', 'FontSize', 12)

xlabel('time $t$','Interpreter','Latex','FontSize', 16)

subplot(2,2,3)
plot(time_vec,d_1_vec,time_vec,d_2_vec,time_vec,d_3_vec,time_vec,habit_mode)
%plot(time_vec,u_A_vec,'r-.',time_vec,r_A_vec,'b:',time_vec,d_A_vec,'m-.',time_vec,d_B_vec,'m--',time_vec,choice_vec,'k')
set(gca,'FontSize',16);
h = legend('$d_1(t)$','$d_2(t)$','$d_3(t)$','habit');
%h = legend('${u}_{A_1}(t)$','$r_{A_1}(t)$','$d_{A_1}(t)$','$d_{A_2}(t)$','$c(t)$');
set(h,'Interpreter','latex', 'FontSize', 12)

xlabel('time $t$','Interpreter','Latex','FontSize', 16)


subplot(2,2,4)
plot(time_vec,u_1_vec)
%plot(time_vec,u_A_vec,'r-.',time_vec,r_A_vec,'b:',time_vec,d_A_vec,'m-.',time_vec,d_B_vec,'m--',time_vec,choice_vec,'k')
set(gca,'FontSize',16);
h = legend('$u_1(t)$');
%h = legend('${u}_{A_1}(t)$','$r_{A_1}(t)$','$d_{A_1}(t)$','$d_{A_2}(t)$','$c(t)$');
set(h,'Interpreter','latex', 'FontSize', 12)

xlabel('time $t$','Interpreter','Latex','FontSize', 16)
end
end

