# Copyright 1999-2017 Gentoo Foundation
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_NAME="tdenetwork"
TRINITY_SUBMODULE="wifi"

inherit trinity-meta-2

need-arts optional

DESCRIPTION="Trinity wifi (wireless network) gui"
KEYWORDS="~amd64 ~x86"

MY_DEPEND="net-wireless/wireless-tools"
DEPEND+=" ${MY_DEPEND}"
RDEPEND+=" ${MY_DEPEND}"
