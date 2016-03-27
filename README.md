#laptasus - ASUS laptop utils

This little project persuits one tagret: to make extra keys somehow work.
I didn't so much power to try to write ACPI driver, or try to patch something.
So, this is intention to fix old problems (thank you, ASUS).

I think about plugins support to make any useful tasks.

#Installation

`$ make && make install`

If you want install to another directory (not /home/$USER/.local), just give it as prefix:

`$ PREFIX=/usr make install` or 
`$ make install PREFIX=/usr`

For uninstall use
`$ make uninstall` or
`$PREFIX=/usr make uninstall`

#Usage
start

send to pipe /tmp/laptasus message in format
subsystem::action::arg1:arg2:arg3

if debug not activated log messages will be
F subsystem action args error\_message


