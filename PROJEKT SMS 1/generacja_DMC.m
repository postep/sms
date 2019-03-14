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



% Wektor z rz�dnymi odpowiedzi skokowych obiektu
  
load('wektors.mat');
clear s str Tp txt u U x Y y;
s=S;
% Horyzonty

D=60;
N=18;
Nu=7;

% Wsp�czynnik kary za przyrosty sterowania

lambda=0.5;

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


% Obliczanie parametr�w regulatora

I=eye(Nu);
K=((M'*M+lambda*I)^-1)*M';
ku=K(1,:)*MP;
ke=sum(K(1,:));
