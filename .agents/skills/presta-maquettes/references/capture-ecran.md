# Ouvrir et capturer un aperçu

Deux gestes différents, qu'il ne faut pas confondre.

- **Ouvrir** — pour que l'utilisateur regarde. C'est le cas courant : il juge, il tranche.
- **Capturer** — pour que *vous* regardiez. Sert à vérifier votre propre production avant de
  la montrer, et à comparer une capture d'implémentation à la maquette validée.

---

## Ouvrir

| Système | Commande |
|---|---|
| macOS | `open <fichier>` |
| Windows | `start "" <fichier>` |
| Linux | `xdg-open <fichier>` |

Plusieurs fichiers en une fois : `open a.html b.html c.html`.

**Affichez toujours le chemin en plus**, sur une ligne, entre parenthèses. Selon le mode de
permission, la commande peut être refusée ou passer inaperçue — l'utilisateur doit pouvoir
ouvrir le fichier lui-même.

> (presta/maquettes/apercus/directions/index.html si l'onglet ne s'est pas ouvert)

**Une planche de contact plutôt que cinq onglets.** Quand il y a plusieurs aperçus à
comparer, ouvrez le `index.html` du dossier : il affiche les pages en vignettes, chacune
cliquable pour s'ouvrir en grand. Un geste au lieu de cinq.

La planche a besoin des fichiers voisins : copiez **le dossier entier**, jamais un fichier
isolé.

---

## Capturer

Chrome en mode sans interface. Aucune installation, aucun serveur, aucun MCP — c'est ce qui
rend la boucle portable sur Claude Code, Codex et Antigravity.

**macOS**

```bash
"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
  --headless --disable-gpu --hide-scrollbars \
  --window-size=1500,2400 \
  --screenshot="sortie.png" \
  "<chemin absolu du fichier>"
```

**Windows** — chemin d'installation standard, à adapter si Chrome est ailleurs

```
"C:\Program Files\Google\Chrome\Application\chrome.exe" ^
  --headless --disable-gpu --hide-scrollbars ^
  --window-size=1500,2400 ^
  --screenshot="sortie.png" ^
  "<chemin absolu du fichier>"
```

**Linux** — `google-chrome`, `google-chrome-stable` ou `chromium` selon la distribution.

Puis lisez le PNG produit.

### Les options qui comptent

| Option | Pourquoi |
|---|---|
| `--window-size=L,H` | La hauteur détermine ce qui entre dans l'image. Une page longue se capture en plusieurs fois, ou avec une hauteur élevée. |
| `--hide-scrollbars` | Sans ça, une barre de défilement traverse la capture. |
| `--virtual-time-budget=4000` | Nécessaire quand la page charge une police web ou contient des `iframe` : sans attente, la capture sort avec la police de repli. |

---

## Quand Chrome n'est pas là

Ne bloquez pas, et ne faites pas semblant d'avoir vu.

```
Je n'ai pas trouvé Chrome sur cette machine, je ne peux donc pas regarder la
page moi-même.

Ouvrez presta/maquettes/apercus/e-05-mes-actions.html et dites-moi ce qui ne va pas — ou
collez-moi une capture, je la lirai.
```

**Ne prétendez jamais avoir vérifié visuellement une page que vous n'avez pas capturée.**
Décrire ce qu'un CSS « devrait » produire n'est pas une vérification, et une erreur de
disposition ne se voit que sur l'image.
