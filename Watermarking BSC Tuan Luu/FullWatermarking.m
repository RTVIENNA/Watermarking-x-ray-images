function [sourceImage, watermarkedImage, hash, signedImage, outputImage, diffImage, rgbImage] = ...
    FullWatermarking(...
    inputImage, watermarkImage, secretkey, watermarkTileSize, dwtWaveletName, alpha, hash_m, hash_p, hash_d, hash_r, signBit...
    )

    sourcePreprocessor = SourceImagePreprocessor(watermarkTileSize);
    watermarker = Watermarking(watermarkTileSize, dwtWaveletName, alpha);
    hasher = ImageHasher(secretkey, hash_m, hash_p, hash_d, hash_r);
    signer = SignatureEmbedder(secretkey, dwtWaveletName, signBit);

    % Extract image with correct size
    sourceImage = sourcePreprocessor.Extract(inputImage);

    % Watermark the image
    watermarkedImage = watermarker.Run(sourceImage, watermarkImage);

    % Calculate the hash of the watermark image
    hash = hasher.Run(watermarkImage);

    % Sign the image with the watermark hash
    signedImage = signer.Run(watermarkedImage, hash);

    % Reintegrate the cropped image into the original image
    outputImage = sourcePreprocessor.Reintegrate(inputImage, signedImage);

    % Calculate differences between the resulting image and the original image
    diffImage = double(outputImage) - double(inputImage);

    % Calculate image with amplified differences in red
    rgbImage = cat(3, inputImage + uint8(abs(diffImage * 20)), inputImage, inputImage);
end
