function [obj] = TD0_linFeat(obj,iAgent,nSteps,nFeatures)
if nargin < 2, iAgent = numel(obj.Agent) + 1; end
if nargin < 3, nSteps = 10000; end
if nargin < 4, nFeatures = 10; end
if iAgent > numel(obj.Agent)
    obj.Agent(iAgent).Name = 'TD0 Random policy';
    obj.Agent(iAgent).Alpha = .1;
    obj.Agent(iAgent).Policy = ones(numel(obj.States),numel(obj.Actions))/numel(obj.Actions);
    obj.Agent(iAgent).Phi = 2*rand(numel(obj.States),nFeatures)-1;
    obj.Agent(iAgent).w = zeros(nFeatures,1);
    obj.Agent(iAgent).Values = nan(size(obj.States));
end
state = randi(numel(obj.States));
for iTD = 1:nSteps
    action = randsample(obj.Actions,1,1,obj.Agent(iAgent).Policy(state,:));
    newState = randsample(obj.States(:),1,1,obj.Transitions{action}(state,:));
    delta = obj.Rewards(state) + obj.Discount*obj.Agent(iAgent).w'*obj.Agent(iAgent).Phi(newState,:)' ...
        - obj.Agent(iAgent).w'*obj.Agent(iAgent).Phi(state,:)';
    obj.Agent(iAgent).w = obj.Agent(iAgent).w + obj.Agent(iAgent).Alpha * delta * obj.Agent(iAgent).w;
    obj.Agent(iAgent).Values = reshape(obj.Agent(iAgent).Phi*obj.Agent(iAgent).w,10,10);
    state = newState;
end
end