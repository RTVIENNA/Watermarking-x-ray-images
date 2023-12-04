function Example()
    %% Parameters for watermarking

    % [1]: "An enhanced hybrid image watermarking scheme 
    %       for security of medical and non-medical images
    %       based on DWT and 2-D SVD"

    % [2]: "Robust Perceptual Image Hashing Via Matrix Invariants"

    % Secret key for the pseudo random number generator.
    secretkey = "Secret";

    % Size of the watermark tiles
    watermarkTileSize = 16;

    % Wavelet to be used for DWT/IDWT operations
    dwtWaveletName = 'db1';

    % Alpha as specified by paper [1]
    alpha = 0.5;

    % See paper [2], SVD-SVD variant for parameter meaning
    hash_m = 16 * watermarkTileSize;
    hash_p = hash_m/2;
    hash_d = 4 * watermarkTileSize;
    hash_r = hash_d/2;

    % Specify which bit of the SVD of LL of image to use for embedding the hash data
    % Paper [1] specifies this to be 2 ("... change the second LSB of the binary value ...")
    signBit = 2;

    %% Read input images, do the actual watermarking and signing work and write output image.
    
    disp("Reading images...");
    inputImage = imread("input.jpeg");
    watermarkImage = imread("watermark.png");

    disp("Watermarking image...");
    [sourceImage, watermarkedImage, hash, signedImage, outputImage, diffImage, rgbImage] =...
        FullWatermarking(...
        inputImage, watermarkImage, secretkey, watermarkTileSize, dwtWaveletName, alpha, hash_m, hash_p, hash_d, hash_r, signBit...
        );

    disp("Writing result image...");
    imwrite(outputImage, "output.png");

    %% The rest is just displaying images and information.
    figure("Name", "Image comparison");

    tiledlayout(2,2, 'Padding', 'none', 'TileSpacing', 'compact');
    nexttile;
    imshow(inputImage);
    title("Original image");

    nexttile;
    imshow(signedImage);
    title("Watermarked, signed image");

    nexttile;
    imshow(uint8(abs(diffImage)));
    title("Difference");

    nexttile;
    imshow(rgbImage);
    title("Amplified Difference with source image");

    disp("Maximum pixel difference through watermarking: " + max(max(abs(double(watermarkedImage) - double(sourceImage)))));
    disp("Watermark hash is: " + hash);
    disp("Maximum pixel difference through signing: " + max(max(abs(double(signedImage) - double(watermarkedImage)))));
    disp("Maximum total pixel difference: " + max(max(abs(double(signedImage) - double(sourceImage)))));

    imwrite(watermarkedImage, "watermarked.png");
    imwrite(signedImage, "signed.png");
    imwrite(outputImage, "output.png");
    imwrite(rgbImage, "differences.png");
end
