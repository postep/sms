delete(instrfindall); % zamkniecie wszystkich polaczen szeregowych
clear all;
% close all;
s = serial('COM8'); % COM9 to jest port utworzony przez mikrokontroler
set(s,'BaudRate',115200);
set(s,'StopBits',1);
set(s,'Parity','none');
set(s,'DataBits',8);
set(s,'Timeout',1);
set(s,'InputBufferSize',800);
set(s,'Terminator',13);
fopen(s); % otwarcie kanalu komunikacyjnego
Tp = 0.05; % czas z jakim probkuje regulator
y = []; % wektor wyjsc obiektu
u = []; % wektor wejsc (sterowan) obiektu
while length(y)~=700 % zbieramy 100 pomiarow
txt = fread(s,22); % odczytanie z portu szeregowego
% txt powinien zawiera ?c Y=%4d;U=%4d;
% czyli np. Y=1234;U=3232;
eval(char(txt')); % wykonajmy to co otrzymalismy
disp(char(txt'));
y=[y;Y]; % powiekszamy wektor y o element Y
u=[u;U]; % powiekszamy wektor u o element U
end

%% wyswietlanie
figure; plot((0:(length(y)-1))*Tp,y); % wyswietlamy y w czasie
figure; plot((0:(length(u)-1))*Tp,u); % wyswietlamy u w czasie

K_kryt = 28;
K = 0.6*K_kryt
Tu = 0.05*8
Td = Tu/8
Ti = Tu/2


% float up, ui, ui_prev = 0, ud, u, e_prev = 0, e, u_prev = 0, u_w;
% float counter = 0;
% static float K = 16.8;
% static float Ti = 0.2;
% static float T = 0.05;
% static float Td = 0.05;
% static float Tv = 100000000000;
% static float y_zad = 1900.0f;
% 		
% void HAL_TIM_PeriodElapsedCallback(TIM_HandleTypeDef *htim){
% 	if(htim->Instance == TIM2){
% 		static float y = 0.0f;
% 		static float u = 0.0f;
% 		y = (input-2048.0f); // przejscie z 0 - 4095 do -2048 - 2047
% 
% 		//u = 512.0; // <-- tutaj algorytm regulacji
% 		
% 		//parametry regulatora
% 		 //wyznaczenie uchybu
% 		if (counter < 100){
% 			y_zad = 0;
% 		}else if (counter < 300){
% 			y_zad = 512.f;
% 		}else if (counter < 500){
% 			y_zad = -512.f;
% 		}else{
% 			y_zad = 0;
% 		}
% 		counter++;
%     e = y_zad - y; 
% 
%     //wyznaczenie sterowania od poszczegolnych czlonow
%     up = K*e;
%     ui = ui_prev+K*T*(e+e_prev)/(2*Ti) + T*(u_w-u_prev)/Tv; //z anty-windup
%     ud = K*Td*(e-e_prev)/T;
% 
%     //wyznaczona wartosc sygnalu sterowania
%     u = up+ui+ud;
% 
%     //zapamietujemy sygnaly z aktualnej chwili (jako poprzednie dla kolejnej iteracji)
%     u_prev = u; 
%     ui_prev = ui;
%     e_prev =e;
% 
% 		if(u >  2047.0f) u =  2047.0f;
% 		if(u < -2048.0f) u = -2048.0f;
% 		u_w = u;
% 		output = u+2048.0f; // przejscie z -2048 - 2047 do 0 - 4095
% 		updateControlSignalValue(output); // aplikacja natychmiast po wyznaczeniu sterowania czy opoznic?
% 				