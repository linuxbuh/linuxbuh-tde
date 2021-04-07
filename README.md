### This is the official Trinity Gentoo overlay from the TDE team. ###

Currently it only supports the latest master branch, which means live version, which is R14.1.x as of writing (9999 ebuilds), which some TDE team members are using in private life too, so it should be not perfect, but stable for the most part and also Gentoo users are very invited to test and report bugs to TGW and so to be some part of TDE. This choice is also made because of realism that otherwise the maintenance burden would be most likely too hard for this overlay. So it is better to support one version, but that good instead of mutiple versions which are more likely to break here and there.

But there are also current efforts to support the stable branch of TDE (R14.0.x - R14.0.6/R14.0.7 as of writing), which is currently still under heavy work and will need some time. The support of v3.5.x was removed completely with the clean up progress, because it is too old now.

At the moment this overlay can only offer a certain set of the TDE packages, but ebuilds for other TDE applications can and will be added more or less regulary. At least that is the plan.

The current main work is more or less about porting the whole overlay to EAPI7 fully and away from EAPI5 and to clean it up and bring it in a healthy state again.

This overlay is largely based on the very good and hard work of Fat-Zer who created and maintained this overlay many years, to a time when Gentoo users had no other choice for TDE had no official overlay for Gentoo users. This base was later ported by E. Liddell to use the newer git-r3.eclass and newer, EAPI7 complicant trinity eclasses. It also tries to be some central place, in which all goods of other floating around TDE overlays should be centralized. So everyone is welcome to contribute to it, just with creating some PR in TGW.

**Please don't report bugs to the Gentoo bugzilla or Fat-Zer and instead of this, report issues at this repository.**

The overlay will be filled with ebuilds of ported to CMake programs from the Trinity Project mainly and that is the goal, but while the CMake conversion of TDE is still in work and will be for some time, it will most likely offer also ebuilds of TDE applications not already converted to CMake and using autotools instead still.

With the change to EAPI7, ``` ninja ``` is the default for building TDE instead of make (with EAPI5). This can results in a lot of faster builds and proved at least for the packages provided by the overlay, to cause no building breakage, but it is possible. If you still want to use ``` make ```, you can just set ``` CMAKE_MAKEFILE_GENERATOR="emake" ``` with your emerge command, to build with make again.

Another goal is to offer also custom versions of specific libraries like ``` libsdl ```,``` xine-lib ``` or ``` pinentry ```, with added support for ``` TDE/TQt ``` and ``` aRts ```, for example, which is deactivated from the official Gentoo ebuilds or to preserve ebuilds related to TDE and/or TQt, which were removed from Portage.

**So the hope is, we can get the good old user experience of a KDE3 (now TDE) based Gentoo back and get back control, like it was until 2008.**

While the goal is that this overlay works out the box without any problems, there can't be any guarantee for that and you might expect some problems from time to time, if there are Gentoo or TDE specific changes, for example. If so, you are free to open some issue in TGW to the tde-packaging-gentoo repo about that and maybe the problem can be fixed in some time. The overlay is maintained by best efforts, which means that it is not tested for absolutely every use case and not tested with every possible library version.

If you are interested in ebuilds for some packages that are not in the overlay or you have any fixes, you can create some PR in TGW and if your work is good, the ebuilds can be added. Also *any* help, from every Gentoo user loving TDE will be highly appreciated.

**You can also join the [TDE IRC channel](https://trinitydesktop.org/support.php) to get in touch with Chris, if you need any further help or want to help out with this overlay.**

Some guideline for this overlay is: **Freedom of choice** for everything. There should be in no case any forced or hardcoded USE flags, to build in any optional support some Gentoo users don't want to have or want on their systems. All building options TDE is offering, should be reflected by this overlay. But keep in mind things *can* break.

-----

### How to add this overlay to Gentoo and install TDE? ###

#### For the git way of sync just use: ####

``` layman -o https://mirror.git.trinitydesktop.org/gitea/TDE/tde-packaging-gentoo/raw/branch/master/Documentation/overlay.xml -f -a trinity-official ```

#### For the rsync way of sync just use: ####

``` layman -o https://mirror.git.trinitydesktop.org/gitea/TDE/tde-packaging-gentoo/raw/branch/master/Documentation/overlay-rsync.xml -f -a trinity-official ```

Add all keywords from the ``` trinity.live.keywords ``` file to your setup, if you want to use the live ebuilds, so the packages can be installed without any problems. If there are still missing ones, just add them too.

After that just run ``` emerge -av trinity-base/tdebase-meta ```, which should pull in all you need to end up with a slim TDE desktop, just like in good old Gentoo KDE3 days. If you need more, just look what the overlay offers at the moment and have fun.

If you want to use TDM (KDM replacement of TDE), just don't forget to change ``` /etc/conf.d/xdm ``` to use ``` tdm ```.

-----

### Re-building TDE live ebuilds: ###

From time to time it is an good idea to update your TDE live install, because as it is build from [master branch](https://mirror.git.trinitydesktop.org/patches/), there are changes nearly every day. If you don't know how this changes are related and your last re-build was some time ago, the best is to rebuild TDE fully. You can simply do that with the following chain of commands. First make sure you have emerged ``` gentoolkit ``` and use that command that should re-build nearly all TDE related packages:

``` emerge -av1 tqt tqtinterface dbus-1-tqt arts tdelibs && emerge -av1 `equery depends tdelibs|awk '{print " ="$1}'` ```

That should bring your TDE install in a fairly consistent state again.

If you have still problems, try to rebuild lacking packages.

### Updating translations of TDE with the live ebuilds: ###

The good thing about the live ebuilds is, you can always install the latest translations, if you have some active translator for your language working on TDE, you can instantly profit from that new translations.

Just use: ``` emerge --oneshot tde-i18n ```

With that, you will have the latest translations at least for all the TDE core stuff, like tdebase, tdegraphics, tdenetwork and so on.

New translations are merged from Weblate nearly all three days into the [master branch](https://mirror.git.trinitydesktop.org/patches/).

-----

### Working on TDE under Gentoo with the live ebuilds: ###

That above is also just some example of how handy it can be to use Gentoo also for TDE development. Maybe you want to [contribute](https://wiki.trinitydesktop.org/TDE_Gitea_Workspace) to TDE and work on some things? Or you want to to improve the translation of it? You can profit instantly from your work, if the work was already merged. Just rebuild that package and enjoy! If you want to fix or add some translations, you can join [TWTW](https://mirror.git.trinitydesktop.org/weblate) and some days later, you can enjoy your changes on your system already after re-building the ``` tde-i18n ``` package.

#### If you have some working branch of a specific package at TGW, you can just tell emerge to check out that by adding: ####

* EGIT_OVERRIDE_REPO_GITEA_TDE_*
* EGIT_OVERRIDE_BRANCH_GITEA_TDE_*
* EGIT_OVERRIDE_COMMIT_GITEA_TDE_*
* EGIT_OVERRIDE_COMMIT_DATE_GITEA_TDE_*

before your ``` emerge ``` command.

Where the ``` * ``` at the end stands for the component you are going to emerge from, like ``` TDELIBS ``` and the branch you can get from some PR, you may want to test, can be added by:

``` EGIT_OVERRIDE_BRANCH_GITEA_TDE_TDELIBS="fix/crash" ```, for example.
