classdef Watermarking < handle
    properties (Access=protected)
        WatermarkTileSize;
        DWTWaveletName;
        Alpha;

        sourceImage;
        sourceImageSize;
        sourceBLW BlockLevelWatermarking;

        watermarkSourceImage;
        watermarkPattern;
        watermarkBLW BlockLevelWatermarking;

    end
    methods (Access=protected)
        %% Load the source image
        function checkSourceImage(this)
            this.sourceImageSize = size(this.sourceImage);

            % Check if this image has a fitting size for this block size
            % (original paper assumes it always has)
            if (~all(mod(this.sourceImageSize, 2*this.WatermarkTileSize) == 0))
                error("Image size is not divisible by 2 times the block size (by " + this.WatermarkTileSize * 2 + ")!");
            end
        end
        %% Load the watermark image
        function checkWatermarkImage(this)
            watermarkRepeats = this.sourceImageSize ./ this.WatermarkTileSize;
            this.watermarkPattern = repmat(this.watermarkSourceImage, watermarkRepeats);
        end        
    end
    methods
        function this = Watermarking(watermarkTileSize, dwtWaveletName, alpha)
            this.WatermarkTileSize = watermarkTileSize;
            this.DWTWaveletName = dwtWaveletName;
            this.Alpha = alpha;
        end

        %% Run a full watermark embedding
        function r = Run(this, sourceImage, watermarkImage)
            this.sourceImage = sourceImage;
            this.watermarkSourceImage = imresize(rgb2gray(watermarkImage), [this.WatermarkTileSize  this.WatermarkTileSize]);

            % Read the source image
            this.checkSourceImage();

            % Read the watermark image
            this.checkWatermarkImage();
            
            % Calculate the DWT, SVD and sub-SVD matrices
            this.sourceBLW = BlockLevelWatermarking(this.sourceImage, this.DWTWaveletName, this.WatermarkTileSize);
            this.watermarkBLW = BlockLevelWatermarking(this.watermarkPattern, this.DWTWaveletName, this.WatermarkTileSize);

            % Mix in the watermark into the original image
            this.sourceBLW.Mixin(this.watermarkBLW, this.Alpha);

            % Revert all transformations to get watermarked image
            r = this.sourceBLW.Reverse();
        end
    end
end


