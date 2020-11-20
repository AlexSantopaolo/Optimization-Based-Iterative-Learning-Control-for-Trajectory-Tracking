function plot_trajectories(xHistory ,uHistory, xOptimal, uOptimal, name)
%%

global Ts Duration;
I=size(uHistory,1);

figure('Name',name,'NumberTitle','off')
for i=1:I
    % Plot the closed-loop response.
    subplot(2,3,1)
    plot(0:Ts:Duration,xHistory(1+(i-1)*4,:),'DisplayName',"iteration "+i)
    hold on

    subplot(2,3,2)
    plot(0:Ts:Duration,xHistory(2+(i-1)*4,:),'DisplayName',"iteration "+i)
    hold on

    subplot(2,3,3)
    plot(0:Ts:Duration,xHistory(3+(i-1)*4,:),'DisplayName',"iteration "+i)
    hold on
    
    subplot(2,3,4)
    plot(0:Ts:Duration,xHistory(4+(i-1)*4,:),'DisplayName',"iteration "+i)
    hold on

    subplot(2,3,5)
    plot(0:Ts:Duration,uHistory(i,:),'DisplayName',"iteration "+i)
    hold on
end

% Plot the closed-loop response.
subplot(2,3,1)
plot(0:Ts:Duration,xOptimal(1,:),'DisplayName',"nominal trajectory")
xlabel('time (seconds)')
ylabel('x (meters)')
title({"",'cart position',""})
lgd = legend;
hold on

subplot(2,3,2)
plot(0:Ts:Duration,xOptimal(2,:),'DisplayName',"nominal trajectory")
xlabel('time (seconds)')
ylabel("x' (meters/seconds)")
title({"",'cart velocity',""})
lgd = legend;
hold on

subplot(2,3,3)
plot(0:Ts:Duration,xOptimal(3,:),'DisplayName',"nominal trajectory")
xlabel('time (seconds)')
ylabel('\phi (radians)')
title({"",'pendulum angle',""})
lgd = legend;
hold on

subplot(2,3,4)
plot(0:Ts:Duration,xOptimal(4,:),'DisplayName',"nominal trajectory")
xlabel('time (seconds)')
ylabel("\phi' (radians/seconds)")
title({"",'pendulum velocity',""})
lgd = legend;
hold on

subplot(2,3,5)
plot(0:Ts:Duration,uOptimal,'DisplayName',"nominal trajectory")
xlabel('time (seconds)')
ylabel("u")
title({"",'input u',""})
lgd = legend;
hold on