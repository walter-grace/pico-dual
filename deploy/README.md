# Deploy: Attach This Folder to a Launched Instance

Use this when your app **launches an EC2 (or other) instance** and **attaches the PicoDual agent repo** to it. On the instance, run from the repo root to start the **PicoDual agent** (CLI). No web UI—minimal footprint; the PicoDual agent can self-build later (e.g. add a UI or API).

## What to attach

Attach the **whole PicoDual agent folder** (pico-combined) to the instance—e.g. copy the repo, or mount it, or unpack a tarball at a path like `/opt/pico-combined` or `$HOME/pico-combined`. The run script must be executed from the **repo root** (the directory that contains `cmd/`, `config/`, `deploy/`, `workspace/`).

## Prerequisites on the instance

- **Go 1.21+** – to build the binary (or pre-build and ship `clawcubed` so run.sh only runs it).
- **AWS credentials** – `aws configure`, IAM role, or env vars (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_REGION`).
- **uv/uvx** – for AWS MCP: `curl -LsSf https://astral.sh/uv/install.sh | sh`.
- **LLM API key** – set via env or in config (OpenRouter, Anthropic, OpenAI, etc.).

## Config

Config is read from **`~/.picoclaw/config.json`**. On first run:

1. Create the dir: `mkdir -p ~/.picoclaw`
2. Copy and edit: `cp config/config.example.json ~/.picoclaw/config.json`
3. Set your providers, S3 bucket, and `tools.aws_mcp.enabled: true` as needed.

For the **self-building repo agent**, use the repo agent + self-builder skill and set `workspace` to the repo path on the instance (e.g. `"."` when running from repo root). See [SELF_BUILDER.md](../SELF_BUILDER.md).

## Env vars (production)

Set these (in `.env`, systemd, or your launcher):

- **AWS**: `AWS_REGION`, `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` (or use IAM role).
- **S3 memory**: `PICOCLAW_MEMORY_S3_BUCKET=your-bucket` (and optional `PICOCLAW_MEMORY_S3_PREFIX`, `PICOCLAW_MEMORY_S3_REGION`).
- **LLM**: e.g. `PICOCLAW_PROVIDERS_OPENROUTER_API_KEY=sk-or-v1-...` or provider-specific keys.

See [../.env.example](../.env.example) and [.env.example](.env.example) for a full list.

## Run

From the **repo root** (e.g. after `cd /opt/pico-combined`):

```bash
chmod +x deploy/run.sh
./deploy/run.sh          # PicoDual agent only (default)
# or
./deploy/run.sh gateway  # agent + HTTP API (for channels / future UI)
```

- **PicoDual agent** (default): CLI-only. Interactive or `./picoclaw agent -m "Build yourself"`. Smallest footprint.
- **gateway**: PicoDual agent plus HTTP API (health, /api/chat, etc.) for Telegram/Discord or a future UI you add when self-building.

## Summary for your launcher app

1. Attach this folder (PicoDual agent repo) to the launched instance at a known path.
2. Ensure Go, AWS creds, uv, and LLM keys are available (env or config).
3. Create `~/.picoclaw/config.json` from `config/config.example.json` and edit.
4. From repo root: `./deploy/run.sh` (PicoDual agent only).

After that, prompt the PicoDual agent via CLI (e.g. “build yourself”); it can extend the repo and add a UI or API later.
