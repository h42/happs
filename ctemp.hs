import System.Environment

main = do
    a <- getArgs
    case a of
        [d] -> toCelsius $ read d
        [d,"c"] -> toFahrenheit $ read d
        [d,"f"] -> toCelsius $ read d
        _   -> putStrLn "Usage ctemp <degrees> [c | f]"

toCelsius x = putStrLn $ show $ 5/9 * (x - 32)
toFahrenheit x = putStrLn $ show $ 9/5 * x + 32
