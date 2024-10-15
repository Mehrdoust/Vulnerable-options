clc
clear all
clf
Data
S0=SQ(1); V0=VON(1);
r=0.0023;sigma=0.1259;theta=0.0402;kappa=0.9322;xi= 1.9778;


K=18;
D=32;
Ds=28.5;
Bu=35;
Bd=30;
beta=.9;
T=1;

ZZ=[.1:.1:1];
M=length(ZZ);

for j=1:M
    beta=ZZ(j);
    N=10^4;
    k=1;
    for i=1:N-1
        alpha=(1/N)*i;
        S=S0*exp(r*T+((sigma*T*sqrt(3))/pi)*log((1-alpha)/(alpha)));
        V=V0*exp(-theta*T)+(1/theta)*(1-exp(-theta*T))*...
            (kappa+((xi*sqrt(3))/pi)*log((1-alpha)/(alpha)));
        if V<Ds
            C(i)=-min(0,K-S)*(((1-beta)*V)/D);
        else
            C(i)=-min(0,K-S);
        end
    end
    Ce(j)=exp(-r*T)*mean(C);
end
% Ce'
% [ZZ' Ce']
plot(ZZ',Ce')


















































% 
% clc
% clear all
% S0=33.26;
% V0=28.135;
% theta= 0.0297;
% kappa= 0.8263;
% xi=1.2927;
% r= 0.0568;
% sigma= 0.6880;
% B=75;
% T=1;
% beta=.9;
% D=32;
% Ds=30;
% K=15;
% ZZ=[34:46];
% M=length(ZZ);
% for j=1:M
%     B=ZZ(j);
%     eta=(1+exp((log(B)-log(S0)-r*T)*(pi/(sigma*T*sqrt(3)))))^(-1);
%     N=10^4;
%     for i=1:N-1
%         alpha=eta+((1-eta)/N)*i;
%         S=S0*exp(r*T+((sigma*T*sqrt(3))/pi)*log((1-alpha)/(alpha)));
%         V=V0*exp(-theta*T)+(1/theta)*(1-exp(-theta*T))*...
%             (kappa+((xi*sqrt(3))/pi)*log((1-alpha)/(alpha)));
%         if V<Ds
%             C(i)=-min(0,K-S)*(((1-beta)*V)/D);
%         else
%             C(i)=-min(0,K-S);
%         end
%     end
%     Ce1(j)=exp(-r*T)*(1-eta)*mean(C);
% end
% subplot(1,2,2)
% plot(ZZ,Ce1')
% xlabel('Barrier level (B)')
% ylabel('Vulnerable uo-out option price')
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clear C eta
% S0=33.26;
% V0=28.135;
% S0=33.26;
% V0=28.135;
% theta= 0.0297;
% kappa= 0.8263;
% xi=1.2927;
% r= 0.0568;
% sigma= 0.6880;
% B=30;
% T=1;
% beta=.9;
% D=32;
% Ds=30;
% K=15;
% ZZ=[20:32];
% M=length(ZZ);
% for j=1:M
%     B=ZZ(j);
%     eta=(1+exp((log(B)-log(S0)-r*T)*(pi/(sigma*T*sqrt(3)))))^(-1);
%     N=10^3;
%     for i=1:N-1
%         alpha=eta+((1-eta)/N)*i;
%         S=S0*exp(r*T+((sigma*T*sqrt(3))/pi)*log((1-alpha)/(alpha)));
%         V=V0*exp(-theta*T)+(1/theta)*(1-exp(-theta*T))*...
%             (kappa+((xi*sqrt(3))/pi)*log((1-alpha)/(alpha)));
%         if V<Ds
%             C(i)=-min(0,K-S)*(((1-beta)*V)/D);
%         else
%             C(i)=-min(0,K-S);
%         end
%     end
%     Ce2(j)=exp(-r*T)*(1-eta)*mean(C);
% end
% subplot(1,2,1)
% plot(ZZ,Ce2')
% xlabel('Barrier level (B)')
% ylabel('Vulnerable own-in option price')

