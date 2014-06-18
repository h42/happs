import Data.List
import System.Environment
import System.Directory
import System.Process
import System.Exit
import Control.Monad

main = do
    argv <- getArgs
    case argv of
        [re, suffix] -> main2 re suffix
        [re]         -> main2 re ".hs"
        _            -> putStrLn "Usage: hgrep <Regular Expression> <quoted space separated suffix list>"

main2 re suffix = do
    fs <- getfiles "." (filterfunc (words suffix)) True
    mapM_ (grepper re) fs

getfiles idir ifunc recurse = do
    getfiles' idir
  where
    nodots fn = fn /= "." && fn /= ".."
    getfiles' dir = do
        fs <- fmap (sort . (filter ifunc) . (filter nodots))
                  (getDirectoryContents dir)
        fs' <- forM fs $ \fn -> do
            gotfile <- doesFileExist fn
            if gotfile then return [dir ++ "/" ++ fn]
            else do
                gotdir <- doesDirectoryExist (dir ++ "/" ++ fn)
                if gotdir && recurse then getfiles' (dir ++ "/" ++ fn)
                else return []
        return $ concat fs'

filterfunc ss fn = any (\x->isSuffixOf x fn) ss

grepper re fn = do
    --putStrLn $ "\n"++fn
    (rc,f1,f2) <- readProcessWithExitCode "egrep" [re,fn] ""
    when (rc==ExitSuccess)  $ do
        putStrLn fn
        putStrLn $ unlines $ map ("  " ++)
            (map (dropWhile (==' ')) (lines f1))

