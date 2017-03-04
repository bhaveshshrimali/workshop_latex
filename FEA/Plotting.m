%CEE 570
%Plotting 

TipDeflec=[0.005305270358293 0.005371386175778 0.005393081893224];
AxialStress=[-3.759622014195507 -2.041893204326012 -1.056874950975649];
ShearStress=[5.946429551644981 3.630972294074025 1.965259103728703];
TipDeflecExact=0.00540125;
TipError=[abs(TipDeflec(1)-TipDeflecExact) abs(TipDeflec(2)-TipDeflecExact) abs(TipDeflec(3)-TipDeflecExact)];
AxialExact=0;
ShearExact=0;
AxialError=[abs(AxialStress(1)) abs(AxialStress(2)) abs(AxialStress(3))];
ShearError=[abs(ShearStress(1)) abs(ShearStress(2)) abs(ShearStress(3))];

L2 = [-2.840014 -3.377636 -3.948141];
H1 = [-3.484825 -3.804538 -4.114668];
h=[3.9 1.95 0.975];
logh=[log10(3.9) log10(1.95) log10(0.975)];

%% Part(a)
figure(1)
semilogx(h,TipError)
xlabel('h')
ylabel('Error in tip deflection')
grid on
title('Part(a)')

%% Part(b)
figure(2)
semilogx(h,AxialError,h,ShearError)
xlabel('h')
ylabel('Stress')
legend('Axial','Shear')
grid on
title('Part(b)')

%% Part(c)
figure(3)
plot(logh,L2,logh,H1)
xlabel('log(h)')
ylabel('Error')
legend('L2 Error','H1 Error')
title('Error Comparison')
grid on

figure (4)
title('H1 Error')
plot(logh, H1)
xlabel('log(h)')
ylabel('Error')
title('H1 Error')
grid on

figure (5)
title('L2 Error')
plot(logh, L2)
xlabel('log(h)')
ylabel('Error')
title('L2 Error')
grid on

