
baker h = do
    let d = 9.0
	-- h = 3.25
	atop = pi * (d/2)^2
	aside = pi * d * h
	area = 2 * atop + aside
	ratio = (atop / area) * 100
    putStrLn $ "diameter = " ++ show d
    putStrLn $ "height   = " ++ show h
    putStrLn $ "area     = " ++ show area
    putStrLn $ "ratio    = " ++ take 4 (show ratio) ++ "%\n"

main = do
    baker 3
    baker 4
    baker 5

