---
name: presta
description: Affiche les étapes de la méthode Presta et l'avancement du projet. Lecture seule. Invocation explicite uniquement, ne pas déclencher de soi-même.
---

# Presta — point d'entrée

Vous affichez les étapes de la méthode, puis une ligne qui dit où en est le projet.

**Cette skill est en lecture seule.** Elle n'écrit aucun fichier, ne modifie aucun état,
ne pose aucune question et ne lance aucune autre skill. Elle se termine sur une phrase.

Elle se lance dix fois par jour : **tout est fait pour qu'elle n'ait rien à réfléchir.**
Le premier message ne dépend d'aucun fichier, et le second est écrit par un script.

---

## Étape 0 — Le message d'ouverture

**Cette section passe avant toutes les autres, y compris les règles de conduite : c'est
le premier message, et rien ne doit s'intercaler devant lui.** Ne lisez pas la suite de
cette skill, n'analysez rien, ne planifiez rien, n'ouvrez aucun fichier.

**Recopiez le bloc ci-dessous tel quel**, puis lancez la commande de l'étape 1 **dans le
même message**, derrière le texte. C'est du markdown : affichez-le rendu, tableau
compris, jamais dans un bloc de code.

````
| **PRESTA** |
|---|

Analyse de votre projet…
````

**Quatre lignes, et c'est voulu.** Ce bloc ne dépend d'aucun fichier : il n'y a rien à
lire, rien à décider et rien à vérifier avant de l'afficher. Tout le reste — les étapes,
les crochets, la légende, le statut — arrive à l'étape 2, écrit par le script.

Ne lui ajoutez rien, même quand vous savez déjà où en est le projet.

---

## Étape 1 — Le script d'état

Un seul appel, lancé **dans le message de l'étape 0**, derrière le texte.

```bash
bash {skill}/analyse-projet.sh
```

`{skill}` est le chemin absolu du dossier de cette skill — celui d'où vous avez chargé ce
`SKILL.md`. Substituez-le : un chemin relatif ne pointerait pas au bon endroit, le script
se lançant depuis la racine du projet de l'utilisateur.

**Le script ne rend pas des données, il rend le message fini.** Tout est calculé dedans :
l'état de chaque étape, les compteurs, les décisions en attente, le nom des étapes, les
accords, l'étape suivante. C'est délibéré — écrire trente-cinq lignes de shell dans un
appel d'outil coûte plus cher que tout le reste de la skill réuni, et recomposer une
phrase depuis neuf marqueurs coûte un second tour de réflexion. Ici, vous écrivez un
chemin et vous recopiez une sortie.

### Si le script ne se lance pas

Chemin introuvable, shell Windows sans bash : **un seul repli**, puis vous composez
vous-même le message de l'étape 2, à partir du tableau ci-dessous.

```bash
ls presta/ presta/specs/ presta/maquettes/ 2>/dev/null; sed -n '1,9p' presta/status.md 2>/dev/null
```

- Pas de `presta/status.md` → le tableau tout décoché, puis « Aucun projet Presta dans ce
  dossier. » et « Prochaine étape : vous pouvez lancer /presta-rdv ».
- Sinon, l'état de chaque étape se déduit ainsi : `[x]` si son artefact existe **et** que
  `etape:` a atteint son rang ; `[-]` si l'artefact existe sans que le rang soit atteint ;
  `[ ]` si l'artefact n'existe pas.

| # | Skill | Libellé | Artefact | Rang |
|---|---|---|---|---|
| 1 | `/presta-rdv` | Rendez-vous | `presta/specs/spec-produit.md` | `rdv` = 1 |
| 2 | `/presta-spec` | Spécifications : écran par écran | `presta/specs/spec-ecrans.md` | `specs` = 2 |
| 3 | `/presta-modeles` | Modèles de données | `presta/specs/spec-modeles.md` | `modeles` = 3 |
| 4 | `/presta-maquettes` | Maquettes et design system | `presta/maquettes/design-system.md` | `maquettes` = 4 |
| 5 | `/presta-valide-specs` | Validation des specs | un rapport dans `presta/validations/` | **aucun** |
| 6 | `/presta-architecture` | Architecture du code | `presta/specs/spec-architecture.md` | `architecture` = 6 |
| 7 | `/presta-phases` | Découpage en phases | un fichier dans `livrables/{livrable_courant}/phases/` | `phases` = 7 |
| 8 | `/presta-setup` | Initialisation du projet | `p-01-setup.md` à `etat: validée`, dans n'importe quel livrable | **aucun** |
| 9 | `/presta-tests` | Mécanismes de test | `presta/specs/spec-tests.md` | `tests` = 9 |
| 10 | `/presta-implemente` | Développement | dans le livrable courant, une phase `etat: validée` autre que P-01-SETUP | `livre` = 11 |

Les deux lignes de « Autres : » — `/presta-essais-techniques` (essais techniques, à tout
moment) et `/presta-audit` (audit du code, après le développement) — et la légende
`E : Écran / M : Modèle / F : Fonctionnalité / D : Décision technique / L : Layout
(maquettes) / A : Architecture / S : Stack / P : Phase / V : Validation des specs /
AU : Audit` se recopient telles quelles.

Les étapes 5 et 8 n'ont pas de rang. `/presta-valide-specs` est relançable et laisse le
projet à `specs` : elle est terminée dès qu'un rapport existe. Le setup se fait une fois
pour le projet, pas une fois par livrable : sur une évolution, `etape:` repart à `rdv` et
un rang le ferait retomber à « pas commencé » alors que l'application tourne.

L'étape suivante est **la première qui n'est pas terminée**, en descendant. Une étape
commencée se reprend avant qu'une autre ne démarre.

---

## Étape 2 — L'affichage de l'état

Le second message, et le dernier. **La sortie du script s'affiche telle quelle, en
entier.** C'est du markdown déjà rédigé : vous le recopiez, vous ne le reformulez pas,
vous ne le complétez pas, vous ne le commentez pas, et vous n'ajoutez rien derrière.

```
**Delta — v1.0**

**Étapes :**

| | | | |
|---|---|---|---|
| [x] | **1** | /presta-rdv | Rendez-vous |
| [x] | **2** | /presta-spec | Spécifications : écran par écran |
| [-] | **3** | /presta-modeles | Modèles de données |
| [ ] | **4** | /presta-maquettes | Maquettes et design system |
| … | | | |

---

**Autres :** … | **Légende :** …

---

En cours : modèles — 3 entités sur 6.
En attente : D-02-FOURNISSEUR-COTATION, D-03-FREQUENCE-COURS — /presta-essais-techniques

Prochaine étape : vous pouvez reprendre /presta-modeles
```

Les crochets valent `[x]` terminée, `[-]` commencée, `[ ]` pas commencée. **Ils ne se
recalculent pas** : le script les a posés.

Il n'y a pas de ligne « ce qui est fait » : le tableau le dit déjà. Ne sont écrites que
les choses que le tableau ne peut pas porter — le compteur d'une étape en cours, une
étape jamais commencée sous une étape faite, les décisions en attente.

---

## Règles de conduite

1. **Vouvoiement**, partout.
2. **Rien ne s'analyse avant l'affichage de l'étape 0.**
3. **Le script est la seule source.** Vous n'ouvrez aucune spec, aucun fichier de phase,
   aucun code.
4. **Un seul appel.** S'il échoue, un seul repli, puis vous affichez avec ce que vous
   avez.
5. **La commande de l'étape suivante s'écrit en entier**, `/presta-modeles`, jamais
   « l'étape suivante » ni « les modèles ». C'est ce qui fait qu'au troisième projet
   l'utilisateur n'a plus besoin de ce routeur.
6. **Aucune question, aucun panneau.** Vous ne proposez pas de lancer la skill suivante :
   vous donnez sa commande et vous vous arrêtez.
7. **Aucun jugement sur l'état du projet.** Pas de « vous avez bien avancé », pas de
   « il ne reste plus grand-chose ». Vous dites ce qui est fait, l'utilisateur juge.
8. **Aucun conseil non demandé.** Pas de « je vous recommande de passer par la validation
   des specs », pas de rappel de ce qu'une skill va faire. Le statut dit où on en est, la
   ligne suivante dit quoi lancer. Rien d'autre.
9. **Un état incohérent s'affiche tel quel.** Si la sortie vous paraît fausse, c'est un
   fichier qui manque ou un `etape:` mal posé dans le projet — vous ne le corrigez pas et
   vous ne le compensez pas.

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
| Shell | `bash {skill}/analyse-projet.sh`, un seul appel | Le repli de l'étape 1, et vous composez le message de l'étape 2 vous-même |
| Panneau de questions | Sans objet — cette skill ne pose aucune question | |
| Recherche web | Sans objet — elle n'affirme rien sur un outil ni sur un tarif | |
| Sous-agents | Sans objet — rien à déléguer | |

C'est la skill la plus portable de la méthode, et c'est voulu : c'est celle qu'on lance
en premier, sur n'importe quel outil.

---

## Ce que cette skill ne fait pas

- Elle n'écrit aucun fichier, ne modifie ni `presta/status.md`, ni `etape:`, ni un
  fichier de phase.
- Elle ne lance aucune autre skill. Elle affiche la commande, l'utilisateur la tape.
- Elle ne pose aucune question et n'affiche aucun panneau.
- Elle n'ouvre aucune spec, aucun code, aucune maquette. Tout vient du script.
- Elle ne juge pas l'avancement, ne recommande pas de sauter une étape, et ne signale pas
  qu'une spec serait incomplète — c'est `/presta-valide-specs`.
- Elle ne corrige pas un état incohérent : elle l'affiche tel qu'il est dans les fichiers.
