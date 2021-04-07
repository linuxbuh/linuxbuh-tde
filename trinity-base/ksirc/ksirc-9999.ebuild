# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_MODULE_NAME="tdenetwork"
inherit trinity-meta-2

DESCRIPTION="Trinity irc client"
IUSE="ssl"

RDEPEND="dev-lang/perl
	ssl? ( dev-perl/IO-Socket-SSL )"
