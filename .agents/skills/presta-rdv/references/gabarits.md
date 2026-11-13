# Gabarits des fichiers produits par `/presta-rdv`

Règles communes :

- **Vouvoiement** dans tout ce qui s'adresse au lecteur.
- **Markdown pur.** Pas d'images, pas de tableaux inutiles. Ça doit se lire en texte brut
  et se differ dans git.
- **Aucune supposition écrite.** Ce qui n'a pas été dit n'apparaît pas, ou apparaît en
  « en attente ».
- **Identifiants** : préfixe + numéro + slug, en majuscules, sans accents —
  `E-01-CREATION-COMPTE`, `M-06-TRANSACTION`, `D-02-FOURNISSEUR-COTATION`. Le slug fait
  1 à 3 mots significatifs, sans article. **Il n'existe pas de forme courte** : un
  identifiant s'écrit toujours en entier, partout, y compris dans la conversation. Le
  numéro ne change jamais et ne se réutilise jamais. Dans un nom de fichier, le même
  identifiant s'écrit en minuscules : `apercus/e-05-mes-actions.html`.
- **Le label du rendez-vous** apparaît dans le nom du compte-rendu et dans le champ
  `source:` des specs. Voir la règle de génération dans `SKILL.md`, étape 7.
- Sur projet existant, ces fichiers se **modifient**. Jamais de copie `v1/`, `v2/`.
- **Horodatage** : le champ `maj:` porte la date **et l'heure à la seconde**, en
  ISO-8601 — `2026-08-20T14:32:07`, obtenu avec `date +%FT%T`. C'est ce qui permet à un
  fichier dérivé de savoir qu'il est périmé : deux écritures du même jour se distinguent.
  Les noms de fichiers, eux, ne portent que la date.

---

## `presta/rdv/AAAA-MM-JJ-rdv-NN-{slug}.md`

Le compte-rendu validé, repris tel qu'il a été affiché — plus tout ce que l'utilisateur a
détaillé en cours de route et qui n'entrait pas dans le récap.

Le `{slug}` est le label du rendez-vous en kebab-case sans accents :
`2026-08-04-rdv-02-ajout-calendrier.md`. Le dossier `presta/rdv/` se lit alors dans
l'explorateur sans ouvrir un seul fichier.

```markdown
# Rendez-vous NN — {Label}

Projet : {Nom du projet}
Date : AAAA-MM-JJ

{Le paragraphe de contexte du récap.}

## Fonctionnalités
...

## Règles métier
...

## Utilisateurs et accès
...

## Périmètre — hors V1
...

## Technique
...

## Points à trancher
- D-NN-{SLUG} ...

## À prévoir côté client
- ...

## Détails donnés en séance
{Tout ce qui a été précisé au-delà du récap : cas particuliers, exemples chiffrés,
préférences. Rien ne se perd, même ce qui relève de la spec-écran. C'est ici que vivent
les comparatifs et les chiffres des options écartées, que les specs ne portent pas.}

## Documents fournis
- `presta/annexes/{fichier}` — {ce que c'est}
```

---

## `presta/specs/spec-produit.md`

```markdown
---
version: 1.0
maj: AAAA-MM-JJTHH:MM:SS
source: rdv-NN — {label}
---

# Spécification produit — {Nom du projet}

## À quoi sert l'application
{Le problème résolu, pour qui, ce que ça leur apporte. 3 à 5 lignes.}

## Utilisateurs et rôles
| Rôle | Qui c'est | Ce qu'il peut faire de particulier |
|---|---|---|

## Espaces
{Public, membre, back-office… Un par ligne, avec qui y entre.}

## Fonctionnalités
### F-NN-{SLUG} — {Titre}
{Ce que ça fait, en quelques lignes. Pas d'écran, pas de champ, pas d'implémentation.}

## Règles métier
- {La règle, nommée. Le détail viendra dans la spec-écran.}

## Hors périmètre
- {Ce que l'application ne fera pas, et pourquoi si ça a été dit.}

## Évolutions envisagées
{Ce qui est anticipé pour plus tard. Sert à ne pas se fermer de portes — schéma de
données, découpage — et non à ajouter de l'abstraction en V1.}
```

---

## `presta/specs/spec-technique.md`

```markdown
---
version: 1.0
maj: AAAA-MM-JJTHH:MM:SS
source: rdv-NN — {label}
---

# Spécification technique — {Nom du projet}

## Type d'application
{Web, mobile, bureau, PWA. Et le second type implicite s'il y en a un.}

## Stack
{Langage, framework, base de données. Si un choix reste ouvert, il devient une décision
ci-dessous, il ne s'écrit pas ici.}

**Moteur de base de données** : le même en développement qu'en production.

## Hébergement et publication
{Où ça tourne, comment c'est publié, contraintes connues.}

## Dépendances externes
| Service | Ce qu'on en attend | Coût / limite | Statut |
|---|---|---|---|

## Décisions techniques

### D-NN-{SLUG} — {Titre}
Statut : en attente | résolu
Enjeu : {ce qui se joue, en une phrase — pourquoi ça compte}
Piste : {l'option envisagée, et ce qu'il faut vérifier}
Ouvert le AAAA-MM-JJ (rdv-NN). {Les skills suivantes ouvrent aussi des D-xx ici, en
citant leur origine : « ouvert le AAAA-MM-JJ par /presta-spec, écran E-05-MES-ACTIONS ».}

<!-- Une fois résolu, ajouter :
Décision : {ce qui a été retenu, et pourquoi}
Preuve : `presta/annexes/{fichier}`
Résolu le AAAA-MM-JJ.
-->
```

Un point ne passe `résolu` que lorsqu'il est **vérifié**, pas lorsqu'on a avancé malgré
lui. Une hypothèse forcée reste `en attente`.

### La longueur — c'est ce document qui déborde

Le contenu de la spec technique est bon ; ce qui l'alourdit, ce sont les passages qui
expliquent. Trois règles :

- **Une justification de choix tient en une à trois phrases.** On garde la raison du choix
  retenu et le nom des options comparées. Leurs chiffres et le détail de la comparaison
  restent dans le compte-rendu.
- **Un report en V2 tient en deux phrases** : ce qui est reporté, et ce que ça change pour
  la V1 — le plus souvent, rien. Les conditions exactes se revérifieront au moment du
  portage ; d'ici là elles auront changé.
- **Ce qui n'a pas été retenu ne se justifie pas deux fois.** Le hors-périmètre est dans
  `spec-produit.md`.

Trop long :

> ### Pourquoi Flutter
> Quatre pistes ont été comparées au rendez-vous : Flutter, Tauri v2, Compose
> Multiplatform et .NET MAUI. Flutter a été retenu parce que macOS, iOS et Android y sont
> au même niveau de maturité, et que le portage mobile est l'objectif du choix.
>
> Tauri v2 était l'alternative la plus légère : environ 90 Mo de RAM au repos et 8 Mo
> d'installateur, contre environ 270 Mo et 25 Mo pour Flutter. Il a été écarté parce que
> son support iOS et Android est le plus récent des quatre et que tous les plugins
> disponibles sur bureau ne le sont pas encore sur mobile. Compose Multiplatform embarque
> un runtime Java pour la version Mac. .NET MAUI vise plutôt l'entreprise.

Juste :

> ### Pourquoi Flutter
> Comparé à Tauri v2, Compose Multiplatform et .NET MAUI. Retenu parce que macOS, iOS et
> Android y sont au même niveau de maturité, et que le portage mobile est l'objectif du
> choix. Le détail de la comparaison est dans le compte-rendu du rdv-NN.

Même traitement pour un report. Trop long : un paragraphe sur l'expiration des
applications auto-installées, le prix du compte développeur, l'alternative Android.
Juste :

> **V2 mobile, pour mémoire.** Publier sur iPhone demandera l'Apple Developer Program
> (99 $/an) ; sur Android, l'installation d'un APK signé est gratuite. Décision reportée au
> portage, sans effet sur la V1.

---

## `presta/elements-a-fournir.md`

**C'est ici qu'est défini le format de ce fichier.** Huit skills y ajoutent des lignes ;
aucune n'en invente une autre forme.

```markdown
# Éléments à fournir

⚠️ Ce fichier est à vous.
- Cochez `[x]` quand vous avez fait une tâche. L'IA ne coche jamais à votre place.
- Ne collez JAMAIS de clé d'API, de mot de passe ou de jeton ici : ce fichier est
  versionné dans git. Les secrets vont uniquement dans `.env`.

## 1. Maintenant — nécessaire pour faire tourner le projet

- [ ] **Clé Fournisseur A** — `.env`, ligne `QUOTES_API_KEY=`. Bloque P-06-COTATIONS :
  sans elle aucune cotation n'arrive, et E-04-TABLEAU-DE-BORD reste vide.
  1. Créez un compte sur https://exemple.test
  2. Générez une clé dans « API keys » — elle ne sera plus affichée ensuite

## 2. Avant la mise en production

- [ ] **Compte Apple Developer** — publication sur l'App Store. Ne bloque rien avant la
  livraison de la version iOS.
  **À reporter ici quand c'est fait :** e-mail du compte `………`, Team ID `………`

## 3. Plus tard / optionnel
```

Quatre règles, valables pour toutes les skills :

- **Une tâche = une puce `- [ ]`.** Le titre en gras, puis où ça se met, puis **ce que ça
  bloque en identifiant complet** — `E-xx`, `M-xx`, `P-xx` — et la conséquence concrète.
  Jamais « le projet ». Les étapes à suivre, quand elles ne vont pas de soi, se numérotent
  dessous.
- **Les sections sont des priorités, pas des numéros de phase.** « Bloquant phase 5 » ne
  veut plus rien dire trois semaines après ; la phase reste nommée, en détail secondaire.
- **L'IA n'y coche jamais rien.** Le fichier appartient à l'utilisateur, et c'est ce qui
  lève l'ambiguïté de la case. Une skill ajoute des lignes ; elle n'en coche aucune et
  n'en retire aucune.
- **Deux destinations selon la nature.** Les secrets vont exclusivement dans `.env`,
  gitignoré. Les informations non sensibles — e-mail de compte, identifiant de projet,
  URL — se reportent dans le fichier, sous `**À reporter ici quand c'est fait :**`, où
  l'IA ira les relire sans qu'on ait à les redonner.

Ce fichier est **alimenté en continu** par les autres skills. `/presta-rdv` ne fait
qu'ouvrir l'en-tête et les premières lignes.

---

## `presta/status.md`

Où en est le projet. **Il est lu au lancement de chaque skill** : il doit rester exact et
court. C'est aussi lui qui marque qu'un dossier est un projet Presta.

```markdown
---
projet: {Nom}
resume: {Une phrase. C'est ce qui s'affiche au message d'accueil.}
version: 1.0
etape: rdv
dernier_rdv: rdv-NN — {label}
livrable_courant: {vide tant que /presta-phases n'a pas découpé}
maj: AAAA-MM-JJTHH:MM:SS
---

# Où en est {Nom}

{Une ou deux lignes : ce qui vient d'être fait, ce qui vient ensuite.}

## Avancement des phases

{Vide jusqu'au développement. C'est `/presta-implemente` qui l'écrit : phase courante,
mode, phases validées.}
```

La section « Avancement des phases » est un **report**. Le statut d'une phase fait autorité
dans le champ `etat:` de son fichier, sous `presta/livrables/{livrable}/phases/` : en cas
de doute, c'est là qu'on relit, et c'est de là que le report se refait.

### Les neuf valeurs de `etape:`

**C'est ici qu'elles sont définies**, et il n'en existe pas d'autres. Chacune est posée par
une skill et une seule, à l'écriture de ses fichiers.

| `etape:` | Posée par | La suivante |
|---|---|---|
| `rdv` | `/presta-rdv` | `/presta-spec` |
| `specs` | `/presta-spec` | `/presta-modeles` |
| `modeles` | `/presta-modeles` | `/presta-maquettes` |
| `maquettes` | `/presta-maquettes` | `/presta-valide-specs` |
| `architecture` | `/presta-architecture` | `/presta-phases` |
| `phases` | `/presta-phases` | `/presta-setup` |
| `setup` | `/presta-setup` | `/presta-implemente` |
| `implementation` | `/presta-implemente`, au premier lancement | `/presta-implemente` |
| `livre` | `/presta-implemente`, en fin de livrable | `/presta-audit`, ou `/presta-rdv` pour la version suivante |

**Trois skills ne font jamais avancer `etape:`** — `/presta-valide-specs`,
`/presta-essais-techniques` et `/presta-audit`. Elles sont relançables à tout moment, et
une étape qu'elles poseraient bloquerait le retour en arrière. C'est pour ça qu'il n'y a
aucune valeur `validation` ni `audit` : leur avancement se lit à l'existence de leur
rapport, pas dans `status.md`.

Sur une évolution, `etape:` **repart à `rdv`** : le nouveau besoin recommence le cycle. Ce
qui a déjà été fait se lit à l'existence des fichiers, pas à la valeur de `etape:`.

### `{livrable}` — la règle de résolution, valable partout dans la méthode

Il n'y a **qu'un seul dossier de livrable à la fois**, et son nom est posé une fois pour
toutes par `/presta-phases`, qui l'écrit dans `livrable_courant`.

| Notation | Ce que c'est | Qui s'en sert |
|---|---|---|
| `v{version}-{slug}` | la **règle de fabrication** du nom — `v1.0-portefeuille-actions` | `/presta-phases`, une fois |
| `{livrable}` | le **contenu de `livrable_courant`**, lu tel quel | toutes les autres skills |

**Aucune skill autre que `/presta-phases` ne recompose ce nom.** Elle lit
`livrable_courant` et l'utilise tel quel. Un dossier recomposé de travers —
`presta/livrables/1.0/` au lieu de `presta/livrables/v1.0-portefeuille-actions/` — reste
orphelin : plus rien ne le lit, et le rapport qu'on y a posé est perdu.

`{version}` seul ne désigne **jamais** un dossier. Il ne s'emploie que dans un nom de
fichier qui porte réellement le numéro de version : `recette-complete-v1.0.md`, le tag
`v1.0`.

Le corps reste minimal : l'état tient dans le frontmatter. Une règle du projet n'a rien à
faire ici, elle va dans `regles-projet.md`.

---

## `presta/regles-projet.md`

Version minimale à la sortie du rendez-vous. Les skills suivantes l'enrichissent. C'est le
fichier que le sous-agent implémenteur lit en premier : il porte les **règles** du projet,
jamais son avancement.

```markdown
---
projet: {Nom}
maj: AAAA-MM-JJTHH:MM:SS
---

# Règles du projet — {Nom}

> Lisez ce fichier avant toute action sur ce projet.

## À quoi sert l'application
{2 à 3 lignes.}

## Les rôles
- {Rôle} — {ce qu'il fait}

## Ce qui est hors périmètre
- ...

## Décisions figées
| Décision | Pourquoi |
|---|---|

## Règle de fonctionnement
Un changement de besoin met à jour les spécifications **avant** le code. Jamais
l'inverse.

## Carte des fichiers
- `presta/status.md` — où en est le projet
- `presta/specs/` — l'état courant des spécifications
- `presta/rdv/` — les comptes-rendus de rendez-vous
- `presta/elements-a-fournir.md` — les tâches côté client
```

`maj:` ne bouge que quand le corps change, c'est-à-dire quand une règle est ajoutée. Une
skill qui n'ajoute aucune règle ne touche pas à ce fichier.
