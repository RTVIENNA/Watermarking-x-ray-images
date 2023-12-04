classdef SourceImagePreprocessor < handle
    properties
    end
    properties (Access=protected)
        WatermarkTileSize;
        Divisor;
    end
    methods
        function this = SourceImagePreprocessor(watermarkTileSize)
            this.WatermarkTileSize = watermarkTileSize;
            this.Divisor = 2 * this.WatermarkTileSize;
        end

        function [yMin, yMax, xMin, xMax] = calcRoi(this, image)
            imageSize = size(image);
            reps = floor(imageSize / this.Divisor);
            border = floor(mod(imageSize, this.Divisor) / 2);
            yMin = border(1) + 1;
            yMax = yMin + reps(1) * this.Divisor - 1;
            xMin = border(2) + 1;
            xMax = xMin + reps(2) * this.Divisor - 1;
        end

        function r = Extract(this, image)
            [yMin,yMax,xMin,xMax] = this.calcRoi(image);
            r = image(yMin:yMax, xMin:xMax);
        end

        function r = Reintegrate(this, original, changedPart)
            [yMin,yMax,xMin,xMax] = this.calcRoi(original);
            original(yMin:yMax, xMin:xMax) = changedPart;
            r = original;
        end
    end
end
