import GHC.ExecutionStack

-- | Trim object file names
cleanUpBacktrace :: String -> String
cleanUpBacktrace = unlines . map trimLine . lines
  where
    trimLine (' ':'i':'n':' ':_) = ""
    trimLine (x:xs)              = x : trimLine xs
    trimLine []                  = []

test :: Int -> IO ()
test 0 = return ()
test i = do
    print i
    showStackTrace >>= putStrLn . maybe "no stacktrace" cleanUpBacktrace
    test (i-1)
    return ()

main = do
        test 4
        print "Hello"
