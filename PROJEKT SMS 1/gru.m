load('lam05.mat');
x=size(u);
x=x(1);
N=18;
Nu=7;
lambda=0.5;
wektor(1:5) = 0*ones(5,1);
wektor(6:41) = ones(36,1)*500;
wektor2(1:41) = ones(41,1)*535;
wektor3(1:41) = ones(41,1)*465;
k=linspace(1, x, x);
figure;
subplot(2, 1,1);
plot(k(15:55), y(15:55));
hold on;
plot(k(15:55),wektor(1:41));
plot(k(15:55),wektor2(1:41),'--');
plot(k(15:55),wektor3(1:41),'--');
title(['Ocena regulatora DMC, N=',num2str(N),', N_{u}= ',num2str(Nu),', \lambda= ',num2str(lambda)]); xlabel('k - nr probki ');
 ylabel('y - wyjscie obiektu');
subplot(2, 1, 2);
plot(k(15:55), u(15:55));
 xlabel('k - nr probki ');
 ylabel('u - sygnal sterujacy');
% clear s, txt;
% x=linspace(1,400,400);
% s=y-y(1);
% s=s./511;
% S=s(28:400, 1);
% str=u./512;
% figure;
% plot(x, s);
% 
% hold on;
% plot (x, str);
% xlabel('k - nr probi ');
% ylabel('wartosci znormalizowanych sygnalow');
% legend('znormalizowana odpowiedz skokowa', 'zmiana sygnalu sterujacego');
%print('ocenaDMC_przereg', '-dpng', '-r400');

