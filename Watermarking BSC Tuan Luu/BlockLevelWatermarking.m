classdef BlockLevelWatermarking < handle
    properties
        LL;
        LH;
        HL;
        HH;
        HHBuf;
        Blocks (:,:) WatermarkingBlock;
        BlockCount;
        S11Matrix;
        S11_U;
        S11_S;
        S11_V;
        dwtWaveletName;
        blockSize;
        HHSize;
    end

    methods
        function this = BlockLevelWatermarking(image, dwtWaveletName, blockSize)
            this.blockSize = blockSize;
            this.dwtWaveletName = dwtWaveletName;

            % Calculate the DWT of the image (Paper 4.1.1, 4.1.2, 4.1.6)
            [this.LL, this.LH, this.HL, this.HHBuf] = dwt2(image, dwtWaveletName);

            this.HHSize = size(image)/2;
            this.HH = this.HHBuf(1:this.HHSize(1), 1:this.HHSize(2));

            % Calculate block counts and reshape HH data (Paper 4.1.3, 4.1.6)
            this.BlockCount = size(this.HH) ./ blockSize;
            blocks = reshape(this.HH, [blockSize blockSize this.BlockCount(1) this.BlockCount(2)]);

            % For all HH blocks...
            for i = 1:this.BlockCount(1)
                for j = 1:this.BlockCount(2)
                    blockIndex = i * this.BlockCount(2) + j;

                    % Extract the data matrix and create a new WatermarkingBlock element (Paper 4.1.3, 4.1.7)
                    this.Blocks(blockIndex) = WatermarkingBlock(blocks(:,:,i,j));

                    % Save the blocks S(1,1) data into the S11Matrix (Paper 4.1.4, 4.1.8)
                    this.S11Matrix(i, j) = this.Blocks(blockIndex).S11;
                end
            end

            % Calculate SVD of S11Matrix (Paper 4.1.5, 4.1.9)
            [this.S11_U, this.S11_S, this.S11_V] = svd(this.S11Matrix);            
        end

        function Mixin(this, other, alpha)
            % Mix original image with watermark image data (Paper 4.1.10)
            this.S11_S = this.S11_S + alpha * other.S11_S;
        end

        function r = Reverse(this)

            % Reverse SVD (Paper 4.1.11)
            this.S11Matrix = this.S11_U * this.S11_S * this.S11_V';
            buf = zeros(this.blockSize, this.blockSize, this.BlockCount(1), this.BlockCount(2));

            % For all HH blocks...
            for i = 1:this.BlockCount(1)
                for j = 1:this.BlockCount(2)
                    blockIndex = i * this.BlockCount(2) + j;

                    % Replace S(1,1) with new values (Paper 4.1.12)
                    this.Blocks(blockIndex).S(1,1) = this.S11Matrix(i, j);

                    % Calculate reverse SVD of block data to receive HH data (Paper 4.1.13)
                    buf(:, :, i, j) = this.Blocks(blockIndex).Reverse();
                end
            end

            % Reshape HH data (part of Paper 4.1.13)
            this.HHBuf(1:this.HHSize(1), 1:this.HHSize(2)) = reshape(buf, size(this.HH));
            
            % Reverse DWT (Paper 4.1.14)
            r = uint8(idwt2(this.LL, this.LH, this.HL, this.HHBuf, this.dwtWaveletName));
        end
    end
end
