%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Arbeitsraumabschätzung
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [klappt_aussen, klappt_innen]=Arbeitsraum(Position)
    % gewünschte Position übergeben
    x=Position(1);
    y=Position(2);
    z=Position(3);
    psi=Position(4); %rad
    
    % 0/1-Variablen für Position innerhalb (1) oder außerhalb (0) des Arbeitsraums
    klappt_aussen=0; % default: Abbruch von main, weil Position nicht innerhalb des max. Arbeitsbereichs
    klappt_innen=0; % default: Abbruch von main, weil Position nicht innerhalb des min. Arbeitsbereichs
    
    % Parameter %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
        % Länge der Links
    l1=147;
    l2=155;
    l3=135;
    l4=217.5; 
    l5=0;
        % Versatz in z-Richtung
    z_versatz=l1; 
    
    % Fallunterscheidung für kritischen Punkt bei Versatz in x-Richtung (je nach Position muss er addiert oder subtrahiert werden)
    if x>=33
        r_versatz=33; % positiver Versatz in x-Richtung
    else
        r_versatz=-33; % negativer Versatz in x-Richtung
    end

    % Theta 3 für minimalen Radius, Anschläge
    theta3_max=deg2rad(150);     
    
    %Berechnung %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Berechnung maximaler Arbeitsraum
    theta2=acos((z-z_versatz-l4*sin(psi))/(l2+l3));
    r_max=508+r_versatz*sin(theta2)-l4; % maximaler Armradius
    theta4=(pi/2)-psi-theta2;
    r_aussen=sqrt((sqrt(x^2+y^2)-l4*cos(psi)-r_versatz)^2+(z-z_versatz)^2);
        % Berechnung minimaler Arbeitsraum
    l_23=sqrt(l2^2+l3^2-2*l2*l3*cos(pi-theta3_max));
    r_min=l_23;
    
    %% Position überprüfen
    % Ist der äußere Radius kleiner/gleich dem maximal möglichen Radius?
    if (r_aussen <= r_max) 
        disp('Klappt außen')
        klappt_aussen=1; % Position im max. AR
    else
        disp('Gewünschte Position ist nicht im maximalen Arbeitsraum')
        klappt_aussen=0; %Abbruch von main, weil Position nicht innerhalb des max. Arbeitsbereichs
    end
    % Ist der äußere Radius größer/gleich dem minimal möglichen Radius?
    if (r_aussen >= r_min)
        disp('Klappt innen')
        klappt_innen=1; % Position im min. AR
    else
        disp('Gewünschte Position ist nicht im minimalen Arbeitsraum')
        klappt_innen=0; %Abbruch von main, weil Position nicht innerhalb des min. Arbeitsbereichs
    end
end

