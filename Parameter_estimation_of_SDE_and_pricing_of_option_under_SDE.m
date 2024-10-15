clc
clear all
format short
% clf
Data
n=30;
dt=.001;
K=14;
D=32;
Ds=28.5;
Bu=35;
Bd=30;
beta=.9;
T=1;
% Fun_sq=@(x)(prod((1./(sqrt(2*pi*x(2)^2*SQ(1:end-1).^2*dt))).*...
%     exp(((SQ(2:end)-(SQ(1:end-1)+x(1)*SQ(1:end-1)*dt)).^2)./(x(2)^2*SQ(1:end-1).^2*dt))));
% par_sq=ga(Fun_sq,2,[],[],[],[],[rand rand]/100,[rand rand])
% Fun_von=@(x)(prod((1./(sqrt(2*pi*x(3)^2*dt))).*...
%     exp(((VON(2:end)-(VON(1:end-1)+(x(1)-x(2)*VON(1:end-1))*dt)).^2)./(x(3)^2*dt))));
% par_von=ga(Fun_sq,3,[],[],[],[],[rand rand rand]/10,rand(3,1)*10)
p=[0.0034 0.3910];
p1=[0.0242 3.5585 0.5221]; % These parameters are obtained based on the MLE method with several iterations according to the above code.
% p=par_sq; p1=par_von;
M=100;
for j=1:M
    S(1)=SQ(1); V(1)=VON(1);
    for i=2:n
        S(i)=S(i-1)+p(1)*S(i-1)*dt+p(2)*S(i-1)*sqrt(dt)*randn;
        V(i)=V(i-1)+(p1(1)-p1(2)*V(i-1))*dt+p1(3)*sqrt(dt)*randn;
    end
    if V(end)>Ds
        I1=1;
    else
        I1=0;
    end
    if V(end)<Ds
        I2=1;
    else
        I2=0;
    end
    if min(S)<Bd
        I3=1;
    else
        I3=0;
    end
    if max(S)<Bu
        I4=1;
    else
        I4=0;
    end
    E(j)=max(S(end)-K,0)*(I1+I2*((1-beta)*V(end))/D);
    DI(j)=max(S(end)-K,0)*I3*(I1+I2*((1-beta)*V(end))/D);
    UO(j)=max(S(end)-K,0)*I4*(I1+I2*((1-beta)*V(end))/D);
end
E_s=exp(-p1(1)*T)*mean(E);
DI_s=exp(-p1(1)*T)*mean(DI);
UO_s=exp(-p1(1)*T)*mean(UO);








Data
dt=.03;
N=10^4;
S10=SQ(1);
V10=VON(1);
r=0.0023;sigma=0.1259;theta=0.0402;kappa=0.9322;xi= 1.9778;
for i=1:N-1
    alpha=(1/N)*i;
    S1=S10*exp(r*T+((sigma*T*sqrt(3))/pi)*log((1-alpha)/(alpha)));
    V1=V10*exp(-theta*T)+(1/theta)*(1-exp(-theta*T))*...
        (kappa+((xi*sqrt(3))/pi)*log((1-alpha)/(alpha)));
    if V1<Ds
        C(i)=-min(0,K-S1)*(((1-beta)*V1)/D);
    else
        C(i)=-min(0,K-S1);
    end
end
E_u=exp(-r*T)*mean(C);



eta=(1+exp((log(Bd)-log(S10)-r*T)*(pi/(sigma*T*sqrt(3)))))^(-1);
N=10^3;
for i=1:N-1
    alpha=eta+((1-eta)/N)*i;
    S1=S10*exp(r*T+((sigma*T*sqrt(3))/pi)*log((1-alpha)/(alpha)));
    V1=V10*exp(-theta*T)+(1/theta)*(1-exp(-theta*T))*...
        (kappa+((xi*sqrt(3))/pi)*log((1-alpha)/(alpha)));
    if V1<Ds
        C(i)=-min(0,K-S1)*(((1-beta)*V1)/D);
    else
        C(i)=-min(0,K-S1);
    end
end
DI_u=exp(-r*T)*(1-eta)*mean(C);


eta=(1+exp((log(Bu)-log(S10)-r*T)*(pi/(sigma*T*sqrt(3)))))^(-1);
N=10^4;
for i=1:N-1
    alpha=eta+((1-eta)/N)*i;
    S1=S10*exp(r*T+((sigma*T*sqrt(3))/pi)*log((1-alpha)/(alpha)));
    V1=V10*exp(-theta*T)+(1/theta)*(1-exp(-theta*T))*...
        (kappa+((xi*sqrt(3))/pi)*log((1-alpha)/(alpha)));
    if V1<Ds
        C(i)=-min(0,K-S1)*(((1-beta)*V1)/D);
    else
        C(i)=-min(0,K-S1);
    end
end
UO_u=exp(-r*T)*(1-eta)*mean(C);

% subplot(2,2,1)
% hold on
% plot(E_u)
% plot(E_s)
% xlabel('Maturity time (T)')
% ylabel('Option price')
% subplot(2,2,2)
% hold on
% plot(DI_u)
% plot(DI_s)
% xlabel('Maturity time (T)')
% ylabel('Option price')
% subplot(2,2,3)
% hold on
% plot(UO_u)
% plot(UO_s)
% xlabel('Maturity time (T)')
% ylabel('Option price')
disp('Uncertain     Stochastic')
European=[E_u' E_s']
D_I=[DI_u' DI_s']
U_O=[UO_u' UO_s']

