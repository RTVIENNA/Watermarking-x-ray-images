% Laden Sie Ihre Original- und komprimierten/veränderten Bilder
originalImage = imread('watermarked.png'); % Ersetzen Sie 'original.png' durch den Dateinamen Ihres Originalbildes
compressedImage = imread('croppedwatermarked_75percentmid.jpg'); % Ersetzen Sie 'compressed.png' durch den Dateinamen Ihres komprimierten/veränderten Bildes

% Stellen Sie sicher, dass die Bilder die gleiche Größe haben
if ~isequal(size(originalImage), size(compressedImage))
    % Bilder auf die gleiche Größe zuschneiden (nach der Größe des kleineren Bildes)
    [h, w, ~] = size(originalImage);
    [h_comp, w_comp, ~] = size(compressedImage);
    min_h = min(h, h_comp);
    min_w = min(w, w_comp);
    
    originalImage = originalImage(1:min_h, 1:min_w, :);
    compressedImage = compressedImage(1:min_h, 1:min_w, :);
end
% Höhe und Breite der Bilder ermitteln
[N, M] = size(originalImage);

% Mittleren quadratischen Fehler (MSE) berechnen
mse = sum(sum((double(originalImage) - double(compressedImage)).^2)) / (N * M);

% MAX-Wert festlegen (normalerweise 255 für 8-Bit-Bilder)
MAX = 255;

% PSNR-Wert berechnen
psnr = 10 * log10((MAX^2) / mse);

% PSNR-Wert anzeigen
fprintf('PSNR: %.2f dB\n', psnr);