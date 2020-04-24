function F=myode(t,x,p)
% Unpack x
% for i=1:4
%     if(x(i)<0.5) x(i)=0; end
% end
R = x(1);IHS=x(2);IHA=x(3);ID=x(4);S=p(1)-sum(x);



% Rate constants

k1 = 1/12;      % rate constant of Recovery
k2 = p(3)/p(1); % rate constant of Infection Spreading, symptomatic
k2p = k2;       % rate constant of Infection Spreading, asymptomatic
%Testing rate data
k3 = 0.9*p(2)*t^0.5/6*IHS; % rate of testing and identifying symptomatic

k3p = 0.1*p(2)*t^0.5/6*IHA; % rate of testing and identifying asymptomatic
k4=1/5;         % rate constant of asymptomatic to symptomatic
%containment

%if(t>50)
%    k2=0.25*p(3)/p(1);
%    k2p=k2;
%end
%RHS
F = zeros(4,1);
F(1,1) = k1*(IHA+IHS+ID);                                                   %dR/dt
F(2,1) = k4*IHA - k1*IHS - k3;                                              %dIHS/dt
F(3,1) = k2*S*IHS + k2p*S*IHA - (k4)*IHA - k3p - k1*IHA;                            %dIHA/dt
F(4,1) = k3 + k3p - k1*ID; %                                           %dID/dt
%F(5,1) = -(sum(F(1:4)));
end
