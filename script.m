tic
clear all
% close all
clc
% addpath('@GridWorld/')
obj = GridWorld; obj = obj.default; 
% obj.Visu = 1;
toc
%%
if isempty(gcf)
    figure('windowstyle','docked')
else
    clf
end
subplot(2,4,1)
imagesc(obj.Rewards)%,[-1 2])
axis square
title Rewards
colorbar

subplot(2,4,2)
% imagesc(obj.Rewards)%,[-1 2])
axis square
title '\pi* DP'
colorbar

%%
obj = obj.DP(1);
subplot(2,4,4)
imagesc(obj.Agent(1).Values)%,[-1 2])
axis square
title DP
colorbar

subplot(2,4,3)

for iTd = 1:10
    obj = obj.TD0(2,1000);
    imagesc(obj.Agent(2).Values)%,[-1 2])
    axis square
    title([obj.Agent(2).Name ' ' num2str(iTd)])
    colorbar
    drawnow
    pause(0.1)
end

%%
subplot(2,4,5)

% obj.Agent(3).Epsilon = .7;%.99*obj.Agent(3).Epsilon;
% obj.Agent(3).Alpha = .7;%.9*obj.Agent(3).Alpha;
for iSarsa = 1:10
    obj = obj.Sarsa(3,1000);
    obj.Agent(3).Epsilon = .5*obj.Agent(3).Epsilon;
    obj.Agent(3).Alpha = .5*obj.Agent(3).Alpha;
%     imagesc(reshape(mean(obj.Agent(3).Values,2),10,10),[-1 1])
    imagesc(reshape(sum(obj.Agent(3).Policy.*obj.Agent(3).Values,2),10,10))%,[-1 2])
    axis square
    title([obj.Agent(3).Name ' ' num2str(iSarsa)])
    colorbar
    drawnow
    pause(0.1)
end

obj = obj.DP(4,obj.Agent(3).Policy);
subplot(2,4,6)
imagesc(obj.Agent(4).Values)%,[-1 2])
axis square
title DP
colorbar
%%
subplot(2,4,7)

for iQ = 1:10
    obj = obj.Qlearning(5,10000);
%     obj.Agent(5).Epsilon = .9*obj.Agent(5).Epsilon;
%     imagesc(reshape(max(obj.Agent(5).Values,[],2),10,10),[-1 1]) % calculate under control policy
    imagesc(reshape(sum(obj.Agent(5).Policy.*obj.Agent(5).Values,2),10,10))%,[-1 2])
    axis square
    title([obj.Agent(5).Name ' ' num2str(iQ)])
    colorbar
    drawnow
    pause(0.1)
end

obj = obj.DP(6,obj.Agent(5).Policy);
subplot(2,4,8), cla
imagesc(obj.Agent(6).Values)%,[-1 2])
axis square
title DP
colorbar
%%
% subplot(2,3,6)
% 
% for iTd = 1:50
%     obj = obj.TD0_linFeat(3,10000,5);
%     imagesc(obj.Agent(3).Values)
%     axis square
%     title(['TD0 ' num2str(iTd) '/10'])
%     colorbar
%     drawnow
%     pause(0.1)
% end
