function err = integrate(kpar,xknown,N,R,ID,IH0,D,k3poly)
IH=kpar(5)*IH0;

S = N-R-IH-ID-D;

%pack x

x=[R;IH;ID;D];


tspan = linspace(0,length(xknown-1),length(xknown))';
options = odeset('OutputFcn',@outfcn);
%options = odeset('Jacobian',@(t,x)myodejacobi(t,x,kpar,k3poly,N),'JConstant','no');
[t,x] = ode45(@(t,x) myode(t,x,kpar,k3poly,N), tspan, x, options);

%unpack x
R = x(:,1); IH = x(:,2); ID = x(:,3); D = x(:,4);
%err = (ID-xknown(:,1)).^2/norm(xknown(:,1),2)^2 + (kpar(1)*ID-xknown(:,2)).^2/norm(xknown(:,2),2)^2 + (kpar(3)*IHS-xknown(:,3)).^2/norm(xknown(:,3),2)^2;
err = (ID-xknown(:,1)).^2/norm(xknown(:,1),2)^2 + (kpar(1)*ID-xknown(:,2)).^2/norm(xknown(:,2),2)^2 + (kpar(4)*ID-xknown(:,4)).^2/norm(xknown(:,4),2)^2 + (kpar(3)/100*IH-xknown(:,3)).^2/norm(xknown(:,3),2)^2;
end