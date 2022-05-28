-- xmonad configuration file, for compiling into xmonad

-- for dependencies and compiling info see https://github.com/xmonad/xmonad/blob/master/INSTALL.md

-- Imports
import XMonad
import System.IO
import XMonad.Config.Xfce
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import XMonad.Util.Cursor
import XMonad.Util.EZConfig
import XMonad.Actions.FloatKeys
import XMonad.Layout.Spiral
import XMonad.Layout.Spacing
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
    , className =? "mpv"                    --> doIgnore
    , className =? "xfdashboard"            --> doFloat
    --, className =? "xfce4-panel"            --> doIgnore
    , className =? "mode-line-flame"        --> doIgnore
    ]
    where viewShift = doF . liftM2 (.) W.greedyView W.shift

-- Workspaces
myWorkspaces :: [String]
myWorkspaces = ["term","web","office","settings","5","6","7","8","9"]

myTerminal :: String
myTerminal = "alacritty"

myStartupCmd :: String
myStartupCmd = "notify-send 'xmonad reloaded' && alacritty"

theEmacs :: String
theEmacs = "emacsclient -n -a /usr/bin/emacs"

myLayout = spacingWithEdge 10 $
  avoidStruts $
  spiral (6/7)

mySwallowHook = swallowEventHook ( className =? "Alacritty" ) ( return True )

myBordersToggle = (sendMessage ToggleStruts <+>
                   toggleWindowSpacingEnabled <+>
                   toggleScreenSpacingEnabled)

theManageHooks = myManageHook <+> manageHook xfceConfig <+> manageDocks

-- keybindings (see ~/.config/sxhkd/sxhkdrc for more)
myKeys :: XConfig l -> M.Map (KeyMask, KeySym) (X ()) 
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList
    [ ((modMask, xK_u), withFocused (keysMoveWindow (0, 10)) )
    , ((modMask, xK_i), withFocused (keysMoveWindow (0, -10)) )
    , ((modMask, xK_y), withFocused (keysMoveWindow (-10, 0)) )
    , ((modMask, xK_o), withFocused (keysMoveWindow (10, 0)) )
    , ((modMask, xK_b), myBordersToggle)
    , ((modMask, xK_Return), spawn myTerminal)
    , ((modMask, xK_e), spawn theEmacs)
    , ((modMask, xK_w), spawn "brave-browser")
    , ((modMask, xK_Escape), spawn "xkill")
    ]

-- main defs: start with XFCE defaults and throw in all the above.
main :: IO ()
main = do
      xmonad $ ewmhFullscreen -- ewmh
        xfceConfig
        { modMask    = mod4Mask
        , terminal   = myTerminal
        , manageHook = theManageHooks
        , workspaces = myWorkspaces
        , keys       = myKeys <+> keys xfceConfig
        , layoutHook = myLayout
        , handleEventHook = mySwallowHook <+>
                        -- ewmhDesktopsEventHook <+>
                        handleEventHook def -- <+> 
        , startupHook = -- ewmhDesktopsStartup <+>
                        spawn myStartupCmd
        }
