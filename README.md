<div align="center">

![Last commit](https://img.shields.io/github/last-commit/Comamoca/nur-packages?style=flat-square)
![Repository Stars](https://img.shields.io/github/stars/Comamoca/nur-packages?style=flat-square)
![Issues](https://img.shields.io/github/issues/Comamoca/nur-packages?style=flat-square)
![Open Issues](https://img.shields.io/github/issues-raw/Comamoca/nur-packages?style=flat-square)
![Bug Issues](https://img.shields.io/github/issues/Comamoca/nur-packages/bug?style=flat-square)
![Issues](https://img.shields.io/github/issues/Comamoca/nur-packages?style=flat-square)
![Build](https://github.com/Comamoca/nur-packages/workflows/Build%20and%20populate%20cache/badge.svg)
[![Cachix Cache](https://img.shields.io/badge/cachix-comamoca-blue.svg)](https://comamoca.cachix.org)


<img src="https://emoji2svg.deno.dev/api/🦊" alt="eyecatch" height="100">

# nur-packages

Comamoca's Nix user repository.

<br>
<br>

</div>

<div align="center">

</div>

## 🚀 How to use

### with Flake

Add reopsitory to inputs.

> [!NOTE]
> This repository support binary cache with use cachix.
> If you have cachix, run `cachix use comamoca` can use binary cache.

```nix
inputs = {
  nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
  nur-packages.url = "github:Comamoca/nur-packages";
};
```
Then use packages.

```nix
system = "x86_64-linux"; # Set your system
nurpkgs = nur.legacyPackages.${system};
nurpkgs.programming-english
```

With overlay.

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur-packages.url = "github:Comamoca/nur-packages";
  };

  outputs = { self, nixpkgs, nur-packages }: {
    nixpkgs.overlays = [
      (import "${nur-packages}/overlay.nix")
    ];
  };
}
```

## 📦 Package List

Name|Description|Homepage|License|Platforms|
----|-----------|--------|-------|---------|
programming-english|プログラミング英語検定学習に使用するデータをいろいろ詰め合わせ|https://github.com/MatsumotoDesuyo/programming-english|N/A|x86_64-darwin, aarch64-darwin, aarch64-linux, x86_64-linux
skk-jisyo-imasparql| Nix flake support to SKK dictionaries for idolmaster.|https://github.com/banjun/skk-jisyo-imasparql|N/A|x86_64-darwin, aarch64-darwin, aarch64-linux, x86_64-linux

## ⛏️   Development

```sh
# build
nix-build

# format
nix fmt
```

## 📝 Todo

Nothing...

## 📜 License

MIT

## 👏 Affected projects

- [Nix User Repository](https://github.com/nix-community/NUR)

## 💕 Special Thanks

- [natsukium/nur-packages](https://github.com/natsukium/nur-packages)
