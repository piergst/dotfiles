# dotfiles (archivé)

> **Ce dépôt est archivé et n'est plus maintenu.**
>
> Il contenait mes fichiers de configuration gérés avec [chezmoi](https://www.chezmoi.io/),
> utilisés lorsque je tournais sous **Arch Linux**. Je suis depuis passé à **NixOS**, où la
> configuration système et utilisateur est déclarative et versionnée directement dans ma
> configuration Nix ; ce dépôt n'est donc plus déployé.
>
> Je le conserve en **référence** : certaines configurations (Neovim, zsh, thème oh-my-posh,
> réglages d'applications) restent utiles à consulter ou à porter ailleurs. Aucune mise à jour
> ni support n'est assuré.

## Comment c'était déployé

Dépôt au format *source state* de chezmoi. La commande `chezmoi apply` transformait l'arborescence
en fichiers réels dans `$HOME` :

| Préfixe / dossier | Effet |
|---|---|
| `dot_` | préfixe retiré, préfixe `.` ajouté (`dot_zshrc.tmpl` → `~/.zshrc`) |
| `private_` | préfixe retiré, permissions restrictives (`private_Code - OSS` → `~/.config/Code - OSS`) |
| `executable_` | bit exécutable positionné |
| `.chezmoitemplates/` | fragments de templates réutilisables (`zshrc_common`, `zsh_aliases_common`, `zsh_keybindings_common`, `omp_theme_common`) |
| `.chezmoi.toml.tmpl` | variables par machine, demandées au premier lancement |
| `.chezmoiignore` | fichiers exclus du déploiement selon la machine |

Le fichier `.chezmoi.toml.tmpl` collecte les données propres à chaque poste : `deviceName`,
`hasExegol`, les interfaces `wlan`/`eth` et les trois noms d'écrans (`leftScreen`, `centerScreen`,
`rightScreen`). Ces valeurs alimentent les templates i3 et polybar. `.chezmoiignore` n'installe
`~/.exegol` que si `hasExegol` est vrai, et laisse hors dépôt les fichiers d'état de Neovim
(`lazy-lock.json`, `lazyvim.json`).

## Contenu de la configuration

Environnement **Arch Linux sous X11**, orienté pentest et développement.

- **Shell — zsh + oh-my-zsh** : plugins `zsh-autosuggestions`, `zsh-completions`,
  `zsh-history-substring-search`, `zoxide`, `zsh-syntax-highlighting`. Prompt **oh-my-posh** avec
  thème maison (`my-theme.omp.json`). Alias basés sur `eza` (`ls`, `ll`, `la`, `lt`), `bat`, `trash`,
  `git`, plus des fonctions utilitaires (recherche d'historique via `fzf`, `topp` pour les ports nmap,
  `wgetpage` pour archiver une page web). Keybindings `Alt`-* personnalisés.
- **Gestionnaire de fenêtres — i3** : `Mod4` comme modificateur, 12 workspaces répartis sur
  trois écrans (variables `left`/`center`/`right`), changement de disposition clavier FR/US,
  `rofi` comme lanceur (`Mod4+d`), `clipmenu` (`Mod4+c`), fond d'écran par `xwallpaper`,
  compositeur `picom`, notifications `dunst`, `redshift`, indicateur de volume `xob`,
  luminosité via `brightnessctl`, volume via `pactl`.
- **Barre — polybar** : panneau supérieur, palette sombre.
- **Lanceur — rofi** : thème Gruvbox (dark hard).
- **Terminal — alacritty** : padding, taille de police, bindings mode vi et copier/coller `Alt+p`/`Alt+y`.
  `~/.Xresources` fournit en complément les réglages Xft et rxvt-unicode.
- **Éditeur — Neovim** : distribution **LazyVim**, extras markdown, Python, tests et dashboard,
  plugins additionnels `flash`, `neo-tree`, `pastify`, dictionnaires de correction `fr` et `en`.
- **Exegol** : ressources personnalisées (`~/.exegol/my-resources`) pour les conteneurs de pentest —
  installation de `eza`, `zoxide`, `ripgrep`, thème oh-my-posh, alias et keybindings partagés avec
  la config zsh locale, synchronisation des plugins Neovim.
- **VS Code** (`Code - OSS`) : `settings.json` et `keybindings.json`.
- **tmux** : configuration minimale (défilement à la souris).

## Structure

```
.chezmoitemplates/     fragments de templates partagés (zsh, oh-my-posh)
.chezmoi.toml.tmpl      variables par machine (écrans, interfaces, Exegol)
.chezmoiignore          exclusions conditionnelles
dot_config/             ~/.config  (i3, polybar, rofi, alacritty, nvim, Code - OSS, zsh)
dot_exegol/             ~/.exegol  (ressources personnalisées Exegol)
dot_oh-my-zsh/          ~/.oh-my-zsh/custom  (alias et keybindings)
dot_tmux.conf           ~/.tmux.conf
dot_Xresources          ~/.Xresources
dot_zshrc.tmpl          ~/.zshrc
```
