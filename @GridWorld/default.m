function [ obj ] = default(obj)
temp = eye(numel(obj.States));
temp2 = circshift(temp,-10,2);
temp2(1:10,:) = temp(1:10,:);
temp2(find(obj.Rewards),:) = 1/10;

temp3 = circshift(temp,-1,2);
temp3(1:10:100,:) = temp(1:10:100,:);
temp3(find(obj.Rewards),:) = 1/10;

temp4 = circshift(temp,10,2);
temp4(end-9:end,:) = temp(end-9:end,:);
temp4(find(obj.Rewards),:) = 1/10;

temp5 = circshift(temp,1,2);
temp5(10:10:100,:) = temp(10:10:100,:);
temp5(find(obj.Rewards),:) = 1/10;

obj.Transitions = {temp2,temp3,temp4,temp5};

obj.Rewards = zeros(size(obj.States));
nRewards = 5;
obj.Rewards(randi(numel(obj.States),nRewards,1)) = randsample([-1 1],nRewards,1);
%             obj.Rewards(randi(numel(obj.States),6,1)) = [-1 -1 -1 1 1 1];
end