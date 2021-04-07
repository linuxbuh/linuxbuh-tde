#!/bin/bash

##################################################################################################
# cd PATH/tde-packaging-gentoo
# Documentation/scripts/create_list_keywords.sh 9999 >/etc/portage/package.accept_keywords/trinity
##################################################################################################

VERS=$1
create_list() {
	local FILE STR ARRAY
	while read file
	do
		FILE=${file//.\//}
		STR=${FILE%.ebuild}
		ARRAY=(${STR//\// })
		echo "~${ARRAY[0]}/${ARRAY[2]} **"
	done < <(find -type f -name "*-${VERS}.ebuild")
}

create_list | sort
