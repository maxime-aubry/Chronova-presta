---
name: presta-tests
description: Mécanismes de test déduits des critères des phases, chacun prouvé par un test vert — produit spec-tests.md. Invocation explicite uniquement, ne pas déclencher de soi-même.
---

# Tests

Vous décidez **avec quoi chaque critère de validation sera prouvé**, et vous le prouvez.
Une fois, avant que le développement ne commence.

Sans ce passage, chaque phase rejoue la même décision dans une session neuve : vingt et
une phases, vingt et une conventions de test. Avec, le vérificateur de chaque phase
applique une grille écrite au lieu d'en inventer une.

À la fin, l'utilisateur a une spécification de test, un projet de tests qui tourne, et un
script qui dit si un critère a été oublié.

**Vous ne décidez rien.** Vous déduisez, vous prouvez, vous recommandez, il tranche.

---

## Règles de conduite — valables à chaque instant

1. **Vouvoiement**, partout.
2. **La grille se déduit des critères, jamais de la stack.** « Quels outils de test
   existent pour ce framework » est la mauvaise question : elle produit une usine à gaz
   dont les trois quarts ne servent à rien. La bonne est « qu'est-ce que ces critères
   demandent de prouver », et les mécanismes s'en déduisent.
3. **Aucun mécanisme n'entre dans la spécification sans un test vert.** Une bibliothèque
   qui a l'air de convenir n'a pas prouvé qu'elle s'installe, qu'elle compile et qu'elle
   tourne sur la version du projet. C'est la seule chose que l'étape 4 établit.
4. **Un critère qui dicte son mécanisme fait autorité.** « Se vérifie en appelant le
   service, sans rendre de composant » — la décision est prise, dans le fichier de phase,
   par `/presta-phases`. Vous ne la rediscutez pas, vous la relevez.
5. **Un critère est un verdict, pas un test.** Un critère se prouve par un test, par dix,
   ou par une étape de cahier de recettes. Ce qui doit être vrai, c'est l'inverse : tout
   test porte l'identifiant du critère qu'il prouve.
6. **Le coût s'affiche avec le bénéfice.** Un mécanisme se propose avec le nombre de
   critères qu'il couvre et ce qu'il coûte à faire tourner. Un utilisateur qui ne voit
   que le bénéfice accepte tout.
7. **Vous n'écrivez aucun test de l'application.** Les tests que vous écrivez prouvent le
   mécanisme, pas le produit. Les tests des critères appartiennent au vérificateur de
   chaque phase, dans `/presta-implemente`.
8. **Écriture au fil de l'eau.** Chaque section validée est écrite immédiatement. Une
   session coupée ne perd rien.
9. **Jamais de page blanche.** Vous arrivez avec une proposition complète et ses raisons.
   « Quels tests voulez-vous ? » est interdit.
10. **Aucune supposition écrite.** Un mécanisme qu'on n'a pas pu prouver ne s'écrit pas
    « à confirmer » dans la spécification : ses critères sont redistribués, et c'est dit.

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

---

## Étape 0 — Démarrage immédiat

**Aucun préambule.** Vous lancez la détection dès le premier message, et vous affichez
l'accueil de l'étape 2. Pas de « je vais analyser votre projet » : l'analyse prend un
appel, elle est faite avant que la phrase ne s'affiche.

---

## Étape 1 — Détection et prérequis

```bash
[ -f presta/status.md ] && sed -n '1,12p' presta/status.md
ls presta/livrables/*/phases/p-*.md 2>/dev/null | wc -l
grep -h '^[0-9]*\. \*\*' presta/livrables/*/phases/p-*.md 2>/dev/null | wc -l
[ -f AGENTS.md ] && sed -n '/^## Commandes/,/^##[^#]/p' AGENTS.md
[ -f presta/specs/spec-tests.md ] && echo "OK spec-tests" || echo "-- spec-tests"
ls *.sln *.csproj package.json pyproject.toml go.mod Cargo.toml 2>/dev/null
[ -d .git ] && git log --oneline -1
```

Un seul appel. Il donne l'état du projet, le nombre de phases, le **nombre total de
critères**, les commandes réelles, la présence d'une spécification de test antérieure et
la stack. Si la commande échoue — shell Windows — repliez-vous sur `ls` et `grep`
séparés, sans enchaîner plus d'un appel de plus.

Ensuite, et seulement ça :

1. **`presta/status.md`** — `livrable_courant` et `etape`.
2. **`presta/specs/spec-technique.md`**, section « Stack » — la version exacte du
   framework et du moteur de base. Pas le reste du fichier.
3. **`presta/specs/spec-architecture.md` et son complément** — les règles de test qui y
   sont déjà écrites. Une architecture qui impose « aucune règle métier dans un
   composant » a déjà tranché la moitié de la grille.
4. **`AGENTS.md`** — les commandes réelles, et la ligne « Tests ».

**Ne lisez pas les fichiers de phase ici.** C'est l'étape 2, et c'est un sous-agent qui
les lit.

### Les arrêts

| Situation | Ce que vous faites |
|---|---|
| Pas de `presta/status.md` | **Arrêt.** « Il n'y a pas de projet Presta ici. Commencez par le rendez-vous : /presta-rdv » |
| Aucun fichier sous `livrables/*/phases/` | **Arrêt.** « Le développement n'est pas découpé : il n'y a pas de critères dont déduire les mécanismes de test. Passez par /presta-phases » |
| P-01-SETUP à `à faire` ou `en cours` | **Soft gate.** Message ci-dessous |

```
Le projet n'est pas initialisé : P-01-SETUP n'est pas validée.

Je peux déduire la grille de vos critères sans ça. Mais je ne peux prouver
aucun mécanisme — prouver un mécanisme, c'est le faire tourner sur du code qui
compile, et il n'y en a pas encore.

| | |
|---|---|
| **Maintenant** | Vous repartez avec la grille, et les mécanismes restent à prouver |
| **Après /presta-setup** | Vous repartez avec la grille et trois tests verts |
```

**[PANNEAU]** — *Je lance /presta-setup d'abord* / *Continuez sans la preuve*.

### S'il existe déjà une `spec-tests.md`

On ne la refait pas. Vous affichez ce qu'elle contient, et vous proposez :

| | |
|---|---|
| **Compléter** | Des phases ont été ajoutées depuis. Vous inventoriez les nouveaux critères seulement, et vous complétez la grille |
| **Reprendre en entier** | Un mécanisme ne convient plus, la stack a bougé. On refait l'inventaire complet |

Un mécanisme déjà prouvé **ne se reprouve pas** : le test gabarit est là, il tourne.

---

## Étape 2 — L'inventaire

**C'est l'étape qui fait le travail.** Tout le reste en découle.

### Ce qu'elle produit

Un classement des critères par **nature de preuve** : non pas ce qu'ils disent, mais ce
qu'il faudrait exercer pour établir qu'ils sont tenus. Sept natures suffisent à couvrir
n'importe quel projet — un projet sans interface n'en utilise que trois.

| Nature | Ce qu'il faut exercer |
|---|---|
| Règle sans données | Une fonction, des objets en mémoire, aucune persistance |
| Règle avec données | Une requête, une contrainte d'unicité, une suppression en cascade |
| Rendu | Ce qu'un écran affiche, sans lancer l'application |
| Accès et routage | Une redirection, une garde, un code de retour |
| Parcours | Un enchaînement qui n'existe que dans un navigateur ou un simulateur |
| Conformité structurelle | Une propriété du code source, qui se lit et ne s'exécute pas |
| Jugement humain | Une impression visuelle, un document imprimé, une comparaison à une maquette |

### Comment vous la menez

**Par un sous-agent**, qui lit tous les fichiers de phase et ne vous renvoie qu'un
tableau. Les fichiers de phase d'un livrable pèsent facilement cent kilo-octets : un
contexte principal qui les a tous lus ne tient pas la conversation qui suit.

Son prompt lui impose quatre choses :

1. Lire **tous** les fichiers sous `presta/livrables/{livrable}/phases/`, index compris.
2. Classer **chaque** critère dans une seule nature. Un critère qui en appelle deux va à
   la plus coûteuse — c'est elle qui dimensionne.
3. Relever les critères qui **dictent leur propre mécanisme**, et les citer.
4. Rendre un tableau, et **un identifiant d'exemple réel par nature**. Pas un exemple
   inventé : `P-07/C-04`, avec les six premiers mots du critère.

Le quatrième point n'est pas décoratif. Un tableau de nombres ne se conteste pas ;
« P-07/C-04 — archivés grisés et en italique » se conteste, et c'est ce qui permet à
l'utilisateur de dire « celui-là, je le veux en recette ».

**Sans sous-agent disponible** : vous lisez les phases vous-même, par groupes de cinq, en
ne gardant qu'un compteur et les exemples. Vous ne gardez pas le texte des critères.

### L'affichage

```
| **PRESTA — Tests** | |
|---|---|
| Projet | TimeTrackerPro — Blazor Server, .NET 11 preview, SQLite |
| Livrable | v1.0-suivi-temps-facturation — 21 phases, 243 critères |

---

**J'ai lu vos 243 critères de validation.** Voici ce qu'ils demandent de prouver.

| Nature | Critères | Exemple |
|---|---|---|
| Règle sans données | 95 | P-05/C-01 — arrondi de facturation au quart d'heure supérieur |
| Règle avec données | 55 | P-07/C-02 — nom de client unique, y compris archivé |
| Rendu | 40 | P-07/C-04 — archivés grisés et en italique |
| Accès et routage | 15 | P-03/C-07 — toute URL sans session redirige vers /login |
| Parcours | 18 | P-12 — le chrono qui tourne, le glisser-déposer des groupes |
| Conformité structurelle | 12 | P-05/C-13 — aucune conversion en double dans les calculs |
| Jugement humain | 8 | P-18/C-06 — A4 portrait, logo en haut à gauche |

**Six de vos critères disent déjà comment les prouver.** P-05/C-14 : « chacune de
ces règles se vérifie en instanciant les objets, sans base de données ».
/presta-phases a tranché, je ne rediscute pas.
```

Le total affiché **est** le total détecté à l'étape 1. S'ils diffèrent, le sous-agent a
raté des critères : relancez-le sur les phases manquantes plutôt que d'afficher un chiffre
faux.

---
## Étape 3 — La proposition

Un mécanisme par nature, jamais l'inverse. Deux natures peuvent partager un mécanisme —
c'est fréquent ; une nature qui en demanderait deux est un classement raté.

### La règle de dimensionnement

**Un mécanisme se justifie par le nombre de critères qu'il couvre, pas par sa qualité.**
Un outil excellent pour trois critères coûte plus cher qu'il ne rapporte : ses trois
critères partent au cahier de recettes, et c'est une bonne décision.

Le seuil n'est pas un chiffre, c'est une comparaison : ce que coûte le mécanisme — à
installer, à faire tourner à chaque phase, à réparer quand il casse — contre ce que
coûterait de vérifier ces critères à la main, vingt et une fois.

### La version de la stack

**Vérifiez sur le web que les bibliothèques retenues sont maintenues et compatibles avec
la version du projet.** Ne répondez pas de mémoire : les versions de bibliothèques de test
bougent vite, et un projet figé sur une préversion — c'est fréquent — n'est pas couvert
par ce que vous croyez savoir.

Si la recherche n'est pas disponible, dites-le, et l'étape 4 devient la seule preuve. Ne
citez jamais un numéro de version de mémoire.

### L'affichage

```
**Ce que je propose**

| Mécanisme | Couvre | Pourquoi |
|---|---|---|
| xUnit | 150 critères | Le socle. 62 % de vos critères sont des règles métier, cohérent avec A-09-SERVICE-AVANT-ECRAN |
| SQLite en mémoire | 55 de ces 150 | Vos décisions figées imposent decimal(18,2) : un fournisseur en mémoire générique ne reproduirait pas l'arrondi de RG-46 |
| bUnit | 40 critères | Rendre un composant sans navigateur |
| WebApplicationFactory | 15 critères | Les gardes de route en HTTP réel. 15 critères sortis du navigateur |
| Playwright | 18 critères | Ce qui n'existe que dans un navigateur : le chrono, le glisser-déposer |
| grep scriptés | 12 critères | Un double dans un calcul, une règle métier dans un composant : ça se lit |
| Cahier de recettes | 8 critères | Le PDF ouvert à l'œil, la comparaison aux aperçus |

**Le poste discutable, c'est Playwright** : 18 critères, mais le mécanisme le
plus lent et le plus fragile. Les retirer les enverrait au cahier de recettes —
vous vérifieriez le chrono à la main à chaque livraison.

---

**Ce que je fais ensuite** : un test vert par mécanisme, sur du code réel de
P-01-SETUP. Un mécanisme qui ne passe pas ne rentre pas dans la spécification.
```

**[PANNEAU]** — *Validez ces mécanismes* / *Retirez le poste discutable* / *J'ai des
corrections*.

Trois règles sur ce message :

- **Chaque ligne « pourquoi » cite ce qui la fonde** — une règle d'architecture, une
  décision figée, une règle métier. Une justification qui ne cite rien n'est pas
  contestable.
- **Le poste discutable se nomme, toujours, et il n'y en a qu'un.** C'est celui dont le
  rapport coût/couverture est le plus mauvais. En désigner trois revient à ne rien
  recommander.
- **Vous n'annoncez pas encore les commandes.** Elles ne sont pas prouvées.

---

## Étape 4 — La preuve

**Un test vert par mécanisme retenu, sur du code réel du projet.** C'est la seule étape
qui distingue cette skill d'une recommandation de blog.

### Ce que prouve un test gabarit

Qu'il s'installe, qu'il compile, qu'il tourne sur la version du projet, et qu'il rend un
résultat lisible. **Pas que l'application est correcte** — il n'y a encore rien à valider.

Le plus simple qui exerce vraiment le mécanisme :

| Mécanisme | Le gabarit |
|---|---|
| Tests unitaires | Une assertion triviale qui passe |
| Tests sur données | Créer une entité, la relire, vérifier une contrainte |
| Rendu | Rendre le composant le plus simple de l'application, celui du gabarit |
| Accès et routage | Une route protégée, appelée sans session, qui redirige |
| Parcours | Entrer dans l'application et faire la première action réelle |
| Conformité | La commande qui cherche, sur un motif dont vous savez qu'il ne sort rien |

### Ce que vous installez, et ce que vous ne touchez pas

Vous installez les paquets de test, dans le projet de tests uniquement. **Vous ne touchez
ni au projet applicatif, ni à ses dépendances.** Un mécanisme qui exigerait de modifier
l'application pour fonctionner n'est pas un mécanisme de test : c'est une contrainte
d'architecture, et elle remonte à `/presta-architecture`.

Ce qui touche à la machine de l'utilisateur — un navigateur à télécharger, un runtime à
installer — **se dit avant, jamais en silence**.

### Quand un mécanisme ne passe pas

C'est le cas qui compte, et il se traite sans jamais laisser la spécification à moitié
écrite.

| Temps | Ce que vous faites |
|---|---|
| **1** | Une alternative, une seule. Vous la cherchez, vous la prouvez |
| **2** | Si elle échoue aussi : les critères de ce mécanisme se **redistribuent**, vers un mécanisme plus lourd qui marche, ou vers le cahier de recettes |
| **3** | Vous affichez la redistribution, avec ce qu'elle coûte, et l'utilisateur tranche |

Trois interdits :

- **Jamais de montage maison.** Un mécanisme qu'il faut bricoler pour qu'il démarre
  cassera à la troisième phase, dans une session qui n'aura pas le contexte pour le
  réparer.
- **Jamais un mécanisme « à confirmer » dans la spécification.** Il est prouvé, ou ses
  critères sont ailleurs.
- **Jamais l'abandon silencieux.** Des critères qui changent de mécanisme changent de
  coût : ça se voit et ça se valide.

```
**bUnit ne passe pas** — incompatible avec la préversion figée dans global.json.

J'ai essayé le rendu par composant hors bUnit : même blocage, il vient du moteur
de rendu, pas de la bibliothèque.

Vos 40 critères de rendu doivent aller ailleurs :

| | |
|---|---|
| **Vers Playwright** | Ils sont prouvés, mais le parcours passe de 18 à 58 critères — plusieurs minutes par phase |
| **Vers le cahier de recettes** | Coût nul en machine, 40 vérifications à l'œil à chaque livraison |
| **En attendant** | bUnit suit les préversions : ça se retentera à la version suivante |
```

**[PANNEAU]** — *Vers Playwright* / *Vers le cahier de recettes* / *Je remonte à
/presta-architecture*.

### Le parallélisme

Les mécanismes se prouvent **un par un, dans l'ordre du plus fondamental au plus
coûteux** : le socle unitaire d'abord, le parcours en dernier. Un socle qui ne passe pas
rend inutile de prouver le reste, et vous vous arrêtez là.

---

## Étape 5 — Le récap

Avant d'écrire quoi que ce soit. Ce qui a été prouvé, avec la sortie réelle des
commandes — pas votre résumé de la sortie.

```
**Les mécanismes sont prouvés.**

| Mécanisme | Preuve |
|---|---|
| xUnit | 1 test, 1 passé — 0,4 s |
| SQLite en mémoire | 1 test, 1 passé — entité créée, relue, contrainte levée |
| bUnit | 1 test, 1 passé — composant rendu |
| WebApplicationFactory | 1 test, 1 passé — 302 vers /login |
| Playwright | 1 test, 1 passé — 11 s, Chromium installé au premier lancement |
| grep | commande lancée, 0 résultat sur un motif absent |

Ce que je vais écrire :

| Fichier | Ce qu'il contiendra |
|---|---|
| presta/specs/spec-tests.md | la grille, la convention de nommage, les commandes |
| outils/couverture.sh | la garde : un critère sans test se voit |
| AGENTS.md | les deux commandes, à la place du renvoi |
| presta/status.md | étape : tests |

Je peux écrire ?
```

**[PANNEAU]** — *Écrivez* / *J'ai une correction*.

---

## Étape 6 — L'écriture

**Seulement une fois le récap validé.** Lisez `references/gabarits.md`. Prenez
l'horodatage avec `date +%FT%T`.

| Fichier | Ce qui s'écrit |
|---|---|
| `presta/specs/spec-tests.md` | La grille, la convention `P-xx/C-nn`, les commandes, ce qui part au cahier de recettes |
| Les tests gabarits | Laissés en place dans le projet de tests, committés |
| `outils/couverture.sh` | Le script de couverture, adapté à la stack |
| `AGENTS.md` | Les commandes réelles, à la place de la ligne « pas encore configurés » |
| `presta/regles-projet.md` | Une ligne dans la carte des fichiers, et rien d'autre |
| `presta/status.md` | `etape: tests` |

Puis le commit :

```
git add -A
git commit -m "Mécanismes de test — grille, gabarits prouvés, script de couverture"
```

**On ne pousse que si un dépôt distant est déjà branché**, et jamais en force.

### Les tests gabarits restent

Ils ne se suppriment pas après la preuve. Un agent frais copie un exemple qui tourne bien
plus fidèlement qu'il ne suit une consigne écrite — c'est ce qui fait que la convention
tiendra sur vingt et une phases.

### Le message de sortie

```
| **PRESTA — Tests** |
|---|

Les mécanismes de test sont en place.

| | |
|---|---|
| Mécanismes | 6, tous prouvés |
| Critères couverts par un test | 235 sur 243 |
| Critères au cahier de recettes | 8, listés dans spec-tests.md |
| Commandes | ./test.sh et ./test.sh --parcours, dans AGENTS.md |

---

**Ce qui reste ouvert**

| | |
|---|---|
| P-18/C-06 | La mise en page du PDF se juge à l'œil. Aucun mécanisme ne la couvre, c'est assumé |
```

<!-- SHARED:NEXT-SKILL:START -->
**Le nom de la skill suivante ne s'affiche jamais avant que les fichiers soient écrits.**
Une skill annoncée est une skill que l'utilisateur lance.
<!-- SHARED:NEXT-SKILL:END -->

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
| Sous-agents | L'inventaire des critères par sous-agent, qui ne rend qu'un tableau | Lire les phases par groupes de cinq, en ne gardant que les compteurs et les exemples |
| Recherche web | Vérifier que les bibliothèques sont maintenues et compatibles avec la version du projet, en datant | Le dire explicitement. Ne jamais citer un numéro de version de mémoire — l'étape 4 devient la seule preuve |
| Shell | Installer les paquets, lancer les tests, écrire le script de couverture | Donner à l'utilisateur les commandes exactes et lui demander de coller la sortie |
| Navigateur piloté | Prouver le mécanisme de parcours | Le mécanisme n'est pas prouvé : ses critères se redistribuent, étape 4 |
| Panneau de questions | `AskUserQuestion` aux endroits marqués **[PANNEAU]** | Les mêmes options en texte simple |

---

## Ce que cette skill ne fait pas

- Elle n'écrit aucun test de l'application. Ses tests prouvent les mécanismes ; les tests
  des critères appartiennent au vérificateur de chaque phase, dans `/presta-implemente`.
- Elle ne modifie aucun critère de validation, même mal formulé. Ils appartiennent aux
  fichiers de phase, et un critère réécrit par qui doit le prouver ne prouve plus rien.
- Elle n'écrit aucun code applicatif et ne touche pas aux dépendances du projet
  applicatif — uniquement à celles du projet de tests.
- Elle ne crée pas le projet de tests ni ne l'inscrit dans la solution : c'est
  `/presta-setup`, qui en pose la coquille vide.
- Elle ne décide pas du périmètre. Un mécanisme retiré, c'est des critères qui changent de
  coût : l'utilisateur tranche.
- Elle n'installe rien sur la machine de l'utilisateur sans le dire — navigateur, runtime,
  outil système.
- Elle ne tient aucun tableau d'avancement des phases et ne touche à aucun champ `etat:`.
- Elle ne fait pas avancer `etape:` au-delà de `tests`, et ne touche à aucun
  `settings.json`.
