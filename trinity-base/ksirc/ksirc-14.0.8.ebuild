# Copyright 1999-2017 Gentoo Foundation
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_NAME="tdenetwork"

inherit trinity-meta-2

DESCRIPTION="Trinity irc client"
KEYWORDS="~amd64 ~x86"
IUSE="ssl"

RDEPEND="dev-lang/perl
	ssl? ( dev-perl/IO-Socket-SSL )"
