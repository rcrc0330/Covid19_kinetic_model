clear all;
k3guess = 0.2;
k2guess = 0.3;
N=10^9;

CoronaData=load('csse_US.dat');
xknown(:,1) = CoronaData(:,2);
%Initial Condition

R = 1;
IHA = 5*xknown(1,1);
IHS = IHA;
ID = xknown(1,1);

%Optimize kpar
kpar = [k3guess;k2guess];
options=optimset('lsqnonlin');
options=optimset(options,'TolFun',1e-7,'TolX',1e-12*100,'MaxFunEvals',1e8/1000,'MaxIter',1e6/5000,'Display','iter');
kpar=lsqnonlin(@(kpar) integrate(kpar,xknown,N,R,ID,IHA,IHS),kpar,[],[],options)

k3=kpar(1); k2=kpar(2);

%Plotting
S = N-R-IHA-IHS-ID;

%pack x

x0=[R;IHS;IHA;ID];

p = [N;k3;k2];

tspan = linspace(0,200,201)';
tspanknown = linspace(0,length(xknown)-1,length(xknown))';
[t,x] = ode15s(@(t,x) myode(t,x,p), tspan, x0);
[tf,xf] = ode15s(@(t,x) myode(t,x,p), tspanknown, x0);

figure(1);
subplot(3,3,1)
plot(t,p(2)*t.^0.5/6.*x(:,4)); xlabel('days'); ylabel('Tested positive');
subplot(3,3,2)
plot(t,x(:,2)); xlabel('days'); ylabel('IHS');
subplot(3,3,3)
plot(t,x(:,3)); xlabel('days'); ylabel('IHA');
subplot(3,3,4)
plot(t,x(:,4),tspanknown,xknown,'.r'); xlabel('days'); ylabel('Detected cases');
subplot(3,3,5)
plot(t,(N*ones(size(t))-sum(x,2))); xlabel('days'); ylabel('Susceptible'); %ylim([0 max(S)]);
subplot(3,3,6)
plot(tf,xf(:,4),tspanknown,xknown,'.r'); %xlabel('t'); ylabel('ID');
subplot(3,3,7)
plot(t,x(:,2)+x(:,3)); xlabel('t'); ylabel('IHA+IHS');
%subplot(3,3,8)
%plot(tf,xf(:,4),tspanknown,xknown,'.r'); %xlabel('t'); ylabel('ID');