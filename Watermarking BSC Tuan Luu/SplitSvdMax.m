classdef SplitSvdMax < handle
    properties
        BlockSize;
        BlockCount;
        Key;
        Blocks;
        Ua;
        Va;
        Gamma (:,:) double;
        Iteration;
    end
    methods
        function this = SplitSvdMax(blockSize, blockCount, key, iteration)
            this.BlockSize = blockSize;
            this.BlockCount = blockCount;
            this.Key = key;
            this.Iteration = iteration;
        end

        function ret = Run(this, image)
            rg = KeyedPrng(this.Key, this.Iteration);
            imgSize = size(image);
            maxYPos = imgSize(1) - this.BlockSize;
            maxXPos = imgSize(2) - this.BlockSize;

            for i = 1:this.BlockCount
                yStart = rg.Nexti(maxYPos);
                xStart = rg.Nexti(maxXPos);

                yEnd = yStart + this.BlockSize-1;
                xEnd = xStart + this.BlockSize-1;

                this.Blocks{i} = double(image(yStart:yEnd, xStart:xEnd));

                [U,~,Vt] = svd(this.Blocks{i});
                this.Ua{i} = U;
                this.Va{i} = Vt';

                [~, UmaxCol] = max(max(this.Ua{i}));
                [~, VmaxCol] = max(max(this.Va{i}));

                % FIXME: Find maximum column
                this.Gamma(:, 2*(i-1)+1) = this.Ua{i}(:, UmaxCol);
                this.Gamma(:, 2*(i-1)+2) = this.Va{i}(:, VmaxCol);
            end

            ret = this.Gamma;
        end
    end
end