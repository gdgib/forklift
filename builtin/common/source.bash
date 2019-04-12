SRC_SELFRAW=$BASH_SOURCE
SRC_SELF_DIR=$(cd $(dirname ${SRC_SELFRAW}) && pwd -P)
SRC_SELF=${SRC_SELF_DIR}/$(basename ${SRC_SELFRAW})

. ${SRC_SELF_DIR}/config.bash
. ${SRC_SELF_DIR}/consoleformat.bash
. ${SRC_SELF_DIR}/util.bash