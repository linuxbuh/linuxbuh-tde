# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

#
# Original Author: fat-zer
# Ported to git-r3 eclass and EAPI7 by E. Liddell
# Purpose: Make it easy to install Trinity ebuilds.
#

inherit trinity-base-2

LICENSE="|| ( GPL-2 GPL-3 )"
HOMEPAGE="http://www.trinitydesktop.org/"

# @FUNCTION: trinity-meta-2_set_trinity_submodule
# @DESCRIPTION:
# Sets the TRINITY_SUBMODULE variable to
# the value obtained from ${PN} if it isn't set yet.
trinity-meta-2_set_trinity_submodule() {
	debug-print-function ${FUNCNAME} "${@}"

	if [[ -z "${TRINITY_SUBMODULE}" ]]; then
		TRINITY_SUBMODULE="${PN#${TRINITY_MODULE_NAME}-}"
	fi
}

# @FUNCTION: trinity-meta-2_src_pkg_setup
# @DESCRIPTION:
# Default pkg_setup function.
# It sets the correct ${S} necessary files.
trinity-meta-2_pkg_setup() {
	debug-print-function ${FUNCNAME} "${@}"
	adjust-trinity-paths

	trinity-meta-2_set_trinity_submodule
}

# @FUNCTION: trinity-meta-2_src_unpack
# @DESCRIPTION:
# Default source extract function.
# It tries to unpack only necessary files.
trinity-meta-2_src_unpack() {
	debug-print-function ${FUNCNAME} "${@}"

	if [[ "${BUILD_TYPE}" == "live" ]]; then
		case "${TRINITY_SCM}" in
			git)
				git-r3_src_unpack
				trinity-meta-2_src_delete
				;;
			*)   die "TRINITY_SCM: ${TRINITY_SCM} is not supported by ${FUNCNAME}" ;;
		esac
	fi
	trinity-meta-2_src_extract
}

# @FUNCTION: trinity-meta-2_src_extract
# @DESCRIPTION:
# A function to extract the source for a split TDE ebuild.
# Also see KMMODULE, KMEXTRACT.
trinity-meta-2_src_extract() {
	debug-print-function ${FUNCNAME} "${@}"

	trinity-meta-2_create_extractlists

	if [[ "${BUILD_TYPE}" == "live" ]]; then
		einfo "Exporting parts of working copy to ${S}"
		case "${TRINITY_SCM}" in
			git) # Nothing we can do to prevent git from unpacking code
				;;
			*)  die "TRINITY_SCM: ${TRINITY_SCM} is not supported by ${FUNCNAME}"
		esac
	else
		local tarfile tarparams f extractlist

		case ${TRINITY_TARBALL} in
			*.gz)
				tarparams=" --gzip"
				;;
			*.xz)
				tarparams=" --xz"
				;;
		esac

		# Full path to source tarball
		tarfile="${DISTDIR}/${TRINITY_TARBALL}"

		# Detect real toplevel dir from tarball name - it will be used upon extraction
		topdir="${TRINITY_TARBALL%.tar.*}"

		ebegin "Unpacking parts of ${TRINITY_TARBALL} to ${WORKDIR}"

		for f in ${TSM_EXTRACT_LIST};	do
			extractlist+=" ${topdir}/${f}"
		done

		tar -xpf "${tarfile}" ${tarparams} -C "${WORKDIR}"  ${extractlist} 2> /dev/null  \
				|| echo "tar extract command failed at least partially - continuing anyway"

		# Make sure ${S} points to right place
		[[ "${WORKDIR}/${topdir}" != "${S}" ]] && S="${WORKDIR}/${topdir}"
	fi
}

# @FUNCTION: trinity-meta-2_rsync_copy 
# @DESCRIPTION:
# Copies files from git repository to ${S}.
trinity-meta-2_rsync_copy() {
	debug-print-function ${FUNCNAME} "${@}"

	local rsync_options subdir targetdir wc_path escm
	case "${TRINITY_SCM}" in
		git) wc_path="${EGIT_STORE_DIR}/${EGIT_PROJECT}";;
		*)   die "TRINITY_SCM: ${TRINITY_SCM} is not supported by ${FUNCNAME}" ;;
	esac

	rsync_options="--group --links --owner --perms --quiet --exclude=.git/"

	# Copy ${TRINITY_MODULE_NAME} non-recursively (toplevel files)
	rsync ${rsync_options} "${wc_path}"/* "${S}" \
		|| die "rsync: can't export toplevel files to '${S}'."
	# Copy cmake directory
	if [[ -d "${wc_path}/cmake" ]]; then
		rsync --recursive ${rsync_options} "${wc_path}/cmake" "${S}" \
			|| die "rsync: can't export cmake files to '${S}'."
	fi
	# Copy all subdirectories listed in ${TSM_EXTRACT_LIST}
	for subdir in ${TSM_EXTRACT_LIST}; do
		rsync --recursive ${rsync_options} "${wc_path}/${subdir}" \
			"${S}/$(dirname subdir)" \
			|| die "rsync: can't export object '${wc_path}/${subdir}' to '${S}'."
	done
}

# @FUNCTION: trinity-meta-2_create_extractlists
# @DESCRIPTION:
# Creates lists of files and subdirectories to extract.
# Also see descriptions of KMMODULE and KMEXTRACT.
trinity-meta-2_create_extractlists() {
	debug-print-function ${FUNCNAME} "${@}"
	local submod
	
	# If ${TSM_EXTRACT} is not set assign it to dirs named in TRINITY_SUBMODULE
	if [[ -z "${TSM_EXTRACT}" ]]; then
		for submod in ${TRINITY_SUBMODULE}; do
			TSM_EXTRACT="${TSM_EXTRACT} ${submod}/"
		done
	fi

	# Add package-specific files and directories
	case "${TRINITY_MODULE_NAME}" in
		tdebase) TSM_EXTRACT_LIST+=" kcontrol/ tdmlib/" ;;
		*) ;; # nothing special for other modules
	esac

	TSM_EXTRACT_LIST+=" ${TSM_EXTRACT} ${TSM_EXTRACT_ALSO} cmake/ CMakeLists.txt"
	TSM_EXTRACT_LIST+=" config.h.cmake ConfigureChecks.cmake"
	[[ ${TRINITY_BUILD_ADMIN} == "yes" ]] && TSM_EXTRACT_LIST+=" configure.in.in Makefile.am.in \
					ChangeLog AUTHORS NEWS README"

 	debug-print "line ${LINENO} ${ECLASS} ${FUNCNAME}: TSM_EXTRACT_LIST=\"${TSM_EXTRACT_LIST}\""
}

# @FUNCTION: trinity-meta_src_prepare
# @DESCRIPTION:
# Default src prepare function. Currently it's only a stub.
trinity-meta-2_src_prepare() {
	debug-print-function ${FUNCNAME} "${@}"
	local shared_patch_dir f f_name;

	shared_patch_dir="${FILESDIR}/shared/${TRINITY_MODULE_NAME}-${PV}/patches/"
	if [[ -d "${shared_patch_dir}" ]]; then
		find "${shared_patch_dir}" -type f | while read f; do
			f_name="$(basename "${f}")"
			case "${f_name}" in
			*.diff | *.patch ) epatch "${f}" ;;
			*.gz ) cp "${f}" "${T}"
				gunzip   "${T}/${f_name}"
				epatch   "${T}/${f_name%.gz}"
				;;
			*.bz2 ) cp "${f}" "${T}"
				bunzip2  "${T}/${f_name}"
				epatch   "${T}/${f_name%.bz2}"
				;;
			*) die "unknown patch type in the patch directory" ;;
			esac
		done;
	fi
	
	trinity-base-2_src_prepare
}

# @FUNCTION: trinity-meta-2_src_configure
# @DESCRIPTION:
# Default source configure function. It sets apropriate cmake args.
# Also see description of KMMODULE.
trinity-meta-2_src_configure() {
	debug-print-function ${FUNCNAME} "${@}"

	local item tsmargs mod

	for item in ${TRINITY_SUBMODULE}; do
		mod="${item^^}"
		mod="${mod//-/_}"
		tsmargs+=" -DBUILD_${mod}=ON"
	done

	mycmakeargs=(
		"${mycmakeargs[@]}"
		${tsmargs}
	)

	trinity-base-2_src_configure
}

# @FUNCTION: trinity-meta-2_src_compile
# @DESCRIPTION:
# Just calls trinity-base_src_compile.
trinity-meta-2_src_compile() {
	debug-print-function ${FUNCNAME} "${@}"
	
	trinity-base-2_src_compile
}

# @FUNCTION: trinity-meta-2_src_install
# @DESCRIPTION:
# Calls default cmake install function and installs documentation.
trinity-meta-2_src_install() {
	debug-print-function ${FUNCNAME} "${@}"
	
	if [[ ${TRINITY_BUILD_ADMIN} == "yes" ]] ; then
		for dir in ${TRINITY_SUBMODULE} ${TSM_EXTRACT}; do
				if [[ -d "${S}"/$dir ]]; then
					pushd "${S}"/$dir > /dev/null || die
						emake DESTDIR="${D}" destdir="${D}" install || die "emake install failed."
					popd > /dev/null || die
				fi
		done
	fi

	TRINITY_BASE_NO_INSTALL_DOC="yes" trinity-base-2_src_install

	trinity-base-2_create_tmp_docfiles ${TSM_EXTRACT}
	trinity-base-2_install_docfiles
}

# @FUNCTION: trinity-meta-2_src_delete
# @DESCRIPTION:
# Default src_delete function for git.
# Removes unnecessary files.
trinity-meta-2_src_delete() {
	debug-print-function ${FUNCNAME} "${@}"
	
	local x i dir newdir array num mod_dir
	# Directories that do not need to be deleted
	mod_dir="cmake admin libltdl libtdevnc"

	dir="${WORKDIR}/tmpdir"
	trinity-meta-2_create_extractlists

	pushd ${S} > /dev/null || die
	mkdir ${dir} || die

	for x in ${TSM_EXTRACT_LIST}
	do
		array=(${x//\// })
		num=${#array[@]}

		if [[ ${num} -gt 1 ]] ; then
			for (( i=0; i<$[${num}-1]; i++ ));
			do
				newdir+="${array[$i]}/"
			done

			mkdir -p ${dir}/${newdir} || die
			cp -af ${x} ${dir}/${newdir} || die
			unset newdir
		else
			cp -af ${x} ${dir}/ || die
		fi
	done
	einfo "Delete directories..."
	for x in *
	do
		if ! has ${x} ${mod_dir} ; then
			rm -rf ${x} || die
		else
			einfo "Skipping ${x}"
		fi
	done

	cp -af ${dir}/. . || die
	rm -rf ${dir} || die
	popd > /dev/null || die
}

EXPORT_FUNCTIONS src_prepare src_configure src_compile src_install src_unpack pkg_setup
