# stem-lab

Claude Code powered stem splitting for the pros and plebs.

Drop a song in, ask Claude for the stems you want, get clean separations back. The repo ships with a built-in audio-separation expert (it lives in `CLAUDE.md`) so you don't need to know which model to pick — Claude handles the chain.

Made for Macs (Apple Silicon especially), but `setup.sh` will pick the best option for your machine.

## What's in here

- `CLAUDE.md` — the expert persona and chain playbook Claude reads before doing anything
- `SOURCES.md` — curated index of where the real knowledge lives (papers, repos, model trainers)
- `notes/lessons.md` — corrections that have piled up over time, auto-loaded into every session
- `projects/` — your per-song working folders (gitignored — your audio stays local)
- `setup.sh` — one-shot install + verification

## Setup

You'll need [ffmpeg](https://ffmpeg.org/) and [uv](https://docs.astral.sh/uv/) installed first. The script will tell you if either is missing.

```bash
./setup.sh
```

That's it. The script picks the right install for your machine, creates `projects/`, and verifies acceleration is working.

## Workflow

1. Make a folder for your song:
   ```bash
   mkdir projects/mysong
   ```
2. Drop your audio in as `source.wav` (or `.flac`, `.mp3` — anything ffmpeg reads):
   ```
   projects/mysong/source.wav
   ```
3. Open [Claude Code](https://www.claude.com/product/claude-code) in this directory and ask for what you want:
   > "Run the 4-stem chain on `projects/mysong/`"
   >
   > "Pull just the vocals from `projects/mysong/`, then dereverb them"
   >
   > "Compare BS-Roformer vs Mel-Band Roformer Kim on `projects/mysong/` and show me the spectrograms"

Claude reads `CLAUDE.md`, picks the right models, runs the chain, and creates `Stems/`, `viz/`, `residuals/` inside the project folder as needed.

## Per-project layout

After Claude has done its thing, a project folder looks like this:

```
projects/mysong/
├── source.wav            # what you dropped in
├── Stems/                # the separated audio
├── viz/                  # spectrograms, A/B comparisons
└── residuals/            # null-test outputs (analytical work)
```

`Stems/` is capitalized on purpose — it matches the convention Ableton Live uses, so a future export step can move that folder straight into a Live project.

## Performance expectations (M1 Max, ~4 min track)

| Model class | Wall-clock |
|---|---|
| MDX-Net (Kim_Vocal_2 etc.) via CoreML | ~10–20 s |
| Demucs / HTDemucs-FT via MPS | ~30–90 s |
| BS-Roformer / Mel-Band Roformer via MPS | ~3–8 min |
| Full chain (BS-Roformer → HTDemucs-FT) | ~5–10 min |

Roformer is the slow part. Worth it for vocal isolation; everything else is much faster.

## Notes

- Models auto-download to `~/.cache/audio-separator/` on first use. They're large (200 MB – 2 GB each). Check the cache size occasionally.
- For YouTube/MP3 sources, ask Claude about Apollo restoration to recover HF content lost to lossy encoding.
- For the full model cheatsheet, chain reasoning, and source rankings, read `CLAUDE.md` and `SOURCES.md`. Written for Claude, but plenty readable as a human reference.
