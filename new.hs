import Control.Monad
import Data.List
import Data.Char
import System.Cmd
import System.Environment
import System.Directory
import System.IO.Error

main = do
    a <- getArgs
    case a of
        [x] -> do
            let x2 = if ".hs" `isSuffixOf` x then x else x++".hs"
            e <- doesFileExist x2
            if e then do
                putStrLn $ x2 ++ " already exists - do you want to relink (y/n)? "
                s<-getLine
                when ((not.null) s && toLower (head s) == 'y') (doit x2)
            else do
                system $ "echo 'main = return ()' > " ++ x2
                doit x2
        _ -> putStrLn "Usage: hnew <fn>"

doit fn = do
    let jpd = "abc.hs"
    tryIOError $ removeFile jpd
    system $ "ln -s "  ++  fn  ++  " " ++ jpd
    return ()
