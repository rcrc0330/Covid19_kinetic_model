function err = integrate(kpar,xknown,N,R,ID,IHA,IHS)

S = N-R-IHA-IHS-ID;

%pack x

x=[R;IHS;IHA;ID];

p = [N;kpar(1);kpar(2)];

tspan = linspace(0,length(xknown-1),length(xknown))';
[t,x] = ode15s(@(t,x) myode(t,x,p), tspan, x);

err = (x(:,4)-xknown).^2;
end