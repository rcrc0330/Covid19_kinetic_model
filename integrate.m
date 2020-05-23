function err = integrate(kpar,xknown,N,R,ID,IHA,IHS,k3poly)

S = N-R-IHA-IHS-ID;

%pack x

x=[R;IHS;IHA;ID];


tspan = linspace(0,length(xknown-1),length(xknown))';
options = odeset();
%options = odeset('Jacobian',@(t,x)myodejacobi(t,x,kpar,k3poly,N),'JConstant','no');
[t,x] = ode45(@(t,x) myode(t,x,kpar,k3poly,N), tspan, x, options);

%unpack x
R = x(:,1); IHS = x(:,2); IHA = x(:,3); ID = x(:,4);

%err = (ID-xknown(:,1)).^2/norm(xknown(:,1),2)^2 + (kpar(1)*ID-xknown(:,2)).^2/norm(xknown(:,2),2)^2 + (kpar(3)*IHS-xknown(:,3)).^2/norm(xknown(:,3),2)^2;
err = (ID-xknown(:,1)).^2/norm(xknown(:,1),2)^2 + (kpar(1)*ID-xknown(:,2)).^2/norm(xknown(:,2),2)^2;% + (2.2*kpar(3)*IHS-polyval(k3poly,t)).^2/norm(polyval(k3poly,t),2)^2;
end