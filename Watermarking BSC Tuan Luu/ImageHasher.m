classdef ImageHasher < handle
    properties
        Key;
        m;
        p;
        d;
        r;
    end

    methods
        function this = ImageHasher(key, m, p, d, r)
            this.Key = key;
            this.m = m;
            this.p = p;
            this.d = d;
            this.r = r;
        end

        function ret = Run(this, image)
            stage1 = SplitSvdMax(this.m, this.p, this.Key, 1);
            stage2 = PROrdering(this.Key, 2);
            stage3 = SplitSvdMax(this.d, this.r, this.Key, 3);

            % Split image into p m*m images called A, calculate SVD and find each maximum column into Gamma
            s1r = stage1.Run(image);

            % Reorder columns from Gamma into J
            s2r = stage2.Run(s1r);

            % Split J into r d*d images called B, calculate SVD and find each maximum column
            s3r = uint8(stage3.Run(s2r) * 255);

            % Calculate hash through XORing all elements
            hash = uint8(0);
            for i = 1:2*this.r
                for j = 1:this.d
                    hash = bitxor(hash, s3r(j, i));
                end
            end

            ret = hash;
        end
    end
end
