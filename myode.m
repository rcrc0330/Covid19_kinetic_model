function F=myode(t,x,p)
% Unpack x
% for i=1:4
%     if(x(i)<0.5) x(i)=0; end
% end
R = x(1);IHS=x(2);IHA=x(3);ID=x(4);S=p(1)-sum(x);



% Rate constants

k1 = 1/12;      %
k2 = p(3)/p(1);%;3/14/S;      %
%if(t>22&& t<22+21*3) k2=0.2*p(3)/S; end
k2p = k2;       %
%Testing rate data
k3 = 0.6*p(2)*IHS;

%k3=0.001*0.9*spline([0 7 14 21],[500 1000 3000 8000],t);
%k3 = 0.125*(k2*S*IHS);  %
%k3p = 0.08*(k2*S*IHS);
%k3p=0.001*0.1*spline([0 7 14 21],[500 1000 3000 8000],t);   %
k3p = 0.4*p(2)*IHA;
%if(t>22&& t<22+21*3) k3=30*0.6*p(3); k3p=30*0.4*p(3); end
% if(t>20 && t<20+180) k2=0.1*p(2); k3=0.6*(k2*S*IHS); k3p=0.4*(k2p*S*IHA); end
% if(t>20+21+5) k2=0.5*p(2); end
% if(t>20+21+5+21) k2=p(2); end
%k3sum=k3+k3p;
%if(k3sum>1200) k3=k3*1200/k3sum; k3p=k3p*1200/k3sum; end
k4=1/5;         %

%RHS
F = zeros(4,1);
F(1,1) = k1*(IHS+ID);                                                   %dR/dt
F(2,1) = k4*IHA - k1*IHS - k3;                                              %dIHS/dt
F(3,1) = k2*S*IHS + k2p*S*IHA - (k4)*IHA - k3p;                            %dIHA/dt
F(4,1) = k3 + k3p - k1*ID; %                                           %dID/dt
%F(5,1) = -(sum(F(1:4)));
end
