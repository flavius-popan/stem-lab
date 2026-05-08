# SOURCES.md — Where the knowledge actually lives

Companion to `CLAUDE.md`. This is the curated source list — where to look when you want to verify a claim, find a new model, or dig deeper than the consensus.

Sources are ranked within each category by signal density. Higher = more direct, less filtered.

---

## Tier 1: Primary technical sources

These are where new information *originates*. Check these first when a claim feels stale or contested.

### Core repositories
- **`ZFTurbo/Music-Source-Separation-Training`** (GitHub) — The training framework that most modern community models are built on. Read `docs/pretrained_models.md` for the canonical SDR table and `docs/ensemble.md` for the official ensemble guidance. The `CHANGELOG` and Releases page are the best signal of what's actually new.
- **`jarredou/Music-Source-Separation-Training-Colab-Inference`** (GitHub) — The README is *the* community model index. Updated more frequently than ZFTurbo's docs. Direct links to every important checkpoint.
- **`nomadkaraoke/python-audio-separator`** (GitHub) — Discussions tab is gold; the maintainer (beveradb) answers "which model should I use" questions with current opinions. Discussion #133 is a perpetual reference.
- **`facebookresearch/demucs`** and **`adefossez/demucs`** — Archived but still the canonical Demucs reference. The README has accurate per-stem SDR numbers for all Demucs variants.
- **`SUC-DriverOld/MSST-WebUI`** — The most active Gradio frontend. The preset configs reveal the chains practitioners actually run.

### Hugging Face model authors (the people who actually train SOTA checkpoints)
Subscribe to these accounts for activity notifications:

- **`KimberleyJSN/melbandroformer`** — Kim's Mel-Band Roformer line; widely deployed in production
- **`pcunwa`** (BS-Roformer-Revive series) — fine-tunes that often beat the originals
- **`unwa`** — Big Beta and FT series; perceptually focused
- **`anvuew`** — dereverb gold standard (`dereverb_mel_band_roformer`)
- **`aufr33`** — denoise, karaoke, crowd removal specialty models
- **`becruily`** and **`Gabox`** — vocal Roformer fine-tunes
- **`viperx`** — the BS-Roformer checkpoints everyone uses (1296/1297)
- **`JusperLee`** — Apollo restoration model
- **`Sucial`** — dereverb-echo combinations and aspiration models

### Academic ground truth
- **arXiv `cs.SD` and `eess.AS` listings** — set up a saved search for "music source separation" and check weekly. Most papers are posted here months before journal publication.
- **ISMIR proceedings** (ismir.net) — the dedicated conference for Music Information Retrieval; source separation papers concentrate here annually.
- **ICASSP proceedings** — the broader signal processing venue. The Sound Demixing Challenge (SDX) and Music Source Restoration (MSR) challenges publish here.
- **paperswithcode.com / sota / music-source-separation** — leaderboard of published models with code links. Updates lag behind community models by 6–12 months but is good for academic baselines.

---

## Tier 2: Benchmarks and competitions

Where models actually get measured against each other.

- **MVSep.com algorithms page** — `mvsep.com/quality_checker/synth_leaderboard` and the per-algorithm pages. The most current real-world leaderboard. They run their own ensembles and rank them.
- **Sound Demixing Challenge (SDX) papers** — SDX'23 (arXiv:2308.06979 + 2308.06981) is still the canonical reference for the BS-Roformer breakthrough. No SDX'24/'25 ran (as of last update); the field migrated to MVSep + ICASSP MSR.
- **MUSDB18-HQ leaderboards** — the standard public-data evaluation. Numbers from MUSDB-only training are not directly comparable to numbers using extra data (always check methodology before comparing).
- **ICASSP Signal Processing Grand Challenge — Music Source Restoration (MSR)** — new track started 2026, focuses on inverting EQ/compression/reverb. Watch for restoration architectures that complement separation.

---

## Tier 3: Practitioner reports

Where producers and audio engineers share what actually works on real material.

### Forums (best signal-to-noise)
- **Gearspace** — "Best Stem Separator [year]" threads run continuously. The 2025/2026 threads are the cleanest snapshot of pro consensus. Subforum: Electronic Music Instruments and Production.
- **KVR Audio** — UVR5 megathread and adjacent. Slower than Gearspace but more technical depth on individual model behavior.
- **AudioSEX** — useful for finding which models work on which genres; less polished than Gearspace.
- **QuadraphonicQuad** — niche but excellent for surround/multitrack-style analytical work.

### Discord (highest signal, hardest to archive)
- **AI Hub Discord** — where unwa, becruily, Gabox, and other trainers actually hang out. Most new checkpoints get announced there days/weeks before they hit Hugging Face. Worth joining if you want to be on the absolute frontier.
- **MVSep Discord** — operator's community; where ensemble configurations get tuned.

### Subreddits (lower density, occasional gems)
- **r/edmproduction** — model comparison threads when new releases happen
- **r/WeAreTheMusicMakers** — broader workflow discussions
- **r/AudioPost** — dialogue/film side, but their dereverb and denoise insights transfer

---

## Tier 4: Deep dives and tutorials

When learning a specific topic, not tracking the field.

- **MVSep's blog and FAQ** (mvsep.com) — written by people running production-scale separation. The "How to use" pages document chains explicitly.
- **The Google Doc** "Instrumental, vocal & other stems separation & mix/master guide" (search title) — community-maintained reference covering UVR/MDX/Demucs/GSEP. Outdated on Roformer specifics but great for fundamentals.
- **YouTube: "rudis"**, **"hojjat ahmadi"**, **"theaiengineer"** — practitioner walkthroughs. Caveat: YouTube SEO drowns these out; search "[model name] tutorial site:youtube.com" rather than browsing.
- **Andrew Beveridge's blog and PyPI release notes** for `python-audio-separator` — direct from the maintainer.
- **`audio-separator` GitHub Discussions** — searchable Q&A, often more current than docs.

---

## Tier 5: Architecture papers worth reading

If the user wants to understand *why* a model works, not just how to use it. Read in this order:

1. **Spleeter (Hennequin et al., 2020)** — the simple baseline. ~1 hour. Establishes the U-Net spectrogram-masking pattern.
2. **Demucs v3/v4 / HTDemucs (Défossez et al., Rouard et al.)** — hybrid waveform + spectrogram with a transformer encoder. ICASSP 2023.
3. **MDX23C / TFC-TDF-UNet v3 (kuielab, arXiv:2306.09382)** — SDX'23 winner before BS-Roformer. Dense, but worth it.
4. **BS-RoFormer (Lu et al., ByteDance, arXiv:2309.02612)** — band-split + RoPE. *The* current SOTA architecture. Read this carefully.
5. **Mel-Band RoFormer (Wang et al., arXiv:2310.01809)** — replaces BS's heuristic split with mel subbands. Short paper, big practical impact.
6. **SCNet (Tong et al., arXiv:2401.13276, ICASSP 2024)** — sparse subband encoder. Faster than HTDemucs at similar quality.
7. **Apollo (Li & Luo, arXiv:2409.08514, ICASSP 2025)** — band-split GAN for restoration. Not separation, but the natural complement.
8. **"Musical Source Separation Bake-Off"** (arXiv:2507.06917) — listening study comparing modern vs. legacy systems. Read if you ever doubt that SDR improvements are perceptually real.

---

## Tier 6: Things to ignore

Where time goes to die.

- **AI tool aggregator blogs** ("Top 10 AI Stem Separators in 2026") — SEO content, no testing, often hallucinated feature lists.
- **YouTube video titles claiming "BEST stem separator"** — usually 2-year-old Spleeter or UVR5 demos.
- **Reddit posts older than 12 months** in this fast-moving field — model recommendations from early 2024 are already stale.
- **Vendor marketing pages** for closed-source tools — useful only for setting a "what's the bar?" reference, not for actual model knowledge.
- **Leaderboards on individual project sites** — only MVSep's leaderboard is broadly trusted; project-self-reported numbers are systematically optimistic.

---

## Update workflow

When you (the user, or Claude on your behalf) learn something new:

1. **Verify against Tier 1 first.** Did MSST's `pretrained_models.md` move? Did jarredou's README list it? If neither, treat the claim as unverified.
2. **Cross-reference with Tier 2 or 3.** Is there a benchmark number, or a forum report from someone running it on real material?
3. **If both check out**, update `CLAUDE.md`'s cheatsheet or chains.
4. **If only Tier 3 confirms**, add it as "emerging" — note it but don't displace established recommendations yet.
5. **If only Tier 1 confirms** (paper exists, no public weights or community reports), don't update `CLAUDE.md` — note in a "watching" comment if anywhere.

The cycle from "paper appears" → "community trains it" → "weights on HF" → "in MSST" → "in audio-separator's loader" → "everyone uses it" usually takes 2–6 months. Patience beats chasing the bleeding edge for production work.

---

## Quick links to bookmark

```
github.com/ZFTurbo/Music-Source-Separation-Training
github.com/ZFTurbo/Music-Source-Separation-Training/blob/main/docs/pretrained_models.md
github.com/jarredou/Music-Source-Separation-Training-Colab-Inference
github.com/nomadkaraoke/python-audio-separator
github.com/nomadkaraoke/python-audio-separator/discussions
github.com/SUC-DriverOld/MSST-WebUI
huggingface.co/KimberleyJSN
huggingface.co/pcunwa
huggingface.co/anvuew
huggingface.co/aufr33
huggingface.co/JusperLee/Apollo
mvsep.com/quality_checker/synth_leaderboard
arxiv.org/list/cs.SD/recent
```

That's the bookmark bar of someone serious about this field.
