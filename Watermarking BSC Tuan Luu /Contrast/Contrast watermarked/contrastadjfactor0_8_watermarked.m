% Laden Sie Ihr Bild
originalImage = imread('watermarked.png'); % Ersetzen Sie 'your_image.jpg' durch den Dateinamen Ihres Bildes

% Kontrastfaktor (1 = keine Änderung, >1 erhöht den Kontrast, <1 verringert den Kontrast)
contrastFactor = 0.8; % Zum Beispiel, um den Kontrast zu erhöhen

% Passen Sie den Kontrast an
adjustedImage = originalImage * contrastFactor;

% Stellen Sie sicher, dass die Pixelwerte im gültigen Bereich liegen (0 bis 255 für 8-Bit-Bilder)
adjustedImage(adjustedImage > 255) = 255;
adjustedImage(adjustedImage < 0) = 0;

% Wandeln Sie die Daten in das geeignete Datenformat um
if isa(originalImage, 'uint8')
    adjustedImage = uint8(adjustedImage);
elseif isa(originalImage, 'uint16')
    adjustedImage = uint16(adjustedImage);
end

% Zeigen Sie das Originalbild und das angepasste Bild an
subplot(1, 2, 1);
imshow(originalImage);
title('Originalbild');

subplot(1, 2, 2);
imshow(adjustedImage);
title('Angepasstes Bild');

% Speichern Sie das angepasste Bild
imwrite(adjustedImage, 'contrastadjfactor0_8.jpg'); % Ersetzen Sie 'adjusted_image.jpg' durch den gewünschten Dateinamen
