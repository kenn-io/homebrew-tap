# Homebrew Taps

Custom Homebrew formulas.

The old `wesm/taps` tap is deprecated for these formulae. Use `kenn-io/tap`
for new installs and updates.

## Available Formulas

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
