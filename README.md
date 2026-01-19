# Free VST Plugins for macOS

A curated collection of **high-quality, legally free** VST/AU plugins for music production on macOS. Includes an automated download script.

## Quick Start

```bash
# Clone the repo
git clone https://github.com/gr8monk3ys/free-vst-plugins-mac.git
cd free-vst-plugins-mac

# Download all plugins (~1.5GB)
./scripts/download-plugins.sh

# Or download specific categories
./scripts/download-plugins.sh --synths
./scripts/download-plugins.sh --effects
```

## What's Included

### Synths (7 plugins)

| Plugin | Description | Open Source |
|--------|-------------|:-----------:|
| **[Surge XT](https://surge-synthesizer.github.io/)** | Hybrid synth - wavetable, FM, subtractive. 2800+ presets | ✅ |
| **[Dexed](https://asb2m10.github.io/dexed/)** | Yamaha DX7 FM synth clone | ✅ |
| **[OB-Xd](https://www.discodsp.com/obxd/)** | Oberheim OB-X emulation | ✅ |
| **[Helm](https://tytel.org/helm/)** | Polyphonic synth with deep modulation | ✅ |
| **[TAL-NoiseMaker](https://tal-software.com/products/tal-noisemaker)** | Classic VA synth, 256 presets | |
| **[Tyrell N6](https://u-he.com/products/tyrelln6/)** | u-he analog synth, Apple Silicon native | |
| **[Zebralette](https://u-he.com/products/zebralette/)** | u-he wavetable oscillator | |

### Effects (10+ plugins)

| Plugin | Type | Open Source |
|--------|------|:-----------:|
| **[Valhalla Supermassive](https://valhalladsp.com/shop/reverb/valhalla-supermassive/)** | Reverb/Delay (21 modes) | |
| **[Valhalla FreqEcho](https://valhalladsp.com/shop/delay/valhalla-freq-echo/)** | Frequency Shifter + Echo | |
| **[OTT](https://xferrecords.com/freeware)** | Multiband Compressor | |
| **[Dragonfly Reverb](https://michaelwillis.github.io/dragonfly-reverb/)** | 4 Reverbs (Hall, Room, Plate, ER) | ✅ |
| **[BYOD](https://chowdsp.com/products.html)** | Modular Distortion | ✅ |
| **[TDR Nova](https://www.tokyodawn.net/tdr-nova/)** | Dynamic EQ | |
| **[Airwindows Consolidated](https://www.airwindows.com/consolidated/)** | **350+ effects** in one plugin | ✅ |
| **[DC1A](https://klanghelm.com/contents/products/DC1A)** | Character Compressor | |
| **[TAL-Vocoder](https://tal-software.com/products/tal-vocoder)** | Classic 80s Vocoder | |

### Instruments & Bundles

| Plugin | Description |
|--------|-------------|
| **[Sitala](https://decomposer.de/sitala/)** | Drum sampler - 16 pads |
| **[MeldaProduction MFreeFXBundle](https://www.meldaproduction.com/MFreeFXBundle)** | 37 free effects |

## Manual Download Required

These require account registration but are worth it:

| Plugin | Link | Why It's Great |
|--------|------|----------------|
| **Vital** | [vital.audio](https://vital.audio) | Best free wavetable synth (rivals $189 Serum) |
| **Spitfire LABS** | [labs.spitfireaudio.com](https://labs.spitfireaudio.com) | Pro-quality sampled instruments |
| **Analog Obsession** | [analogobsession.com](https://analogobsession.com) | 50+ analog hardware emulations |
| **Kilohearts Essentials** | [kilohearts.com](https://kilohearts.com/products/kilohearts_essentials) | 30+ modular effects |
| **Komplete Start** | [native-instruments.com](https://www.native-instruments.com/en/products/komplete/bundles/komplete-start/) | NI's free starter bundle |

## Usage

```bash
# Show help
./scripts/download-plugins.sh --help

# List all available plugins
./scripts/download-plugins.sh --list

# Download everything
./scripts/download-plugins.sh --all

# Download specific categories
./scripts/download-plugins.sh --synths
./scripts/download-plugins.sh --effects
./scripts/download-plugins.sh --instruments

# Custom download directory
./scripts/download-plugins.sh --dir ~/Music/Plugins
```

## Installation

After downloading:

1. Open `~/Downloads/VST-Plugins/`
2. Double-click each `.dmg` or `.pkg` file
3. Run the installer
4. Rescan plugins in your DAW:
   - **FL Studio**: Options → Manage Plugins → Start Scan
   - **Ableton**: Preferences → Plug-Ins → Rescan
   - **Logic Pro**: Automatic on restart

## Plugin Locations on macOS

```
/Library/Audio/Plug-Ins/VST/          # System VST
/Library/Audio/Plug-Ins/VST3/         # System VST3
/Library/Audio/Plug-Ins/Components/   # System AU
~/Library/Audio/Plug-Ins/VST/         # User VST
~/Library/Audio/Plug-Ins/VST3/        # User VST3
~/Library/Audio/Plug-Ins/Components/  # User AU
```

## Related Projects

- **[OpenAudio](https://github.com/webprofusion/OpenAudio)** - Comprehensive list of open-source audio software
- **[awesome-vst](https://github.com/dreikanter/awesome-vst)** - Curated VST plugins reference
- **[FreeAudioPluginList](https://github.com/twinysam/FreeAudioPluginList)** - Ultimate list of free audio plugins
- **[free-music-plugins](https://github.com/spnw/free-music-plugins)** - Free audio and MIDI plugins
- **[OwlPlug](https://github.com/DropSnorz/OwlPlug)** - Cross-platform plugin manager
- **[homebrew-audio](https://github.com/joshka/homebrew-audio)** - Homebrew casks for audio plugins

## Contributing

Found a great free plugin? PRs welcome!

1. Fork the repo
2. Add plugin to `plugins.json`
3. Update the download script
4. Submit PR

### Plugin Criteria

- ✅ Legally free (not cracked/pirated)
- ✅ macOS compatible (Intel or Apple Silicon)
- ✅ 64-bit
- ✅ VST3 or AU format
- ✅ High quality / useful for production

## License

MIT License - Plugin downloads are subject to their respective licenses.

## Disclaimer

All plugins are downloaded from their official sources. This project does not host any plugin binaries. Always verify downloads and check plugin licenses before commercial use.
