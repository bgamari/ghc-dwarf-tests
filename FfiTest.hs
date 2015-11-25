{-# LANGUAGE ForeignFunctionInterface #-}

module Main where

import Data.Maybe
import Foreign.C.Types
import Foreign.Ptr
import GHC.ExecutionStack

type Test = CInt -> IO ()

foreign import ccall "ffi_test" ffiTest :: CInt -> FunPtr Test -> IO ()

foreign import ccall "wrapper" mkTest :: Test -> IO (FunPtr Test)

test :: Test
test n = do
  print ("in test", n)
  showStackTrace >>= putStrLn . fromMaybe "no stacktrace"
  print ("leaving test", n)

main = do
  test' <- mkTest test
  ffiTest 42 test'
  return ()
