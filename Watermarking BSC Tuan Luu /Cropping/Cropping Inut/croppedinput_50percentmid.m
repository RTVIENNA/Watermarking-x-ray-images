% Laden Sie Ihr Bild
originalImage = imread('input.jpeg'); % Ersetzen Sie 'your_image.jpg' durch den Dateinamen Ihres Bildes

% Prozentualen Anteil des Zuschneidens (zum Beispiel 20%)
cropPercentage = 50;

% Berechnen Sie die Höhe und Breite des neuen zugeschnittenen Bildes
[rows, cols, ~] = size(originalImage);
cropRows = round(rows * (1 - cropPercentage/100));
cropCols = round(cols * (1 - cropPercentage/100));

% Berechnen Sie die Position des zugeschnittenen Bereichs, um die Mitte zu erhalten
startRow = round((rows - cropRows) / 2) + 1;
startCol = round((cols - cropCols) / 2) + 1;

% Zuschneiden des Bildes, um die Mitte zu erhalten
croppedImage = imcrop(originalImage, [startCol, startRow, cropCols-1, cropRows-1]);

% Zeigen Sie das zugeschnittene Bild an
imshow(croppedImage);
title('Zugeschnittenes Bild mit erhaltener Mitte');

% Speichern Sie das zugeschnittene Bild als JPG
imwrite(croppedImage, 'croppedinput_50percentmid.jpg'); % Ersetzen Sie 'cropped_image.jpg' durch den gewünschten Dateinamen
