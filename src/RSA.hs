import           Data.Char
{-
import qualified Data.Text.Lazy as L
import qualified Data.Text.Lazy.IO as L
-}
import qualified Data.ByteString.Lazy       as LBS
import qualified Data.ByteString.Lazy.Char8 as LBSC

data Keys = Keys
       { publicKey1 :: Integer
       , publicKey2 :: Integer
       , privateKey :: Integer
       } deriving (Show)

generateKeys :: Integer -> Integer -> Keys
generateKeys prime1 prime2 = Keys publicKey1 publicKey2 privateKey
    where
        publicKey1 = prime1 * prime2
        l = lcm (prime1 - 1) (prime2 - 1)
        publicKey2 = head [x | x <- [2 .. (l - 1)], gcd x l == 1]
        privateKey = head [x | x <- [2 .. (l - 1)], mod (publicKey2 * x) l == 1]

rsaEnDec :: [Integer] -> Integer -> Integer -> [Integer]
rsaEnDec txt key n = map (\x -> x ^ key `mod` n) txt

lbsToIntegerList :: LBS.ByteString -> [Integer]
lbsToIntegerList txt = map toInteger $ LBS.unpack txt

--integerListToLBS :: [Integer] -> LBS.ByteString
--integerListToLBS list = LBS.pack list

rsaEncode :: LBS.ByteString -> Integer -> Integer -> [Integer]
rsaEncode txt = rsaEnDec (lbsToIntegerList txt)

main = do
        txt <- LBS.readFile "test.txt"
        print txt
        LBS.putStrLn txt
        print $ map toInteger $ LBS.unpack txt
        print $ rsaEncode txt (publicKey2 keys) (publicKey1 keys)
        --print $ rsaEncode (rsaEncode txt publicKey n) privateKey n
        print $ rsaEncode txt (privateKey keys) (publicKey1 keys)
        --print $ rsaEncode (rsaEncode txt privateKey n) publicKey n
        print keys
        print str
            where
                keys = generateKeys 103 19
                str = "abcdefghijklmnopqrstuvwxyz"
                --strint = map toInteger $ LBS.unpack txt
                --strint = map (toInteger . fromEnum) str
                --code = map (\x -> (x ^ publicKey `mod` n)) strint
                --decode = map (\x -> (x ^ privateKey `mod` n)) code
                --intstr = map (chr . fromIntegral) decode
