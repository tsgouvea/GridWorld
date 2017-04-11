function [obj] = TD0(obj,iAgent,nSteps)
if nargin < 2, iAgent = numel(obj.Agent) + 1; end
if nargin < 3, nSteps = 10000; end
if iAgent > numel(obj.Agent)
    obj.Agent(iAgent).Name = 'TD0 Random policy';
    obj.Agent(iAgent).Alpha = .1;
    obj.Agent(iAgent).Values = zeros(size(obj.States))*mean(obj.Rewards(:));%+.5;
    obj.Agent(iAgent).Policy = ones(numel(obj.States),numel(obj.Actions))/numel(obj.Actions);
end
state = randi(numel(obj.States));
for iTD = 1:nSteps
    action = randsample(obj.Actions,1,1,obj.Agent(iAgent).Policy(state,:));
    newState = randsample(obj.States(:),1,1,obj.Transitions{action}(state,:));
    delta = obj.Rewards(state) + obj.Discount*obj.Agent(iAgent).Values(newState) - obj.Agent(iAgent).Values(state);
    obj.Agent(iAgent).Values(state) = obj.Agent(iAgent).Values(state) + obj.Agent(iAgent).Alpha * delta;
    state = newState;
end
end