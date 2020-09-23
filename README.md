# Personal Dotfiles

Uses `stow` to manage symlinks.

**Platform Table**
|	       	| Arch Linux| Mac OSX	|
| --------- | --------- | --------- | 
| X		    | [x]		|	    	|
| alacritty	| [x]		| [x]		|
| feh		| [x]		|   		|
| fonts		| [x]		|   		|
| homebrew	| 		    | [x]		|
| i3		| [x]		|   		|
| karabiner	| 	    	| [x]		|
| neofetch	| [x]		| [x]		|
| nvim		| [x]		| [x]		|
| polybar	| [x]		|   		|
| tmux		| [x]		| [x]		|
| zsh		| [x]		| [x]		|

## Arch Linux instructions
### Caps to ctrl & esc
1. install [`xcape`](https://archlinux.org/packages/community/x86_64/xcape)
2. Add to i3 config
```
exec setxkbmap -layout us -option ctrl:nocaps
exec_always xcape -e 'Control_L=Escape'
```

## Mac OSX instructions
### Install Homebrew
(and other utilities you'll need including `stow`)
1. Install homebrew: `/usr/bin/ruby -e "$(curl -fsSL 
   https://raw.githubusercontent.com/Homebrew/install/master/install)"`
2. `brew install stow`
3. `stow homebrew`
4. Install `brew bundle --global`


### Remap Caps Lock to Ctrl/Esc
([THANK YOU Max Pechyonkin](https://medium.com/@pechyonkin/how-to-map-capslock-to-control-and-escape-on-mac-60523a64022b))
  1. Install [Karabiner-Elements](https://pqrs.org/osx/karabiner/) to customize 
     key bindings. (additionally unblock MacOS privacy issues)
  2. `stow karabiner`
  3. Enable rule:
      * Karabiner-elements Preferences > Complex Modifications > Add Rule
      * Enable 'Change caps_lock to Esc and Control'
      * In 'Parameters' change the value of `to_if_alone_timeout_milliseconds` 
       from 1000 to 500 milliseconds.
  4. Remap keys:
      * Karabiner-elements Preferences > Simple Modifications > Add item
      * from Caps Lock to Left Control
      * from Escape to Caps Lock


### [Optional] Latex
1. Install BasicTex `brew cask install basictex`
    * log into new terminal for changes to take place `zsh --login`
2. Update tool manager `sudo tlmgr update --self`
3. Install requisite tools
```
sudo tlmgr install textpos isodate substr titlesec
```
