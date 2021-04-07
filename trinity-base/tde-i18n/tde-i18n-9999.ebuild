# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_LANGS="af ar az be bg bn br bs ca cs csb cy da de el en_GB eo es et
	eu fa fi fr fy ga gl he hi hr hu is it ja kk km ko lt lv mk mn ms
	nb nds nl nn pa pl pt pt_BR ro ru rw se sk sl sr sr@Latn ss sv ta te
	tg th tr uk uz uz@cyrillic vi wa zh_CN zh_TW"

TRINITY_MODULE_NAME="tde-i18n"
inherit trinity-base-2

DESCRIPTION="Trinity internationalization package"
HOMEPAGE="https://trinitydesktop.org/"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="14"

for X in ${TRINITY_LANGS} ; do
	IUSE="${IUSE} l10n_${X}"
done

run_phase() {
	local lang dir phase;
	phase=${1}
	lang=${2}

	dir="tde-i18n-${lang}"
	pushd "${S}/${dir}" || die "No such dir: ${dir}"
	CMAKE_USE_DIR="${S}/${dir}"
	BUILD_DIR="${WORKDIR}/${dir}-build"
	trinity-base-2_${phase}
	popd || die
}

src_prepare() {
	trinity_l10n_for_each_locale_do run_phase src_prepare
	eapply_user
}

src_configure() {
	local mycmakeargs=( -DBUILD_ALL=ON )
	trinity_l10n_for_each_locale_do run_phase src_configure
}

src_compile() {
	trinity_l10n_for_each_locale_do run_phase src_compile
}

src_install() {
	trinity_l10n_for_each_locale_do run_phase src_install
}
