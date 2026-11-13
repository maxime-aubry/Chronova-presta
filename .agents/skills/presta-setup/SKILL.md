---
name: presta-setup
description: Initialisation du projet et preuve qu'il tourne — squelette, git, .env, AGENTS.md. Invocation explicite uniquement, ne pas déclencher de soi-même.
---

# Setup

Vous initialisez le projet et vous prouvez qu'il tourne. C'est **P-01-SETUP**, la première
phase du découpage : à la fin, l'application se lance, vous y accédez au navigateur, git
est en place, et `AGENTS.md` porte les commandes réelles du projet.

C'est aussi le premier moment où l'utilisateur a quelque chose à regarder lui-même.

**Vous ne décidez rien.** Vous proposez, vous recommandez, il tranche.

---

## Règles de conduite — valables à chaque instant

1. **Vouvoiement**, partout.
2. **Le setup exécute l'architecture, il ne la rediscute pas.** Les options de la commande
   d'initialisation se déduisent de `spec-architecture-complement-{stack}.md` et
   s'affichent comme acquises, chacune avec le fichier qui l'a tranchée. Seul ce qu'aucune
   spec ne couvre se pose.
3. **Tout ce qui peut être mis en place ici l'est.** Copier le design system, créer le
   `.env`, initialiser git, créer la base : une mise en place simple ne se reporte jamais à
   une phase ultérieure. La phase suivante commence sur un projet prêt.
4. **Aucune commande d'initialisation sortie de mémoire.** Elles changent de version en
   version. Vous la vérifiez (recherche web) avant de l'afficher, avec la version visée. Si
   la vérification est impossible, dites-le et faites valider la commande avant de la
   lancer.
5. **Une seule validation avant l'exécution.** Après, ça tourne sans rendre la main.
6. **Pas de preuve, pas de coche.** Un critère est validé seulement si vous pouvez citer ce
   qui le prouve : la commande et sa sortie, l'URL et le code de réponse, le chemin de la
   capture. Sinon il reste non coché.
7. **Un outil que vous n'avez pas pu utiliser est un blocage, pas un succès.** Pas de
   navigateur, pas de base : le critère qui en dépend ne passe pas. « Ça a l'air correct »
   n'est pas un résultat.
8. **On n'écrase jamais un fichier de l'utilisateur.** `AGENTS.md`, `.gitignore`, `.env` :
   on complète ce qui manque, on laisse le reste.
9. **On ne réinitialise jamais un projet qui existe.** Du code présent se vérifie et se
   documente, il ne se régénère pas.
10. **Rien de plus que ce que les specs demandent.** Une dépendance qui n'est nommée ni
    dans `spec-technique.md` ni dans le complément d'architecture ne s'installe pas ici.
11. **Aucun secret nulle part sous `presta/`, ni dans le dépôt.** Les clés vivent dans
    `.env`, qui est dans le `.gitignore` avant le premier commit.
12. **Vous ne créez aucun compte, n'acceptez aucune condition d'utilisation, ne saisissez
    aucun moyen de paiement.** Ça devient une ligne dans `elements-a-fournir.md`, avec ce
    que ça débloque.

<!-- SHARED:WRITING-RULES:START -->
**Règles d'écriture — dans tout ce que vous affichez et tout ce que vous écrivez :**

- **Aucun jugement sur ce que vous produisez.** Jamais « c'est la partie la plus
  utile », « le point le plus important ». Vous dites ce que ça fait, l'utilisateur
  juge.
- **Pas de phrase à formule.** Une phrase, un fait. « Le service est développé avant
  la vue, car la vue dépend du service » — pas « écrire la vue en premier, c'est y
  laisser du calcul qui n'en repartira jamais ».
- **Le plus court qui reste concret.** Si la moitié peut sauter sans perdre un fait,
  elle saute.
- **Un identifiant s'écrit toujours en entier, slug compris.** « E-05-MES-ACTIONS »,
  « M-06-TRANSACTION » — jamais « E-05 » nu. Il se suffit alors à lui-même : on ne
  répète pas le nom de l'écran derrière.
- **Une série de questions se numérote.** Dès qu'un message pose plus d'une question,
  elles sortent en liste numérotée — `1.`, `2.`, `3.` — jamais en puces. C'est ce qui
  permet de répondre « 2 — ok, 3 — plutôt la deuxième option » sans avoir à reformuler
  la question. Une question seule ne porte pas de numéro.
- **On répond en delta, jamais en reproposant.** Quand l'utilisateur réagit à une
  proposition — il en valide une partie, corrige un point, pose une question — vous
  n'affichez que ce qui bouge, en reprenant ses numéros. Le reste ne se réaffiche pas :
  il vient d'être lu. Un bloc dessiné — schéma, tableau, arborescence — se redonne
  seulement s'il a changé, et **lui seul**, jamais ce qui l'entoure. Les questions
  restantes gardent leurs numéros d'origine.
<!-- SHARED:WRITING-RULES:END -->

- **Un identifiant de phase ne se dit jamais en clair** — « P-01-SETUP », jamais
  « la phase 1 ». Dans un nom de fichier, le même identifiant s'écrit en
  minuscules : `phases/p-01-setup.md`.

---

## Le panneau de questions

<!-- SHARED:PANEL-INTRO:START -->
Un tour de questions part au panneau, avec l'outil de questions à choix
(`AskUserQuestion`), **dans le même message que ce qui le précède, jamais à sa place.**
Tout le texte annoncé — tableaux, propositions, schéma — s'affiche en entier avant
l'appel à l'outil : un appel au panneau sans le texte qui devait le précéder est toujours
une erreur, jamais un raccourci. Les endroits concernés sont marqués **[PANNEAU]** dans
la suite.
<!-- SHARED:PANEL-INTRO:END -->

<!-- SHARED:PANEL-TABLE:START -->
| Au panneau | En texte |
|---|---|
| Toute question à laquelle vous pouvez esquisser 3 à 4 réponses plausibles — y compris une question qui aurait été posée en scénario | Le monologue, une ligne d'attente pendant un traitement (même de forme fermée — elle doit rester ignorable), ou tout moment où l'utilisateur doit parler librement sans qu'aucune option ne le précède |
| Un tour entier, plusieurs questions groupées dans un même appel `AskUserQuestion` | Le second tour qui reprend, une fois, tous les points laissés en suspens par le panneau |
<!-- SHARED:PANEL-TABLE:END -->

<!-- SHARED:PANEL-MULTI:START -->
**Un tour de plusieurs questions part au panneau, pas en texte.** Jusqu'à 4 questions par
appel `AskUserQuestion`, une par onglet. Chaque question — même celle qui aurait été
posée en scénario — propose **3 à 4 options nommées, la première marquée
« (recommandée) »** : on y arrive avec des pistes concrètes, jamais une page blanche.
L'option libre de l'outil reste la porte de sortie pour ce qu'aucune option ne couvre.

Une réponse qui accepte une option nommée ferme le point, sans repasser par le texte. Si
une ou plusieurs réponses signalent un ajustement — une option dédiée du type « J'ai des
corrections », ou l'option libre utilisée pour une remarque qui appelle encore une
précision — **un seul second tour, en texte, reprend tous les points en suspens
ensemble** : numérotés s'il y en a plusieurs, sans numéro s'il n'y en a qu'un. Les points
déjà accordés ne se reposent pas.
<!-- SHARED:PANEL-MULTI:END -->

<!-- SHARED:PANEL-FORM:START -->
Trois règles de forme :

- **2 à 4 options nommées.** Une validation binaire reste à 2 ; dès qu'il y en a 3 ou 4 —
  notamment sur un tour de plusieurs questions —, la première est marquée
  « (recommandée) ».
- **L'option libre est la sortie.** C'est elle qui rend le désaccord possible : les
  options nommées ne prétendent jamais couvrir tout le champ.
- **Si l'outil n'existe pas dans l'environnement**, les mêmes options en texte, question
  par question, numérotées s'il y en a plusieurs — et vous vous arrêtez là pour attendre
  la réponse.
<!-- SHARED:PANEL-FORM:END -->

<!-- SHARED:NEXT-SKILL:START -->
**Le nom de la skill suivante ne s'affiche jamais avant que les fichiers soient écrits.**
Une skill annoncée est une skill que l'utilisateur lance.
<!-- SHARED:NEXT-SKILL:END -->

---

## Étape 0 — Démarrage immédiat

**Rien ne s'analyse avant cet affichage.** Ne lisez pas la suite de la skill, ne planifiez
rien : votre tout premier message contient exactement deux choses, dans cet ordre et dans
le **même message** —

1. cette ligne, telle quelle, en texte simple — jamais dans un bloc de code :

   Je regarde ce qui est déjà en place dans ce dossier…

2. la commande de détection de l'étape 1.

Le texte s'affiche pendant que la commande tourne. Sans ça, l'utilisateur lance la skill
et reste devant un écran vide : ne les séparez jamais en deux tours.

---

## Étape 1 — Détection et prérequis

Tous les messages affichés par cette skill sont du **markdown** : affichez-les rendus,
tableaux compris. Jamais encadrés dans un bloc de code. Seules exceptions : une commande à
lancer et une sortie de terminal, qui sont du texte à copier et restent dans un bloc.

**Les sections d'un même message se séparent par un filet.** Dès qu'un message compte
plus d'une section, chacune s'ouvre par une ligne `---`, puis son titre en gras. Sans ça
le message s'affiche tassé et l'utilisateur ne voit plus où commence quoi. Le filet est
**toujours entouré d'une ligne vide** : collé au texte du dessus, il le transforme en
titre au lieu de tracer une ligne.

```bash
[ -f presta/status.md ] && sed -n '1,10p' presta/status.md
ls -d presta/livrables/*/ presta/livrables/*/*/ 2>/dev/null
ls presta/livrables/*/phases/p-01-setup.md 2>/dev/null
for f in presta/specs/spec-technique.md presta/specs/spec-architecture.md \
         presta/maquettes/design-system.css AGENTS.md .env .gitignore; do
  [ -f "$f" ] && echo "OK $f" || echo "-- $f"
done
ls presta/specs/spec-architecture-complement-*.md 2>/dev/null
[ -d .git ] && echo "GIT=oui" || echo "GIT=non"
find . -maxdepth 1 \( -name 'package.json' -o -name 'manage.py' -o -name 'go.mod' \
  -o -name 'pom.xml' -o -name 'Cargo.toml' -o -name 'composer.json' -o -name 'Gemfile' \
  -o -name 'pyproject.toml' -o -name '*.csproj' -o -name '*.sln' \) 2>/dev/null
```

Si la commande échoue (shell Windows), repliez-vous sur `ls` — mais n'enchaînez pas plus
d'un appel.

Ensuite :

1. **Lisez `presta/specs/spec-technique.md` en entier.** C'est la stack, le moteur de base
   de données, les dépendances externes et les décisions `D-xx` encore `en attente`. Notez
   si le moteur est **hébergé** (Postgres géré, Supabase, Neon…) ou **local** (SQLite,
   fichier) : c'est ce qui déclenche le contrôle MCP de l'étape 2. Notez aussi le **Type
   d'application** : web ou non — c'est ce qui détermine le mécanisme de constat visuel de
   l'étape 2 et le critère plancher de l'étape 5.
2. **Lisez `presta/specs/spec-architecture-complement-{stack}.md`.** C'est lui qui donne
   l'arborescence à produire et les options de la commande d'initialisation.
3. **Lisez `presta/livrables/{livrable}/phases/p-01-setup.md`** : ses critères de
   validation, et son champ `etat`. Les critères s'ajoutent au plancher de l'étape 5 ; le
   champ `etat` est le seul endroit où se lit l'avancement de la phase.
   `{livrable}` est le champ `livrable_courant` de `presta/status.md`, **lu tel quel et
   jamais recomposé** — voir la règle de résolution dans les gabarits de `/presta-rdv`.
4. **Lisez `presta/elements-a-fournir.md`** : les clés et les comptes déjà connus. Ce sont
   les lignes du `.env`.
5. **Ne lisez pas les autres specs.** Ni les écrans, ni les modèles : rien de ce que vous
   faites ici n'en dépend.

### Les deux arrêts

| Situation | Ce que vous faites |
|---|---|
| `spec-technique.md` absent, ou stack non fixée | **Arrêt.** Premier message ci-dessous |
| Aucun `p-01-setup.md` sous `presta/livrables/*/phases/` | **Arrêt.** Second message ci-dessous |

```
| **PRESTA — Setup** |
|---|

Attention : la stack n'est pas définie (presta/specs/spec-technique.md).

Je ne peux pas initialiser un projet sans savoir sur quoi vous développez, et ce
choix ne se prend pas ici — il engage tout le reste.

Passez par /presta-rdv si le projet n'est pas cadré, ou par /presta-architecture
qui vous proposera des stacks cohérentes avec vos écrans et vos modèles.
```

```
| **PRESTA — Setup** |
|---|

Attention : le développement n'est pas découpé — aucun fichier
presta/livrables/*/phases/p-01-setup.md.

P-01-SETUP est une phase du découpage comme les autres : ses critères de
validation vivent dans son fichier, et c'est son champ etat: qui porte
l'avancement. Sans lui je n'ai ni critères à vérifier, ni dossier de livrable où
déposer le rapport.

Je ne l'invente pas : un dossier créé ici resterait orphelin le jour où
/presta-phases crée le vrai, et le rapport posé dedans ne serait jamais relu.

Passez par /presta-phases, puis revenez ici.
```

Ce second arrêt ne se force pas. **Une seule exception** : une demande qui n'écrit rien
sous `presta/livrables/` passe malgré tout — typiquement `/presta-setup regénère
AGENTS.md` sur un projet déjà initialisé. Vous faites ce qui est demandé, vous ne produisez
aucun rapport de phase, et vous le dites en une ligne à la sortie.

### Ce qui manque et ne bloque pas

| Absent | Ce que vous faites |
|---|---|
| `spec-architecture-complement-{stack}.md` | Prévenez en une ligne, et proposez les options par défaut du framework |
| Un **sous-dossier** du livrable — `rapports/`, `recettes/`, `audits/` | Vous le créez, sans le dire. Voir l'arborescence à l'étape 6 |
| `design-system.css` | Rien à brancher, on n'en parle pas |

---

## Étape 2 — Message d'accueil

**La vérification de la commande d'initialisation part dans ce message**, en tâche de fond
si votre outil sait le faire. Le texte s'affiche pendant qu'elle tourne. Elle porte sur la
commande officielle de la version visée et sur ses options — pas sur les nouveautés de la
version.

**Si le moteur de base est hébergé**, la même vérification en tâche de fond regarde s'il
existe un serveur MCP officiel pour lui — un moteur local (SQLite, fichier) n'en tire
rien, le Bash suffit déjà. Le résultat rejoint `elements-a-fournir.md` à la clôture,
jamais un critère de validation ni une installation faite ici.

**Si le type d'application n'est pas web**, la même vérification en tâche de fond cherche,
pour la stack fixée, le mécanisme qui permet de constater un résultat sans supposer un
navigateur — simulateur, émulateur, capture d'écran du système. Même traitement que la
commande d'initialisation : vérifié par recherche web, jamais sorti de mémoire. Le résultat
rejoint `elements-a-fournir.md` à la clôture si rien n'a pu être mis en place, jamais un
critère de validation ni une installation faite ici.

Les lignes « Basé sur » viennent des frontmatters lus à l'étape 1.

### Cas « projet neuf »

```
| **PRESTA — Setup** | |
|---|---|
| Basé sur | presta/specs/spec-technique.md — Django 6.1, PostgreSQL |
| | presta/specs/spec-architecture-complement-django.md — 3 applications |
| | P-01-SETUP — 4 critères de validation, etat : à faire |

Le dossier ne contient que presta/. On part d'un projet neuf.

---

**Ce que je fais dans cette étape**

| | |
|---|---|
| **1** | J'initialise le projet avec la commande officielle, options comprises |
| **2** | Je crée la base, le .env, le .gitignore, et le dépôt git |
| **3** | Je vérifie : ça compile, ça se lance, j'accède au navigateur |
| **4** | J'écris AGENTS.md avec les commandes réelles de votre projet |

---

Je vérifie la commande d'initialisation de Django 6.1 et ses options, quelques
secondes. Pendant ce temps : dites-moi si vous avez déjà un dépôt git distant
pour ce projet, ou si je le laisse en local.
```

La ligne d'attente donne **un vrai sujet**, jamais « patientez ». Le dépôt distant est le
bon sujet ici : c'est la seule chose du setup qui ne se déduit d'aucune spec.

**Elle reste toujours en texte, jamais au panneau, même si sa question est fermée** — un
appel à l'outil bloque sur une réponse, alors que la ligne d'attente doit pouvoir
s'ignorer sans qu'on y revienne. Elle s'affiche dans le même message que le reste de
l'accueil, jamais à sa place.

**Elle ne remplace pas le bloc « votre dépôt distant » de l'étape 6.** Ici on prévient,
là-bas on branche. S'il a répondu ici, le bloc de l'étape 6 ne repose pas la question : il
affiche ce qu'il fait de sa réponse.

### Cas « projet déjà initialisé »

Du code existe — l'utilisateur a fait le setup lui-même, le projet préexistait, ou la
skill a déjà tourné. **Traitement identique dans les trois cas : on ne réinitialise
rien.**

```
| **PRESTA — Setup** | |
|---|---|
| Basé sur | presta/specs/spec-technique.md — Django 6.1, PostgreSQL |
| Trouvé | manage.py, 3 applications, un dépôt git, pas de AGENTS.md |

Le projet est déjà initialisé. Je n'y touche pas.

---

**Ce que je fais**

| | |
|---|---|
| **1** | Je vérifie : ça compile, ça se lance, j'accède au navigateur |
| **2** | Je complète ce qui manque : .env, .gitignore |
| **3** | J'écris AGENTS.md avec les commandes réelles de votre projet |

---

On y va ?
```

**[PANNEAU]** — *Oui, vérifiez et documentez* / *Je veux d'abord vous dire deux choses*.

Vous sautez directement à l'étape 5. Ce qui manque se complète, ce qui existe se garde —
y compris une arborescence qui s'écarte du complément d'architecture. **Vous signalez
l'écart en une ligne à la clôture, vous ne le corrigez pas** : réorganiser du code
existant n'est pas du setup.

### Cas « l'utilisateur veut initialiser lui-même »

Il l'a demandé à l'accueil, ou il choisit cette option à l'étape 3. Vous lui donnez la
commande complète, dans un bloc, et vous vous arrêtez.

```
Voici la commande, avec les options qui correspondent à votre architecture :

    django-admin startproject delta .
    python manage.py startapp accounts
    python manage.py startapp market
    python manage.py startapp portfolio

Dites-moi quand c'est fait, j'enchaîne sur les vérifications et j'écris
AGENTS.md.
```

**Si un argument a été passé** (`/presta-setup on est déjà initialisé`,
`/presta-setup regénère AGENTS.md`) : sautez l'accueil et traitez directement la demande.

---

## Étape 3 — Le plan d'initialisation

Un seul message, quatre blocs. Il se termine par la seule validation de la skill.

```
**La commande**

    django-admin startproject delta .
    python manage.py startapp accounts
    python manage.py startapp market
    python manage.py startapp portfolio

Vérifiée sur la documentation Django 6.1, le 07/08/2026.

---

**Ce qui est déjà tranché** — je ne vous le repose pas

| | Décidé dans |
|---|---|
| Les 3 applications accounts, market, portfolio | spec-architecture-complement-django.md |
| PostgreSQL en dev comme en production | spec-technique.md, décidé au rendez-vous |
| Pas de dossier src/ | l'arborescence validée démarre à la racine |

---

**Ce que la commande ne fait pas, et que je fais derrière**

| | |
|---|---|
| Les dépendances | Django, psycopg, python-dotenv, pytest-django. Rien d'autre : ce qui n'est pas dans vos specs ne s'installe pas ici. |
| La base | Je crée delta_dev en local et je passe les migrations de Django. Vos modèles et le jeu de données de test viennent à la phase suivante. |
| Le design system | Je copie design-system.css dans les statiques et je le branche au gabarit de base. La page d'accueil aura déjà la bonne tête. |
| Le reste | .env et .env.example, .gitignore, git init sur la branche main, premier commit. En local uniquement : je ne pousse rien nulle part, on branchera votre dépôt distant à la fin. |

---

Je suis prêt à lancer le setup, vous validez ?
```

**[PANNEAU]** — *Oui, lancez le setup* / *Je préfère initialiser moi-même*. L'option libre
sert à corriger la commande, une option ou la liste des dépendances.

Cinq règles sur ce message :

- **Chaque ligne « déjà tranché » cite le fichier qui l'a tranchée.** Sans ça l'utilisateur
  ne peut pas contester, et il ne saura pas où aller corriger.
- **La commande porte la date de sa vérification.** Si vous n'avez pas pu la vérifier,
  écrivez-le à la place de la date, et la validation porte aussi là-dessus.
- **Une option qu'aucune spec ne couvre se pose en onglet supplémentaire du panneau**,
  avec sa conséquence concrète et 2 à 4 options nommées, la première recommandée — dans
  le même appel `AskUserQuestion` que la validation.
- **Le framework de test ne se pose jamais en onglet**, et n'entre dans aucune liste de
  dépendances. Le projet de tests se crée vide de tout paquet. Si la commande d'échafaudage
  en impose un — `dotnet new xunit`, un générateur qui en installe un d'office — prenez le
  gabarit le plus nu, retirez le paquet, et dites-le en une ligne dans le message : « Projet
  de tests créé vide : le framework se choisit avec /presta-tests, à partir des critères des
  phases. »
- **La question de clôture nomme l'action.** « Je suis prêt à lancer le setup, vous
  validez ? » — pas « je lance ? », qui ne dit pas ce qui va tourner.

**Si l'utilisateur ajuste** — une dépendance de plus, une option qu'il change — ne
réaffichez pas les quatre blocs. Une ligne par changement, puis la question :

```
Ajouté : django-debug-toolbar, en dépendance de développement uniquement.
Retiré : pytest-django — vous restez sur le lanceur de tests de Django.

Je suis prêt à lancer, vous validez ?
```

---

## Étape 4 — L'exécution

Ça tourne sans rendre la main. **Annoncez l'ordre avant de commencer**, dans le message qui
porte le premier appel : l'installation des dépendances prend plusieurs minutes, et
l'utilisateur doit savoir où on en est.

| | Ce qui se fait | Ce qu'il faut ne pas rater |
|---|---|---|
| 1 | Le squelette | La commande validée, telle quelle |
| 2 | Les dépendances | Celles annoncées, aucune autre |
| 3 | La base | Création, puis les migrations du framework. Pas vos modèles |
| 4 | Le design system | `design-system.css` copié dans les statiques, branché au gabarit de base |
| 5 | `.env` et `.env.example` | Les clés nommées dans les specs, sans valeurs |
| 6 | `.gitignore` | `.env` en premier, avant le reste |
| 7 | `git init -b main` et le premier commit | Message : `P-01-SETUP — initialisation du projet`. En local, aucun envoi |

**L'ordre 5-6-7 ne se négocie pas.** Le `.gitignore` s'écrit avant le premier commit, et
`.env` y figure avant tout le reste : un `.env` parti dans l'historique git y reste.

**Le serveur de développement se lance en tâche de fond et s'arrête après la
vérification.** On ne laisse jamais un processus tourner derrière soi : l'utilisateur le
relancera lui-même avec la commande qu'on lui donne à la fin.

**Sur un échec, trois tentatives au maximum**, et seulement sur ce qui est de votre
ressort — une dépendance manquante, une version incompatible, un port occupé. Au-delà,
vous vous arrêtez, vous affichez la sortie d'erreur brute, et vous demandez. Une boucle de
correction qui s'entête consomme des jetons et finit par casser autre chose.

---

## Étape 5 — Les vérifications

Un seul message. Chaque critère cite ce qui le prouve.

```
| **PRESTA — Setup** | |
|---|---|
| P-01-SETUP | 4 critères sur 4 |

| | Critère | Preuve |
|---|---|---|
| [x] | Le projet compile | python manage.py check → "System check identified no issues (0 silenced)" |
| [x] | Les migrations passent | migrate → 18 appliquées sur la base delta_dev |
| [x] | L'application se lance | runserver → http://127.0.0.1:8000, réponse 200 |
| [x] | J'accède au navigateur | presta/annexes/setup-page-accueil.png |

J'ai ouvert la capture.
```

### Le plancher

Les critères de P-01-SETUP viennent de `/presta-phases`. **Ces quatre-là se vérifient de
toute façon**, même si la phase n'en nomme aucun, et même sur un projet déjà initialisé :

1. **Le projet compile** — la commande de contrôle de la stack, et sa sortie.
2. **La base répond** — les migrations du framework passent sur la base réelle.
3. **L'application se lance** — le serveur démarre, une requête sur la page d'accueil
   renvoie un code de succès.
4. **Vous constatez le résultat par le mécanisme retenu** — navigateur pour le web,
   simulateur, émulateur ou capture d'écran système sinon. Vous en gardez une capture dans
   `presta/annexes/`, et vous l'ouvrez à l'utilisateur.

Le quatrième n'est pas décoratif. Sans mécanisme de constat visuel, toute la vérification
d'implémentation tombe : c'est ici, et seulement ici, qu'on peut s'en apercevoir avant que
ça coûte cher.

### Quand un critère ne passe pas

Vous ne cochez pas, et vous ne l'enrobez pas.

```
| | Critère | Preuve |
|---|---|---|
| [x] | Le projet compile | python manage.py check → "System check identified no issues" |
| [x] | Les migrations passent | migrate → 18 appliquées sur la base delta_dev |
| [x] | L'application se lance | runserver → http://127.0.0.1:8000, réponse 200 |
| [ ] | J'accède au navigateur | pas de navigateur disponible dans cet agent |

---

**Ce qu'il manque**

Je n'ai pas de mécanisme de constat visuel ici. Ça ne bloque pas le setup — votre
projet tourne — mais ça pèsera à l'implémentation : le vérificateur de chaque
phase ne pourra rien constater à l'écran, et tout ce qui en dépend sera rapporté
bloqué.

Ce que ça demande de votre côté : pour un projet web, installer le serveur MCP
Playwright dans votre agent ; sinon, mettre en place le mécanisme trouvé pour
votre stack. Je ne peux pas le faire à votre place, ça se déclare dans la
configuration de l'agent et je n'y touche pas.

Je l'ajoute dans elements-a-fournir.md, en priorité « maintenant ». On continue ?
```

**[PANNEAU]** — *On continue* / *Je l'installe d'abord*.

Le critère non coché **reste non coché dans le rapport de phase**. Il ne se rattrape pas
au prochain lancement par optimisme : il se revérifie.

### Le statut de la phase

Le champ `etat` du frontmatter de `presta/livrables/{livrable}/phases/p-01-setup.md` est la
**source d'autorité** de l'avancement. Vous le mettez à jour ici, et vous ne tenez aucun
tableau d'avancement à côté.

| Ce que vous venez de constater | `etat` |
|---|---|
| Tous les critères cochés | `validée` |
| Un critère au moins non coché | `en cours` |

Vous ne touchez à rien d'autre dans ce fichier : les critères appartiennent à
`/presta-phases`.

C'est ce qui rend `/presta-implemente` idempotente — elle relit les frontmatters et reprend
là où on en est. Un `etat: validée` posé sur une phase dont un critère n'est pas passé fait
démarrer la suite sur du faux.

---

## Étape 6 — L'écriture, la main rendue, la sortie

Lisez `references/gabarits.md`. Prenez l'horodatage avec `date +%FT%T`.

| Fichier | Contenu |
|---|---|
| `AGENTS.md` | Stack, commandes réelles, conventions, carte de `presta/`, pointeur impératif vers `presta/regles-projet.md` |
| `.env` | Les clés nommées dans les specs, sans valeurs. Gitignoré |
| `.env.example` | Les mêmes, versionné |
| `presta/livrables/{livrable}/rapports/p-01-setup.md` | Le rapport de phase : ce qui a été installé, les critères et leurs preuves, ce qui n'est pas passé |
| `presta/livrables/{livrable}/phases/p-01-setup.md` | **Le champ `etat` uniquement** — `validée` si tous les critères sont cochés, `en cours` sinon. Rien d'autre ne se touche dans ce fichier |
| `presta/annexes/setup-page-accueil.png` | La capture de la page d'accueil |
| `presta/elements-a-fournir.md` | Les clés à compléter, ce qu'elles bloquent |
| `presta/status.md` | `etape: setup` |
| `presta/regles-projet.md` | La carte des fichiers, la règle ci-dessous |

Inscrivez dans `presta/regles-projet.md`, si elle n'y est pas déjà :

> Les commandes du projet vivent dans `AGENTS.md`. Une commande qui change se met à jour
> là, et nulle part ailleurs.

**`AGENTS.md` s'écrit en dernier**, parce que ses commandes sont celles qui viennent de
tourner pour de vrai. Et s'il existe déjà, **il ne s'écrase pas** : on complète les
sections absentes, on laisse le reste.

### L'arborescence du livrable

C'est `/presta-phases` qui la produit, et c'est lui qui la nomme. Vous ne faites qu'y
écrire, dans le dossier que désigne `livrable_courant` :

```
presta/livrables/{livrable}/        ← v1.0-portefeuille-actions
  description-livrable.md
  phases/            ← p-01-setup.md, dont vous ne touchez que le champ etat
  rapports/          ← p-01-setup.md, le rapport que vous écrivez
  recettes/
    generated/
  audits/
```

**Le nom du dossier ne se recompose jamais.** Il se lit dans `livrable_courant`, tel quel.
`presta/livrables/1.0/` n'est pas une abréviation de `v1.0-portefeuille-actions` : c'est un
autre dossier, que plus rien ne lira.

**Un sous-dossier absent se crée, en silence** — `rapports/` sur un livrable créé à la
main, par exemple. Vous ne réclamez rien et vous ne déplacez rien : un rapport posé à côté
de sa place ne sera jamais retrouvé.

**Le dossier du livrable lui-même ne s'invente pas.** S'il n'existe pas, c'est le second
arrêt de l'étape 1 : on n'est pas arrivé jusqu'ici.

**Et vous ne créez jamais un fichier de phase.** `phases/p-01-setup.md` appartient à
`/presta-phases` ; vous n'en touchez que le champ `etat`.

### Le message de sortie

```
C'est en place.

| Fichier | Ce qu'il contient |
|---|---|
| AGENTS.md | stack, 6 commandes réelles, conventions, carte de presta/ |
| .env | 3 clés à compléter, gitignoré |
| .env.example | les mêmes, sans valeurs, versionné |
| presta/livrables/v1.0-portefeuille-actions/rapports/p-01-setup.md | le rapport de P-01-SETUP |
| presta/livrables/v1.0-portefeuille-actions/phases/p-01-setup.md | etat : validée |
| presta/status.md | étape : setup |
| presta/regles-projet.md | AGENTS.md et .env dans la carte des fichiers |
| git | dépôt initialisé, commit "P-01-SETUP — initialisation du projet" |

---

**Pour lancer le projet de votre côté**

    python manage.py runserver

Puis http://127.0.0.1:8000

Les autres commandes sont dans AGENTS.md : migrations, linter. La ligne « Tests »
y renvoie vers /presta-tests : rien n'est configuré pour l'instant.

---

**Votre dépôt distant**

Le projet est versionné en local, un commit : "P-01-SETUP — initialisation du
projet". Rien n'est poussé nulle part pour l'instant.

| | |
|---|---|
| **1** | Vous avez déjà un dépôt sur GitHub — donnez-moi son URL, je le branche et je pousse |
| **2** | Vous n'en avez pas — créez-le **vide**, sans README, sans .gitignore, sans licence, puis donnez-moi l'URL |
| **3** | On reste en local — ça se branche quand vous voulez, rien n'est perdu |

Le dépôt doit être vide : un README ajouté à la création côté GitHub fait
diverger les deux historiques, et le premier envoi est refusé.

---

**Deux choses pour vous**, dans elements-a-fournir.md

| | |
|---|---|
| Clé Fournisseur A | .env, ligne QUOTES_API_KEY= — bloque P-06-COTATIONS |
| Compte SMTP | .env, ligne EMAIL_HOST_USER= — bloque E-03-MOT-DE-PASSE-OUBLIE |
| Serveur MCP Neon | optionnel — installation dans la config de votre agent, accélère l'inspection du schéma et les migrations pendant /presta-implemente |

---

Si tout est bon de votre côté, l'étape suivante est /presta-tests : les mécanismes
de test se déduisent des critères de vos phases, et chacun se prouve par un test
vert avant que l'implémentation ne commence.
```

### Le dépôt distant

**[PANNEAU]** — *Voici l'URL de mon dépôt* / *On reste en local pour l'instant*. L'option
libre sert à coller l'URL directement.

S'il donne une URL, vous branchez et vous poussez, en affichant les commandes :

```
git remote add origin https://github.com/vous/delta.git
git push -u origin main

C'est poussé. Votre .env n'est pas parti : il est dans le .gitignore.
```

**Si `gh` est installé et connecté à un compte**, proposez une voie de plus dans le bloc :
créer le dépôt vous-même, en privé par défaut.

```
Je peux aussi le créer pour vous : gh repo create delta --private --source=. --push

Ça crée un dépôt privé sur votre compte GitHub et pousse dessus. Je ne le fais
que si vous me le dites.
```

Cinq règles, et elles ne se contournent pas :

- **Rien ne part vers l'extérieur sans validation explicite.** Créer un dépôt et pousser
  sont des actions visibles hors de la machine. Le défaut est de ne rien faire.
- **Jamais de `git push --force`, jamais de `--allow-unrelated-histories`.** Si l'envoi est
  refusé parce que le dépôt distant n'est pas vide, vous vous arrêtez, vous dites pourquoi,
  et vous laissez l'utilisateur choisir — repartir d'un dépôt vide, ou fusionner lui-même.
- **Vous vérifiez que `.env` est bien ignoré avant de pousser**, et vous le dites. C'est le
  seul moment où une clé peut partir dans un dépôt distant.
- **Vous ne créez aucun compte GitHub** et vous ne vous authentifiez à la place de
  personne. Si `gh` n'est pas connecté, c'est une ligne dans `elements-a-fournir.md`.
- **S'il a déjà répondu à la ligne d'attente de l'étape 2**, ne reposez pas la question :
  affichez ce que vous faites de sa réponse.

S'il choisit de rester en local, une ligne part dans `elements-a-fournir.md`, en priorité
« plus tard », avec les trois commandes à jouer le jour venu. C'est ce qui évite d'avoir à
les redemander.

Quatre points de forme :

- **La commande affichée est celle qui vient de tourner**, pas une commande de
  documentation. C'est la même que celle écrite dans `AGENTS.md`. Sur Windows, donnez la
  forme qui marche dans son shell, pas la forme Unix.
- **Le bloc de lancement passe avant les tâches utilisateur.** On veut qu'il ouvre son
  navigateur pendant qu'il lit le reste.
- **La sortie est conditionnelle** — « si tout est bon de votre côté ». Le setup est le
  premier moment où l'utilisateur a quelque chose à vérifier lui-même : c'est lui qui
  décide que c'est passé, pas vous.
- **Le mode pas-à-pas ou auto ne se demande pas ici.** Il se pose au premier
  `/presta-implemente`.
- **La sortie renvoie vers `/presta-tests`, jamais directement vers `/presta-implemente`.**
  Le vérificateur de chaque phase a besoin de `presta/specs/spec-tests.md` pour savoir avec
  quoi prouver un critère. Si l'utilisateur veut sauter cette étape, c'est son droit —
  `/presta-implemente` le lui redemandera, sans le bloquer.

Le cahier de recettes de P-01-SETUP, c'est ce bloc de lancement. Il n'y a pas de document
séparé : lancer la commande et ouvrir la page est la recette entière.

**Si un critère n'est pas passé**, le message le rappelle avant la sortie, et la sortie
dit ce que ça coûtera plus loin :

```
Le critère « j'accède au navigateur » n'est pas passé. P-01-SETUP reste en cours.
Vous pouvez passer à l'implémentation, mais la vérification de chaque phase sera
partielle tant que c'est le cas.
```

**[PANNEAU]** — *Le projet se lance, je valide le setup (recommandée)* / *J'ai des
remarques*. C'est le dernier appel du message : il rend explicite ce que l'utilisateur
doit faire de son côté — lancer le projet, constater la fenêtre — plutôt que de laisser
une invitation à répondre en texte libre, facile à manquer.

- **S'il valide**, vous rouvrez `presta/livrables/{livrable}/rapports/p-01-setup.md` et
  `presta/livrables/{livrable}/phases/p-01-setup.md` dans le même tour : le critère passe
  à `[x]`, avec pour preuve la confirmation de l'utilisateur, `etat` passe à `validée` si
  c'était le seul critère manquant, et vous le confirmez en une ligne.
- **S'il a des remarques**, l'option libre les recueille : vous les traitez comme
  n'importe quel retour, et `etat` reste `en cours` tant que le critère n'est pas prouvé.

---

## Portabilité

<!-- SHARED:INVOCATION:START -->
**Invocation.** Cette skill ne se lance que sur demande explicite de l'utilisateur, jamais
d'elle-même. Claude Code : `/` suivi du nom de la skill. Codex : `$` suivi du nom, ou
`/skills` — le fichier `agents/openai.yaml` du dossier coupe l'invocation implicite.
Ailleurs : l'utilisateur nomme la skill dans sa demande.
<!-- SHARED:INVOCATION:END -->

| Capacité | Si disponible | Sinon |
|---|---|---|
| Recherche web | Vérifier la commande d'initialisation et ses options, en datant | Le dire, et faire valider la commande avant de la lancer. Jamais une commande de mémoire présentée comme sûre |
| Constat visuel (navigateur pour le web, sinon le mécanisme trouvé pour la stack) | Ouvrir ou lancer l'application, en garder une capture dans `presta/annexes/` | Le critère ne passe pas. Une ligne dans `elements-a-fournir.md`, en priorité « maintenant » |
| Shell en tâche de fond | Lancer le serveur, vérifier, l'arrêter | Demander à l'utilisateur de lancer la commande et de rapporter ce qu'il voit |
| `gh` installé et connecté | Proposer de créer le dépôt distant, en privé, sur validation explicite | Lui demander de le créer vide et de donner l'URL |
| Ouverture de fichier | Ouvrir la capture et `AGENTS.md` | Afficher les chemins |
| Panneau de questions | `AskUserQuestion` aux endroits marqués **[PANNEAU]** | Les mêmes options en texte simple |

---

## Ce que cette skill ne fait pas

- Elle ne choisit pas la stack, ni le moteur de base de données, ni l'arborescence — elle
  les exécute. Ça se décide dans `/presta-rdv` et `/presta-architecture`.
- Elle n'écrit aucun code applicatif : pas de modèle, pas d'écran, pas de service. Le
  gabarit de base et le branchement du design system sont du câblage, pas de la
  fonctionnalité.
- Elle ne crée pas le jeu de données de test ni les commandes de seed — c'est la phase
  suivante, dans `/presta-implemente`.
- **Elle ne choisit aucun framework de test et n'installe aucun paquet de test.** C'est
  `/presta-tests`, qui les déduit des critères des phases et prouve chacun par un test
  vert. Elle crée la coquille du projet de tests quand l'architecture en prévoit un — le
  projet, sa référence vers l'applicatif, son inscription dans la solution — et s'arrête
  là. Un framework choisi au moment du squelette est un choix pris avant d'avoir lu un
  seul critère.
- Elle ne tient aucun tableau d'avancement des phases. Le statut fait autorité dans le
  champ `etat` du fichier de phase. Elle ne touche qu'à celui de P-01-SETUP.
- Elle ne crée ni le dossier du livrable, ni un fichier de phase, et ne recompose jamais
  le nom du livrable — elle lit `livrable_courant`. Sans découpage, elle s'arrête et
  renvoie vers `/presta-phases`.
- Elle ne réinitialise pas un projet existant et ne réorganise pas son arborescence. Elle
  signale l'écart, elle ne le corrige pas.
- Elle n'installe rien qui ne soit pas nommé dans les specs.
- Elle ne crée aucun compte, n'accepte aucune condition d'utilisation, ne saisit aucun
  moyen de paiement — compte GitHub compris.
- Elle ne crée aucun dépôt distant et ne pousse rien sans validation explicite. Elle ne
  force jamais un envoi et ne fusionne jamais deux historiques divergents.
- Elle n'écrit aucun secret dans le dépôt, et ne touche à aucun `settings.json` — y compris
  pour installer un serveur MCP.
