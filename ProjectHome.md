There's times when Gentoo devs does not react in timely manner or does not react at all and there is no way to convience them. But we need new ebuilds, functions and stuff. Therefore here I will be make my ebuilds. When proposed changes will be accepted by devs this overlay will be ceased.

# To start using my overlay #

Install layman if you doesn't have it yet:
```
# emerge layman
```
Add [my overlay list](http://barzog-gentoo-overlay.googlecode.com/files/barzog-overlay.xml) to `/etc/layman/layman.cfg`, it should looks this way:
```
overlays : http://www.gentoo.org/proj/en/overlays/repositories.xml
           http://barzog-gentoo-overlay.googlecode.com/files/barzog-overlay.xml
```
then you should fetch list of available overlays and add my overlay:
```
# layman -L 
# layman -a barzog-overlay
```
To sync my overlay you can either manually run ` # layman -S ` each time you run ` # emerge --sync` or you can use eix utility.
Install eix if you doesn't have it yet:
```
# emerge eix
```
Configure eix to sync all layman's overlays automatically:
```
# echo "*" >> /etc/eix-sync.conf
```
Now you can sync portage, sync layman overlays and update eix database with single command:
```
# eix-sync
```

# About ebuild in overlay #
  1. nginx with aio and realip support. Corresponding PR [here](http://bugs.gentoo.org/show_bug.cgi?id=300619).
  1. Auhen::Radius and Data::HexDump perl modules. Corresponding PR [here](http://bugs.gentoo.org/show_bug.cgi?id=252131).
  1. MySQL-zrm. Corresponding PR [here](http://bugs.gentoo.org/show_bug.cgi?id=164850).
  1. mwlib-ext. Corresponding PR [here](http://bugs.gentoo.org/show_bug.cgi?id=294168).
  1. flow-tools. Corresponding PR [here](http://bugs.gentoo.org/show_bug.cgi?id=347591).
  1. Updated isc dhcpd server. Corresponding PR [here](http://bugs.gentoo.org/show_bug.cgi?id=295637).
  1. perf for kernels 2.6.32 (its LTS-kernel, I've don't understand why gentoo dev does not keep it in portage tree).
  1. fprobe-ulog. Corresponding PR [here](http://bugs.gentoo.org/show_bug.cgi?id=150563).
  1. ftputil. Corresponding PR [here](http://bugs.gentoo.org/show_bug.cgi?id=318853).
  1. ifenslave. Corresponding PR [here](http://bugs.gentoo.org/show_bug.cgi?id=345741).
  1. verlihub. Correspongnd PR [here](http://bugs.gentoo.org/show_bug.cgi?id=60564).
  1. xbtt. Corresponding PR [here](http://bugs.gentoo.org/show_bug.cgi?id=324447).