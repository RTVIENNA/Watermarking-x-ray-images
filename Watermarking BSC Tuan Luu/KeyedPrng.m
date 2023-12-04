classdef KeyedPrng < handle
    properties
        randStream;
    end
    methods
        function this = KeyedPrng(key, offset)
            md5Hash = char(mlreportgen.utils.hash(key));

            md5HashSeed = md5Hash(offset*4+1:offset*4+4);
            seed = uint32(hex2dec(md5HashSeed));
            this.randStream = RandStream("twister", "Seed", seed, "NormalTransform","Ziggurat");
        end

        function Reset(this)
            this.randStream.reset();
        end

        function ret = Next(this)
            ret = this.randStream.rand();
        end

        function ret = Nexti(this, iMax)
            ret = this.randStream.randi(iMax);
        end
    end
end
