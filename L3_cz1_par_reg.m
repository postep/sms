%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                              %
%%    Przyk�adowy skrypt z implementacj� prostego regulatora DMC w wersji       %
%%  analitycznej, uzupe�niony o pomiar zak��cenia (cz. I - wyznaczanie          %
%%  parametr�w regulatora).                                                     %
%%    Przyj�te oznaczenia:                                                      %
%%    s - rz�dne odpowiedzi skokowej obiektu                                    %
%%    sz - rz�dne odpowiedzi obiektu na skok zak��cenia mierzalnego             %
%%    D - horyzont dynamiki                                                     %
%%    N - horyzont predykcji                                                    %
%%    Nu - horyzont sterowania                                                  %
%%    lambda - wsp�czynnik kary za przyrosty sterowania                        %
%%    ke, ku, kz - parametry regulatora                                         %
%%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Autor: Piotr Marusak; 2001-2017
%   Wersja przeznaczona dla s�uchaczy wyk�adu Diagnostyka proces�w przemys�owych
% (DIPR) prowadzonego na Wydziale Elektroniki i Technik Informacyjnych 
% Politechniki Warszawskiej.

clear all;

% Wektor z rz�dnymi odpowiedzi skokowych obiektu

s=[0.8000 1.3600 1.7520 2.0264 2.2185 2.3529 2.4471 2.5129 2.5591 2.5913 2.6139 2.6298 2.6408 2.6486 2.6540 2.6578 2.6605 2.6623 2.6636];
sz=[0.1000 0.1700 0.2190 0.2533 0.2773 0.2941 0.3059 0.3141 0.3199 0.3239 0.3267 0.3287 0.3301 0.3311 0.3318 0.3322 0.3326 0.3328 0.3330];

% Horyzonty

D=12;
N=12;
Nu=6;

% Wsp�czynnik kary za przyrosty sterowania

lambda=1;

% Generacja macierzy

M=zeros(N,Nu);
for i=1:N
   for j=1:Nu
      if (i>=j)
         M(i,j)=s(i-j+1);
      end;
   end;
end;

MP=zeros(N,D-1);
for i=1:N
   for j=1:D-1
      if i+j<=D
         MP(i,j)=s(i+j)-s(j);
      else
         MP(i,j)=s(D)-s(j);
      end;      
   end;
end;

MZP=zeros(N,D-1);
for i=1:N
   for j=1:D-1
      if i+j<=D
         MZP(i,j)=sz(i+j)-sz(j);
      else
         MZP(i,j)=sz(D)-sz(j);
      end;      
   end;
end;

% Obliczanie parametr�w regulatora

I=eye(Nu);
K=((M'*M+lambda*I)^-1)*M';
ku=K(1,:)*MP;
kz=K(1,:)*MZP;
ke=sum(K(1,:));
