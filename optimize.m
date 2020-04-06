clear all;
k3guess = 0.2934;
k2guess = 0.2;
N=10^9;
CoronaData=load('CoronaData.dat');
countryid=5;
for ii=1:size(CoronaData,1) if(CoronaData(ii,countryid)==-1) break; end; xknown(ii,1) = CoronaData(ii,countryid); end
%Initial Condition

R = 1;
IHA = 10*xknown(1,1);
IHS = IHA;
ID = xknown(1,1);

%Optimize kpar
kpar = [k3guess;k2guess];
options=optimset('lsqnonlin');
options=optimset(options,'TolFun',1e-7*100,'TolX',1e-12*100,'MaxFunEvals',1e8/100,'MaxIter',1e6/100);
kpar=lsqnonlin(@(kpar) integrate(kpar,xknown,N,R,ID,IHA,IHS),kpar,[],[],options)

k3=kpar(1); k2=kpar(2);

%Plotting
S = N-R-IHA-IHS-ID;

%pack x

x0=[R;IHS;IHA;ID];

p = [N;k3;k2];

tspan = linspace(0,100,101)';
tspanknown = linspace(0,length(xknown-1),length(xknown))';
[t,x] = ode15s(@(t,x) myode(t,x,p), tspan, x0);
[tf,xf] = ode15s(@(t,x) myode(t,x,p), tspanknown, x0);

figure(1);
subplot(3,2,1)
plot(t,x(:,1)); xlabel('t'); ylabel('R');
subplot(3,2,2)
plot(t,x(:,2)); xlabel('t'); ylabel('IHS');
subplot(3,2,3)
plot(t,x(:,3)); xlabel('t'); ylabel('IHA');
subplot(3,2,4)
plot(t,x(:,4),tspanknown,xknown,'.r'); xlabel('t'); ylabel('ID');
subplot(3,2,5)
plot(t,N*ones(size(t))-sum(x,2)); xlabel('t'); ylabel('S'); ylim([0 max(S)]);
subplot(3,2,6)
plot(tf,xf(:,4),tspanknown,xknown,'.r'); xlabel('t'); ylabel('ID');