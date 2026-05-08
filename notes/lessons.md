# Lessons

## Verify audio commands with a self-null test before recommending

When proposing any ffmpeg / sox / DAW command for audio subtraction, mixing, or null-testing, run it against the same file twice first. If the result is not at the noise floor (-90 dB or lower for float pipelines), the command is broken regardless of how plausible it looks.

Specific gotcha that caused this: `ffmpeg amix=inputs=2:weights=1 -1:normalize=0` silently ignores negative weights and just sums positively. The correct subtraction pattern is:

```
[1:a]volume=-1.0[inv];[0:a][inv]amix=inputs=2:normalize=0
```

General principle: filter graphs that *look* mathematically correct may not be — option semantics differ from documentation. A single self-null test is cheap and decisive. Never write the command into CLAUDE.md / docs without that verification step.

## Keep procedures procedural, not interpretive

When documenting a reusable workflow, don't bake in "what to expect" from the specific session that prompted it. That session's findings become bias primers when the procedure is reused on different material. Interpret live, every time.

## Lessons stay short

One or two sentences each. Verbose lessons defeat their own purpose — they cost the context they're meant to save.
