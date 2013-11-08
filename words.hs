getWords = do
    w <- readFile "/usr/share/dict/usa"
    let w2 = filter (\x -> length x == 4) $ lines w
    mapM putStrLn $ take 10 $ reverse w2

main = do
    getWords
