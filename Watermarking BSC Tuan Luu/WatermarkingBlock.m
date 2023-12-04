classdef WatermarkingBlock < handle
    properties
        HH;
        U;
        S;
        V;
        S11;
    end
    methods
        function this = WatermarkingBlock(hhData)
            % Avoid errors due to automatic matrix rescaling
            if nargin ~= 1
                return;
            end

            this.HH = hhData;

            % Calculate SVD of data block (Paper 4.1.3, 4.1.7)
            [this.U, this.S, this.V] = svd(this.HH);
            this.S11 = this.S(1,1);
        end

        function r = Reverse(this)
            % Calculate reverse SVD of data block (Paper 4.1.11)
            this.HH = this.U * this.S * this.V';
            r = this.HH;
        end
    end
end