% clc
% clear all
% clf
% close all
% % flag=1;
% % while flag==1
%     tic
%     Data
%     S=SQ;
%     V=VON;
%     n=length(S);
%     dt=.3;
%     t=[0:dt:1000];t=t(1:n); T=t(end);
%
%     phi_s=@(x)((1+exp(pi*(log(S(1:end-1))+x(1)*dt-log(S(2:end)))./...
%         (sqrt(3)*x(2)*dt))).^(-1));
%     phi_v=@(x)((1+exp(pi*(x(1)*V(1:end-1)*exp(-x(1)*dt)+x(2)*(1-exp(-x(1)*dt))-x(1)*V(2:end))./...
%         (sqrt(3)*x(3)*(1-exp(-x(1)*dt))))).^(-1));
%     FUN_s=@(x)(0);
%     for k=1:2
%         FUN_s=@(x)((FUN_s(x)+mean(phi_s(x).^k)-1/(k+1))^2);
%     end
%     FUN_v=@(x)(0);
%     for k=1:3
%         FUN_v=@(x)((FUN_v(x)+mean(phi_v(x).^k)-1/(k+1))^2);
%     end
%     options =  gaoptimset('TimeLimit',.01,'PopulationSize',10);
%     [par_s fs]=ga(FUN_s,2,[],[],[],[],[0 0],[.3 2],[],options);
%     [par_v fv]=ga(FUN_v,3,[],[],[],[],[.02 .1 .2],[1 1 2],[],options);
%     AA=par_v(2)/par_v(1);
%     phi_S=phi_s(par_s);
%     phi_V=phi_v(par_v);
%     LL=[find(phi_V<.025)' find(phi_V>.975)'];
% %     if length(LL)<2
% %         flag=0;
% %     end
% %         if AA>20&&AA<32&&length(LL)<2
% %             flag=0;
% %         end
%         tt=toc;
% % end
% length(LL)
% par_v
% % fs
% % tt
% % phi_V
% % par_v(2)/par_v(1)


clc
clear all
tic
Data
S=SQ;
V=VON;
n=length(S);
dt=.3;
t=[0:dt:1000];t=t(1:n); T=t(end);

phi_s=@(x)((1+exp(pi*(log(S(1:end-1))+x(1)*dt-log(S(2:end)))./...
    (sqrt(3)*x(2)*dt))).^(-1));
phi_v=@(x)((1+exp(pi*(x(1)*V(1:end-1)*exp(-x(1)*dt)+x(2)*(1-exp(-x(1)*dt))-x(1)*V(2:end))./...
    (sqrt(3)*x(3)*(1-exp(-x(1)*dt))))).^(-1));
FUN_s=@(x)(0);
for k=1:2
    FUN_s=@(x)((FUN_s(x)+mean(phi_s(x).^k)-1/(k+1))^2);
end
FUN_v=@(x)(0);
for k=1:3
    FUN_v=@(x)((FUN_v(x)+mean(phi_v(x).^k)-1/(k+1))^2);
end
% options = optimoptions('particleswarm','MaxStallTime',10,...
%     'SwarmSize',100,'Display','off');
% [par_s fs]=particleswarm(FUN_s,2,[0 0],[.3 2],options);
% [par_v fv]=particleswarm(FUN_v,3,[.02 .1 .2],[1 1 2],options);
% Objective_Squarespace_particleswarm=fs
% Objective_Vonovia_particleswarm=fv
% Parameter_Squarespace_particleswarm=par_s
% Parameter_Vonovia_particleswarm=par_v
options =  gaoptimset('TimeLimit',10,'PopulationSize',1000);
[par_s fs]=ga(FUN_s,2,[],[],[],[],[0 0],[.3 2],[],options);
[par_v fv]=ga(FUN_v,3,[],[],[],[],[.02 .1 .2],[1 1 2],[],options);
Objective_Squarespace_GA=fs
Objective_Vonovia_GA=fv
Parameter_Squarespace_GA=par_s
Parameter_Vonovia_GA=par_v
















