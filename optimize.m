clear all;
k1guess = 0.0522;
k2guess = 0.1109;
k3guess = 0.00015357;
N=10^9;

country='India';
data_c=load(strcat('csse_confirmed_',country,'.dat'));
data_d=load(strcat('csse_deaths_',country,'.dat'));
data_r=load(strcat('csse_recovered_',country,'.dat'));
data_a(:,2)=data_c(:,2)-data_d(:,2)-data_r(:,2);
data_a(:,1)=data_c(:,1);
xknown(:,1) = data_a(:,2);
xknown(:,2) = [0;data_r(2:end,2)+data_d(2:end,2)-data_r(1:end-1,2)-data_d(1:end-1,2)];
xknown(:,3) = [0;data_c(2:end,2)-data_c(1:end-1,2)];
%xknown = xknown(1:20,:);

k3poly = polyfit(data_c(:,1), [0;data_c(2:end,2)-data_c(1:end-1,2)],5);

%Initial Condition

R = 1;
IHA = 800*xknown(1,1);
IHS = 200*xknown(1,1);
ID = xknown(1,1);

%Optimize kpar
kpar = [k1guess;k2guess;k3guess];
options=optimset('lsqnonlin');
options=optimset(options,'TolFun',1e-16,'TolX',1e-16,'MaxFunEvals',1e8/100,'MaxIter',1e6/100,'Display','iter');
kpar=lsqnonlin(@(kpar) integrate(kpar,xknown,N,R,ID,IHA,IHS,k3poly),kpar,[],[],options)

k1=kpar(1); k2=kpar(2); k3=kpar(3);

%Plotting
S = N-R-IHA-IHS-ID;

%pack x

x0=[R;IHS;IHA;ID];

tspan = linspace(0,365,366)';
tspanknown = linspace(0,length(xknown)-1,length(xknown))';
[t,x] = ode15s(@(t,x) myode(t,x,kpar,k3poly,N), tspan, x0);
[tf,xf] = ode15s(@(t,x) myode(t,x,kpar,k3poly,N), tspanknown, x0);

figure(1);
subplot(3,3,1)
plot(tspanknown,polyval(k3poly,tspanknown),tspanknown,xknown(:,3),'.r',tspanknown,2.2*k3*xf(:,2),'-g'); xlabel('days'); ylabel('Rate of positive tested'); title('k3fit');
subplot(3,3,2)
plot(t,x(:,2)); xlabel('days'); ylabel('IHS');
subplot(3,3,3)
plot(t,x(:,3)); xlabel('days'); ylabel('IHA');
subplot(3,3,4)
plot(t,x(:,4),tspanknown,xknown(:,1),'.r'); xlabel('days'); ylabel('ID, Active cases');
subplot(3,3,5)
plot(t,(N*ones(size(t))-sum(x,2))); xlabel('days'); ylabel('Susceptible'); %ylim([0 max(S)]);
subplot(3,3,6)
plot(tf,xf(:,4),tspanknown,xknown(:,1),'.r'); %xlabel('t'); ylabel('ID');
subplot(3,3,7)
plot(t,x(:,2)+x(:,3)); xlabel('t'); ylabel('IHA+IHS');
subplot(3,3,8)
plot(tf,k1*xf(:,4),tspanknown,xknown(:,2),'.r'); xlabel('t'); ylabel('k1*ID,recovered');