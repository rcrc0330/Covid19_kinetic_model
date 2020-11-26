clear all;
myName= mfilename;
state = myName(5:end)
path = "/UGP-7thsem/dist_data/";
path2 = "/UGP-7thsem/temp_dist/my/";
path3 = "/ratio/"
filename=strcat(pwd,path2,"kpar_",state,".dat");
kpar=load(filename);
global t1
t1  = datetime('now');
data_c=load(strcat(pwd,path,'csse_confirmed_',state,'.dat'));
data_d=load(strcat(pwd,path,'csse_deaths_',state,'.dat'));
data_r=load(strcat(pwd,path,'csse_recovered_',state,'.dat'));
data_p=load(strcat(pwd,path,'csse_population_',state,'.dat'));
j = 1;
for i=1:length(data_c)
    if data_c(i:2) ~= 0
        j = i;
	break;
    end
end
data_c2 = zeros(length(data_c)-j+1,2);
for i=j:length(data_c)
    data_c2(i-j+1,1) = i-j+1;
    data_c2(i-j+1,2) = data_c(i,2);
end
data_d2 = zeros(length(data_d)-j+1,2);
for i=j:length(data_d)
    data_d2(i-j+1,1) = i-j+1;
    data_d2(i-j+1,2) = data_d(i,2);
end
data_r2 = zeros(length(data_r)-j+1,2);
for i=j:length(data_r)
    data_r2(i-j+1,1) = i-j+1;
    data_r2(i-j+1,2) = data_r(i,2);
end
data_c = data_c2;
data_d = data_d2;
data_r = data_r2;
data_a(:,1)= data_c(:,1);
data_a(:,2)= data_c(:,2)-data_d(:,2)-data_r(:,2);
xknown(:,1) = data_a(:,2);
xknown(:,2) = [0;data_r(2:end,2)-data_r(1:end-1,2)];
xknown(:,3) = [0;data_c(2:end,2)-data_c(1:end-1,2)];
xknown(:,4) = [0;data_d(2:end,2)-data_d(1:end-1,2)];
xknown(:,5) = [0;data_c(2:end,2)-data_c(1:end-1,2)];
xknown(:,6) = data_c(:,1);
%kpar(2) = (kpar(6)*kpar(2))/data_p(end);
kpar(6) = data_p(end);
N=kpar(6);
%xknown = xknown(1:20,:);
k1guess=kpar(1);
k2guess=kpar(2);
k3guess=kpar(3);
k4guess=kpar(4);
k3poly = polyfit(data_c(:,1), [0;data_c(2:end,2)-data_c(1:end-1,2)],4);

%Initial Condition

R = 1;
initialhiddenfactor=kpar(5);
IHA0= 100000*0.8*xknown(1,1);
IHS0 = 100000*0.2*xknown(1,1);
ID = xknown(1,1);
D=1;

%Optimize kpar
kpar = [k1guess;k2guess;k3guess;k4guess;initialhiddenfactor];

k1=kpar(1); k2=kpar(2); k3=kpar(3)/100; k5=kpar(4);
IHA=IHA0*kpar(5);
IHS=IHS0*kpar(5);
%Plotting
S = N-R-IHA-IHS-ID-D;



%pack x

x0=[R;IHS;IHA;ID;D];

tspan = linspace(0,365,366)';
tspanknown = linspace(0,length(xknown)-1,length(xknown))';
[t,x] = ode15s(@(t,x) myode(t,x,kpar,k3poly,N), tspan, x0);
[tf,xf] = ode15s(@(t,x) myode(t,x,kpar,k3poly,N), tspanknown, x0);

filename=strcat(pwd,path3,"ratio_",state,".dat");

IHratio = (xf(end,2)+xf(end,3))/xf(end,4);

save(filename,'IHratio','-ascii');


%figure(1);
%subplot(2,3,1)
%plot(tspanknown,polyval(k3poly,tspanknown),tspanknown,xknown(:,3),'.r',tspanknown,5*k3*xf(:,2),'-g'); xlabel('days'); ylabel('Rate of positive tested'); title(strcat(state," plot"));
%subplot(2,3,2)
%plot(tf,xf(:,4),tspanknown,xknown(:,1),'.r'); xlabel('days'); ylabel('ID, Active cases');
%subplot(2,3,3)
%plot(tf,(xf(:,2)+xf(:,3))./xf(:,4)); xlabel('t'); ylabel('(IHA+IHS)/ID');
%subplot(2,3,4)
%plot(tf,k1*xf(:,4),tspanknown,xknown(:,2),'.r'); xlabel('t'); ylabel('k1*ID,recovered');
%subplot(2,3,5)
%plot(tf,k5*xf(:,4),tspanknown,xknown(:,4),'.r'); xlabel('t'); ylabel('k5*ID,dead');
%subplot(2,3,6)
%plot(tf,5*k3*xf(:,2)./xknown(:,5)); xlabel('t'); ylabel('5*k3*IHS/IT');
%saveas(figure(1),strcat(pwd,path2,'plot/plot_',state,'.eps'),'epsc');
%saveas(figure(1),strcat(pwd,path2,'/plot/plot_',state,'.png'));