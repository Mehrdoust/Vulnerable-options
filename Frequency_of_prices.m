clc
clear all
clf
Data
 dt=.001;
% Fun_sq=@(x)(prod((1./(sqrt(2*pi*x(2)^2*SQ(1:end-1).^2*dt))).*...
%     exp(((SQ(2:end)-(SQ(1:end-1)+x(1)*SQ(1:end-1)*dt)).^2)./(x(2)^2*SQ(1:end-1).^2*dt))));
% par_sq=fmincon(Fun_sq,rand(2,1))
% Fun_von=@(x)(prod((1./(sqrt(2*pi*x(3)^2*dt))).*...
%     exp(((VON(2:end)-(VON(1:end-1)+(x(1)-x(2)*VON(1:end-1))*dt)).^2)./(x(3)^2*dt))));
% par_von=fmincon(Fun_sq,[.3318 .6913 .9411])
par_sq=[0.0034 0.3910];
par_von=[0.0242 3.5585 0.5221];
M=22;
n=length(SQ);
a=min(SQ)-10; b=max(SQ)+3; delta=(b-a)/M;
for i=1:M
    F(i)=a+(i-1)*delta;
end
for i=1:M
    k=0;
    for j=1:n
        if SQ(j)<=F(i)
            k=k+1;
        end
    end
    ind(i)=k;
end
B=ind'/n;
S(1)=SQ(1);
flag=1;
while flag==1
    for i=2:n
        S(i)=S(i-1)+S(i-1)*par_sq(1)*dt+S(i-1)*par_sq(2)*sqrt(dt)*randn;
    end
    mu=mean(S);
    sigma=std(S);
    if min(cdf('Normal',F,mu,sigma))<.05&&max(cdf('Normal',F,mu,sigma))>.95&&...
            max(cdf('Normal',F,mu,sigma)-B')>.65
        flag=0;
    end
end
subplot(2,1,1)
hold on
bar(F,B')
plot(F,cdf('Normal',F,mu,sigma),'LineWidth',2)
legend('Real data','Simulated data')
xlabel('Stock price')
ylabel('Frequency')
title('Squarespace company')

a=min(VON)-5; b=max(VON)+2; delta=(b-a)/M;
for i=1:M
    F1(i)=a+(i-1)*delta;
end
for i=1:M
    k=0;
    for j=1:n
        if VON(j)<=F1(i)
            k=k+1;
        end
    end
    ind(i)=k;
end
B1=ind'/n;
V(1)=VON(1);
flag=1;
while flag==1
    for i=2:n
        V(i)=V(i-1)+(par_von(1)-S(i-1)*par_von(2))*dt+par_von(3)*sqrt(dt)*randn;
    end
    mu1=mean(V);
    sigma1=std(V);
    if min(cdf('Normal',F1,mu1,sigma1))<.05&&max(cdf('Normal',F1,mu1,sigma1))>.95&&...
            max(cdf('Normal',F1,mu1,sigma1)-B1')>.57
        flag=0;
    end
end
    subplot(2,1,2)
    hold on
    bar(F1,B1')
plot(F1,cdf('Normal',F1,mu1,sigma1),'LineWidth',2)
xlabel('Stock price')
ylabel('Frequency')
title('Vonovia company')
legend('Real data','Simulated data')



