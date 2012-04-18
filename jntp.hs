import Network
import System.IO
import System.Cmd

main = withSocketsDo $ do
    h <- connectTo "time.nist.gov" (PortNumber 13)
    hSetBuffering h LineBuffering
    hGetLine h
    line1 <- hGetLine h
    let
	tl = words line1
	d = head $ tail tl
	t = head $ drop 2 tl
	yr = take 2 d
	mon = take 2 (drop 3 d)
	day = drop 6 d
	hr = take 2 t
	minute = take 2 (drop 3 t)
	sec = drop 6 t
	cmd = "date --utc " ++ mon ++ day ++ hr ++ minute ++ yr ++ "." ++ sec
    putStrLn cmd
    hClose h
    system cmd
    system "hwclock --systohc --utc"
    system "hwclock --show"
