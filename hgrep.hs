import Data.List
import System.Directory
import Control.Monad

allfiles _ fn = True

getfiles idir ifunc recurse = do
    getfiles' idir
  where
    nodots fn = fn /= "." && fn /= ".."
    getfiles' dir = do
        fs <- fmap (sort . (filter (ifunc dir)) . (filter nodots))
                  (getDirectoryContents dir)
        fs' <- forM fs $ \fn -> do
            gotfile <- doesFileExist fn
            if gotfile then return [dir ++ "/" ++ fn]
            else do
                gotdir <- doesDirectoryExist (dir ++ "/" ++ fn)
                if gotdir && recurse then getfiles' (dir ++ "/" ++ fn)
                else return []
        return $ concat fs'

--
-- Sample filterfunc
--
filterfunc dir fn =
    (".hs" `isSuffixOf` fn
        || ".c" `isSuffixOf` fn
        || ".cc" `isSuffixOf` fn
        || fn == "makefile"
    )
    && fn /= ".git"

main = do
    getfiles "." allfiles True >>= mapM putStrLn
    getfiles "." filterfunc True >>= mapM putStrLn

