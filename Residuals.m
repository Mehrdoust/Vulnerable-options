clc
clear all
close all
Data
S=SQ;
V=VON;
n=length(S);
dt=.3;
t=[0:dt:1000];t=t(1:n); T=t(end);
x=[0.0023 0.1259];
x1=[0.0402 0.9322 1.9778];
phi_s=((1+exp(pi*(log(S(1:end-1))+x(1)*dt-log(S(2:end)))./...
    (sqrt(3)*x(2)*dt))).^(-1));
phi_v=((1+exp(pi*(x1(1)*V(1:end-1)*exp(-x1(1)*dt)+x1(2)*(1-exp(-x1(1)*dt))-x1(1)*V(2:end))./...
    (sqrt(3)*x1(3)*(1-exp(-x1(1)*dt))))).^(-1));
subplot(2,1,1)
hold on
plot(phi_v)
line([1,length(phi_v)],[0.975,0.975])
line([1,length(phi_v)],[1-0.975,1-0.975])
subplot(2,1,2)
hold on
plot(phi_s)
line([1,length(phi_s)],[0.975,0.975])
line([1,length(phi_s)],[1-0.975,1-0.975])