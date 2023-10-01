import Control.Monad
import Text.Printf
import qualified Data.Map as M

import XMonad
import XMonad.ManageHook
import XMonad.StackSet as W

import XMonad.Actions.SpawnOn
import XMonad.Actions.Submap
import XMonad.Actions.UpdatePointer

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.FadeWindows
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.Place
import XMonad.Hooks.SetWMName
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

import XMonad.Layout.LayoutModifier
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing

import XMonad.Util.EZConfig
import XMonad.Util.NamedScratchpad
import XMonad.Util.SpawnOnce

data TerminalArgs = TerminalArgs {
        appNameT :: Maybe String
      , classNameT :: Maybe String
      , backgroundOpacityT :: Maybe Float
      , execT :: Maybe String
      , singleInstanceT :: Bool
    }

instance Default TerminalArgs where
    def = TerminalArgs {
            appNameT = Nothing
          , classNameT = Nothing
          , backgroundOpacityT = Nothing
          , execT = Nothing
          , singleInstanceT = False
        }

terminalCommand "kitty" args = "kitty" ++ foldr (++) "" args'
    where
        args' = map ($ args) [singleInstance, cls, name, backgroundOpacity, exec]

        f <? m = maybe "" f m
        cls TerminalArgs{classNameT = value} =
            printf " --class '%s'" <? value
        name TerminalArgs{appNameT = value} =
            printf " --name '%s'" <? value
        backgroundOpacity TerminalArgs{backgroundOpacityT = value} =
            printf " --override background_opacity=%.1f" <? value
        exec TerminalArgs{execT = value} =
            (" " ++) <? value
        singleInstance TerminalArgs{singleInstanceT = value} =
            if value
                then " -1"
                else ""

draculaTheme c =
    c {
            normalBorderColor = "#424450"
          , focusedBorderColor = "#516291"
          , borderWidth = 1
          , startupHook = do
                spawnOnce "hsetroot -solid '#222430'"
                startupHook c
        }

xmobar =
    ewmh
  . ewmhFullscreen
  . withEasySB (statusBarProp "xmobar" $ pure xmobarPP) defToggleStrutsKey

scratchpads c@XConfig{modMask = modm} =
    c {
           manageHook = namedScratchpadManageHook definition <> manageHook c
        }
    `additionalKeys` [
            ((modm .|. shiftMask, xK_space),
                namedScratchpadAction definition "terminal")
          , ((modm, xK_s), submap . M.fromList $ [
                    ((0, xK_i), namedScratchpadAction definition "irc")
                  , ((0, xK_s), namedScratchpadAction definition "spotify")
                  , ((0, xK_k), namedScratchpadAction definition "keepassxc")
                ])
        ]
    where
        definition = [
                NS "terminal"
                    (terminalCommand (terminal c) factotumTerminal)
                    (appName =? "factotum" <&&> className =? "scratchpad")
                  $ doSpacingFloat 0.5 0.5
              , NS "irc"
                    (terminalCommand (terminal c) ircTerminal)
                    (appName =? "irc" <&&> className =? "scratchpad")
                  $ doSpacingFloat 0.2 0.2
              , NS "keepassxc"
                    keepassCommand
                    (liftM not isDialog <&&> appName =? "keepassxc")
                  $ doSpacingFloat 0.2 0.2
              , NS "spotify"
                    spotifyCommand
                    (appName =? "spotify")
                  $ doSpacingFloat 0.2 0.2
            ]

        factotumTerminal :: TerminalArgs
        factotumTerminal =
            def {
                    classNameT = Just "scratchpad"
                  , appNameT = Just "factotum"
                  , backgroundOpacityT = Just 0.9
                }

        ircTerminal :: TerminalArgs
        ircTerminal =
            def {
                    classNameT = Just "scratchpad"
                  , appNameT = Just "irc"
                  , backgroundOpacityT = Just 0.9
                  , execT = Just "~/scripts/irc.sh"
                }
        keepassCommand = "keepass"
        spotifyCommand = "spotify"

        doSpacingFloat sw sh = customFloating $ W.RationalRect cx cy w h
            where
                cx = (1 - w) / 2
                cy = (1 - h) / 2
                w = 1 - sw
                h = 1 - sh

hooks c =
    fullscreenSupport
  . docks
  $ c {
            startupHook = do
                setWMName "LG3D"
                spawnOnce "picom"
                spawnOnce "nm-applet"
                spawnOnce "blueman-applet"
                startupHook c
          , layoutHook =
                avoidStruts
              . smartBorders
              $ layoutHook c
          , logHook = do
              updatePointer (0.5, 0.5) (0, 0)
              fadeWindowsLogHook transparentWindows
              logHook c
          , manageHook =
                composeAll [
                        floatDialogs
                      , floatWindows
                      , manageHook c
                    ]
        }
    where
        floatDialogs = isDialog --> doCenterFloat
        floatWindows = composeAll [
                 appName =? "feh" --> doCenterFloat
               , appName =? "qjackctl" --> doCenterFloat
               , appName =? "qemu" --> doCenterFloat
            ]
        transparentWindows = composeAll [
                 className =? "scratchpad" --> transparency 0.1
               , appName =? "spotify" --> transparency 0.1
               , appName =? "rofi" --> transparency 0.1
            ]

keyBindings c =
    let modm = mod4Mask in
        c { modMask = modm }

        `additionalKeys` [
                ((modm              , xK_Return), sendMessage NextLayout)
              , ((modm .|. shiftMask, xK_Return), spawn
                  $ terminalCommand (terminal c) def { singleInstanceT = True })
              , ((modm .|. shiftMask, xK_e), sendMessage Shrink)
              , ((modm .|. shiftMask, xK_i), sendMessage Expand)
              , ((modm,               xK_e), windows W.swapDown)
              , ((modm,               xK_i), windows W.swapUp)
              , ((modm,               xK_m), windows W.focusMaster)
              , ((modm .|. shiftMask, xK_m), windows W.swapMaster)
            ]

        `additionalKeys` [
                ((modm, xK_f), spawn "rofi -show window")
              , ((modm, xK_space),
                    spawn "dmenu_run -fn Inconsolata-14 -nb '#000000' -nf '#cccccc'")
            ]

        `additionalKeys` [
                ((modm .|. shiftMask, xK_l), spawn "xset s activate")
            ]

main =
    xmonad
  . xmobar
  . hooks
  . scratchpads
  . keyBindings
  . draculaTheme
  $ def { terminal = "kitty" }
