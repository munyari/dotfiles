import System.IO
import XMonad
import XMonad.Actions.SpawnOn
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Layout.NoBorders
import XMonad.Util.EZConfig(additionalKeys, additionalKeysP)
import XMonad.Util.Run(spawnPipe)
import qualified XMonad.StackSet as W

-- preferred terminal
myTerminal = "urxvt"

-- Whether focus follows the mouse pointer
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- width of window border in pixels
myBorderWidth = 2

-- modMask specifies which modKey you want to use. Here set to super
myModMask = mod4Mask

-- unfocused and focused borders respectively
myNormalBorderColor = "#000000"
myFocusedBorderColor = "#26a98b"

-- Window rules
myManageHook = composeAll
      [ isDialog --> doFloat
      , className =? "Firefox" --> doShift "WEB"
      , className =? "qutebrowser" --> doShift "WEB"
      , className =? "urxvt" --> doShift "TERM"
      , (isFullscreen --> doFullFloat)
      ]

myLayoutHook = smartBorders(avoidStruts $ layoutHook defaultConfig)

-- Default number of workspaces and their names.
myWorkspaces = ["TERM", "WEB", "MEDIA", "TASKS", "OTHER"]

myLogHook :: X()
myLogHook = fadeInactiveLogHook fadeAmount where fadeAmount = 0.8

myStartupHook :: X()
myStartupHook =
  spawn "compton --backend glx -fcC"

main = xmonad $ defaultConfig
      { modMask = myModMask
      , terminal = myTerminal
      , borderWidth = myBorderWidth
      , normalBorderColor = myNormalBorderColor
      , focusedBorderColor = myFocusedBorderColor
      , workspaces = myWorkspaces
      , manageHook = manageDocks <+> myManageHook <+> manageSpawn
      , layoutHook = myLayoutHook
      , handleEventHook = handleEventHook defaultConfig <+> fullscreenEventHook
      , logHook = myLogHook
      , startupHook = setWMName "LG3D" <+> myStartupHook
      }
