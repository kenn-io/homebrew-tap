# Homebrew Tap

Custom Homebrew formulae and casks.

The old `wesm/taps` tap is deprecated for these formulae. Use `kenn-io/tap`
for new installs and updates.

## Available Casks

### Ghosthub

[Ghosthub](https://ghosthub.ai/) is a native macOS terminal for local and
remote tmux fleets. It requires Apple Silicon and macOS 26 or newer.

**Install:**
```bash
brew install kenn-io/tap/ghosthub
```

Or tap first, then install:
```bash
brew tap kenn-io/tap
brew install ghosthub
```

## Available Formulas

### docbank

Store, search, and export documents with version history.

**Install:**
```bash
brew install kenn-io/tap/docbank
```

For documentation, visit [docbank.ai](https://docbank.ai).

### msgvault

Archive email and chat with offline search, analytics, and a web UI.

**Install:**
```bash
brew install kenn-io/tap/msgvault
```

For documentation, visit [msgvault](https://github.com/kenn-io/msgvault).

### roborev

Automatic code review daemon for git commits using AI agents.

**Install:**
```bash
brew install kenn-io/tap/roborev
```

Or tap first, then install:
```bash
brew tap kenn-io/tap
brew install roborev
```

**Quick Start:**
```bash
cd your-repo
roborev init      # Install post-commit hook
git commit -m "..." # Reviews happen automatically
roborev tui       # View reviews in interactive UI
```

For full documentation, visit [roborev.io](https://roborev.io).

### agentsview

Browse, search, and track costs across local AI coding agent sessions.

**Install:**
```bash
brew install kenn-io/tap/agentsview
```

Or tap first, then install:
```bash
brew tap kenn-io/tap
brew install agentsview
```

**Quick Start:**
```bash
agentsview serve
agentsview usage daily
```

For full documentation, visit [agentsview.io](https://agentsview.io).

### kwt

Manage Git worktrees from a terminal dashboard or a scriptable CLI.

**Install:**
```bash
brew install kenn-io/tap/kwt
```

Homebrew also installs tmux, which kwt uses to open workspaces. kwt needs Git
2.20 or newer.

For documentation, visit [kwt](https://github.com/kenn-io/kwt).
