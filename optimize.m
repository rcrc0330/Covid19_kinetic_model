clear all;
k3guess = 0.2271;
k2guess = 0.5394;
k1guess = 0.3494;
N=10^9;

country='India';
data_c=load(strcat('csse_confirmed_',country,'.dat'));
data_d=load(strcat('csse_deaths_',country,'.dat'));
data_r=load(strcat('csse_recovered_',country,'.dat'));
data_a(:,2)=data_c(:,2)-data_d(:,2)-data_r(:,2);
data_a(:,1)=data_c(:,1);
xknown(:,1) = data_a(:,2);
xknown(:,2) = data_r(:,2)+data_d(:,2);

%Initial Condition

R = 1;
IHA = 5*xknown(1,1);
IHS = xknown(1,1)/2;
ID = xknown(1,1);

%Optimize kpar
kpar = [k3guess;k2guess;k1guess];
options=optimset('lsqnonlin');
options=optimset(options,'TolFun',1e-7,'TolX',1e-12*100,'MaxFunEvals',1e8/1000,'MaxIter',1e6/1000,'Display','iter');
kpar=lsqnonlin(@(kpar) integrate(kpar,xknown,N,R,ID,IHA,IHS),kpar,[],[],options)

k3=kpar(1); k2=kpar(2); k1=kpar(3);

%Plotting
S = N-R-IHA-IHS-ID;

%pack x

x0=[R;IHS;IHA;ID];

p = [N;k3;k2;k1];

tspan = linspace(0,200,201)';
tspanknown = linspace(0,length(xknown)-1,length(xknown))';
[t,x] = ode15s(@(t,x) myode(t,x,p), tspan, x0);
[tf,xf] = ode15s(@(t,x) myode(t,x,p), tspanknown, x0);

figure(1);
subplot(3,3,1)
plot(t,p(2)*t.^0.5/6.*x(:,4)); xlabel('days'); ylabel('Rate of positive tested');
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