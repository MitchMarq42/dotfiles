-- xmonad configuration file, for compiling into xmonad

-- Imports
import XMonad
import XMonad.Config.Xfce
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import XMonad.Util.Cursor
import XMonad.Util.EZConfig
import XMonad.Actions.FloatKeys
import XMonad.Layout.Spiral
import XMonad.Layout.AvoidFloats
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.WindowSwallowing
import Control.Monad (liftM2)

-- Window rules
myManageHook = composeAll
    [ className =? "Brave-browser"          --> doShift "web"
    , className =? "DesktopEditors"         --> viewShift "office"
    , className =? "Xfce4-settings-manager" --> viewShift "settings"
    , className =? "Emacs"                  --> viewShift "office"
    , className =? "Oblogout"	        	--> doFloat
    , className =? "st256color"		        --> doIgnore
    , className =? "mpv"			        --> doIgnore
    --, className =? "xfce4-panel"  		--> doIgnore
    , manageDocks
    ]
    where viewShift = doF . liftM2 (.) W.greedyView W.shift

-- Workspaces
myWorkspaces = ["term","web","office","settings","5","6","7","8","9"]

myTerminal = "alacritty"

--myLayout = avoidStruts $ spiral (6/7)

mySwallowHook = swallowEventHook ( className =? "Alacritty" ) ( return True )

-- keybindings (see ~/.config/sxhkd/sxhkdrc for more)
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList
    [ ((modMask, xK_u), withFocused (keysMoveWindow (0, 10)) )
    , ((modMask, xK_i), withFocused (keysMoveWindow (0, -10)) )
    , ((modMask, xK_y), withFocused (keysMoveWindow (-10, 0)) )
    , ((modMask, xK_o), withFocused (keysMoveWindow (10, 0)) )
    , ((modMask, xK_b), sendMessage ToggleStruts)
    , ((modMask, xK_Return), spawn myTerminal)
    , ((modMask, xK_w), spawn "brave")
    , ((modMask, xK_Escape), spawn "xkill")
    ]

-- main defs: start with XFCE defaults and throw in all the above.
main = xmonad xfceConfig
    { modMask    = mod4Mask
    , terminal   = myTerminal
    , manageHook = myManageHook <+> manageHook xfceConfig
    , workspaces = myWorkspaces
    , keys       = myKeys <+> keys xfceConfig
    --, layoutHook = myLayout
    , handleEventHook = mySwallowHook <+> ewmhDesktopsEventHook <+> fullscreenEventHook <+> handleEventHook def
    , startupHook = ewmhDesktopsStartup <+> spawn myTerminal
    }
