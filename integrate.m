function err = integrate(kpar,xknown,N,R,ID,IHA0,IHS0,D,k3poly)
IHA=kpar(5)*IHA0;
IHS=kpar(5)*IHS0;

S = N-R-IHA-IHS-ID-D;

%pack x

x=[R;IHS;IHA;ID;D];


tspan = linspace(0,length(xknown-1),length(xknown))';
options = odeset('OutputFcn',@outfcn);
[t,x] = ode45(@(t,x) myode(t,x,kpar,k3poly,N), tspan, x, options);

%unpack x
R = x(:,1); IHS = x(:,2); IHA = x(:,3); ID = x(:,4); D = x(:,5);
%err = (ID-xknown(:,1)).^2/norm(xknown(:,1),2)^2 + (kpar(1)*ID-xknown(:,2)).^2/norm(xknown(:,2),2)^2 + (kpar(3)*IHS-xknown(:,3)).^2/norm(xknown(:,3),2)^2;
err = (ID-xknown(:,1)).^2/norm(xknown(:,1),2)^2 + (kpar(1)*ID-xknown(:,2)).^2/norm(xknown(:,2),2)^2 + (kpar(4)*ID-xknown(:,4)).^2/norm(xknown(:,4),2)^2 + (5*kpar(3)/100*IHS-xknown(:,3)).^2/norm(xknown(:,3),2)^2;
end