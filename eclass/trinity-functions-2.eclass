# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

#
# Original Author: Alexander Golubev (Fat-Zer)
# Ported to git-r3 eclass and EAPI7 by E. Liddell
# Purpose: Basic Trinity eclass functions and variables
#

inherit multilib

TRINITY_LIVEVER="14.1.0"

# @FUNCTION: set-trinityver
# @USAGE: < version >
# @DESCRIPTION:
# Sets the right TRINITY_VER, TDEDIR etc...
# !!! unfinished
set-trinityver() {
	debug-print-function ${FUNCNAME} "${@}"
	[[ ${BUILD_TYPE} == live ]] && return

	# Set install location:
	# - The third party applications and libraries go into /usr, and have SLOT="0".
	# - The Trinity related applications and libraries go into /usr/trinity/${TRINITY_VER},
	#   and have SLOT="${TRINITY_VER}".
	# - This function exports ${PREFIX} (location to install to) and ${TDEDIR}
	#   (location of tdelibs to link against) for all ebuilds.

	# Get version elements
	if [[ -n "${1}" ]]; then
		ETRINITY_VER="${1}"
	else
		ETRINITY_VER="${PV}"
	fi

	case "${ETRINITY_VER}" in
		9999 )
			export TRINITY_VER="$(ver_cut 1 "${TRINITY_LIVEVER}" )" ;;
		* )
			export TRINITY_VER="$(ver_cut 1 "${ETRINITY_VER}" )" ;;
	esac

	export TDEDIR="/usr/trinity/${TRINITY_VER}"
	export TDEDIRS="/usr/trinity/${TRINITY_VER}"

	# This should solve problems like "cannot find libraries",
	# especially when compiling tdelibs.
	# NOTE: Binaries which run during compilation and try to load shared
	#       libraries from the TDE directory (which may be broken) may still
	#	break compilation of tdelibs(?)
	# TODO: fix that issue for tdelibs
	adjust-trinity-paths
}

# @FUNCTION: get-trinity-libdirs
# @USAGE:
# @DESCRIPTION:
# Lists all the trinity library directories.
get-trinity-libdirs() {
	local rv
	for libdir in $(get_all_libdirs); do
		echo "${TDEDIR}/${libdir}"
	done
}

# @FUNCTION: adjust-trinity-paths
# @USAGE: < version >
# @DESCRIPTION:
# Adjusts PATH and LD_LIBRARY_PATH to see only current trinity version.
adjust-trinity-paths() {
	debug-print-function ${FUNCNAME} "${@}"
	local libdir

	# This function can be called during depend phase so we shouldn't use sed here
	PATH="$(trinity_remove_path_component "${PATH}" "/usr/trinity/*/bin")"
	PATH="$(trinity_remove_path_component "${PATH}" "/usr/trinity/*/sbin")"
	PATH="$(trinity_prepand_path_component "${PATH}" "${TDEDIR}/bin" )"

	LD_LIBRARY_PATH="$(trinity_remove_path_component "${LD_LIBRARY_PATH}" "/usr/trinity/*/${libdir}")"
	for libdir in $(get-trinity-libdirs); do
		LD_LIBRARY_PATH="$(trinity_prepand_path_component "${LD_LIBRARY_PATH}" "${libdir}" )"
	done

	export PATH
	export LD_LIBRARY_PATH

	# Unset home paths so applications wouldn't try to write to root's dir while building
	unset TDEHOME
	unset TDEROOTHOME
}

trinity_remove_path_component() {
	local i new_path path_array

	IFS=: read -ra path_array <<< "${1}"
	for i in "${path_array[@]}"; do
		case "${i}" in
			${2} ) ;; # delete specyfied entry
			"" ) ;;
			* ) new_path="${new_path}:${i}" ;;
		esac
	done

	echo "${new_path#:}"
}

trinity_prepand_path_component() {
	local new_path

	new_path="${2%:}:${1#:}"
	echo "${new_path%:}"
}

# @FUNCTION: need-trinity
# @USAGE: < version >
# @DESCRIPTION:
# Sets the correct DEPEND and RDEPEND for the needed trinity < version >.
need-trinity() {
	debug-print-function ${FUNCNAME} "${@}"
	[[ ${BUILD_TYPE} == live ]] && return

	local my_depend

	# determine install locations
	set-trinityver ${1}
	adjust-trinity-paths

	my_depend="~trinity-base/tdelibs-${PV}"

	DEPEND+=" ${my_depend}"
	RDEPEND+=" ${my_depend}"
}

# @FUNCTION: need-arts
# @USAGE: need-arts <yes|optional>
# @DESCRIPTION:
# This function adds DEPENDs for aRTs support.
# Possible arguments are 'yes' and 'optional' 'yes' means arts is required, 'optional' results in USE flag arts.
# NOTE: This function modifies IUSE DEPEND and RDEPEND variables, so if you call it before setting
#       those variables don't forget to include the previously set value when you set them again.
need-arts() {
	debug-print-function ${FUNCNAME} "${@}"

	local arts tdelibs my_depend

	[[ -z "${1}" ]] && die "${FUNCNAME} requires an argument"

	TRINITY_NEED_ARTS="${1}"

	tdelibs="~trinity-base/tdelibs-${PV}"
	arts="~trinity-base/arts-${PV}"

	# Handle trinity-base/tdelibs in special way
	if [[ "${CATEGORY}/${PN}" == "trinity-base/tdelibs" ]]; then
		if [[ "${1}" == "optional" ]]; then
			my_depend=" arts? ( ${arts} )"
			IUSE+=" arts"
		else
			die "aRts support for ${tdelibs} supposed to be optional"
		fi
	else
		case "${1}" in
			yes) my_depend=" ${arts}
					${tdelibs}[arts]" ;;
			optional) my_depend=" arts? ( ${arts}
					${tdelibs}[arts] )"
				IUSE+=" arts" ;;
			*) die "bad parameter: ${1}"
		esac
	fi

	DEPEND+=" ${my_depend}";
	RDEPEND+=" ${my_depend}";
}

trinity_l10n_for_each_locale_do() {
	local locs x

		for x in ${TRINITY_LANGS}
		do
			if has ${x} ${L10N} ; then
				locs+=" ${x}"
			fi
		done

	for x in ${locs}; do
		"${@}" ${x} || die "failed to process enabled ${x} locale"
	done
}

trinity-admin-prepare() {
        pushd "${PWD}/admin"
        libtoolize -c || die "Error libtoolize"
        cp -Rp /usr/share/aclocal/libtool.m4 "libtool.m4.in" || die "No such file: libtool.m4"
	cp -Rp /usr/share/libtool/build-aux/config.* . || die
        popd
}

trinity-gen-configure() {
        trinity-admin-prepare
        emake -f admin/Makefile.common || die "Error creating configuration"
}

trinity-econf() {
        local myconf
        myconf=(--prefix="${TDEDIR}"
                --bindir="${TDEDIR}/bin"
                --datadir="${TDEDIR}/share"
                --includedir="${TDEDIR}/include"
                --libdir="${TDEDIR}/$(get_libdir)"
                --disable-dependency-tracking
                --enable-new-ldflags
                --enable-final
                --enable-closure
                --enable-rpath)

        if has "debug" ${IUSE} || has "-debug" ${IUSE} || has "+debug" ${IUSE}; then
                use debug &&  myconf+=(--enable-debug=yes) || myconf+=(--disable-debug)
        else
                 myconf+=(--disable-debug)
        fi

        if [[ "${TRINITY_NEED_ARTS}" == "yes" ]]; then
                echo "configure ${myconf[@]} $@"
                ./configure ${myconf[@]} $@ || die "Error creating configuration"
        elif [[ "${TRINITY_NEED_ARTS}" == "optional" ]]; then
                use arts || myconf+=(--without-arts)
                echo "./configure ${myconf[@]} $@"
                build_arts=$(usex arts yes no) ./configure ${myconf[@]} $@ || die "Error creating configuration"
        else
                myconf+=(--without-arts)
                echo "./configure ${myconf[@]} $@"
                build_arts=no ./configure ${myconf[@]} $@ || die "Error creating configuration"
        fi
}
