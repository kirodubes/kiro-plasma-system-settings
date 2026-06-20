#!/bin/bash
set -euo pipefail
#####################################################################
# Author    : Erik Dubois
# Website   : https://kiroproject.be
#####################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
#   Purpose:
#   - Maintainer helper (NOT shipped in the package) to discover which
#     KDE Plasma System Settings actually changed, so only those keys
#     get baked into etc/skel/.config/.
#   - Run `snapshot` on a Plasma box BEFORE touching System Settings to
#     save a baseline of every top-level ~/.config/*rc file. Then change
#     the settings that annoy you in the GUI. Then run `diff` to print
#     exactly which file / [group] / key=value changed — paste that back.
#
#   Why: shipping a full frozen kdeglobals/kwinrc into /etc/skel froze
#   KDE's defaults and was non-revertable (lesson from kiro-plasma-
#   keybindings). Capturing only the changed keys keeps the skel files
#   minimal so everything else still falls back to KDE defaults.
#
#####################################################################

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${HOME}/.config"
BASELINE_DIR="${HOME}/.cache/kiro-plasma-capture/baseline"

#####################################################################
# Colors
#####################################################################
if command -v tput >/dev/null 2>&1 && [[ -t 1 ]]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    CYAN="$(tput setaf 6)"
    RESET="$(tput sgr0)"
else
    RED="" GREEN="" YELLOW="" BLUE="" CYAN="" RESET=""
fi

#####################################################################
# Logging
#####################################################################
log_section() {
    echo
    echo "${GREEN}############################################################${RESET}"
    echo "$1"
    echo "${GREEN}############################################################${RESET}"
    echo
}

log_info() {
    echo
    echo "${BLUE}############################################################${RESET}"
    echo "$1"
    echo "${BLUE}############################################################${RESET}"
    echo
}

log_warn() {
    echo
    echo "${YELLOW}############################################################${RESET}"
    echo "$1"
    echo "${YELLOW}############################################################${RESET}"
    echo
}

log_error() {
    echo
    echo "${RED}############################################################${RESET}"
    echo "$1"
    echo "${RED}############################################################${RESET}"
    echo
}

log_success() {
    echo
    echo "${GREEN}############################################################${RESET}"
    echo "$1"
    echo "${GREEN}############################################################${RESET}"
    echo
}

#####################################################################
# Error handling
#####################################################################
on_error() {
    local lineno="$1"
    local cmd="$2"
    echo
    echo "${RED}ERROR on line ${lineno}: ${cmd}${RESET}"
    echo
    sleep 10
}

trap 'on_error "$LINENO" "$BASH_COMMAND"' ERR

#####################################################################
# Functions
#####################################################################
take_snapshot() {
    log_section "Snapshotting top-level ${CONFIG_DIR}/*rc files"
    rm -rf "${BASELINE_DIR}"
    mkdir -p "${BASELINE_DIR}"
    # only top-level config files — System Settings live there, not in subdirs
    find "${CONFIG_DIR}" -maxdepth 1 -type f -print0 | while IFS= read -r -d '' f; do
        cp -a "$f" "${BASELINE_DIR}/"
    done
    log_success "Baseline saved. Now change your Plasma settings, then run: $(basename "$0") diff"
}

show_diff() {
    if [[ ! -d "${BASELINE_DIR}" ]]; then
        log_error "No baseline found — run '$(basename "$0") snapshot' first"
        exit 1
    fi
    log_section "Changed settings since baseline (file / changed lines)"
    local found=0
    local cur base name
    for cur in "${CONFIG_DIR}"/*; do
        [[ -f "${cur}" ]] || continue
        name="$(basename "${cur}")"
        base="${BASELINE_DIR}/${name}"
        if [[ ! -f "${base}" ]]; then
            echo "${YELLOW}### ${name} (new file)${RESET}"
            sed 's/^/  + /' "${cur}"
            echo
            found=1
            continue
        fi
        if ! diff -q "${base}" "${cur}" >/dev/null 2>&1; then
            echo "${CYAN}### ${name}${RESET}"
            # show only added/changed lines, keeping any [Group] header context
            diff "${base}" "${cur}" | grep -E '^[<>]|^[0-9]' || true
            echo
            found=1
        fi
    done
    if [[ "${found}" -eq 0 ]]; then
        log_info "No changes detected since the baseline"
    else
        log_success "Paste the blocks above back to Claude to turn into skel entries"
    fi
}

usage() {
    echo "Usage: $(basename "$0") {snapshot|diff}"
    echo "  snapshot  save baseline of ~/.config/*rc (run BEFORE changing settings)"
    echo "  diff      show what changed (run AFTER changing settings)"
}

#####################################################################
# Main
#####################################################################
main() {
    case "${1:-}" in
        snapshot) take_snapshot ;;
        diff)     show_diff ;;
        *)        usage; exit 1 ;;
    esac

    log_success "$(basename "$0") done"
}

main "$@"
