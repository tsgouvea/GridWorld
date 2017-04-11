classdef GridWorld
    properties
        States = reshape(1:100,10,10);
        Actions = 1:4;
        Rewards;
        Discount = .9;
        Transitions;
        Agent;
    end
    methods
        obj = default(obj);
        obj = DP(obj,iAgent, Policy);
        obj = TD0(obj,iAgent,nSteps);
        obj = Sarsa(obj,iAgent,nSteps);
        obj = Qlearning(obj,iAgent,nSteps);
        obj = TD0_linFeat(obj,iAgent,nSteps,nFeatures);
    end
end
