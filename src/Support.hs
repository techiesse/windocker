module Support where

import Data.String.Utils
import System.Environment
import System.IO
import System.Process


executeCommand :: String -> IO String
executeCommand cmd = do
    putStrLn $ "Executando comando: " ++ cmd
    (_, hout, _, pHandle ) <- createProcess (shell cmd) {std_out = CreatePipe}
    let output =
            case hout of
                Nothing -> return ""
                Just handle -> hGetContents handle >>= (return . strip)
    waitForProcess pHandle
    output
