main = do
        print l
        print publicKey
        print privateKey
        print strint
        print code
        print decode
        where
            p = 7
            q = 19
            n = p * q
            l = lcm (p - 1) (q - 1)
            publicKey = head [x | x <- [2 .. (l - 1)], gcd x l == 1]
            privateKey = head [x | x <- [2 .. (l - 1)], mod (publicKey * x) l == 1]
            str = "hello"
            strint = map fromEnum str
            code = map (\x -> ((x ^ publicKey) `mod` n))  strint
            decode = map (\x -> ((x ^ privateKey) `mod` n))  code
