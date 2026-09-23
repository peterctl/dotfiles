# Pi dotfiles layout

This directory keeps your Pi config under version control.

## What belongs here

- `settings.json` — global Pi settings, including the package/plugin list
- `extensions/` — your global Pi extensions
- `skills/` — your global Pi skills
- `prompts/` — your prompt templates
- `themes/` — your custom themes

## Install into `~/.pi/agent`

From the dotfiles repo root:

```bash
./install.sh pi
```

That command symlinks:

- `pi/settings.json` → `~/.pi/agent/settings.json`
- `pi/extensions` → `~/.pi/agent/extensions`
- `pi/skills` → `~/.pi/agent/skills`
- `pi/prompts` → `~/.pi/agent/prompts`
- `pi/themes` → `~/.pi/agent/themes`

## What should stay out of git

Keep these as runtime state in `~/.pi/agent/`:

- `auth.json`
- `trust.json`
- `sessions/`
- `npm/`
- `git/`
- caches and indexes

## Managing plugins/packages

Edit `settings.json` and update the `packages` array, or run `pi install ...` once and copy the resulting package entry into this file.

If you want fully reproducible installs, pin versions/tags, for example:

```json
{
  "packages": [
    "npm:context-mode@1.2.3",
    "git:github.com/user/repo@v1"
  ]
}
```
