# Copy Path — Finder Quick Action

A macOS Quick Action that adds a **Copy Path** item to Finder's right-click menu.
Selecting it copies the absolute path(s) of the selected file(s)/folder(s) to the
pasteboard, ready to paste with **⌘V**.

- Single item → the path, with no trailing newline
- Multiple items → one absolute path per line

## Layout

```
Copy Path.workflow/          Automator Quick Action bundle
  Contents/Info.plist        Declares the "Copy Path" menu item (Finder only, any file/folder)
  Contents/document.wflow    One "Run Shell Script" action (see below)
install.sh                   Copies the bundle to ~/Library/Services and refreshes the services registry
```

The whole action is a one-liner in `/bin/zsh`, receiving the selected paths as arguments:

```zsh
{ IFS=$'\n'; printf '%s' "$*"; } | pbcopy
```

## Install

```bash
./install.sh
```

This copies `Copy Path.workflow` into `~/Library/Services/` and runs
`/System/Library/CoreServices/pbs -update` so Finder picks it up without a logout.

## Enable the menu item (required)

After installing, the Quick Action is registered but **not shown** in the context
menu until you turn it on:

1. In Finder, right-click any file or folder.
2. Choose **Quick Actions → Customize…**
3. Toggle on **Copy Path**.

It will then appear under **Quick Actions → Copy Path** (and under the **Services**
submenu). The same toggle lives in
*System Settings → General → Login Items & Extensions → Extensions → Finder*.

## Usage

Right-click a file or folder → **Quick Actions → Copy Path** → paste with **⌘V**.

## Troubleshooting

- **Menu item missing after install** — do the "Enable the menu item" step above.
  Restarting Finder (`killall Finder`) or flushing the services cache
  (`/System/Library/CoreServices/pbs -flush && /System/Library/CoreServices/pbs -update`)
  does not make it appear on its own; the toggle is what matters.
- **Test the workflow without Finder** — run it directly and read the pasteboard:

  ```bash
  automator -i "/path/to/some/file" ~/Library/Services/"Copy Path.workflow"; pbpaste
  ```

## Uninstall

```bash
rm -rf ~/Library/Services/"Copy Path.workflow"
```

## Built-in alternative

macOS already has this without any install: right-click an item in Finder and
**hold ⌥ (Option)** — the **Copy "name"** item becomes **Copy "name" as Pathname**.

This Quick Action exists for people who'd rather have a plain, always-visible
menu item than remember the modifier key. It is also a minimal, hand-written
example of an Automator `.workflow` bundle (no Automator GUI required), which
may be useful on its own.

## License

[MIT](LICENSE)
