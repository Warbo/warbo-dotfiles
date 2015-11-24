import XMonad

import qualified Data.Map as M
import           Data.Ratio ((%))
import           System.Exit
import           System.IO
import           XMonad
import           XMonad.Actions.CycleWS
import           XMonad.Actions.PhysicalScreens
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.ManageHelpers
import           XMonad.Hooks.SetWMName
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.UrgencyHook
import           XMonad.Hooks.FadeInactive
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Layout.NoBorders (smartBorders, noBorders)
import           XMonad.Layout.PerWorkspace (onWorkspace, onWorkspaces)
import           XMonad.Layout.Reflect (reflectHoriz)
import           XMonad.Layout.IM
import           XMonad.Layout.SimpleFloat
import           XMonad.Layout.Spacing
import           XMonad.Layout.ResizableTile
import           XMonad.Layout.LayoutHints
import           XMonad.Layout.LayoutModifier
import           XMonad.Layout.Grid
import           XMonad.Operations
import           XMonad.Prompt
import           XMonad.Prompt.RunOrRaise (runOrRaisePrompt)
import           XMonad.Prompt.AppendFile (appendFilePrompt)
import qualified XMonad.StackSet as W
import           XMonad.Util.Run
import           XMonad.Util.EZConfig

main = do
    xmonad $ defaultConfig {
      terminal   = "st"        ,
      workspaces = myWorkspaces,
      keys       = myKeys      ,

      -- Fix Java crappiness
      startupHook = ewmhDesktopsStartup >> setWMName "LG3D",

      -- Use super key as modifier
      modMask = mod4Mask,

      layoutHook = myLayoutHook,
      manageHook = myManageHook,

      -- Prettyness
      normalBorderColor  = "#666666",
      focusedBorderColor = "#6666CC",
      borderWidth        = 1        }

myWorkspaces = ["1:Term" , "2:Emacs", "3:Mail" , "4:Misc" , "5:Web",
                "6:Music", "7:Seven", "8:Eight", "9:Nine"          ]

myKeys     c = M.union (customKeys c) (keys defaultConfig c)
customKeys c = mkKeymap c [("M-<Left>",  nextScreen),
                           ("M-<Right>", nextScreen)]

-- How to lay out the windows on a workspace
myLayoutHook = avoidStruts $ layoutHook defaultConfig

-- What to do when new windows are created
myManageHook = manageHook defaultConfig {-<+> manageDocks-} <+> extras
               where extras = composeAll . concat $ [
                       -- Ignore these
                       [resource     =? r --> doIgnore          | r <- ignore],
                       -- Put terminals on 1
                       [className    =? c --> doShift "1:Term"  | c <- terms ],
                       -- Put Emacs on 2
                       [className    =? c --> doShift "2:Emacs" | c <- emacs ],
                       -- Put browsers on 5
                       [className    =? c --> doShift "5:web"   | c <- webs  ],
                       -- Put Basket on 8
                       [className    =? c --> doShift "8:Notes" | c <- notes ],
                       -- Floating windows
                       [className    =? c --> doCenterFloat     | c <- floats],
                       -- Fullscreen windows
                       [definitelyFullscreen --> myDoFullFloat                ]]

                     -- Predicates
                     role = stringProperty "WM_WINDOW_ROLE"
                     name = stringProperty "WM_NAME"

                     -- Classes
                     terms  = ["lxterminal", "Lxterminal", "st-256color"]
                     emacs  = ["emacs", "Emacs"]
                     webs   = ["Firefox", "Google-chrome", "Chromium",
                               "Chromium-browser", "chromium-browser"] ++ conkerorClasses
                     notes  = ["basket"]
                     floats = ["MPlayer", "Xmessage", "XFontSel"]

                     -- Resources
                     ignore = ["desktop", "desktop_window", "notify-osd",
                               "stalonetray", "trayer"]

                     -- Fullscreen which still allows focusing of other windows
                     myDoFullFloat :: ManageHook
                     myDoFullFloat = doF W.focusDown <+> doFullFloat

conkerorClasses = ["conkeror", "Conkeror", "Navigator"]

definitelyFullscreen = do
  full <- isFullscreen
  conk <- or <$> (sequence [className =? c | c <- conkerorClasses])
  return (full && not conk)
