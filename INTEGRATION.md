# Integration: create_skill and Cloudflare in the main loop (PicoDual)

**Status:** Planned. Today you get both entrypoints side by side; full integration is a follow-up.

- **create_skill and Cloudflare memory (R2/Vectorize) in the main picoclaw loop** are planned. When implemented, the picoclaw agent will be able to use the `create_skill` tool and load LLM-created skills from `workspace/skills/`, and optionally use R2 + Vectorize for memory.
- **Until then:** use **`cmd/picoflare`** for the PicoDual agent (Cloudflare): full `/createagent` and create_skill (interactive or Telegram bot). Use **`cmd/picoclaw`** for the PicoDual agent (AWS): gateway, multi-channel, and S3 memory.

For merge strategy and benefits of combining both codebases, see the combined-repo guide in the repo root (e.g. COMBINED-PICOCLAW-PICOFLARE.md) if present.
