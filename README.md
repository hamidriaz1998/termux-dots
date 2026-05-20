# myTermux

<p align="center">Personal configuration for my favorite Termux</p>

<p align="center">
  <a href="./LICENSE"><img src="https://img.shields.io/badge/license-GPL-blue.svg"></a>
  <a href="https://github.com/mayTermux/awesomeshot/releases"><img src="https://img.shields.io/github/release/mayTermux/myTermux.svg"></a>
</p>

## Video Installation

> Click the thumbnail below to see the video installation

[![myTermux Thumbnail](https://user-images.githubusercontent.com/64394320/170211137-554dfd78-8424-4699-876c-7483b45de068.png)](https://www.youtube.com/watch?v=sYkNxK_44Zg "myTermux - Installation")

## Installation Dependencies

> **Attention!**
>
> - Termux must be the **F-Droid** version — Play Store version is no longer maintained
> - [Termux:API](https://f-droid.org/en/packages/com.termux.api/) is required for commands like `termux-battery-status`

### Update Repository & Upgrade Package

```bash
pkg update && pkg upgrade
```

### git & bc

- `git` for cloning repositories
- `bc` for calculating repository sizes

```bash
pkg i -y git bc
```

## Installation myTermux

### Clone Repository

```bash
git clone --depth=1 https://github.com/mayTermux/myTermux.git
```

### Run Installer

```bash
cd myTermux
export COLUMNS LINES
./install.sh
```

> If you see `Please Zoom Out`, zoom out your terminal and try again.

## :camera_flash: Screenshots

> Screenshots taken by [**Awesomeshot**](https://github.com/mayTermux/awesomeshot) and system fetch by [**rxfetch-termux**](https://github.com/mayTermux/rxfetch-termux)

### System Fetch

> rxfetch

![rxfetch](https://user-images.githubusercontent.com/64394320/170211137-554dfd78-8424-4699-876c-7483b45de068.png)

> neofetch

![neofetch_out](https://user-images.githubusercontent.com/64394320/170211168-9e44dab1-7047-4f12-985c-3608b93ee033.png)

### Colorscheme (Theme)

> Change colorscheme with:

```bash
chcolor
```

![chcolor_out](https://user-images.githubusercontent.com/64394320/170211188-69f6317f-31e5-4feb-8422-3b0912ec3f8d.png)

### Fonts

> Change font with:

```bash
chfont
```

![chfont_out](https://user-images.githubusercontent.com/64394320/170211200-74ffac55-3181-4b43-9faa-a076ba847a70.png)

### Fish Theme

> Change Fish prompt theme with:

```bash
chfish
```

![fish_out](https://user-images.githubusercontent.com/64394320/170211230-059d59be-376b-440c-9fb9-ea3750c983b9.png)

### NVIM - Text Editor

![nvim_out](https://user-images.githubusercontent.com/64394320/170211252-e11d41cf-7674-40e5-b1f8-11ac3320a83f.png)

### NYANCAT

![nyancat_out](https://user-images.githubusercontent.com/64394320/170211265-40e42967-1aee-40ad-9a39-11e9a45139ee.png)

## Credits

- [siduck](https://github.com/siduck) — Neovim Setup (NvChad), Colorscheme (onedark-siduck)
- [owl4ce](https://github.com/owl4ce) — First introduction to dotfiles
- [adi1090x](https://github.com/adi1090x) — Termux Setup
- [bandithijo](https://github.com/bandithijo) — Awesome screenshot like MacOS using imagemagick
- [lwotcynna](https://github.com/lwotcynna) — Contributor
- [nekonako](https://github.com/nekonako) — Colorscheme nekonako-djancoeg, nekonako-hue, nekonako-om-mar
- [Dotfiles Indonesia](https://t.me/dotfiles_id)
- [Vim Indonesia](https://t.me/VimID)
- [Bashid.org](https://t.me/bashidorg)

## Colorscheme

- [catppuccin/termux](https://github.com/catppuccin/termux)
