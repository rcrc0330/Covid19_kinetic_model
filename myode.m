function F=myode(t,x,kpar,k3poly,N)
% Unpack x
% for i=1:4
%     if(x(i)<0.5) x(i)=0; end
% end
R = x(1); IHS = x(2); IHA = x(3); ID = x(4); S = N-sum(x);



% Rate constants

k1 = kpar(1);      % rate constant of Recovery
k2 = kpar(2)/N; % rate constant of Infection Spreading, symptomatic
k2p = k2;       % rate constant of Infection Spreading, asymptomatic
%Testing rate data
%k3 = 0.9*kpar(3)*t^0.5*IHS; % rate of testing and identifying symptomatic
k3=kpar(3)*IHS;
%k3p = 0.1*kpar(3)*t^0.5*IHA; % rate of testing and identifying asymptomatic
k4=1/15;         % rate constant of asymptomatic to symptomatic
%containment

%if(t>50)
%    k2=0.25*p(3)/p(1);
%    k2p=k2;
%end
%RHS
F = zeros(4,1);
F(1,1) = k1*(IHA+IHS+ID);                                                   %dR/dt
F(2,1) = k4*IHA - k1*IHS - k3;                                              %dIHS/dt
F(3,1) = k2*S*IHS + k2p*S*IHA - (k4)*IHA - k1*IHA - 1.2*k3;                            %dIHA/dt
F(4,1) = 2.2*k3 - k1*ID; %                                           %dID/dt
%F(5,1) = polyval(polyder(k3poly),t)/kpar(3)-k4*IHA+k1*IHS+k3;
%F(5,1) = -(sum(F(1:4)));
end
