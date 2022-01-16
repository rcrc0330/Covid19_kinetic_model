clear all;
myName= mfilename;
state = myName(10:end)
RN = 4;           % The number of days to take the running average
global del_T
del_T = 5;          % Number of minutes the code should exit after going to callback fn outfcn.m
path = "/UGP-7thsem/dist_data/";
path2 = "/UGP-7thsem/temp_dist/";
path3 = "/UGP-7thsem/temp/";
path4 = "/timeseries/";
state_part = lower(state(1:2));
filename=strcat(pwd,'/UGP-7thsem/',"initial_guess_kpar",".dat");
kpar=load(filename);
global t1
t1  = datetime('now');
data_c3=load(strcat(pwd,path,'csse_confirmed_',state,'.dat'));
data_d3=load(strcat(pwd,path,'csse_deaths_',state,'.dat'));
data_r3=load(strcat(pwd,path,'csse_recovered_',state,'.dat'));
data_p3=load(strcat(pwd,path,'csse_population_',state,'.dat'));
j = 1;
for i=1:length(data_c3)
    if data_c3(i,2) ~= 0
        j = i;
	break;
    end
end
data_c = zeros(length(data_c3)-j+1,2);
for i=j:length(data_c3)
    data_c(i-j+1,1) = i-j+1;
    data_c(i-j+1,2) = data_c3(i,2);
end
data_d = zeros(length(data_d3)-j+1,2);
for i=j:length(data_d3)
    data_d(i-j+1,1) = i-j+1;
    data_d(i-j+1,2) = data_d3(i,2);
end
data_r = zeros(length(data_r3)-j+1,2);
for i=j:length(data_r3)
    data_r(i-j+1,1) = i-j+1;
    data_r(i-j+1,2) = data_r3(i,2);
end
data_a(:,1)= data_c(:,1);
data_a(:,2)= data_c(:,2)-data_d(:,2)-data_r(:,2);
xknown(:,1) = data_a(:,2);
xknown(:,2) = [0;data_r(2:end,2)-data_r(1:end-1,2)];
xknown(:,3) = [0;data_c(2:end,2)-data_c(1:end-1,2)];
xknown(:,4) = [0;data_d(2:end,2)-data_d(1:end-1,2)];
xknown(:,5) = [0;data_c(2:end,2)-data_c(1:end-1,2)];
xknown(:,6) = data_c(:,1);
%kpar(2) = (kpar(6)*kpar(2))/data_p(end);
kpar(6) = data_p3(end);
N=kpar(6);
%xknown = xknown(1:20,:);
k1guess=kpar(1);
k2guess=kpar(2);
k3guess=kpar(3);
k4guess=kpar(4);
k3poly = polyfit(data_c(:,1), [0;data_c(2:end,2)-data_c(1:end-1,2)],4);
poly2 = polyfit(data_c(:,1), data_a(:,2),4);
%Initial Condition

R = 1;
initialhiddenfactor=kpar(5);
IH0= 100000*xknown(1,1);
ID = xknown(1,1);
D=1;

%Optimize kpar
kpar = [k1guess;k2guess;k3guess;k4guess;initialhiddenfactor];
options=optimset('lsqnonlin');

options=optimset(options,'TolFun',1e-16,'TolX',1e-16,'MaxFunEvals',1e8/100,'MaxIter',1e6/100,'Display','iter', 'OutputFcn',@outfcn);
[kpar,resnorm]=lsqnonlin(@(kpar) integrate(kpar,xknown,N,R,ID,IH0,D,k3poly),kpar,[],[],options)

k1=kpar(1); k2=kpar(2); k3=kpar(3)/100; k5=kpar(4);
IH=IH0*kpar(5);
%Plotting
S = N-R-IH-ID-D;




%pack x

x0=[R;IH;ID;D];

tspan = linspace(0,365,366)';
tspanknown = linspace(0,length(xknown)-1,length(xknown))';
[t,x] = ode15s(@(t,x) myode(t,x,kpar,k3poly,N), tspan, x0);
[tf,xf] = ode15s(@(t,x) myode(t,x,kpar,k3poly,N), tspanknown, x0);

M2 = max(data_c);
M = M2(2);
err = sqrt(immse(k3*xf(:,2),polyval(k3poly,tspanknown)))/mean(polyval(k3poly,tspanknown));
err2 = sqrt(immse(xf(:,3),polyval(poly2,tspanknown)))/mean(polyval(poly2,tspanknown));

filename=strcat(pwd,path2,"kpar_",state,".dat");
kpar
N
err
err2
M
state
save(filename,'kpar','N','err','err2','M','-ascii');

filename2=strcat(pwd,path4,"timeseries_",state,".dat");
mat = [xknown(:,3) k3.*xf(:,2) xknown(:,1)  xf(:,3)]
save(filename2,'mat','-ascii');
writematrix(mat,strcat(pwd,path4,"timeseries_",state,".csv"));


figure(1);
subplot(2,3,1)
plot(tspanknown,polyval(k3poly,tspanknown),tspanknown,xknown(:,3),'.r',tspanknown,k3*xf(:,2),'-g'); xlabel('days'); ylabel('Rate of positive tested'); title(strcat(state," plot"));
subplot(2,3,2)
plot(tf,xf(:,3),tspanknown,xknown(:,1),'.r'); xlabel('days'); ylabel('ID, Active cases');
subplot(2,3,3)
plot(tf,(xf(:,2)./xf(:,3))); xlabel('t'); ylabel('(IHA+IHS)/ID');
subplot(2,3,4)
plot(tf,k1*xf(:,3),tspanknown,xknown(:,2),'.r'); xlabel('t'); ylabel('k1*ID,recovered');
subplot(2,3,5)
plot(tf,k5*xf(:,3),tspanknown,xknown(:,4),'.r'); xlabel('t'); ylabel('k5*ID,dead');
%subplot(2,3,6)
%plot(tf,k3*xf(:,2)./xknown(:,5)); xlabel('t'); ylabel('k3*IH/IT');
saveas(figure(1),strcat(pwd,path2,'plot/plot_',state,'.png'));
