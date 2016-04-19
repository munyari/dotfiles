import XMonad
import XMonad.Actions.SpawnOn
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.NoBorders
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys, additionalKeysP)
import System.IO
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

-- TODO: Let xbindkeys handle all non-default keybindings
myKeys = [ ("<Print>", spawn "scrot -e 'mkdir -p ~/images/shots && mv $f ~/images/shots'")
         , ("C-<Print>", spawn "scrot -ue 'mkdir -p ~/images/shots && mv $f ~/images/shots'")
         , ("M1-<Print>", spawn "scrot -se 'mkdir -p ~/images/shots && mv $f ~/images/shots'")
         , ("M-f", spawn "firefox")
         -- dmenu_alias recognizes aliases and sorts by recent selection
         , ("M-p", spawn "dmenu_alias")
         -- , ("M-q", spawn "qutebrowser")
         -- , ("<XF86AudioLowerVolume>", spawn "pulseaudio-ctl down")
         -- , ("<XF86AudioRaiseVolume>", spawn "pulseaudio-ctl up")
         -- , ("<XF86MonBrightnessDown>", spawn "xbacklight -dec 5")
         -- , ("<XF86MonBrightnessUp>", spawn "xbacklight -inc 5")
         ]

main = xmonad $ defaultConfig
      { modMask = myModMask
      , terminal = myTerminal
      , borderWidth = myBorderWidth
      , normalBorderColor = myNormalBorderColor
      , focusedBorderColor = myFocusedBorderColor
      -- , manageHook = manageDocks <+> manageHook defaultConfig
      , workspaces = myWorkspaces
      , manageHook = manageDocks <+> myManageHook <+> manageSpawn
      , layoutHook = myLayoutHook
      , handleEventHook = handleEventHook defaultConfig <+> fullscreenEventHook
      } `additionalKeysP` myKeys
      -- -- TODO: Screen locking (xscreensaver?)
      -- [ (( myModMask, xK_f), spawn "firefox") -- to open firefox
      -- -- screenshot with print screen
      -- , (( 0, xK_Print), spawn "scrot -e 'mkdir -p ~/images/shots && mv $f ~/images/shots'")
      -- -- capture region
      -- , (( controlMask, xK_Print), spawn "scrot -se 'mkdir -p ~/images/shots && mv $f ~/images/shots'")
      -- ]
