import XMonad
import XMonad.Prompt
import XMonad.Prompt.RunOrRaise (runOrRaisePrompt)
import XMonad.Prompt.AppendFile (appendFilePrompt)
import XMonad.Operations
import System.IO
import System.Exit
import XMonad.Util.Run
import XMonad.Actions.CycleWS
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.NoBorders (smartBorders, noBorders)
import XMonad.Layout.PerWorkspace (onWorkspace, onWorkspaces)
import XMonad.Layout.Reflect (reflectHoriz)
import XMonad.Layout.IM
import XMonad.Layout.SimpleFloat
import XMonad.Layout.Spacing
import XMonad.Layout.ResizableTile
import XMonad.Layout.LayoutHints
import XMonad.Layout.LayoutModifier
import XMonad.Layout.Grid
import Data.Ratio ((%))
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Actions.PhysicalScreens
import qualified Data.Map as M
import qualified XMonad.StackSet as W

main = do
    dzenLeftBar  <- spawnPipe myXmonadBar
    xmonad $ ewmh defaultConfig {
      terminal            = myTerminal           ,
      workspaces          = myWorkspaces         ,
      keys                = myKeys               ,
      modMask             = myModMask            ,
      layoutHook          = myLayoutHook         ,
      manageHook          = myManageHook         ,
      logHook             = myLogHook dzenLeftBar,
      normalBorderColor   = colorNormalBorder    ,
      focusedBorderColor  = colorFocusedBorder   ,
      borderWidth         = 1                    }

myTerminal = "lxterminal"

myWorkspaces = ["1:Term" ,
                "2:Emacs",
                "3:Mail" ,
                "4:SVN"  ,
                "5:Web"  ]

myKeys = keys defaultConfig

-- Use Super key as mod
myModMask = mod4Mask

-- How to lay out the windows on a workspace
myLayoutHook = avoidStruts $ layoutHook defaultConfig

-- What to do when new windows are created
myManageHook = manageHook defaultConfig <+> manageDocks <+> extras
               where extras = composeAll . concat $ [
                       -- Ignore these
                       [resource     =? r --> doIgnore          | r <- ignore],
                       -- Put terminals on 1
                       [className    =? c --> doShift "1:Term"  | c <- terms ],
                       -- Put Emacs on 2
                       [className    =? c --> doShift "2:Emacs" | c <- emacs ],
                       -- Put SVN on 4
                       [className    =? c --> doShift "4:SVN"   | c <- svn   ],
                       -- Put browsers on 5
                       [className    =? c --> doShift "5:web"   | c <- webs  ],
                       -- Floating windows
                       [className    =? c --> doCenterFloat     | c <- floats],
                       -- float my names
                       [name         =? n --> doCenterFloat     | n <- names ],
                       -- Fullscreen windows
                       [isFullscreen      --> myDoFullFloat                  ]]

                     -- Predicates
                     role = stringProperty "WM_WINDOW_ROLE"
                     name = stringProperty "WM_NAME"

                     -- Classes
                     terms  = ["lxterminal", "Lxterminal"]
                     emacs  = ["emacs", "Emacs"]
                     webs   = ["Firefox", "Google-chrome", "Chromium",
                              "Chromium-browser", "chromium-browser"]
                     svn    = ["kdesvn", "Kdesvn"]
                     floats = ["MPlayer", "Xmessage", "XFontSel"]

                     -- Resources
                     ignore = ["desktop", "desktop_window", "notify-osd",
                               "stalonetray", "trayer"]

                     -- Names
                     names = []

                     -- Fullscreen which still allows focusing of other windows
                     myDoFullFloat :: ManageHook
                     myDoFullFloat = doF W.focusDown <+> doFullFloat

myLogHook :: Handle -> X ()
myLogHook  h = myLogHook' h >> fadeInactiveLogHook 0xdddddddd
myLogHook' h = dynamicLogWithPP $ defaultPP {
                 ppCurrent           =   dzenColor "#ebac54" "#1B1D1E" . pad,
                 ppVisible           =   dzenColor "white"   "#1B1D1E" . pad,
                 ppHidden            =   dzenColor "white"   "#1B1D1E" . pad,
                 ppHiddenNoWindows   =   dzenColor "#7b7b7b" "#1B1D1E" . pad,
                 ppUrgent            =   dzenColor "#ff0000" "#1B1D1E" . pad,
                 ppWsSep             =   " ",
                 ppSep               =   "  |  ",
                 ppLayout            =   dzenColor "#ebac54" "#1B1D1E",
                 ppTitle             =   (" " ++) . dzenColor "white" "#1B1D1E" . dzenEscape,
                 ppOutput            =   hPutStrLn h}

myXmonadBar = "dzen2 -x '1440' -y '0' -h '24' -w '640' -ta 'l' -fg '#FFFFFF' -bg '#1B1D1E'"
colorNormalBorder   = "#666666"
colorFocusedBorder  = "#6666CC"
