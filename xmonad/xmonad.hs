import XMonad

import qualified Data.Map as M
import           Data.Ratio ((%))
import           System.Exit
import           System.IO
import           XMonad
import           XMonad.Actions.CopyWindow
import           XMonad.Actions.CycleWS
import           XMonad.Actions.PhysicalScreens
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.FadeInactive
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.ManageHelpers
import           XMonad.Hooks.SetWMName
import           XMonad.Hooks.UrgencyHook
import           XMonad.Layout.Grid
import           XMonad.Layout.IM
import           XMonad.Layout.LayoutHints
import           XMonad.Layout.LayoutModifier
import           XMonad.Layout.NoBorders (smartBorders, noBorders)
import           XMonad.Layout.PerWorkspace (onWorkspace, onWorkspaces)
import           XMonad.Layout.Reflect (reflectHoriz)
import           XMonad.Layout.ResizableTile
import           XMonad.Layout.SimpleFloat
import           XMonad.Layout.Spacing
import           XMonad.Operations
import           XMonad.Prompt
import           XMonad.Prompt.AppendFile (appendFilePrompt)
import           XMonad.Prompt.RunOrRaise (runOrRaisePrompt)
import qualified XMonad.StackSet as W
import           XMonad.Util.Run
import           XMonad.Util.EZConfig

main = do
    -- ewmh is required to make things like xdotool work
    xmonad $ ewmh $ defaultConfig {
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

myKeys c = mkKeymap c customKeys      `M.union`
           mkKeymap c copyToWorkspace `M.union`
           keys defaultConfig c

customKeys = [("M-<Left>",  nextScreen),          -- Toggle between 2 screens
              ("M-<Right>", nextScreen),          -- Toggle between 2 screens
              ("M-s",       windows copyToAll),   -- Sticky
              ("M-S-s",     killAllOtherCopies)]  -- Unsticky

-- Duplicate a window onto another workspace, e.g. copy to workspace 3
copyToWorkspace = map makeKey [1..length myWorkspaces]
  where doCopy  num windowSet = copy (map W.tag (W.workspaces windowSet) !! num)
                                     windowSet
        makeKey num           = ("M-S-C-" ++ show num, windows (doCopy (num - 1)))

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
