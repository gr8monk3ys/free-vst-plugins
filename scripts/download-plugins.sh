#!/bin/bash

# Free VST Plugins Downloader for macOS
# https://github.com/gr8monk3ys/free-vst-plugins-mac
#
# This script downloads high-quality free VST/AU plugins for music production.
# All plugins are legally free from their official sources.

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Configuration
DOWNLOAD_DIR="${HOME}/Downloads/VST-Plugins"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGINS_JSON="${SCRIPT_DIR}/../plugins.json"

# Plugin URLs - Synths
declare -A SYNTHS=(
    ["Surge XT"]="https://github.com/surge-synthesizer/releases-xt/releases/download/1.3.4/surge-xt-macOS-1.3.4.dmg"
    ["Dexed"]="https://github.com/asb2m10/dexed/releases/download/v1.0.1/Dexed-1.0.1-macOS.dmg"
    ["OB-Xd"]="https://github.com/reales/OB-Xd/releases/download/v2.19/OB-Xd.2.19.pkg"
    ["Helm"]="https://tytel.org/static/dist/Helm_v0_9_0_r.pkg"
    ["TAL-NoiseMaker"]="https://tal-software.com/downloads/plugins/TAL-NoiseMaker-installer_macos.zip"
    ["Tyrell N6"]="https://dl.u-he.com/releases/TyrellN6_300_public_beta_16976_Mac.zip"
    ["Zebralette"]="https://dl.u-he.com/releases/Zebra_Legacy_294_16765_Mac.zip"
)

# Plugin URLs - Effects
declare -A EFFECTS=(
    ["Valhalla Supermassive"]="https://valhallaproduction.s3.us-west-2.amazonaws.com/supermassive/ValhallaSupermassiveOSX_5_0_0.dmg"
    ["Valhalla FreqEcho"]="https://valhallaproduction.s3.us-west-2.amazonaws.com/freqecho/ValhallaFreqEchoOSX_1_2_8.dmg"
    ["OTT"]="https://xferrecords.com/product_downloads/24/freeware"
    ["Dragonfly Reverb"]="https://github.com/michaelwillis/dragonfly-reverb/releases/download/3.2.10/dragonfly-reverb-3.2.10-macos-universal.dmg"
    ["BYOD"]="https://github.com/Chowdhury-DSP/BYOD/releases/download/v1.3.0/BYOD-Mac-1.3.0.dmg"
    ["TDR Nova"]="https://www.tokyodawn.net/labs/Nova/2.2.1/TDR%20Nova.zip"
    ["DC1A"]="https://klanghelm.com/free/DC1A3dl.php?id=3"
    ["TAL-Vocoder"]="https://tal-software.com/downloads/plugins/TAL-Vocoder-2-installer_macos.zip"
)

# Plugin URLs - Instruments
declare -A INSTRUMENTS=(
    ["Sitala"]="https://www.decomposer.de/sitala/releases/Sitala-1.0.dmg"
)

# Plugin URLs - Bundles
declare -A BUNDLES=(
    ["MeldaProduction"]="https://meldaproduction.b-cdn.net/download/mpluginmanager/MPluginManager_02_16_setupmac.zip"
)

# Functions
print_header() {
    echo ""
    echo -e "${CYAN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${NC}    ${GREEN}Free VST Plugins Downloader for macOS${NC}                     ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}    High-quality plugins for music production                ${CYAN}║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

print_section() {
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

download_plugin() {
    local name="$1"
    local url="$2"
    local filename=$(basename "$url" | sed 's/%20/ /g')

    # Handle special filenames
    case "$name" in
        "OTT") filename="Install_Xfer_OTT.dmg" ;;
        "DC1A") filename="DC1A3-macOS.pkg" ;;
        "TDR Nova") filename="TDR-Nova.zip" ;;
        "Tyrell N6") filename="TyrellN6_Mac.zip" ;;
        "Zebralette") filename="Zebralette_Mac.zip" ;;
        "MeldaProduction") filename="MPluginManager_mac.zip" ;;
    esac

    local filepath="${DOWNLOAD_DIR}/${filename}"

    if [[ -f "$filepath" ]]; then
        echo -e "  ${YELLOW}⏭${NC}  ${name} - already downloaded"
        return 0
    fi

    echo -e "  ${CYAN}⬇${NC}  Downloading ${name}..."

    if curl -L -f -o "$filepath" "$url" --progress-bar 2>/dev/null; then
        echo -e "  ${GREEN}✓${NC}  ${name} - downloaded successfully"
        return 0
    else
        echo -e "  ${RED}✗${NC}  ${name} - download failed"
        return 1
    fi
}

download_airwindows() {
    echo -e "  ${CYAN}⬇${NC}  Fetching latest Airwindows Consolidated..."

    # Get latest release URL from GitHub API
    local api_url="https://api.github.com/repos/baconpaul/airwin2rack/releases/tags/DAWPlugin"
    local download_url=$(curl -s "$api_url" | grep "browser_download_url.*macOS.*\.dmg" | head -1 | cut -d '"' -f 4)

    if [[ -n "$download_url" ]]; then
        local filename="airwindows-consolidated-macOS.dmg"
        local filepath="${DOWNLOAD_DIR}/${filename}"

        if [[ -f "$filepath" ]]; then
            echo -e "  ${YELLOW}⏭${NC}  Airwindows Consolidated - already downloaded"
            return 0
        fi

        if curl -L -f -o "$filepath" "$download_url" --progress-bar 2>/dev/null; then
            echo -e "  ${GREEN}✓${NC}  Airwindows Consolidated (350+ plugins) - downloaded"
            return 0
        fi
    fi

    echo -e "  ${RED}✗${NC}  Airwindows Consolidated - failed (check GitHub manually)"
    return 1
}

unzip_archives() {
    print_section "Extracting Archives"

    cd "$DOWNLOAD_DIR"

    for zip in *.zip; do
        [[ -f "$zip" ]] || continue
        local dirname="${zip%.zip}"

        if [[ ! -d "$dirname" ]]; then
            echo -e "  ${CYAN}📦${NC}  Extracting $zip..."
            unzip -q -o "$zip" -d "$dirname" 2>/dev/null || unzip -q -o "$zip" 2>/dev/null
            echo -e "  ${GREEN}✓${NC}  Extracted $zip"
        else
            echo -e "  ${YELLOW}⏭${NC}  $zip - already extracted"
        fi
    done
}

print_summary() {
    print_section "Download Summary"

    local total=$(ls -1 "$DOWNLOAD_DIR" 2>/dev/null | wc -l | tr -d ' ')
    local size=$(du -sh "$DOWNLOAD_DIR" 2>/dev/null | cut -f1)

    echo ""
    echo -e "  ${GREEN}Downloads complete!${NC}"
    echo ""
    echo -e "  📁 Location: ${CYAN}${DOWNLOAD_DIR}${NC}"
    echo -e "  📊 Files: ${CYAN}${total}${NC}"
    echo -e "  💾 Total size: ${CYAN}${size}${NC}"
    echo ""
    echo -e "  ${YELLOW}To install:${NC}"
    echo -e "     1. Open ${CYAN}${DOWNLOAD_DIR}${NC}"
    echo -e "     2. Double-click each .dmg or .pkg file"
    echo -e "     3. Run the installer inside"
    echo -e "     4. Rescan plugins in your DAW"
    echo ""
    echo -e "  ${YELLOW}Manual downloads needed:${NC}"
    echo -e "     • Vital           → ${CYAN}https://vital.audio${NC}"
    echo -e "     • Spitfire LABS   → ${CYAN}https://labs.spitfireaudio.com${NC}"
    echo -e "     • Analog Obsession → ${CYAN}https://analogobsession.com${NC}"
    echo ""
}

show_help() {
    print_header
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -a, --all        Download all plugins (default)"
    echo "  -s, --synths     Download synths only"
    echo "  -e, --effects    Download effects only"
    echo "  -i, --instruments Download instruments only"
    echo "  -l, --list       List available plugins"
    echo "  -d, --dir DIR    Set download directory"
    echo "  -h, --help       Show this help"
    echo ""
    echo "Examples:"
    echo "  $0                    # Download all plugins"
    echo "  $0 --synths           # Download synths only"
    echo "  $0 --dir ~/Music/Plugins  # Custom download location"
    echo ""
}

list_plugins() {
    print_header

    print_section "Synths"
    for name in "${!SYNTHS[@]}"; do
        echo -e "  • ${name}"
    done

    print_section "Effects"
    for name in "${!EFFECTS[@]}"; do
        echo -e "  • ${name}"
    done
    echo -e "  • Airwindows Consolidated (350+ plugins)"

    print_section "Instruments"
    for name in "${!INSTRUMENTS[@]}"; do
        echo -e "  • ${name}"
    done

    print_section "Bundles"
    for name in "${!BUNDLES[@]}"; do
        echo -e "  • ${name} (37 free effects)"
    done

    print_section "Manual Download Required"
    echo -e "  • Vital (wavetable synth)"
    echo -e "  • Spitfire LABS (sampled instruments)"
    echo -e "  • Analog Obsession (50+ analog emulations)"
    echo -e "  • Kilohearts Essentials (30+ effects)"
    echo -e "  • Native Instruments Komplete Start"
    echo ""
}

# Main execution
main() {
    local download_synths=false
    local download_effects=false
    local download_instruments=false
    local download_bundles=false
    local download_all=true

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            -a|--all) download_all=true; shift ;;
            -s|--synths) download_synths=true; download_all=false; shift ;;
            -e|--effects) download_effects=true; download_all=false; shift ;;
            -i|--instruments) download_instruments=true; download_all=false; shift ;;
            -l|--list) list_plugins; exit 0 ;;
            -d|--dir) DOWNLOAD_DIR="$2"; shift 2 ;;
            -h|--help) show_help; exit 0 ;;
            *) echo "Unknown option: $1"; show_help; exit 1 ;;
        esac
    done

    # Set flags for --all
    if $download_all; then
        download_synths=true
        download_effects=true
        download_instruments=true
        download_bundles=true
    fi

    print_header

    # Create download directory
    mkdir -p "$DOWNLOAD_DIR"
    echo -e "📁 Download directory: ${CYAN}${DOWNLOAD_DIR}${NC}"

    local failed=0

    # Download synths
    if $download_synths; then
        print_section "Synths"
        for name in "${!SYNTHS[@]}"; do
            download_plugin "$name" "${SYNTHS[$name]}" || ((failed++))
        done
    fi

    # Download effects
    if $download_effects; then
        print_section "Effects"
        for name in "${!EFFECTS[@]}"; do
            download_plugin "$name" "${EFFECTS[$name]}" || ((failed++))
        done
        download_airwindows || ((failed++))
    fi

    # Download instruments
    if $download_instruments; then
        print_section "Instruments"
        for name in "${!INSTRUMENTS[@]}"; do
            download_plugin "$name" "${INSTRUMENTS[$name]}" || ((failed++))
        done
    fi

    # Download bundles
    if $download_bundles; then
        print_section "Bundles"
        for name in "${!BUNDLES[@]}"; do
            download_plugin "$name" "${BUNDLES[$name]}" || ((failed++))
        done
    fi

    # Extract zip files
    unzip_archives

    # Print summary
    print_summary

    if [[ $failed -gt 0 ]]; then
        echo -e "${YELLOW}⚠ ${failed} download(s) failed. Check the output above.${NC}"
        exit 1
    fi
}

main "$@"
