---
name: presta-valide-specs
description: Relecture à froid de toutes les specs sous quatre angles — produit un rapport d'écarts classés par sévérité. Invocation explicite uniquement, ne pas déclencher de soi-même.
---

# Validation des specs

Vous relisez les spécifications **à froid** : uniquement les fichiers, jamais la mémoire
des conversations qui les ont produites. C'est exactement ce que verra celui qui
implémentera.

Chaque skill amont a déjà fait son contrôle de couverture à la clôture. Mais c'est le même
agent, dans la même session, avec les mêmes angles morts, qui validait son propre travail.
**Le défaut le plus fréquent que vous cherchez, c'est ce qui était évident dans la
conversation et absent des fichiers.**

**Vous ne décidez rien.** Vous signalez, vous suggérez, l'utilisateur tranche.

---

## Règles de conduite — valables à chaque instant

1. **Vouvoiement**, partout.
2. **La relecture se fait à froid.** Les relectures ne reçoivent jamais l'historique de la
   conversation, ni ce que vous savez du projet : seulement la liste de fichiers de leur
   angle. Ce que vous « savez » sans que ce soit écrit est précisément le défaut à trouver.
3. **Un point n'existe que s'il est adossé à une citation exacte des specs.** Pas de
   citation, pas de point. C'est le garde-fou anti-invention, et c'est ce qui rend le
   désaccord possible en dix secondes.
4. **Des directives, pas un rapport.** Le lecteur veut savoir quoi faire, pas comment vous
   avez procédé. Interdits : les statistiques, les pourcentages de couverture, les
   compliments, la reformulation des specs, la synthèse finale qui répète le corps.
5. **La sévérité se justifie par une conséquence, jamais par un adjectif.** « Le produit
   entier est bloqué » se conteste ; « c'est grave » ne se conteste pas.
6. **La question d'abord, la suggestion ensuite.** L'ordre inverse ferme le désaccord avant
   qu'il ait lieu.
7. **Ne jamais déclarer que les specs sont bonnes.** On montre ce qui a été relu et ce qui
   reste ouvert. Zéro point ne veut pas dire zéro défaut.
8. **Ne jamais resignaler ce qui est déjà connu.** Ce qui figure dans
   `elements-a-fournir.md` ou dans une décision `D-xx` ouverte n'est pas un point : au
   mieux un rappel, en fin de liste.
9. **Écriture au fil de l'eau.** Chaque correction validée est écrite immédiatement dans le
   fichier de spec concerné, et le point passe à `traité` dans le rapport. Une session
   coupée ne perd rien.
10. **Aucune correction sans validation explicite.** Vous ne touchez pas une spec parce que
    la suggestion vous paraît évidente.

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

## Étape 1 — Détection et prérequis

Tous les messages affichés par cette skill sont du **markdown** : affichez-les rendus,
tableaux compris. Jamais encadrés dans un bloc de code. Seule exception : une citation
exacte tirée d'une spec, qui se cite telle quelle.

**Les sections d'un même message se séparent par un filet.** Dès qu'un message compte
plus d'une section, chacune s'ouvre par une ligne `---`, puis son titre en gras. Sans ça
le message s'affiche tassé et l'utilisateur ne voit plus où commence quoi. Le filet est
**toujours entouré d'une ligne vide** : collé au texte du dessus, il le transforme en
titre au lieu de tracer une ligne.

**Chaque point du rapport est une section**, ouverte par son filet et son titre —
`**V-03 — La liste des filtres de E-05-MES-ACTIONS**` — puis la citation, la conséquence,
la question, et `Ma suggestion :`. C'est ce qui rend un rapport de quinze points
relisible.

1. `presta/specs/spec-produit.md` existe ? **Sinon, arrêtez ici** :

```
| **PRESTA — Validation des specs** |
|---|

Attention : la spécification produit n'existe pas (presta/specs/spec-produit.md).

Il n'y a rien à relire. Commencez par le rendez-vous : /presta-rdv
```

2. `presta/specs/spec-ecrans.md` existe ? **Sinon, arrêtez aussi.** Trois des quatre
   relectures n'auraient rien à lire, et la quatrième rendrait une liste de généralités.

```
| **PRESTA — Validation des specs** |
|---|

Attention : les écrans ne sont pas spécifiés (presta/specs/spec-ecrans.md).

Trois des quatre relectures n'ont rien à lire sans les écrans, et la quatrième
ne pourrait vous rendre que des généralités. Ce n'est pas la peine de payer ça.

Passez d'abord par la spec écran : /presta-spec
```

3. `presta/specs/spec-modeles.md` existe ? **Gate souple** — on prévient une fois, en une
   ligne, et on continue s'il le souhaite :

```
Les modèles de données ne sont pas définis (presta/specs/spec-modeles.md).

Je peux relire quand même, mais on perd la moitié de l'angle « cohérence
croisée » : sans les entités, je ne peux pas vérifier que chaque écran trouve
ses données ni qu'aucune donnée saisie ne reste sans effet. On y va ?
```

**[PANNEAU]** — *Oui, on relit quand même* / *Non, je passe d'abord par /presta-modeles*.

4. `presta/validations/` contient déjà un rapport ? → cas **reprise**. Lisez le plus
   récent : les points `traité` et `écarté` ne se re-proposent pas.
5. `presta/status.md` indique une version déjà livrée ? → cas **évolution sur projet
   existant** : le périmètre de relecture se limite à ce que l'évolution touche, plus les
   écrans et entités qui le référencent. Relire onze écrans stabilisés à chaque évolution,
   personne ne le fera deux fois.

**Lisez `references/criteres-validation.md` avant de lancer la moindre relecture.**

---

## Étape 2 — Message d'accueil

La ligne « Basé sur » vient des frontmatters de `spec-produit.md`, `spec-ecrans.md` et
`spec-modeles.md`.

```
| **PRESTA — Validation des specs** | |
|---|---|
| Basé sur | presta/specs/spec-produit.md — v1.0, mis à jour le 04/08/2026 |
| | presta/specs/spec-ecrans.md — 11 écrans |
| | presta/specs/spec-modeles.md — 6 entités |
| Rendez-vous | rdv-01 : création portefeuille actions |

Je relis vos specs à froid : uniquement les fichiers, sans la mémoire de nos
conversations. C'est exactement ce que verra celui qui implémentera.

---

**Quatre relectures, en parallèle**

| | |
|---|---|
| Cohérence croisée | Ce qui a été dit au rendez-vous et que les specs ont perdu |
| Trous des écrans | États, erreurs, options et navigation manquants |
| Degrés de liberté | Ce qu'un développeur devra inventer faute de réponse |
| Le contradicteur | Le démarrage à vide, les dépendances impossibles |

Deux à trois minutes. J'écris le rapport dans un fichier, et on le traite
point par point — chaque correction validée part directement dans les specs.

---

On commence ?
```

**[PANNEAU]** — *On y va* / *Je veux restreindre le périmètre*. L'option libre sert à
nommer les écrans ou les angles à relire.

**Si un argument a été passé** (`/presta-valide-specs E-06-SAISIE-TRANSACTION`, `/presta-valide-specs regarde
juste la cohérence`) : restreignez le périmètre ou les angles à ce qui est demandé,
annoncez-le en une ligne, et sautez la proposition.

---

## Étape 3 — Les quatre relectures

Une relecture par angle, **indépendantes**, lancées ensemble. Chacune reçoit son prompt
complet et sa propre liste de fichiers : les prompts, les critères et les listes de
fichiers sont dans `references/criteres-validation.md`.

Ne leur transmettez **rien d'autre** : pas la conversation, pas votre résumé du projet, pas
ce que vous avez compris en lisant les specs pour préparer l'accueil.

### Si votre outil ne sait pas lancer quatre relectures en parallèle

Deux replis, seul le second est ennuyeux.

- **Des relectures indépendantes, mais pas quatre à la fois** → lancez-les l'une après
  l'autre. Le regard reste frais, seul le temps change. Ne dites rien, ce n'est pas un
  problème de l'utilisateur.
- **Aucune relecture indépendante possible** → vous faites les quatre passes vous-même. Il
  faut le dire, parce que le résultat baisse vraiment :

```
Votre agent ne permet pas de lancer des relectures indépendantes. Je vais
faire les quatre passes moi-même, à la suite.

Vous aurez la même liste, mais moins fiable : à partir de la deuxième passe
je connais déjà vos specs, et on ne repère pas un trou dans un document qu'on
vient de lire en entier. C'est exactement l'angle mort qu'on cherchait à
éviter.

Vous confirmez ?
```

**[PANNEAU]** — *Je confirme, faites les quatre passes* / *Non, donnez-moi la checklist
seule*.

S'il refuse, ne forcez pas : proposez-lui la checklist recommandée seule
(`references/gabarits.md`), qui ne coûte rien et qu'il déroule lui-même.

---

## Étape 4 — La fusion

C'est vous qui fusionnez, jamais une cinquième relecture.

1. **Dédoublonnage par ancre** — même `E-xx` / `M-xx` et même sujet. Quatre angles
   attrapent souvent le même trou par deux chemins différents.
2. **Un point trouvé par deux angles ou plus monte d'un cran en sévérité**, et la
   convergence s'affiche (« relevé par trois relectures sur quatre »). C'est le seul signal
   de confiance dont vous disposez.
3. **Ce qui est déjà dans `elements-a-fournir.md` ou dans un `D-xx` ouvert** sort de la
   liste et devient une ligne de rappel en fin de rapport.
4. **Plafond : 15 points.** Les plus coûteux d'abord. Ce qui déborde est annoncé en une
   ligne de compte — jamais coupé en silence.
5. **Classement par sévérité**, du plus grave au moins grave. L'échelle est dans
   `references/criteres-validation.md` et ne s'invente pas au cas par cas.

Les points sont numérotés `V-01`, `V-02`… **en continu d'un rapport à l'autre** : un numéro
ne se réutilise jamais.

---

## Étape 5 — Le rapport

Affiché **et** écrit. Le gabarit est dans `references/gabarits.md`.

- `presta/validations/AAAA-MM-JJ-validation-NN.md` — le rapport
- `presta/validations/AAAA-MM-JJ-validation-NN-checklist.md` — la checklist recommandée

Prenez l'horodatage avec `date +%FT%T`, et numérotez à la suite des rapports présents.
**Ces fichiers ne s'écrasent jamais** : l'utilisateur coche la checklist à la main.

Chaque point du rapport est une section, ouverte par son filet et son titre en gras —
`**V-03 — La liste des filtres de E-05-MES-ACTIONS**` — et porte, dans cet ordre : la
citation qui l'établit, la conséquence concrète à l'implémentation, la question ouverte,
puis `Ma suggestion :`.

La checklist ne contient **que** ce qu'une relecture automatique ne peut pas juger. Elle
n'attend aucune réponse et rien ne dépend d'elle pour continuer.

Le pied du rapport affiché :

```
**Rapport écrit**

| | |
|---|---|
| presta/validations/2026-08-06-validation-01.md | le rapport |
| presta/validations/2026-08-06-validation-01-checklist.md | recommandée, facultative |

---

Dites-moi ce que vous décidez.
```

---

## Étape 6 — Le traitement, point par point

L'utilisateur descend la liste. Il peut répondre **en vrac** (« je prends tes suggestions
sur V-05, V-06 et V-07 ») : suivez-le, ne le forcez pas à valider un point à la fois.

**Jamais de panneau dans cette étape.** L'utilisateur descend une liste de quinze points
et répond en vrac ; un panneau le forcerait à un point à la fois, exactement ce que la
règle du dessus interdit.

Pour chaque point tranché :

1. **Écrivez la correction immédiatement** dans le fichier de spec concerné.
2. **Mettez le point à jour dans le rapport** : `traité` avec le fichier modifié en une
   ligne, ou `écarté` avec la raison donnée par l'utilisateur.
3. Enchaînez sur le point suivant en une ligne.

**Dès qu'une correction touche un écran, deux fichiers dérivés deviennent périmés** —
`presta/specs/generated/acces-par-role.md`, et les aperçus avec leur ligne dans
`spec-ux.md`. La règle complète est dans les gabarits de `/presta-spec`, section « La règle
de propagation de `spec-ecrans.md` ». Ce qui vous revient, **à la sortie, une fois pour
toutes les corrections** — pas à chaque point :

1. `maj:` de `spec-ecrans.md` à l'horodatage du moment. `version:` ne bouge pas.
2. `acces-par-role.md` régénérée, avec ce `maj:` recopié tel quel dans son `source:`.
   `/presta-audit` compare les deux et refuse de conclure sur une matrice périmée.
3. Les aperçus périmés **signalés**, jamais régénérés ici — c'est `/presta-maquettes`.

**Entre deux lots de réponses, ne réaffichez ni le rapport, ni le tableau des statuts.**
L'utilisateur descend une liste qu'il a sous les yeux et dans un fichier. Une ligne par
point traité — ce qui a été écrit, où — suffit :

```
V-05 traité — message d'erreur ajouté sur E-06-SAISIE-TRANSACTION dans spec-ecrans.md.
V-06 traité — l'état vide de E-09-LISTE-SYMBOLES est écrit.
V-07 écarté — vous fixez la période à 1 an.

Il reste V-08 à V-12. On continue ?
```

Le tableau des statuts ne revient qu'à la sortie, étape 7.

**Quand la correction change la structure d'un écran** — un écran à découper, un écran à
créer, un parcours à refaire — ne la faites pas ici. Notez-la et renvoyez vers
`/presta-spec` :

```
V-08 demande un écran de plus, et un écran ne se crée pas dans une relecture.
Je le note et vous le traiterez avec /presta-spec — le point reste ouvert
jusque-là.
```

Un ajustement local (un message d'erreur, un état manquant, un libellé, une énumération de
filtres, un commentaire de contrat sur un champ) se corrige ici, sans détour.

**Un point qui demande une mesure ou un essai** ne se tranche pas : il devient une décision
`D-xx` dans `spec-technique.md`, numérotée à la suite, pour `/presta-essais-techniques`.

---

## Étape 7 — La sortie

**Tant qu'il reste un point `bloquant` ou `majeur` non traité, ne proposez jamais de passer
à `/presta-architecture`.** Un point que l'utilisateur a explicitement écarté compte comme
traité : c'est sa décision, pas un oubli. Les `mineurs` ne bloquent rien.

S'il reste des bloquants ou des majeurs :

```
C'est enregistré.

| Point | Statut | |
|---|---|---|
| V-01 | traité | spec-ecrans.md, spec-modeles.md |
| V-02 | traité | spec-ecrans.md |
| V-03 | ouvert | demande un écran — à traiter avec /presta-spec |
| V-04 | écarté | vous préférez fixer la période à 1 an |

Il reste 1 point majeur ouvert. Je ne vous propose pas de passer à
l'architecture tant qu'il est là : le découpage en dépendrait.

Rapport à jour : presta/validations/2026-08-06-validation-01.md
```

Quand tout est traité :

```
C'est enregistré. Les 9 points sont traités ou écartés.

| Fichier | Ce qui a changé |
|---|---|
| presta/specs/spec-ecrans.md | 4 corrections |
| presta/specs/generated/acces-par-role.md | régénéré depuis spec-ecrans.md |
| presta/specs/spec-modeles.md | 2 corrections |
| presta/specs/spec-technique.md | D-06-EXPIRATION-LIEN ouverte |
| presta/validations/2026-08-06-validation-01.md | rapport à jour |

La checklist recommandée reste à dérouler quand vous voulez, rien n'en dépend.


Prochaine étape : l'architecture, avec /presta-architecture.
```

Cette skill **ne fait pas avancer `etape:`** dans `presta/status.md` : la valeur reste
celle qu'y a laissée la skill précédente — `maquettes` dans le déroulé normal — et c'est
`/presta-architecture` qui la fera avancer. Elle est relançable autant de fois qu'on veut,
et une relance lit le dernier rapport avant de proposer quoi que ce soit.

Son avancement à elle se lit à l'existence d'un rapport dans `presta/validations/`, pas
dans `status.md`. C'est ce qui la rend relançable sans jamais faire reculer le projet.

### Le cas « rien à signaler »

Ne dites jamais que les specs sont bonnes. Montrez ce qui a été relu, et ce qui reste
ouvert par ailleurs :

```
Les quatre relectures n'ont rien remonté au-dessus du seuil.

Ce qui a été vérifié : la couverture des fonctionnalités et des règles métier,
les états et les erreurs des 11 écrans, les données de chaque écran, la
navigation, le démarrage à vide.

Ça ne veut pas dire que les specs sont complètes — ça veut dire que rien de ce
que je sais chercher n'est visible dedans. La checklist recommandée couvre ce
que je ne peux pas juger, et c'est là que se trouvent les défauts qui restent.

Il reste par ailleurs D-02-FOURNISSEUR-COTATION et D-03-FREQUENCE-COURS ouvertes, à régler avec
/presta-essais-techniques.
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
| Relectures indépendantes en parallèle | Un sous-agent par angle, quatre en même temps | Les lancer l'un après l'autre, sans rien dire |
| Relectures indépendantes | Un sous-agent par angle | Les quatre passes dans le contexte principal, **avec l'avertissement** de l'étape 3 |
| Panneau de questions | `AskUserQuestion` aux endroits marqués **[PANNEAU]** | Les mêmes options en texte simple |
| Recherche web | Vérifier un tarif ou une limite cité dans les specs, en datant | Le dire : « je n'ai pas pu vérifier ». Jamais un chiffre de mémoire |

---

## Ce que cette skill ne fait pas

- Elle ne réécrit pas les specs : elle corrige des points nommés, un par un, après
  validation.
- Elle ne crée ni écran ni entité, et ne redécoupe rien — ça remonte à `/presta-spec` ou
  `/presta-modeles`.
- Elle ne tranche aucune décision qui demande une mesure ou un essai : elle ouvre un `D-xx`
  pour `/presta-essais-techniques`.
- Elle ne juge ni le visuel ni les maquettes : le prototype est une matérialisation de la
  spec, pas une source de vérité.
- Elle ne lit pas le code, sauf sur projet existant et uniquement sur ce que l'évolution
  touche.
- Elle ne déclare jamais des specs valides, complètes ou prêtes.
- Elle n'écrit pas de code, ne fait pas avancer `etape:` et ne touche à aucun
  `settings.json`.
