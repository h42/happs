{-# LANGUAGE ForeignFunctionInterface  #-}

import Text.Printf
import Data.Char
import Data.List
import System.Environment
import System.Directory
import Control.Monad
import Foreign
import Foreign.C.String

foreign import ccall c_filesize :: CString -> IO Int

getsize fn = do
    s <- newCString fn
    l <- c_filesize s
    free s
    return l

getfiles dir = do
    let nodots fn = fn /= "." && fn /= ".."
    fs <- fmap (filter nodots) (getDirectoryContents dir)
    fs' <- forM fs $ \fn -> do
        gotfile <- doesFileExist fn
        if gotfile then return [dir ++ "/" ++ fn]
        else do
            gotdir <- doesDirectoryExist (dir ++ "/" ++ fn)
            if gotdir then getfiles (dir ++ "/" ++ fn)
            else return []
    return $ concat fs'

main = do
    argv <- getArgs
    if length argv == 1 && all isDigit (head argv) then
        main2 (read (head argv) :: Int)
    else putStrLn "Usage: hsize <size::Int>"

main2 n = do
    fs <- fmap sort (getfiles ".")
    ls <- mapM  (getsize) fs
    let as = filter (\(f,l)->l>=n) (zip fs ls)
        maxlen = foldr (\(f,l) a->
            let len = length f
            in if len>a then len else a) 0 as
        format = "%-" ++ show maxlen ++ "s  %d\n"
    forM_ as $ \(fn,len) -> printf format fn len
