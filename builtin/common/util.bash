function fail () {
	echo -e "${CFMT_ERROR}${1}${CFMT_NORMAL}"
	echo
	help
	exit 1
}

function args_min () {
	if [[ ${#BASH_ARGV[@]} -lt ${1} ]]; then
		fail "Too few arguments, ${1} (at least) required!"
	fi
}
function args_max () {
	if [[ ${#BASH_ARGV[@]} -gt ${1} ]]; then
		fail "Too many arguments, ${1} (at most) allowed!"
	fi
}
function args_eq () {
	if [[ ${#BASH_ARGV[@]} -ne ${1} ]]; then
		fail "Wrong number of arguments, expected exactly ${1} but got ${#BASH_ARGV[@]}!"
	fi
}

function create_flbin_dir () {
	if [ ! -d ${FLBIN_DIR} ]; then
		mkdir -p ${FLBIN_DIR}
		cat >${FLBIN_DIR}/README.md << EOF
# Forklift Binaries

This directory contains the main [forklift](https://github.com/${FL_WAREHOUSE}) binaries, which are added to the path.
EOF
	fi
}