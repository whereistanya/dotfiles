-- http ://www.haskell.org/haskellwiki/Xmonad/Config_archive
--
-- test correctness with 'xmonad --recompile'; reload with 'xmonad --restart'
import XMonad
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Hooks.SetWMName
import XMonad.Layout.Combo
import XMonad.Layout.ThreeColumns
import XMonad.Layout.TwoPane
import XMonad.Layout.ResizableTile
import Graphics.X11.ExtraTypes.XF86
import System.IO

myManageHook = composeAll
    [ className =? "Gimp"      --> doFloat
    , className =? "Vncviewer" --> doFloat
    ]

-- avoidStruts: leave space for taskbars
-- 1: how many windows in main window
-- 3/100: amount to resize while resizing
-- 1/2: if positive, the fraction of the screen that the main window
--       should occupy, but if negative, the absolute value other columns
--       should occupy.

myLayout = avoidStruts (ThreeCol 1 (3/100) (1/2) ||| ThreeCol 2 (3/100) (1/2) ||| Full ||| Tall 1 (3/100) (1/2))

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/tanya/.xmobarrc"
    xmonad $ defaultConfig
        { manageHook = manageDocks <+> myManageHook
                        <+> manageHook defaultConfig
        , layoutHook = myLayout
        , logHook = dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , startupHook = setWMName "LG3D"  -- this makes android studio work </noideadog>
        , terminal = "xterm"
        }
        `additionalKeys`
        [ ((0, xK_F7), spawn "/usr/bin/gnome-screensaver-command -a")
        , ((0, xK_F8), spawn "/usr/bin/chromium-browser")
        -- Map volume control keys. Uses https://github.com/bchurchill/xmonad-pulsevolume
        , ((0, 0x1008FF12), spawn "/home/tanya/pulse-volume.sh toggle")
        , ((0, 0x1008FF13), spawn "/home/tanya/pulse-volume.sh increase")
        , ((0, 0x1008FF11), spawn "/home/tanya/pulse-volume.sh decrease")
        , ((0, xF86XK_MonBrightnessUp), spawn "xbacklight +20")
        , ((0, xF86XK_MonBrightnessDown), spawn "xbacklight -20")
       ]
