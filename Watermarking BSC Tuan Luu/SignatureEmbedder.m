classdef SignatureEmbedder < handle
    properties
        Key;
        DWTWaveletName;
        LL;
        SignBit;
    end
    methods
        function this = SignatureEmbedder(key, dwtWaveletName, signBit)
            this.Key = key;
            this.DWTWaveletName = dwtWaveletName;
            this.SignBit = signBit;
        end

        function EmbedBit(this, yStart, yEnd, xStart, xEnd, bit)
            [U,S,Vt] = svd(this.LL(yStart:yEnd, xStart:xEnd));
            v21 = Vt(2,1) * 100;
            
            vfloor = floor(v21);
            vdec = v21 - double(vfloor);

            vbits = flip(dec2bin(int32(vfloor), 32));

            if (bit == 1)
                vbits(this.SignBit) = '0';
            else                
                vbits(this.SignBit) = '1';
            end

            vint = bin2dec(strcat('0b', flip(vbits), 's32'));

            v21 = double(vint) + vdec;

            Vt(2,1) = v21 / 100;

            this.LL(yStart:yEnd, xStart:xEnd) = U*S*Vt';
        end

        function ret = Run(this, image, hash)
            rg = KeyedPrng(this.Key, 4);
            blockSize = 4;

            % Calculate U8 hash into bits array
            hashBits = flip(dec2bin(uint8(hash), 8) == '1');
            
            % Calculate DWT
            [this.LL, LH, HL, HH] = dwt2(double(image), this.DWTWaveletName);

            llSize = size(this.LL);
            maxY = llSize(1) - blockSize;
            maxX = llSize(2) - blockSize;

            % Find 8 random blocks and embed the bit
            for i = 1:8
                yStart = rg.Nexti(maxY);
                yEnd = yStart + blockSize;
                xStart = rg.Nexti(maxX);
                xEnd = xStart + blockSize;

                this.EmbedBit(yStart, yEnd, xStart, xEnd, hashBits(i));
            end

            % Calculate IDWT
            ret = uint8(idwt2(this.LL, LH, HL, HH, this.DWTWaveletName));
        end
    end
end