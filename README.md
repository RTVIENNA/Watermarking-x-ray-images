# Watermarking-x-ray images
Embedding a watermark in a x-ray image. Post-processing of watermarked x-ray images and calculating PSNR to study the effects.
Einbettung eines Wasserzeichens in ein Röntgenbild. Nachbearbeitung der mit Wasserzeichen versehenen Röntgenbilder und Berechnung des PSNR-Werts, um die Auswirkungen zu untersuchen. Aufgrund der Größe ist die gesamte Datei unterteilt hochgeladen worden.  Ein Teil beinhaltet den Einbettungsprozess und alle dazugehörigen Skripte, Klassen und Funktionen. Der andere Teil enthält die Nachbearbeitungen und die dazugehörigen PSNR-Messungen. 

Einführung: 

In den folgenden Zeilen soll der gesamte Ablauf der experimentellen Pretest
- Posttest Studie beschrieben werden, die im Rahmen der Bachelorarbeit 
„Gewährleistung der Integrität von radiologischen Bilddaten mittels 
technischer Verfahren“ ausgeführt wurde. 
Die Einbettung des Wasserzeichens soll dem Schema der Studie von 
Arahagi et al., 
„An enhanced hybrid image watermarking scheme for security of medical 
and non-medical images based on DWT and 2-D SVD”, folgen. 

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


 
