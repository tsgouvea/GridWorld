function [obj] = DP(obj,iAgent, Policy) % accept arbitrary policies
if nargin < 2, iAgent = numel(obj.Agent) + 1; end
if nargin < 3
    obj.Agent(iAgent).Policy = ones(numel(obj.States),numel(obj.Actions))/numel(obj.Actions);
else
    obj.Agent(iAgent).Policy = Policy;
end
M = zeros(numel(obj.States));
for i = 1:numel(obj.Transitions)
    M = M + repmat(obj.Agent(iAgent).Policy(:,i),1,size(obj.Transitions{i},2)) .* obj.Transitions{i};
end
obj.Agent(iAgent).Values = inv(eye(100)-obj.Discount*M)*obj.Rewards(:);
obj.Agent(iAgent).Values = reshape(obj.Agent(iAgent).Values,10,10);
obj.Agent(iAgent).Name = 'DP under random policy';
end