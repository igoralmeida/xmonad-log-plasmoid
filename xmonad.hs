import XMonad
import XMonad.Config.Kde
import XMonad.Hooks.DynamicLog

import Control.OldException

import DBus
import DBus.Connection as DC
import DBus.Message

import qualified Codec.Binary.UTF8.String as UTF8

main :: IO ()
main =  withConnection Session $ \dbus -> do
    getWellKnownName dbus
    xmonad $ kdeConfig
         { logHook = dynamicLogWithPP (prettyPrinter dbus)
         }

prettyPrinter :: DC.Connection -> PP
prettyPrinter dbus = defaultPP
    { ppOutput   = dbusOutput dbus
    , ppCurrent  = wrap "[" "]"
    , ppSep      = " | "
    }

getWellKnownName :: DC.Connection -> IO ()
getWellKnownName dbus = tryGetName `catchDyn` (\(DBus.Error _ _) -> getWellKnownName dbus)
  where
    tryGetName = do
        namereq <- newMethodCall serviceDBus pathDBus interfaceDBus "RequestName"
        addArgs namereq [String "org.xmonad.Log", Word32 5]
        sendWithReplyAndBlock dbus namereq 0
        return ()

dbusOutput :: DC.Connection -> String -> IO ()
dbusOutput dbus str = do
    msg <- newSignal "/org/xmonad/Log" "org.xmonad.Log" "Update"
    addArgs msg [String (UTF8.decodeString str)]
    -- If the send fails, ignore it.
    send dbus msg 0 `catchDyn` (\(DBus.Error _ _) -> return 0)
    return ()
