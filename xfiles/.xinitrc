# Load X resources
xrdb -load ~/.Xresources &

xrdb -I$HOME/.colors -merge ~/.Xresources

# custom keybinding
if [ -s ~/.Xmodmap ]; then
  xmodmap ~/.Xmodmap
fi

# let control key serve function of both CTRL and ESC
xcape &

# run wallpaper - custom script
wallpaper &

xsetroot -cursor_name left_ptr &

unclutter &

redshift &

# synchronize primary selection and clipboard
autocutsel -fork &
autocutsel -selection PRIMARY -fork &

wmname LG3D

exec bspwm
