# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit pam

DESCRIPTION="pam.d files used by several Trinity components"
HOMEPAGE="https://trinitydesktop.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ~ia64 ~mips ppc ppc64 sparc x86"
IUSE="elogind"

DEPEND="sys-libs/pam"
RDEPEND="${DEPEND}"
