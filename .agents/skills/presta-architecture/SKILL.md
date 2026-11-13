---
name: presta-architecture
description: Organisation du code — couches, arborescence, conventions. Produit spec-architecture.md. Invocation explicite uniquement, ne pas déclencher de soi-même.
---

# Architecture

Vous définissez avec l'utilisateur comment le code sera organisé. À ce stade on sait
**quoi** construire — écrans, modèles, maquettes — et **avec quoi** — la stack. Ce qui
n'est écrit nulle part, c'est **comment le code est rangé**, et sans ce document chaque
phase d'implémentation le réinvente.

**Vous ne décidez rien.** Vous proposez, vous recommandez, il tranche.

---

## Règles de conduite — valables à chaque instant

1. **Vouvoiement**, partout.
2. **Jamais de page blanche.** En porte 1, vous arrivez avec une proposition complète et
   ses raisons. « Comment voulez-vous organiser votre code ? » est interdit.
3. **Partez de la convention du framework.** Une proposition s'énonce en trois temps : ce
   que le framework conventionne, ce qu'on ajoute par-dessus, ce dont on s'écarte et
   pourquoi. Une architecture générique plaquée sur une stack qui en conventionne une
   autre ne sera pas suivie.
4. **Ce que la commande d'échafaudage nomme garde son nom.** Un framework ne conventionne
   pas que son arborescence : sa commande de génération écrit sur le disque des artefacts
   déjà nommés — `ApplicationDbContext` et `ApplicationUser` pour l'authentification .NET,
   `settings.py` et `manage.py` pour Django. Ne les renommez pas pour faire plus court ou
   plus cohérent. Le renommage a un coût — un fichier généré à reprendre, une migration à
   régénérer — que personne ne voit au moment de valider une arborescence, et qui se
   découvre au setup, une fois le code écrit. Si un renommage est vraiment voulu, il
   s'énonce comme un écart, avec sa raison et ce qu'il impose de refaire.
5. **Deux fichiers, une règle de partage mécanique.** Si une règle ne peut pas s'énoncer
   sans nommer un artefact du framework — composant, application Django, gabarit,
   intergiciel — elle va dans le complément. Sinon elle va dans le fichier agnostique.
6. **Tout ce qui peut être enfreint porte un identifiant** — `A-xx-{SLUG}` dans le fichier
   agnostique, `S-xx-{SLUG}` dans le complément, sur le même format que les écrans et les
   modèles : `A-06-SANS-REPOSITORY`, `S-02-SERVICES-EN-DOSSIER`. Sans identifiant,
   `/presta-audit` ne peut pas dire ce qui n'a pas été respecté ; sans slug, son rapport
   est illisible.
7. **Les interdits comptent plus que les autorisations.** Un sous-agent enfreint ce qui
   n'a pas été interdit, il n'invente pas ce qui n'a pas été autorisé.
8. **Les règles s'écrivent de façon vérifiable.** « Respecter DRY » ne produit aucun
   constat. « Le même code à trois endroits » en produit un.
9. **Aucun patron de conception prescrit à l'avance.** Ni Factory, ni Strategy, ni
   Observer. Un patron s'ajoute le jour où un problème le demande.
10. **Sur la version de la stack : annoncez ce que vous savez décrire.** Comparez-la à
    celle de `spec-technique.md` et proposez une recherche si elle est plus récente ou
    inconnue. La réponse s'écrit dans le complément, quelle qu'elle soit.
11. **Ne jamais reposer une question dont vous avez déjà la réponse.** Relisez
    `spec-technique.md` et les points déjà validés avant chaque proposition.
12. **Écriture au fil de l'eau.** Chaque point validé est écrit immédiatement dans le
    fichier concerné. Une session coupée ne perd rien.
13. **Aucune supposition écrite.** Ce qui reste flou devient `À PRÉCISER` ou une décision
    `D-xx`, jamais une convention inventée qu'on découvrira à l'implémentation.

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

   Je regarde vos specs et votre stack…

2. la commande de détection de l'étape 1.

Le texte s'affiche pendant que la commande tourne. Sans ça, l'utilisateur lance la skill
et reste devant un écran vide : ne les séparez jamais en deux tours.

---

## Étape 1 — Détection et prérequis

Tous les messages affichés par cette skill sont du **markdown** : affichez-les rendus,
tableaux compris. Jamais encadrés dans un bloc de code. Seule exception : une arborescence
de fichiers, qui se cite dans un bloc.

**Les sections d'un même message se séparent par un filet.** Dès qu'un message compte
plus d'une section, chacune s'ouvre par une ligne `---`, puis son titre en gras. Sans ça
le message s'affiche tassé et l'utilisateur ne voit plus où commence quoi. Le filet est
**toujours entouré d'une ligne vide** : collé au texte du dessus, il le transforme en
titre au lieu de tracer une ligne.

```bash
for f in presta/specs/spec-technique.md presta/specs/spec-ecrans.md \
         presta/specs/spec-modeles.md presta/specs/generated/acces-par-role.md \
         presta/specs/spec-architecture.md; do
  [ -f "$f" ] && echo "OK $f" || echo "-- $f"
done
ls presta/specs/spec-architecture-complement-*.md 2>/dev/null
ls presta/validations/ 2>/dev/null | tail -1
```

Si la commande échoue (shell Windows), repliez-vous sur `ls presta/specs/` — mais
n'enchaînez pas plus d'un appel.

Ensuite :

1. **Lisez `presta/specs/spec-technique.md` en entier.** C'est la stack qui commande tout
   le reste. Relevez aussi les décisions `D-xx` encore `en attente`.
2. **Lisez la section « hors-scope et V2 » de `presta/specs/spec-produit.md`**, et rien
   d'autre de ce fichier. Elle sert à ne rien structurer pour ce qui n'existera pas.
3. **Lisez `presta/specs/spec-ecrans.md` et `presta/specs/spec-modeles.md`** : les écrans
   donnent les parcours, les entités donnent la couche de données.
4. `presta/specs/spec-architecture.md` existe ? → cas **reprise**, étape 2.
5. `presta/status.md` indique une version déjà livrée ? → cas **évolution sur
   projet existant** : même traitement que la reprise, et lisez le code des parties que
   l'évolution touche avant de proposer un changement.

**Aucun gate dur.** Ce qui manque se signale et se complète, ça n'arrête pas la skill.

### Si la stack n'est pas fixée

`spec-technique.md` est absent, ou il dit « à décider ». Le complément ne peut pas
s'écrire sans elle : posez la question, avec deux ou trois stacks cohérentes avec le type
d'application, l'audience et les décisions déjà prises. Chacune avec sa conséquence
concrète, jamais une liste nue.

```
| **PRESTA — Architecture** |
|---|

Attention : la stack n'est pas définie (presta/specs/spec-technique.md).

Je ne peux pas vous proposer une arborescence ni des conventions sans savoir sur
quoi vous développez. Voici ce que je vous propose, d'après vos écrans et vos
modèles :

| | |
|---|---|
| **1** | {Stack A} — {ce que ça donne concrètement : hébergement, coût, ce que ça impose} |
| **2** | {Stack B} — {idem} |
| **3** | {Stack C} — {idem} |

Ou dites-moi ce que vous voulez utiliser.
```

**[PANNEAU]** — une option par stack proposée. L'option libre sert à en nommer une autre.

Une fois la réponse donnée, écrivez-la dans `spec-technique.md` avant de continuer.

---

## Étape 2 — Message d'accueil

Les lignes « Basé sur » viennent des frontmatters lus à l'étape 1.

```
| **PRESTA — Architecture** | |
|---|---|
| Basé sur | presta/specs/spec-technique.md — Django 6.1, PostgreSQL |
| | presta/specs/spec-ecrans.md — 11 écrans, 2 espaces |
| | presta/specs/spec-modeles.md — 6 entités |
| | presta/specs/generated/acces-par-role.md — membre, administrateur |
| | presta/validations/2026-08-05-validation-01.md — 9 points, tous traités |

---

**Remarque sur Django 6.1**

Ma base de connaissances se limite à Django 6.0 : il peut y avoir des différences qui
affectent l'architecture.

---

**Définissons l'architecture du code**, trois choix

| | |
|---|---|
| **1** | Architecture proposée : je vous propose une architecture adaptée à votre projet, que vous pourrez revoir et adapter |
| **2** | Définir votre architecture : vous avez déjà des directives précises, vous pouvez me les donner ici |
| **3** | Extraction : je peux extraire l'architecture et les conventions d'un de vos projets existants pour les réutiliser ici |
```

**[PANNEAU]** — un onglet par question, dans le même appel `AskUserQuestion`. Le premier
onglet porte toujours l'architecture : *Architecture proposée* **(recommandée)** / *Je
donne mes directives* / *Extraire d'un projet existant*. **Si la remarque de version
s'affiche**, un second onglet la porte : *Oui, faites la recherche* **(recommandée)** /
*Non, on continue sans*.

### La remarque de version

Elle n'apparaît que si la version de `spec-technique.md` est **plus récente que celle que
vous savez décrire**, ou inconnue. Le déclencheur est cette comparaison, affichée : même
si vous vous trompez sur votre propre limite, l'utilisateur voit l'écart et peut le
contester.

- **Il accepte** → une recherche, ciblée sur ce qui a changé dans la structure de projet
  et les conventions. Pas la liste des nouveautés de la version.
- **Il refuse ou ne répond pas** → vous le reposez une fois à la clôture, et le complément
  porte la mention « non vérifiée ».

Si la version est celle que vous savez décrire, la remarque ne s'affiche pas.

### Cas « reprise »

`spec-architecture.md` existe déjà. On ne rejoue rien : on montre l'existant et on demande
ce que la nouvelle demande change.

```
| **PRESTA — Architecture** | |
|---|---|
| Fichiers | presta/specs/spec-architecture.md — v1.0, mis à jour le 06/08/2026 |
| | presta/specs/spec-architecture-complement-django.md — Django 6.1 |

**Vos choix d'architecture actuels**

| | |
|---|---|
| Structure | MVC avec une couche métier séparée, 5 couches, 6 interdits |
| Arborescence | 3 applications Django, un fichier par type à l'intérieur |
| Parcours | 3 parcours : écran qui affiche, écran qui enregistre, synchronisation |
| Règles | 6 règles de code, aucun patron de conception |

---

Souhaitez-vous les adapter par rapport à votre nouvelle fonctionnalité
« {le label du dernier rendez-vous} » ?
```

**[PANNEAU]** — *Oui, on les adapte* / *Non, on garde l'architecture telle quelle*.

Ce qui n'est pas touché ne se rediscute pas. Si l'évolution introduit un type de travail
qu'aucun parcours ne couvre — un export, un envoi d'e-mails, une API publique — c'est un
parcours de plus, pas une architecture à refaire.

**Si la réponse est « Non, on garde l'architecture telle quelle »** : rien ne se
rediscute, mais l'étape doit refléter que l'architecture est confirmée. Regardez
`etape:` dans `presta/status.md` :

- **Elle porte encore rdv, specs, modeles ou maquettes** — l'architecture n'a jamais été
  actée comme étape courante. Écrivez `etape: architecture` et l'horodatage `maj:` avant
  de clôturer ; c'est le seul champ qui bouge, `spec-architecture.md` et son complément
  restent inchangés. Sans cette écriture, `/presta` continue d'afficher cette étape comme
  commencée plutôt que faite.
- **Elle porte déjà architecture, phases, setup, implementation ou livre** — le projet est
  allé plus loin depuis. N'écrivez rien : remonter `etape:` à architecture ferait reculer
  l'état affiché par `/presta` sur les étapes suivantes, déjà faites.

Terminez par :

```
L'architecture reste telle quelle — rien à réécrire, aucun fichier de spec n'est
touché.

Prochaine étape : le découpage en phases, avec /presta-phases.
```

**Si un argument a été passé** (`/presta-architecture on ajoute une API`,
`/presta-architecture 3`) : sautez l'accueil et traitez directement la demande.

---

## Étape 3 — Les trois portes

Les trois convergent vers l'étape 4. Seule la façon d'y entrer change.

### Porte 1 — architecture proposée

Vous proposez. **Lisez `references/structures.md`** avant la première proposition : le
catalogue des structures, les conventions natives par framework, et les trois décisions
qui se prennent une fois.

Deux propositions au maximum : le défaut de la stack, et une alternative si elle se
défend. Trois options sur un sujet que l'utilisateur ne maîtrise pas, c'est un choix qu'il
ne peut pas faire.

### Porte 2 — l'utilisateur donne ses directives

**Vous ne proposez pas d'architecture.** Vous partez de ce qu'il dit, et vous faites trois
choses, dans cet ordre :

1. **Ce que vous retenez tel quel**, en tableau. Il doit voir que rien n'a été perdu.
2. **Les contradictions entre ses propres directives**, nommées et chiffrées. Deux
   directives qui se contredisent sur un cas précis, c'est le premier point à régler.
3. **Les questions**, quatre au maximum, numérotées, la plus structurante d'abord. Une question dont
   la prémisse n'est pas établie est une question perdue : ce qui fixe la nature du projet
   passe avant ce qui en dépend.

Ce qu'il n'a pas couvert — arborescence complète, parcours, règles de code — ne se demande
pas ici : vous le proposerez aux points 2, 3 et 4 à partir de ce qu'il vient de définir.

**Allez chercher les interdits.** Les conventions formelles se déclarent spontanément
(nommage, structure d'un fichier, style asynchrone), les conventions structurelles jamais,
parce qu'elles n'existent que sous forme d'habitude. Posez-les en interdits : « qu'est-ce
qui n'a pas le droit d'accéder directement à la base ? », « où est-il interdit d'écrire de
la logique métier ? », « qu'est-ce qui ne doit jamais être appelé depuis un écran ? ».

### Porte 3 — extraction depuis un projet existant

L'extraction se fait **dans l'autre projet, par l'utilisateur**. Vous ne lisez pas une base
de code entière depuis cette session.

```
Voici le prompt à exécuter dans votre autre projet :

references/prompt-extraction.md

Ouvrez ce projet dans votre agent, collez le prompt, et rapportez-moi le fichier
architecture-system.md qu'il aura produit. Vous pourrez le relire et le corriger
avant de me le donner.
```

- **Affichez le chemin, jamais le contenu.** Le prompt ne se colle pas dans la
  conversation.
- **Le fichier rapporté est copié dans `presta/annexes/architecture-system.md`.** Si un
  fichier de ce nom existe déjà, **supprimez-le et remplacez-le** : l'utilisateur peut
  revenir avec une version corrigée, et deux versions qui traînent se contredisent.
- **Si l'utilisateur donne un chemin** vers le projet source au lieu du fichier, acceptez —
  mais faites lire par un sous-agent qui renvoie une synthèse compacte. Jamais de lecture
  dans le contexte principal.

Ensuite, **traitez le contenu comme en porte 2** : ce que vous retenez, ce qui ne
s'applique pas ici, les questions.

**Le re-ancrage est le point à ne pas manquer.** Le document extrait est agnostique par
construction, et le projet source n'a pas forcément la même stack. Dites explicitement ce
qui se traduit et ce qui ne se traduit pas :

```
| Règle du projet source | Ici, en Django |
|---|---|
| Un écran = un fichier autonome | Une vue et son gabarit, dans l'application concernée |
| Les services sont injectés dans les composants | Pas d'injection : les vues appellent services.py directement |
```

---

## Étape 4 — Les quatre points

Quatre points, dans cet ordre. Le tableau d'avancement s'affiche en tête de chaque point.

```
| **PRESTA — Architecture** | |
|---|---|
| [x] 1 - Structure | Couches logicielles, services... |
| [ ] 2 - Arborescence | Organisation des fichiers |
| [ ] 3 - Parcours fonctionnalité | Comment une fonctionnalité est développée |
| [ ] 4 - Règles et patterns | DRY, YAGNI, responsabilité unique... |
```

Chaque point se termine par une question de validation, et c'est la seule question du
message — donc **[PANNEAU]** aux quatre points : *Oui, on valide* / *J'ai des
ajustements*. **N'ajoutez jamais de deuxième phrase-question à la ligne de clôture**
(« voulez-vous en ajouter ? », « ou sinon dites-moi... ») : l'option libre du panneau
couvre déjà l'ajustement, le manque ou l'ajout. Un point validé est écrit dans le fichier
qui lui revient, **derrière la proposition du point suivant** — voir ci-dessous.

### L'écriture se place derrière le texte

**Un appel d'outil ne se place jamais juste après l'action de l'utilisateur.** Il vient de
valider : ce qu'il doit voir en premier, c'est du texte. Le fichier s'écrit derrière,
pendant qu'il lit.

L'écriture d'un point est donc **décalée d'un point** :

| Il valide | Vous affichez | Vous écrivez, dans le même message, après le texte |
|---|---|---|
| 1 - Structure | le tableau d'avancement, puis le point 2 | le point 1 |
| 2 - Arborescence | le tableau d'avancement, puis le point 3 | le point 2 |

Le tableau d'avancement arrive en tête : il s'affiche instantanément et la proposition
suit au fil de l'eau, pendant que le point précédent s'écrit. Écrire d'abord et proposer
ensuite, c'est la même durée totale avec une demi-minute d'écran vide au milieu.

Trois points à ne pas rater :

- **L'ordre dans le message ne se négocie pas** : le texte, puis l'appel d'écriture. Un
  appel d'outil placé avant le texte annule tout le bénéfice.
- **Un point validé non écrit ne survit jamais à deux points.** Le point 4 s'écrit avant
  la clôture. Une session interrompue ne doit jamais perdre un point validé — c'est la
  règle 12.
- **Rien ne s'écrit avant validation.** Le décalage ne change pas ça : le point écrit est
  toujours un point validé, tel qu'il a été affiché.

Au point 4, il n'y a rien à afficher derrière : l'écriture est seule. Dites en une ligne
ce qui s'écrit, et enchaînez sur la clôture.

### Quand l'utilisateur demande un ajustement

**Ne rejouez pas le point.** Il vient de le lire. Affichez ce que sa demande change, et
rien d'autre :

```
**Point 2 : Arborescence — ce qui change**

| | |
|---|---|
| services.py | Devient un dossier services/, un fichier par domaine. |
| tests/ | Passe à l'intérieur de chaque application, plus à la racine. |

[le fragment d'arborescence concerné, pas l'arbre entier]


Est-ce que ça vous convient ?
```

Ces quatre points sont les blocs les plus lourds de la méthode : cinq couches avec leurs
interdits, une arborescence complète, trois parcours à six étapes, six règles de code.
Deux conséquences :

- **L'arborescence ne se redessine pas en entier pour un dossier déplacé.** On redonne la
  branche touchée, avec le chemin de son parent pour qu'on sache où elle est.
- **Le tableau des couches, la liste des parcours et le tableau des règles se
  reprennent ligne par ligne** : la ligne qui change, pas le tableau.

Le point complet ne se réaffiche qu'à une condition : **l'utilisateur le demande**.

### Point 1 — Structure

Une structure **nommée**, une à deux lignes qui disent ce qu'elle sépare, puis les couches
avec leurs interdits.

```
[le tableau d'avancement, point 1 en cours]

---

**Point 1 : Structure**

MVC avec une couche métier séparée. La vue ne connaît que le contrôleur, le
contrôleur ne décide rien : les règles vivent à un seul endroit, appelé aussi
bien par l'espace membre que par le back-office.

| Couche | Contenu | Interdits |
|---|---|---|
| Présentation | Gabarits, formulaires | A-01-PRESENTATION-SANS-METIER — aucune règle, aucune requête |
| Contrôleur | Lit l'entrée, appelle un service, rend | A-02-CONTROLEUR-SANS-CALCUL — aucun calcul |
| Métier | Les règles, la valorisation du portefeuille | A-03-METIER-SANS-HTTP — ne connaît ni HTTP ni gabarit |
| Données | Modèles et leurs requêtes | A-04-DONNEES-SANS-RESEAU — aucun appel réseau |
| Intégration | Le client du fournisseur de cotation (D-02-FOURNISSEUR-COTATION) | A-05-INTEGRATION-DEPUIS-METIER — appelée depuis le métier uniquement |

A-06-SANS-REPOSITORY — Pas de repository : l'ORM en est déjà un. En échange, toute
requête autre qu'un accès par identifiant vit avec le modèle, jamais dans une vue.

---

**Deux endroits où j'ai tranché**

| | |
|---|---|
| Couche métier | Le calcul « combien vaut mon portefeuille aujourd'hui » a besoin des transactions, des symboles et des cotations en même temps. Il n'appartient donc à aucun des trois modèles. Je le mets dans un fichier à part, appelé par E-04-TABLEAU-DE-BORD et E-05-MES-ACTIONS. |
| Intégration | Tout le code qui va chercher les cours chez le fournisseur tient dans un seul fichier. Le jour où vous changez de fournisseur ou passez au palier payant, c'est le seul fichier à modifier. |

---

Est-ce que cette structure vous convient ?
```

Le bloc « où j'ai tranché » ne contient que des arbitrages réels, expliqués avec des mots
simples et un exemple du projet. Un arbitrage qu'on ne peut pas illustrer par un cas
concret n'en est pas un.

**Les tâches de fond sont une pièce de structure**, pas un détail d'implémentation. Dès
qu'il y a une synchronisation planifiée, un envoi différé ou un traitement long : qui la
déclenche, où vit le code, ce qui se passe si elle échoue.

### Point 2 — Arborescence

L'arborescence réelle, dans un bloc, avec ce que contient chaque dossier. **Les écrans se
citent par leur identifiant complet** — `E-01-CREATION-COMPTE` — jamais `E-01` nu.

**Une unité qui dépassera le seuil de A-15 figure déjà découpée.** Avant d'afficher
l'arborescence, confrontez ce que chaque unité doit porter — nombre d'écrans servis, nombre
de règles numérotées — au seuil convenu. Celle qui le dépassera se cite en plusieurs
fichiers nommés, et la phase qui crée chacun se dit. Une arborescence est lue comme une
instruction : un fichier unique y sera écrit tel quel, et une phase ultérieure devra le
démonter — du travail refait, dans une phase qui avait autre chose à livrer.

Puis le contenu type d'une unité — application, module, dossier de fonctionnalité, selon
le mot de la stack — et les interdits de dépendance entre unités.

Terminez par l'alternative écartée, en une ligne, et par :

```
Cette arborescence sera écrite dans spec-architecture-complement-django.md

Est-ce que cette arborescence vous convient ?
```

### Point 3 — Parcours fonctionnalité

Les parcours d'ajout, en fichiers réels, dans l'ordre.

```
[le tableau d'avancement, point 3 en cours]

---

**Point 3 : Parcours fonctionnalité**

Ceci permettra au modèle d'avoir un exemple, un pattern de comment vous
construisez une fonctionnalité, qu'il pourra réutiliser pour les autres.
Trois parcours couvrent vos 11 écrans.

---

**A — un écran qui affiche** — E-04-TABLEAU-DE-BORD, E-05-MES-ACTIONS,
E-08-DETAIL-ACTION, E-09-LISTE-SYMBOLES

| | |
|---|---|
| **1** | services.py — la fonction qui prépare les données : requêtes et calculs |
| **2** | views.py — la vue appelle le service et passe le résultat au gabarit |
| **3** | urls.py — la route |
| **4** | templates/ — le gabarit, repris de l'aperçu validé en maquette |
| **5** | tests/ — un test sur la fonction du service |
| **6** | base.html — le lien de navigation, si l'écran s'atteint par le menu |

A-09-SERVICE-AVANT-VUE — Le service est développé avant la vue. La vue dépend du
service.

---

Est-ce que ces « parcours fonctionnalité » vous conviennent ?
```

Deux à quatre parcours. Ils se déduisent des écrans : un parcours qui affiche, un parcours
qui enregistre, et un par type de travail que ces deux-là ne couvrent pas — une
synchronisation, un export, un envoi d'e-mails.

S'il en manque un, c'est à l'utilisateur de le signaler — l'option « J'ai des
ajustements » du panneau couvre ce cas, pas besoin d'un second onglet ni d'une phrase
d'invite dans le texte.

### Point 4 — Règles et patterns

Six règles, écrites de façon vérifiable, avec ce qui se constate. Ce sont celles-ci sauf
si l'utilisateur en retire ou en ajoute — elles visent les défauts du code écrit par une
IA, pas les principes classiques.

| ID | Règle | Ce qui se constate |
|---|---|---|
| A-10-UNE-SEULE-FACON | Une seule façon de faire | Deux manières de récupérer des données coexistent |
| A-11-DRY-SEUIL-3 | DRY à partir de 3 | Le même code à trois endroits |
| A-12-YAGNI | YAGNI | Interface à une seule implémentation, option non utilisée |
| A-13-UN-SEUL-ENDROIT | Un seul endroit par sujet | Autorisation vérifiée hors du fichier prévu |
| A-14-ECHOUER-BRUYAMMENT | Échouer bruyamment | Un `catch` qui renvoie une valeur par défaut |
| A-15-UNE-RESPONSABILITE | Une responsabilité par fichier | Un fichier au-delà du seuil convenu — ou un fichier démonté après coup, alors que son dépassement était prévisible |

Chacune s'affiche avec une phrase concrète tirée du projet, et le seuil chiffré quand elle
en demande un.

**Sous le tableau, une définition en une ligne par règle** — l'utilisateur découvre peut-être
DRY ou YAGNI pour la première fois. Une puce par règle, dans l'ordre du tableau, nom en
entier puis ce que ça veut dire :

```
* DRY (Don't Repeat Yourself) : éviter qu'une même logique soit dupliquée à plusieurs
  endroits.
* YAGNI (You Aren't Gonna Need It) : ne pas construire une capacité tant qu'un besoin réel
  ne l'exige pas.
* Responsabilité unique : un fichier ne porte qu'un seul sujet. Quand on sait d'avance
  qu'il dépassera le seuil, il naît déjà découpé — on ne le démonte pas plus tard.
```

Une phrase par règle, jamais plus — c'est un rappel, pas un cours. Terminez par la ligne sur
les patrons de conception, et par :

```
Ces règles seront écrites dans spec-architecture.md

Est-ce que ces règles vous conviennent ?
```

Ajouter une règle passe par la même option « J'ai des ajustements » — pas besoin d'une
deuxième question dans le texte pour ça.

---

## Étape 5 — La clôture

**Le point 4 s'écrit ici**, avant le bloc : on n'entre pas dans la clôture avec un point
en attente.

Un seul bloc. Il repose ce qui est resté sans réponse, montre ce qui sera écrit, et attend
la validation.

```
| **PRESTA — Architecture** | |
|---|---|
| [x] 1 - Structure | Couches logicielles, services... |
| [x] 2 - Arborescence | Organisation des fichiers |
| [x] 3 - Parcours fonctionnalité | Comment une fonctionnalité est développée |
| [x] 4 - Règles et patterns | DRY, YAGNI, responsabilité unique... |

---

**Un point est resté sans réponse**

| | |
|---|---|
| Django 6.1 | Ma base de connaissances s'arrête à Django 6.0. Je fais la recherche sur les différences qui affectent l'architecture, ou j'écris les fichiers tels quels ? Dans ce cas la limite sera indiquée en tête du complément. |

---

**Ce que je vais écrire**

| Fichier | Contenu |
|---|---|
| spec-architecture.md | Les couches et leurs interdits, les 6 règles de code, les 3 parcours en étapes, la règle de regroupement et de dépendance |
| spec-architecture-complement-django.md | L'arborescence, le contenu type d'une application, les 3 parcours en fichiers réels, la version Django 6.1 |
| status.md | étape : architecture |
| regles-projet.md | Les deux fichiers à lire avant d'écrire du code |

---

Si tout est bon, j'écris.
```

**[PANNEAU]** — la porte de validation : *Oui, je valide, vous pouvez écrire* / *J'ai des
ajustements*. Si un point est resté sans réponse, il se traite en texte d'abord ; la
porte ne s'ouvre qu'ensuite.

**S'il reste une décision `D-xx` en attente qui touche l'architecture**, elle apparaît ici
avec ce qu'elle bloque, et vous demandez s'il faut la régler avec
`/presta-essais-techniques` avant d'écrire. Vous ne clôturez jamais en silence sur un point
ouvert.

---

## Étape 6 — L'écriture des fichiers

**Seulement une fois la porte de validation franchie.** Lisez `references/gabarits.md`.

| Fichier | Contenu |
|---|---|
| `presta/specs/spec-architecture.md` | Structure, couches et interdits `A-xx`, regroupement, parcours en étapes, règles de code, patrons |
| `presta/specs/spec-architecture-complement-{stack}.md` | Arborescence, contenu type d'une unité, traduction des couches, parcours en fichiers, conventions `S-xx`, dérogations |
| `presta/annexes/architecture-system.md` | En porte 3 seulement : le document rapporté par l'utilisateur |
| `presta/specs/spec-technique.md` | La stack, si elle a été fixée ici. Les décisions `D-xx` ouvertes pendant l'architecture |
| `presta/status.md` | `etape: architecture` |
| `presta/regles-projet.md` | Les deux règles ci-dessous |

Le slug du complément est **le framework qui structure le code**, pas le langage ni la
plateforme : `django`, `blazor`, `nextjs`, `laravel`. Pas `python`, pas `dotnet`. En
minuscules, sans point, sans numéro de version — la version vit dans le frontmatter.

Inscrivez dans `presta/regles-projet.md`, si elles n'y sont pas déjà :

> Avant d'écrire du code, lire `presta/specs/spec-architecture.md` et
> `presta/specs/spec-architecture-complement-{stack}.md`. En cas de contradiction, le
> complément l'emporte.

> Toute dérogation à ces fichiers est écrite dans le rapport de la phase concernée.

Prenez l'horodatage avec `date +%FT%T`. Ouvrez les deux fichiers produits en aperçu quand
l'outil le permet, sinon affichez leurs chemins. Terminez par :

```
| **PRESTA — Architecture** |
|---|

C'est en place.

| Fichier | Contenu |
|---|---|
| presta/specs/spec-architecture.md | couches, 6 règles, 3 parcours |
| presta/specs/spec-architecture-complement-django.md | arborescence Django 6.1, contenu type d'une application |
| presta/status.md | étape : architecture |
| presta/regles-projet.md | les deux fichiers à lire avant d'écrire du code |

J'ai ouvert les deux fichiers.


Prochaine étape : le découpage en phases, avec /presta-phases.
```

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
| Recherche web | Vérifier l'écart de version sur les conventions de structure, en datant | L'écrire dans le complément : `connaissance: non vérifiée — écrit d'après {version}` |
| Sous-agents | Lire un projet source dont l'utilisateur donne le chemin, et renvoyer une synthèse compacte | Lui demander d'exécuter le prompt d'extraction dans l'autre projet |
| Ouverture de fichier | Ouvrir les deux fichiers produits en aperçu | Afficher les chemins |
| Panneau de questions | `AskUserQuestion` aux endroits marqués **[PANNEAU]** | Les mêmes options en tableau |

---

## Ce que cette skill ne fait pas

- Elle ne découpe pas le développement en phases — c'est `/presta-phases`.
- Elle n'initialise pas le projet, n'installe rien et ne génère aucun squelette de code —
  c'est `/presta-setup`.
- Elle ne redéfinit ni les écrans, ni les entités, ni le visuel. Elle les lit.
- Elle ne prescrit aucun patron de conception à l'avance.
- Elle n'assainit pas une architecture existante et n'audite pas de code — l'audit est
  dans `/presta-audit`.
- Elle ne tranche aucune décision qui demande une mesure ou un essai : elle ouvre un
  `D-xx` pour `/presta-essais-techniques`.
- Elle n'écrit pas de code et ne touche à aucun `settings.json`.
