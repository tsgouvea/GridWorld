function [obj] = Sarsa(obj,iAgent,nSteps)
if nargin < 2, iAgent = numel(obj.Agent) + 1; end
if nargin < 3, nSteps = 10000; end
if iAgent > numel(obj.Agent)
    obj.Agent(iAgent).Name = 'Sarsa, e-greedy';
    obj.Agent(iAgent).Alpha = .9;
    obj.Agent(iAgent).Epsilon = .9;
    obj.Agent(iAgent).Values = zeros(numel(obj.States),numel(obj.Actions))*2*max(obj.Rewards(:));
    obj.Agent(iAgent).Policy = ones(numel(obj.States),numel(obj.Actions))/numel(obj.Actions);
end
state = randi(numel(obj.States));
for iSarsa = 1:nSteps
    action = randsample(obj.Actions,1,1,obj.Agent(iAgent).Policy(state,:));
    newState = randsample(obj.States(:),1,1,obj.Transitions{action}(state,:));
    delta = obj.Rewards(state) + obj.Discount*obj.Agent(iAgent).Values(newState,action) - obj.Agent(iAgent).Values(state,action);
    obj.Agent(iAgent).Values(state,action) = obj.Agent(iAgent).Values(state,action) + obj.Agent(iAgent).Alpha * delta;
    actMax = obj.Agent(iAgent).Values(state,:) == max(obj.Agent(iAgent).Values(state,:)); actMax = actMax/sum(actMax);
    obj.Agent(iAgent).Policy(state,:) = obj.Agent(iAgent).Epsilon * ones(size(actMax))/numel(actMax) + ...
        (1-obj.Agent(iAgent).Epsilon) * actMax; % Epsilon greedy policy
    state = newState;
end
end