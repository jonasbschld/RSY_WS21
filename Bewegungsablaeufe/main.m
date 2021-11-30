createSerialLink_ZeroModify;

% Daten von Kamera
Punkt_links = [300 30 0];
Punkt_rechts = [400 40 0];

% Position des 2. YouBots mit Daten aus Kamera bestimmen
pos_YB=YB2_Pos_Bestimmung(Punkt_links, Punkt_rechts);

% Übergabehöhe berechnen
z_ueb=Uebergabehoehe(pos_YB,0); % mit Psi=0 als Übergabeorientierung

% Übergabe-Position unseres YB und Sicherheitsposition davor bestimmen
[Position_sicher, Position_ueb] =Uebergabeposition(pos_YB, z_ueb, 45);

% Überprüfen, ob Positionen im Arbeitsraum liegen
Arbeitsraum(Position_sicher);
Arbeitsraum(Position_ueb);

% Sicherheitsposition anfahren
[Winkel, Position]=IK(Position_sicher);
PunktEbeneAbstand(pos_YB, Position); %überprüft, ob gewünschter Punkt kollisionsgefährdet ist
GelenkPos(ROS, Winkel);
pause('on'); %Pause ermöglichen
pause(3); %für 3 Sekunden warten

% Übergabeposition auf gerader Linie anfahren
schritte=20; % Anzahl Schritte
a=0:(1/schritte):1; 
a=transpose(a);
for i=1:schritte+1    % Schrittweise von Sicherheits- zu Übergabeposition
        Y=a*(Position_ueb(1:3)-Position_sicher(1:3));
        TKoordinate=Y+Position_sicher(1:3);
        
        Position(1)=TKoordinate(i,1);
        Position(2)=TKoordinate(i,2);
        Position(3)=TKoordinate(i,3);
        Position(4)=0;
        Position(5)=0;
        
        createSerialLink_ZeroModify;
        [Winkel]=IK(Position);
        GelenkPos(ROS, Winkel);
 end


