% Bild einlesen
inputImage = imread('watermarked.png'); % Passe den Dateinamen an

% Winkel für die Rotation in Grad festlegen
rotationAngle = 180; % Ändere den Rotationswinkel nach Bedarf

% Bild rotieren
rotatedImage = imrotate(inputImage, rotationAngle, 'bilinear');

% Rotiertes Bild anzeigen
imshow(rotatedImage);
title(['Rotiertes Bild (', num2str(rotationAngle), ' Grad)']);

% Bild als PNG speichern
outputFileName = 'Rotation_bild180real2.png'; % Passe den Dateinamen an
imwrite(rotatedImage, outputFileName);

disp(['Das rotierte Bild wurde als "', outputFileName, '" gespeichert.']);