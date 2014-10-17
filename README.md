tinc-on-routers
===============

Configurations for tinc on routers, for bypassing GFW in China. Can
be used to replace OpenVPN solutions.

For HOWTO, please visit: (In Chinese only, contact me if you need it
translated into English)

http://blog.emzee.be/replace-openvpn-with-tinc-tomato-openwrt-ddwrt-bypassing-gfw/

Simple explanations on the files:

`env` and `functions` are some common variables and functions that are
needed for other scripts.

`setup.sh` is for setting up the whole rig for the first time. It's a
quickly hacked script so don't expect it to work well in some other
cases (like running it the second time).

For `tinc.conf`, `tinc-up`, `tinc-down` and the folder `hosts`, please refer to [tinc's website](http://www.tinc-vpn.org/docs/).

`custom_route.sh` is used in `tinc-up` to set up the custom routes
defiend in `custom_host` and `custom_net`.

`custom_host` is for adding address like `173.194.117.137`. `custom_net`
is for adding subnets like `173.194.117.0/24`.

Each file in these two folders will be read. They can be organized in
different files names, so that you can trace which IP maps to which domain.
Lines start with `#` will be skipped.
