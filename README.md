# PicoDual

**PicoDual** is the combined PicoDual agent — picoclaw-aws + pico-flare in one repo. One Go module with two entrypoints: AWS-native PicoDual agent (gateway, channels, S3) and Cloudflare-native PicoDual agent (R2, Vectorize, MCP, `/createagent`).

## Entrypoints

| Command | Description |
|--------|-------------|
| **cmd/picoaws** | PicoDual agent (AWS): gateway, chat API, multi-channel (Telegram, Slack, Discord, etc.), S3 memory, AWS MCP. Run on EC2 or any server. |
| **cmd/picoflare** | PicoDual agent (Cloudflare): interactive agent or Telegram bot, R2 + Vectorize, Cloudflare MCP, `/createagent` and create_skill. |

## Quick start

1. **Copy env** and fill in values for the entrypoint you use (PicoDual supports both AWS and Cloudflare):
   ```bash
   cp .env.example .env
   ```

2. **Build both** (or the one you need):
   ```bash
   go build -o picoclaw ./cmd/picoclaw
   go build -o picoflare ./cmd/picoflare
   ```

3. **Run PicoDual agent (AWS)** — gateway + channels:
   ```bash
   export PICOCLAW_MEMORY_S3_BUCKET=your-bucket
   ./picoclaw agent   # or start gateway; see deploy/README.md
   ```

4. **Run PicoDual agent (Cloudflare)** — interactive or Telegram bot:
   ```bash
   ./picoflare        # interactive agent
   ./picoflare bot    # Telegram bot (TELEGRAM_BOT_TOKEN required)
   ./picoflare help   # all commands
   ```

## Setup

- **PicoDual agent (picoclaw)**: AWS credentials, S3 bucket for memory, LLM API key (OpenRouter/Anthropic/OpenAI). See [deploy/README.md](deploy/README.md) and [docs/AWS_DEPLOYMENT_ONEPAGER.md](docs/AWS_DEPLOYMENT_ONEPAGER.md).
- **PicoDual agent (picoflare)**: Cloudflare account ID + API token, optional R2 keys, `OPENROUTER_API_KEY`, `TELEGRAM_BOT_TOKEN` for bot. See [.env.example](.env.example) and [DEPLOY_CLOUDFLARE.md](DEPLOY_CLOUDFLARE.md).

## Docs

- [ONE_PAGER.md](ONE_PAGER.md) – PicoDual (AWS) positioning
- [SELF_BUILDER.md](SELF_BUILDER.md) – PicoDual self-building repo agent (EC2)
- [deploy/README.md](deploy/README.md) – PicoDual production run (AWS)
- [DEPLOY_CLOUDFLARE.md](DEPLOY_CLOUDFLARE.md) – PicoDual on Cloudflare Tunnel
- [TEST_MEMORY.md](TEST_MEMORY.md) – PicoDual memory testing (S3)
- [INTEGRATION.md](INTEGRATION.md) – create_skill and Cloudflare in the main PicoDual agent loop (planned)

## License

MIT
