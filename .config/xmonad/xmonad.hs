-- xmonad configuration file, for compiling into xmonad

-- for dependencies and compiling info see https://github.com/xmonad/xmonad/blob/master/INSTALL.md

-- Imports
import XMonad
import System.IO
import XMonad.Config.Xfce
import XMonad.Config.Desktop
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import XMonad.Util.Cursor
import XMonad.Util.Paste
import XMonad.Util.EZConfig
import XMonad.Util.WindowProperties
import XMonad.Actions.FloatKeys
import XMonad.Layout.Spiral
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
-- import XMonad.Layout.AvoidFloats
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.WindowSwallowing
import Control.Monad (liftM2)

-- Window rules
myManageHook = composeAll
    [ className =? "Brave-browser"          --> doShift "web"
    , className =? "DesktopEditors"         --> viewShift "office"
    , className =? "Xfce4-settings-manager" --> viewShift "settings"
    , className =? "Emacs"                  --> viewShift "office"
    , className =? "Oblogout"               --> doFloat
    , className =? "st256color"             --> doIgnore
    -- , className =? "mpv"                    --> doIgnore
    , title =? "xfdashboard"                --> doFullFloat
    --, className =? "xfce4-panel"            --> doIgnore
    , className =? "mode-line-flame"        --> doIgnore
    , isFullscreen                          --> doFullFloat
    , manageHook desktopConfig
    , manageDocks
    ]
    where viewShift = doF . liftM2 (.) W.greedyView W.shift

-- Workspaces
myWorkspaces :: [String]
myWorkspaces = ["term","web","office","settings","5","6","7","8","9"]

myTerminal :: String
myTerminal = "alacritty"

myStartupCmd :: String
myStartupCmd = "notify-send 'xmonad reloaded' && alacritty"

-- theEmacs :: String

myLayout = (
  spacingWithEdge 10 .
    smartBorders .
    avoidStruts $ spiral (6/7)
  )

mySwallowHook = swallowEventHook ( className =? "Alacritty" ) ( return True )

myBordersToggle = (sendMessage ToggleStruts <+>
                   toggleWindowSpacingEnabled <+>
                   toggleScreenSpacingEnabled)

-- keybindings (see ~/.config/sxhkd/sxhkdrc for more)
myKeys :: XConfig l -> M.Map (KeyMask, KeySym) (X ()) 
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList
    [ ((modMask, xK_u), withFocused (keysMoveWindow (0, 10)) )
    , ((modMask, xK_i), withFocused (keysMoveWindow (0, -10)) )
    , ((modMask, xK_y), withFocused (keysMoveWindow (-10, 0)) )
    , ((modMask, xK_o), withFocused (keysMoveWindow (10, 0)) )
    , ((modMask, xK_b), myBordersToggle)
    , ((modMask, xK_Return), spawn myTerminal)
    , ((modMask, xK_e), spawn "emacsclient -nc -a emacs")
    , ((modMask, xK_w), spawn "brave-browser")
    , ((modMask, xK_Escape), spawn "xkill")
    , ((modMask, xK_slash), spawn "xfdashboard")
    , ((modMask, xK_f), (sendMessage $ Toggle FULL))
    , ((modMask, xK_1), spawn "xtransition.sh 0")
    , ((modMask, xK_2), spawn "xtransition.sh 1")
    , ((modMask, xK_3), spawn "xtransition.sh 2")
    , ((modMask, xK_4), spawn "xtransition.sh 3")
    , ((modMask, xK_5), spawn "xtransition.sh 4")
    , ((modMask, xK_6), spawn "xtransition.sh 5")
    , ((modMask, xK_7), spawn "xtransition.sh 6")
    , ((modMask, xK_8), spawn "xtransition.sh 7")
    , ((modMask, xK_9), spawn "xtransition.sh 8")
    -- , ((0, xK_Super_L), sendKey noModMask xK_Escape )
    -- , ((0, xK_Escape), sendKey mod4Mask xK_Super_L <+> sendKey noModMask xK_Escape)
    ]

-- main defs: start with XFCE defaults and throw in all the above.
main :: IO ()
main = do
  xmonad $ ewmhFullscreen $ ewmh -- $ ewmhDesktops
    desktopConfig
    { modMask    = mod4Mask
    , terminal   = myTerminal
    , manageHook = myManageHook
    , workspaces = myWorkspaces
    , keys       = myKeys <+> keys xfceConfig
    , layoutHook = myLayout
    , handleEventHook = mySwallowHook <+>
                        -- ewmhDesktopsEventHook <+>
                        handleEventHook def -- <+> 
    , startupHook = -- ewmhDesktopsStartup <+>
        spawn myStartupCmd
    }
