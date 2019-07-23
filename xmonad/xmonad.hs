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

main = xmonad (docks (ewmh myConfig))

-- ewmh is required to make things like xdotool work
myConfig = defaultConfig {
      terminal   = "st"        ,
      workspaces = myWorkspaces,
      keys       = myKeys      ,

      -- Fix Java crappiness and check keymap for parse errors
      startupHook = ewmhDesktopsStartup >> setWMName "LG3D",
                                        -- >> checkKeymap myConfig (myKeys myConfig),

      -- Use super key as modifier
      modMask = mod4Mask,

      layoutHook = myLayoutHook,
      manageHook = myManageHook,

      -- Prettyness
      normalBorderColor  = "#666666",
      focusedBorderColor = "#6666CC",
      borderWidth        = 1        }

myWorkspaces = map fst workspaceWindows

workspaceWindows = [("1:Term" , ["lxterminal", "Lxterminal", "st-256color"]),
                    ("2:Emacs", ["emacs", "Emacs"                         ]),
                    ("3:Mail" , ["Buddy List"                             ]),
                    ("4:Misc" , [                                         ]),
                    ("5:Web"  , ["Firefox", "Google-chrome", "Chromium",
                                 "Chromium-browser", "chromium-browser"] ++
                                 conkerorClasses                           ),
                    ("6:Music", [                                         ]),
                    ("7:Seven", [                                         ]),
                    ("8:Notes", ["basket", "Basket"                       ]),
                    ("9:Nine" , [                                         ])]

myKeys c = mkKeymap c customKeys      `M.union`
           mkKeymap c copyToWorkspace `M.union`
           keys defaultConfig c

customKeys = [("M-<Left>",  nextScreen),          -- Toggle between 2 screens
              ("M-<Right>", nextScreen),          -- Toggle between 2 screens
              ("M-s",       windows copyToAll),   -- Sticky
              ("M-S-s",     killAllOtherCopies),  -- Unsticky
              ("M-p",       spawn runner)]        -- Run command prompt

runner = "rofi -show combi window,run"

-- Duplicate a window onto another workspace, e.g. copy to workspace 3
copyToWorkspace = map makeKey [1..length myWorkspaces]
  where doCopy  num windowSet = copy (map W.tag (W.workspaces windowSet) !! num)
                                     windowSet
        makeKey num           = ("M-S-C-" ++ show num, windows (doCopy (num - 1)))

-- How to lay out the windows on a workspace
myLayoutHook = avoidStruts $ layoutHook defaultConfig

-- What to do when new windows are created
myManageHook = manageHook defaultConfig <+>
               composeAll (concat [ignore, classMap, titleMap, floats, fullscreen])
  where classMap = [ className =? c --> doShift w
                   | (w, cs) <- workspaceWindows
                   , c       <- cs
                   ]

        titleMap = [ title =? t --> doShift w
                   | (w, ts) <- workspaceWindows
                   , t       <- ts
                   ]

        floats = [className =? c --> doCenterFloat |
                  c <- ["MPlayer", "Xmessage", "XFontSel", "krunner"]]

        ignore = [resource =? r --> doIgnore |
                  r <- ["desktop", "desktop_window", "notify-osd",
                        "stalonetray", "trayer"]]

        -- Fullscreen which still allows focusing of other windows
        fullscreen = [definitelyFullscreen  --> doF W.focusDown <+> doFullFloat]

conkerorClasses = ["conkeror", "Conkeror", "Navigator"]

definitelyFullscreen = do
  full <- isFullscreen
  conk <- or <$> (sequence [className =? c | c <- conkerorClasses])
  return (full && not conk)
