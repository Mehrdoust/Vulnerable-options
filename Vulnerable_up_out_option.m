clc
clear all
clf
Data
% B>S0 for U-O

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
    eta=(1+exp((log(Bu)-log(S0)-r*T)*(pi/(sigma*T*sqrt(3)))))^(-1);
    N=10^4;
    for i=1:N-1
        alpha=eta+((1-eta)/N)*i;
        S=S0*exp(r*T+((sigma*T*sqrt(3))/pi)*log((1-alpha)/(alpha)));
        V=V0*exp(-theta*T)+(1/theta)*(1-exp(-theta*T))*...
            (kappa+((xi*sqrt(3))/pi)*log((1-alpha)/(alpha)));
        if V<Ds
            C(i)=-min(0,K-S)*(((1-beta)*V)/D);
        else
            C(i)=-min(0,K-S);
        end
    end
    Ce(j)=exp(-r*T)*(1-eta)*mean(C);
end
plot(ZZ,Ce','-o')
Ce'
plot(ZZ',Ce')




