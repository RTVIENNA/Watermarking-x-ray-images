# Watermarking-x-ray images

Gewährleistung der Integrität von radiologischen Bilddaten mittels technischer Verfahren.

Einbettung eines Wasserzeichens in ein Röntgenbild. Nachbearbeitung der mit Wasserzeichen versehenen Röntgenbilder 
und Berechnung des PSNR-Werts, um die Auswirkungen zu untersuchen.
In Form einer modifizierten Pretest-Posttest-Studie wurden ausgewählte Nachbearbeitungsmethoden, 
darunter Rotation, Zuschneiden und Kontrastanpassung in unterschiedlichen Abwandlungen, angewendet. 
Die Ergebnisse wurden in Form einer deskriptiven Statistik ausgewertet. 
In der Pretest-Messung erzielte das Röntgenbild mit eingebetteten Wasserzeichen einen PSNR-Wert von 25,27 dB, als Basiswert. 
Nach allen Interventionen wurde in den Posttest-Messungen eine Reduktion des PSNR-Wertes verzeichnet. Ziel war es zu erforschen, 
ob Nachbearbeitungen eines Projektionsradiografiebildes Auswirkungen auf den PSNR-Wert und der einhergehenden Wahrnehmbarkeit haben.

Ensuring the integrity of radiological image data trough technical methods.

Embedding a watermark in a x-ray image. Post-processing of watermarked x-ray images and calculating PSNR to study the effects.
In the form of a modified pretest-posttest study, selected postprocessing methods, including rotation, cropping and contrast 
adjustment in various variations, were applied. The results were evaluated in the form of descriptive statistics. 
In the pretest phase, the x-ray image with an embedded watermark achieved a PSNR value of 25,27 dB, as a benchmark value. 
After all interventions, a reduction in the PSNR value was recorded in the posttest measurements. 
The aim was to research whether postprocessing of x-ray images influenced the PSNR value and the associated imperceptibility.

Einführung: 

Aufgrund der Größe ist die gesamte Datei unterteilt hochgeladen worden. 
Ein Teil beinhaltet den Einbettungsprozess und alle dazugehörigen Skripte, Klassen und Funktionen. Der andere Teil enthält die 
Nachbearbeitungen und die dazugehörigen PSNR-Messungen. 

In den folgenden Zeilen soll der gesamte Ablauf der experimentellen 
Pretest-Posttest Studie beschrieben werden, die im Rahmen der Bachelorarbeit 
„Gewährleistung der Integrität von radiologischen Bilddaten mittels 
technischer Verfahren“ ausgeführt wurde. 

Die Funktion Example.m durchläuft den gesamten Einbettungsprozess des 
Wasserzeichens, die Erstellung der Hash Funktion, 
und die Implementierung der Signatur. Das neue Bild mit eingebetteten 
Wasserzeichen trägt am Ende den Namen watermarked.png. Folglich wird 
zugleich der maximale Pixel Unterschied angezeigt. 
Dabei zieht die Funktion Example.m die benötigten 
Informationen aus den anderen verlinkten Skripten, Klassen und Funktionen 
(BlockLevelWatermarking.m, FullWatermarking.m, ImageHasher.m, KeyedPrng.m,
PROrdering.m, SignatureEmbedder.m, SourceImagePreprocessor.m, 
SplitSvdMax.m, Watermarking.m und WatermarkingBlock.m). 

In den Unterordnern Contrast, Cropping und Rotations sind die 
Nachbearbeitungen sowie die ausgeführten PSNR-Messungen zu finden.
Aufgeteilt in weitere Unterordner in denen die Nachbearbeitungen 
und Messungen mit und ohne Wasserzeichen sich in eigenen Ordnern befinden. 
Zur Ausführung der Nachbearbeitungen und Messungen müssen die Ordner 
jedoch a priori dem Pfad hinzugefügt werden. 

von Tuan Luu 12/2023
