import Data.List
import System.Environment
import System.Cmd
import System.Posix.User

authtab = [("libby","shutdown"),("jerry","date")]

main = do
    uid <- getEffectiveUserID
    args <- getArgs
    name <- getLoginName

    if length args == 0 then putStrLn "missing arguments"
    else if uid /= 0 then putStrLn "Access denied"
    else case name of
        "jerry" -> step3 args
	_       ->  do
	    if elem (name,head args) authtab then step3 args
	    else putStrLn $ "Access denied - " ++ name ++ " not authorized"

step3 args = do
    setUserID 0
    setGroupID 0
    let cmd = concat $ intersperse " " args
    print cmd
    system cmd
    return ()
