# Gabarits et procédure de vérification de `/presta-setup`

Règles communes :

- **Vouvoiement** dans tout ce qui s'adresse au lecteur.
- **Markdown pur.** Ça doit se lire en texte brut et se differ dans git.
- **Tout est daté.** Une commande vérifiée, une capture, un rapport de phase portent leur
  date.
- **Identifiants** : préfixe + numéro + slug, en majuscules, sans accents —
  `E-03-MOT-DE-PASSE-OUBLIE`, `M-06-TRANSACTION`, `D-02-FOURNISSEUR-COTATION`,
  `P-01-SETUP`. Le slug fait 1 à 3 mots significatifs, sans article. **Il n'existe pas de
  forme courte** : un identifiant s'écrit toujours en entier, partout, y compris dans la
  conversation. Le numéro ne se réutilise jamais et reste unique sur toute la vie du
  projet — il ne repart pas à 1 au livrable suivant. Dans un nom de fichier, le même
  identifiant s'écrit en minuscules : `phases/p-01-setup.md`.
- **Aucun secret nulle part sous `presta/`, ni dans un fichier versionné.** Les clés vivent
  dans `.env`, gitignoré.
- **Aucune commande écrite ici de mémoire.** Tout ce qui figure dans `AGENTS.md` a tourné
  au moins une fois pendant le setup.
- **Horodatage** : le champ `maj:` porte la date **et l'heure à la seconde**, en
  ISO-8601 — `2026-08-20T14:32:07`, obtenu avec `date +%FT%T`. C'est ce qui permet à un
  fichier dérivé de savoir qu'il est périmé : deux écritures du même jour se distinguent.
  Les noms de fichiers, eux, ne portent que la date.

---

## `AGENTS.md` — la racine

C'est le fichier d'outillage : **ce qu'il faut taper**. Il ne redit pas ce que fait
l'application, il pointe vers `presta/regles-projet.md`.

**Court.** Un `AGENTS.md` de deux cents lignes n'est pas lu. Si une section grossit, elle
appartient à `presta/`.

```markdown
# {Nom du projet}

> Lisez `presta/regles-projet.md` avant toute action sur ce projet.

Application {web / mobile / bureau} en {stack}, base {moteur}.

## Commandes

| | |
|---|---|
| Lancer | `python manage.py runserver` — http://127.0.0.1:8000 |
| Migrations | `python manage.py migrate` |
| Nouvelle migration | `python manage.py makemigrations` |
| Tests | pas encore configurés — `/presta-tests` |
| Contrôle | `python manage.py check` |
| Linter | `ruff check .` |

Les variables d'environnement sont dans `.env`, modèle dans `.env.example`.

## Organisation du code

Trois applications : `accounts`, `market`, `portfolio`.
Les règles d'architecture sont dans `presta/specs/spec-architecture.md` et
`presta/specs/spec-architecture-complement-django.md`. **En cas de contradiction, le
complément l'emporte.**

## Carte de presta/

| | |
|---|---|
| `presta/regles-projet.md` | Le produit, les rôles, les décisions figées. À lire en premier |
| `presta/status.md` | Où en est le projet |
| `presta/specs/` | L'état courant des spécifications |
| `presta/maquettes/` | Le design system et les aperçus d'écrans |
| `presta/livrables/` | Les phases, les rapports, les recettes |
| `presta/elements-a-fournir.md` | Les tâches côté utilisateur. **L'IA n'y coche jamais rien** |
```

Quatre points à ne pas rater :

- **La ligne « Tests » reste un renvoi vers `/presta-tests`**, tant que rien n'est
  configuré. Jamais une commande plausible mais fausse : un agent qui lit `dotnet test`
  ou `pytest` dans ce tableau la croit exécutable, et rapporte un échec de lancement comme
  un échec de tests.
- **Le pointeur est impératif.** « Lisez `presta/regles-projet.md` avant toute action » —
  pas « voir aussi ». C'est ce qui fait tenir la chaîne `CLAUDE.md` → `AGENTS.md` →
  `presta/regles-projet.md`.
- **Les commandes de base de données sont nommées** : c'est là que la phase socle viendra
  ajouter `db:reset` et `db:seed`.
- **Le tableau des commandes est la seule source.** Une commande qui change se met à jour
  ici, nulle part ailleurs.

### S'il existe déjà

On ne l'écrase pas. On ajoute les sections absentes, dans l'ordre du gabarit, et on
complète le tableau des commandes avec celles qui manquent. Ce que l'utilisateur a écrit
reste tel quel, y compris s'il dit autre chose que ce que vous auriez écrit.

---

## `.env` et `.env.example`

Les deux fichiers portent **les mêmes lignes**. `.env` reste vide de valeurs, `.env.example`
est versionné.

```
# Base de données
DATABASE_URL=postgresql://localhost:5432/delta_dev

# Fournisseur de cotation — D-02-FOURNISSEUR-COTATION
# Compte à créer : voir presta/elements-a-fournir.md
QUOTES_API_KEY=

# Envoi des e-mails — E-03-MOT-DE-PASSE-OUBLIE
EMAIL_HOST_USER=
EMAIL_HOST_PASSWORD=
```

- **Une ligne par clé nommée dans les specs**, jamais une clé inventée.
- **Chaque groupe porte ce à quoi il sert**, en `E-xx`, `M-xx` ou `D-xx`. Une variable
  d'environnement sans contexte finit par être remplie au hasard ou supprimée.
- **`DATABASE_URL` porte une valeur**, c'est la base locale créée par le setup. Les autres
  sont vides : elles attendent l'utilisateur.
- **`.env` figure dans le `.gitignore` avant le premier commit.** Un `.env` parti dans
  l'historique git y reste.

---

## `.gitignore`

Écrit avant le premier commit, dans cet ordre :

```
.env
```

puis le contenu standard de la stack — environnement virtuel, dossiers de build, caches,
fichiers d'éditeur. Et les dossiers de `presta/` qui n'ont pas à être versionnés : aucun à
ce stade, `presta/` se versionne en entier.

S'il existe déjà, on ajoute `.env` s'il manque et on ne touche à rien d'autre.

---

## `presta/livrables/{livrable}/rapports/p-01-setup.md`

`{livrable}` est le champ `livrable_courant` de `presta/status.md`, lu tel quel. Voir la
règle de résolution dans les gabarits de `/presta-rdv`.

Le rapport de P-01-SETUP. Même forme que les rapports des phases suivantes : ce qui a été
fait, ce qui a été prouvé, ce qui reste ouvert.

**Le nom, lui, ne porte pas de suffixe** — les phases suivantes produisent une paire
`p-xx-{slug}-implementation.md` / `p-xx-{slug}-verification.md`, écrites par deux
sous-agents différents. P-01-SETUP n'a pas ce découpage : `/presta-setup` met en place et
vérifie lui-même. Il n'y a donc qu'un rapport, et un suffixe annoncerait un second fichier
qui n'existera jamais.

```markdown
---
phase: P-01-SETUP
date: 2026-08-07
---

# P-01-SETUP — rapport

## Ce qui a été mis en place

| | |
|---|---|
| Squelette | `django-admin startproject delta .`, 3 applications : accounts, market, portfolio |
| Dépendances | Django 6.1, psycopg 3.2, python-dotenv, pytest-django |
| Base | delta_dev en local, 18 migrations Django appliquées |
| Design system | `design-system.css` copié dans `static/css/`, branché à `templates/base.html` |
| Environnement | `.env` (3 clés à compléter) et `.env.example` |
| Git | dépôt initialisé, commit `P-01-SETUP — initialisation du projet` |

## Les critères

| | Critère | Preuve |
|---|---|---|
| [x] | Le projet compile | `python manage.py check` → "System check identified no issues (0 silenced)" |
| [x] | Les migrations passent | `python manage.py migrate` → 18 appliquées |
| [x] | L'application se lance | `python manage.py runserver` → http://127.0.0.1:8000, réponse 200 |
| [ ] | J'accède au navigateur | pas de navigateur disponible dans cet agent |

## Ce qui reste ouvert

- Accès navigateur absent. La vérification de chaque phase sera partielle tant que
  c'est le cas. Ligne ajoutée dans `presta/elements-a-fournir.md`.

## Écarts

- Aucun.
```

Trois règles :

- **Aucun champ de statut dans ce frontmatter.** Le statut d'une phase vit dans le
  frontmatter de `phases/p-01-setup.md`, et nulle part ailleurs. Un rapport qui porterait
  `statut:` créerait une deuxième vérité, qui divergerait.
- **Un critère non passé reste non coché**, avec ce qui l'a empêché. Il ne se rattrape pas
  au lancement suivant par optimisme : il se revérifie.
- **La section « écarts » est obligatoire**, même vide. C'est là que se déclare une
  dérogation à `spec-architecture-complement-{stack}.md` — typiquement une arborescence
  existante qu'on a gardée telle quelle.

---

## `presta/livrables/{livrable}/phases/p-01-setup.md` — le champ `etat`

Ce fichier appartient à `/presta-phases`. **Le setup n'y touche qu'à une ligne du
frontmatter :**

```markdown
---
phase: P-01-SETUP
etat: validée
---
```

| Ce qui a été constaté | `etat` |
|---|---|
| Tous les critères cochés | `validée` |
| Un critère au moins non coché | `en cours` |

Les trois valeurs possibles sont `à faire`, `en cours`, `validée`.

C'est la **source d'autorité** de l'avancement : `phases/index.md` ne porte aucun statut,
et ce que `presta/status.md` en affiche n'est qu'un report. C'est ce qui rend
`/presta-implemente` idempotente — elle relit les frontmatters et reprend là où on en est.

**Les critères de validation ne se modifient pas ici**, même si l'un d'eux s'avère mal
formulé pendant le setup. Ils appartiennent à la phase, et un vérificateur qui réécrit ses
propres critères ne vérifie plus rien. Ce qui coince se dit dans la section « écarts » du
rapport.

---

## `presta/elements-a-fournir.md`

Une puce par tâche, dans la section de priorité qui convient. Ce que ça bloque est nommé
en `E-xx`, `M-xx` ou phase — jamais « le projet ». Le setup ajoute deux familles de
lignes : les clés que le `.env` attend, et l'outillage manquant. Les deux vont en
« Maintenant ».

```markdown
- [ ] **Compte Fournisseur A** — la clé va dans `.env`, ligne `QUOTES_API_KEY=`, déjà
  créée vide par le setup. Bloque P-06-COTATIONS : sans elle, aucun cours n'arrive.
- [ ] **Serveur MCP Playwright** — à installer dans votre agent, ça se déclare dans sa
  configuration et je n'y touche pas. Bloque la vérification à l'écran de toutes les
  phases : le vérificateur rapportera chaque critère visuel en bloqué.
```

S'il a choisi de rester en local, la ligne du dépôt distant porte **les commandes**, pas
seulement l'intention : il ne doit rien avoir à redemander le jour où il crée son dépôt.

**Le format du fichier est défini dans les gabarits de `/presta-rdv`** — une puce
`- [ ]`, dans la section de priorité qui convient. Celle-ci va en « Plus tard /
optionnel » :

```markdown
- [ ] **Dépôt distant** — quand vous en aurez un. Ne bloque rien : le projet fonctionne
  en local. Créez-le **vide** sur GitHub — sans README, sans .gitignore, sans licence —
  puis lancez ces deux commandes :
  1. `git remote add origin {URL}`
  2. `git push -u origin main`
```

Le fichier appartient à l'utilisateur : **l'IA n'y coche jamais rien.**

---

## `presta/status.md`

Le champ `etape:` passe à `setup`. Le frontmatter est défini dans `/presta-rdv`.

---

## `presta/regles-projet.md`

La structure est définie dans `/presta-rdv`. À inscrire, si elle n'y est pas déjà :

> Les commandes du projet vivent dans `AGENTS.md`. Une commande qui change se met à jour
> là, et nulle part ailleurs.

Et dans la carte des fichiers :

```markdown
- `AGENTS.md` — les commandes réelles du projet
- `.env` — les secrets, jamais versionné. Modèle dans `.env.example`
```

---

## La procédure de vérification

Quatre critères, dans cet ordre. Chacun produit **une preuve citable** : la commande et sa
sortie, l'URL et le code de réponse, le chemin d'une capture. Les commandes ci-dessous sont
des exemples — les vraies sont celles de la stack du projet, et elles finissent dans
`AGENTS.md`.

| | Critère | Comment on le prouve | Exemples de commande |
|---|---|---|---|
| 1 | **Le projet compile** | La commande de contrôle de la stack rend une sortie sans erreur | `python manage.py check`, `npm run build`, `dotnet build`, `go build ./...` |
| 2 | **La base répond** | Les migrations du framework passent sur la base réelle | `python manage.py migrate`, `npx prisma migrate dev`, `dotnet ef database update` |
| 3 | **L'application se lance** | Le serveur démarre en tâche de fond, une requête sur la page d'accueil rend un code de succès | lancer, puis `curl -I http://127.0.0.1:8000` |
| 4 | **Vous accédez au navigateur** | La page s'ouvre, une capture est écrite dans `presta/annexes/setup-page-accueil.png`, et vous l'ouvrez à l'utilisateur | navigateur piloté, ou capture native de l'agent |

Trois règles :

- **Le serveur se lance en tâche de fond et s'arrête après le critère 4.** On ne laisse pas
  un processus tourner derrière soi.
- **Un critère qui dépend d'un critère non passé ne passe pas non plus.** Si la base ne
  répond pas, « l'application se lance » ne se coche pas parce que la page d'accueil, elle,
  s'affiche.
- **Sur un projet sans base de données**, le critère 2 disparaît. Il ne se remplace pas par
  autre chose et ne se coche pas par défaut : il n'existe pas.

### Sur un projet déjà initialisé

Les quatre critères sont les mêmes. Ce qui change, c'est qu'on ne connaît pas les commandes
d'avance : on les cherche là où elles vivent — `package.json`, `Makefile`, `pyproject.toml`,
la documentation du dépôt — et on les essaie. Ce sont ces commandes-là, celles qui ont
réellement tourné, qui vont dans `AGENTS.md`.
