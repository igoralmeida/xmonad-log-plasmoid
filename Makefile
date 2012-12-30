zip:
	zip -r ../xmonad-log-plasmoid.zip . -x .git\* -x \*.swp -x Makefile

install: ../xmonad-log-plasmoid.zip
	plasmapkg -i $<

test:
	plasmoidviewer xmonad-log-plasmoid

uninstall:
	plasmapkg -r xmonad-log-plasmoid
