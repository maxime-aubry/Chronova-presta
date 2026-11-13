---
name: presta-audit
description: Relecture du code contre les specs sous six angles — produit un rapport d'audit daté. Invocation explicite uniquement, ne pas déclencher de soi-même.
---

# Audit

Vous relisez le code **produit par la méthode**, contre **les specs du projet**. Pas un
audit générique : on ne contrôle pas ce code contre des bonnes pratiques du marché, on le
contrôle contre ce qui a été décidé et écrit ici.

Six audits indépendants, lancés ensemble, puis un rapport classé par sévérité que
l'utilisateur relit avant qu'une ligne de code ne bouge.

**Vous ne décidez rien.** Vous signalez, vous suggérez, il tranche.

---

## Règles de conduite — valables à chaque instant

1. **Vouvoiement**, partout.
2. **Le contexte principal ne lit pas le code.** Vous lisez `presta/status.md`,
   `description-livrable.md`, `elements-a-fournir.md`, les décisions `D-xx` et le dernier
   rapport d'audit. **Rien d'autre.** Ce sont les six audits qui lisent, chacun dans son
   contexte. Un contexte principal qui a tout lu ne tient pas la phase de correction.
3. **Un point n'existe que s'il est ancré** — chemin de fichier et numéros de ligne. Sans
   ancre, pas de point. Et l'ancre vient d'un fichier **lu**, pas d'un `grep` : c'est le
   garde-fou anti-faux-positif de cette skill.
4. **Des constats lisibles, pas un rapport.** Interdits : les statistiques, les
   pourcentages de conformité, la reformulation des specs, les compliments, la synthèse
   finale qui refait le corps. Le lecteur veut savoir quoi corriger.
5. **La sévérité se justifie par une conséquence, jamais par un adjectif.** « Un membre
   obtient la page en appelant l'URL » se conteste ; « c'est grave » ne se conteste pas.
6. **Ne jamais resignaler ce qui est déjà connu.** Un écart accepté dans
   `description-livrable.md`, une hypothèse forcée, une décision `D-xx` ouverte, un point
   `écarté` d'un audit précédent : ça ne revient pas. Au mieux un rappel, hors du compte.
7. **Aucune correction sans validation explicite.** Vous ne touchez pas au code parce que
   la suggestion vous paraît évidente.
8. **Une correction ne modifie jamais une spec, un critère ou un test pour se débloquer.**
   Si le point est faux, ça remonte à la skill qui l'a produit.
9. **Écriture au fil de l'eau.** Chaque point tranché est mis à jour dans le rapport au
   moment où la correction est écrite. Une session coupée ne perd rien.
10. **Ne jamais déclarer que le code est conforme, propre ou sécurisé.** Vous montrez ce
    qui a été relu et ce qui reste ouvert. Zéro point ne veut pas dire zéro défaut.
11. **Ce n'est pas un test d'intrusion.** Vous lisez du code contre des specs, vous
    n'attaquez rien et vous ne scannez rien.
12. **Aucun secret n'entre dans `presta/`.** Un extrait de code cité dans le rapport est
    nettoyé avant écriture, et l'altération est écrite à côté.

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

   Je regarde ce qu'il y a à auditer…

2. la commande de détection de l'étape 1.

Le texte s'affiche pendant que la commande tourne. Sans ça, l'utilisateur lance la skill
et reste devant un écran vide : ne les séparez jamais en deux tours.

---

## Étape 1 — Détection et prérequis

Tous les messages affichés par cette skill sont du **markdown** : affichez-les rendus,
tableaux compris. Jamais encadrés dans un bloc de code. Seules exceptions : une commande à
lancer, une sortie de terminal et un extrait de code cité, qui restent dans un bloc.

**Les sections d'un même message se séparent par un filet.** Dès qu'un message compte
plus d'une section, chacune s'ouvre par une ligne `---`, puis son titre en gras. Sans ça
le message s'affiche tassé et l'utilisateur ne voit plus où commence quoi. Le filet est
**toujours entouré d'une ligne vide** : collé au texte du dessus, il le transforme en
titre au lieu de tracer une ligne.

```bash
[ -f presta/status.md ] && sed -n '1,12p' presta/status.md
ls -d presta/livrables/*/ 2>/dev/null | tail -1
ls presta/livrables/*/audits/*.md 2>/dev/null | tail -3
for f in presta/specs/spec-architecture.md presta/specs/spec-ecrans.md \
         presta/specs/spec-modeles.md presta/specs/generated/acces-par-role.md \
         presta/specs/spec-ux.md presta/regles-projet.md AGENTS.md; do
  [ -f "$f" ] && echo "OK $f" || echo "-- $f"
done
ls presta/specs/spec-architecture-complement-*.md 2>/dev/null
find . -maxdepth 1 \( -name 'package.json' -o -name 'manage.py' -o -name 'go.mod' \
  -o -name 'pom.xml' -o -name 'Cargo.toml' -o -name 'composer.json' -o -name 'Gemfile' \
  -o -name 'pyproject.toml' -o -name '*.csproj' -o -name '*.sln' \) 2>/dev/null
head -6 presta/specs/generated/acces-par-role.md 2>/dev/null
grep -m1 '^base_specs:' presta/specs/spec-ux.md 2>/dev/null
grep -m1 -E '^(version|maj):' presta/specs/spec-ecrans.md 2>/dev/null
```

Un seul appel. Si la commande échoue (shell Windows), repliez-vous sur `ls` — mais
n'enchaînez pas plus d'un appel de plus.

Ensuite, et seulement ça :

1. **`presta/status.md`** — `livrable_courant`, `version`, `etape`.
2. **`presta/livrables/{livrable_courant}/description-livrable.md`** — le périmètre, les
   **écarts acceptés**, les **hypothèses forcées**, les limites. C'est le « déjà connu ».
3. **`presta/elements-a-fournir.md`** — ce qui est encore à fournir.
4. **La section « Décisions techniques » de `presta/specs/spec-technique.md`** — les `D-xx`
   `en attente`, et la section « Hébergement et publication » pour la **destination du
   projet**. Pas le reste du fichier.
5. **Le dernier rapport de `presta/livrables/*/audits/`**, s'il existe — les points
   `écarté` et `traité`, et le dernier numéro `AU-xx` attribué.

**Ne lisez ni le code, ni `spec-architecture.md`, ni `spec-ecrans.md`, ni
`spec-modeles.md`.** Les six audits les lisent, chacun pour son angle. C'est la règle 2, et
c'est ce qui rend la skill tenable.

### Les deux arrêts

| Situation | Ce que vous faites |
|---|---|
| Pas de `presta/status.md` | **Arrêt.** « Il n'y a pas de projet Presta ici. Commencez par le rendez-vous : /presta-rdv » |
| Aucun marqueur de projet trouvé par le `find` | **Arrêt.** Message ci-dessous |

```
| **PRESTA — Audit** |
|---|

Il n'y a pas de code à auditer ici : le projet n'est pas initialisé.

L'audit relit du code contre vos specs. Sans code, les six audits n'auraient
rien à ouvrir.

Passez par /presta-setup, puis par /presta-implemente.
```

### Les trois cas dégradés — aucun ne bloque

Ils se disent **à l'accueil**, jamais après coup.

| Absent ou périmé | Ce que vous affichez, et ce que ça change |
|---|---|
| `spec-architecture.md` | « L'audit 1 ne tournera pas : il n'y a rien à contrôler le code contre. » Cinq audits partent au lieu de six |
| `acces-par-role.md` absente | « L'audit 3 s'appuiera sur les annotations de rôle de `spec-ecrans.md`, moins fiables qu'une matrice. » |
| `acces-par-role.md` périmée | Voir ci-dessous |
| `spec-ux.md` périmée — son `base_specs:` ne correspond plus au `maj:` de `spec-ecrans.md` | « Les aperçus ne reflètent plus les écrans : l'audit 2 ne comparera pas le rendu à sa maquette. Pour les régénérer : /presta-maquettes. » Les six audits partent quand même |
| Aucun test dans le projet | Rien à l'accueil. Ça se dit **avant la première correction**, étape 6 |

**Un fichier dérivé est périmé quand son champ de provenance ne correspond plus au `maj:`
de `spec-ecrans.md`** — `source:` pour la matrice, `base_specs:` pour `spec-ux.md`. C'est
le cas le plus fréquent après une correction de spec faite ailleurs. On ne conclut pas sur
un fichier faux :

```
| **PRESTA — Audit** | |
|---|---|
| presta/specs/generated/acces-par-role.md | périmée — générée sur spec-ecrans.md du 2026-08-06T09:12:44, le fichier est au 2026-08-20T14:32:07 |

La matrice des accès ne reflète plus les écrans. L'audit de sécurité tournera
quand même, à partir des annotations de rôle de spec-ecrans.md, mais il ne
pourra pas vous dire qu'un accès manque : il ne sait plus qui a droit à quoi.

Pour la régénérer : /presta-spec. Ça prend quelques minutes et l'audit 3 vaudra
le double.

On lance maintenant, ou vous régénérez d'abord ?
```

**[PANNEAU]** — *Je régénère d'abord avec /presta-spec* / *On lance maintenant*.

**Si un argument a été passé** : `/presta-audit securite` ou `/presta-audit 3` ne lance
que cet audit-là ; `/presta-audit AU-03-VALORISATION-DUPLIQUEE` reprend le traitement de ce
point dans le dernier rapport ; tout autre texte se traite comme une restriction de
périmètre, annoncée en une ligne.

---

## Étape 2 — Message d'accueil

### Cas « premier audit du livrable »

```
| **PRESTA — Audit** | |
|---|---|
| Livrable | v1.0-portefeuille-actions — 10 phases, livré le 08/08/2026 |
| Basé sur | presta/specs/spec-architecture.md — 15 règles A-xx |
| | presta/specs/spec-architecture-complement-django.md — Django 6.1 |
| | presta/specs/spec-ecrans.md — 11 écrans |
| | presta/specs/generated/acces-par-role.md — à jour |

---

**Six audits en parallèle :**

| | | |
|---|---|---|
| **1** | Architecture | Les couches respectées, les fichiers à leur place, une seule façon de faire |
| **2** | Implémentation | Chaque écran existe, chaque action déclarée est branchée, aucun lien mort |
| **3** | Sécurité | L'autorisation côté serveur écran par écran, plus les fuites connues |
| **4** | Code dupliqué | Deux implémentations de la même chose, écrites à trois jours d'écart |
| **5** | Data et points manquants | Les contrats des champs tenus, les `// HYPOTHÈSE` et `// TODO` restants |
| **6** | Performances | Requête en boucle, chargement complet d'une table, appels en cascade |

Ces audits vérifient la conformité de l'implémentation par rapport aux
spécifications.

---

Six sous-agents lisent votre code : c'est l'étape la plus coûteuse en jetons de
la méthode. Lancez-la sur une session dont vous n'avez pas besoin par ailleurs,
ou baissez l'effort de votre agent avant de démarrer.

---

Vous souhaitez lancer les audits ?
```

**[PANNEAU]** — *Oui, lancez les audits* / *Je veux restreindre le périmètre*. L'option
libre sert à nommer les audits ou les écrans à relire.

Trois règles sur ce message :

- **Les six audits gardent leur numéro et leur nom, toujours.** C'est ce qui permet à
  l'utilisateur de dire « relance juste le 3 » trois jours plus tard.
- **Un audit qui ne tournera pas se dit ici**, sur sa ligne, avec la raison — jamais
  supprimé du tableau en silence.
- **L'avertissement de coût ne se négocie pas et ne s'enjolive pas.** Deux lignes, un
  fait, une conduite à tenir.

### Cas « un rapport d'audit existe déjà »

```
| **PRESTA — Audit** | |
|---|---|
| Livrable | v1.0-portefeuille-actions |
| Dernier audit | presta/livrables/v1.0-portefeuille-actions/audits/2026-08-08-audit-01.md |
| | 9 points — 6 traités, 2 écartés, 1 ouvert |

AU-06-EXPORT-NON-BRANCHE est resté ouvert : il demandait un écran, et un écran ne
se crée pas dans un audit.

---

| | |
|---|---|
| **1** | Reprendre le point ouvert du rapport 01 |
| **2** | Relancer les six audits — ce qui a été écarté ne reviendra pas |

---

C'est à vous :
```

**[PANNEAU]** — *Relancer les six audits* / *Reprendre le point ouvert*. L'option libre
sert à nommer un audit précis.

Une relance **crée un nouveau rapport**, elle n'écrase jamais le précédent. Les points
gardent leur numérotation en continu : `AU-10-…` suit `AU-09-…`, même d'un rapport à
l'autre.

---

## Étape 3 — Les six audits

Ils partent **ensemble, dans un seul message**, derrière le texte de lancement :

```
Lancement des six audits... (durée estimée : 2-3 minutes)
```

Rien d'autre dans ce message. Pas de rappel de ce qui tourne, pas de sujet à occuper :
l'agent affiche déjà ses sous-agents, et six lignes de plus n'apportent rien.

### Ce que reçoit chaque audit

**Deux chemins, jamais du contenu recopié.** Vous ne lisez aucun des sept fichiers de
`references/audits/` : le sous-agent lit le sien. C'est ce qui garde le contexte principal
disponible pour la phase de correction.

`{skill}` est le chemin absolu du dossier de cette skill — celui d'où vous avez chargé ce
`SKILL.md`. Substituez-le, un chemin relatif ne veut rien dire pour un sous-agent.

```
Vous êtes l'audit {N} — {NOM} d'un projet Presta, dans le dossier courant.

LISEZ D'ABORD, DANS CET ORDRE

1. {skill}/references/audits/00-socle.md — les règles communes, l'échelle de
   sévérité et le format de sortie.
2. {skill}/references/audits/{NN}-{slug}.md — votre angle, vos fichiers, vos
   critères, vos faux positifs.

Puis exécutez ce que ces deux fichiers décrivent, et rien d'autre.

LIVRABLE : {livrable_courant}
STACK : {stack}
DESTINATION DU PROJET : {personnel | interne | publiable | non dit}

DÉJÀ CONNU — ne le signalez pas
{les écarts acceptés et les hypothèses forcées de description-livrable.md, les
D-xx en attente, les lignes de elements-a-fournir.md, et les points écartés des
rapports d'audit précédents — une ligne chacun}
```

Les six fichiers d'angle :

| | Audit | Fichier |
|---|---|---|
| 1 | Architecture | `references/audits/01-architecture.md` |
| 2 | Implémentation | `references/audits/02-implementation.md` |
| 3 | Sécurité | `references/audits/03-securite.md` |
| 4 | Code dupliqué | `references/audits/04-code-duplique.md` |
| 5 | Data et points manquants | `references/audits/05-data-points-manquants.md` |
| 6 | Performances | `references/audits/06-performances.md` |

**Sur un modèle capable, pas un modèle rapide.** Ce n'est pas de la collecte de faits :
chaque audit juge un écart contre une spec.

**Le bloc « déjà connu » est ce qui coûte le moins cher et rapporte le plus.** Sans lui,
six audits remontent les écarts que vous avez déjà acceptés, et la fusion passe son temps à
les jeter.

**Ne transmettez ni la conversation, ni votre résumé du projet, ni ce que les autres
audits ont trouvé.** Chacun est aveugle aux cinq autres : c'est ce qui donne du sens à la
convergence, à l'étape suivante.

---

## Étape 4 — La fusion

C'est vous qui fusionnez, jamais un septième sous-agent.

1. **Dédoublonnage par ancre** — même fichier, mêmes lignes, même sujet. Six angles
   attrapent souvent le même défaut par deux chemins : une valorisation dupliquée remonte
   en Architecture (`A-11-DRY-SEUIL-3`) et en Code dupliqué.
2. **Un point trouvé par deux audits ou plus monte d'un cran en sévérité**, et la
   convergence s'écrit dans sa fiche (« relevé par deux audits »). C'est le seul signal de
   confiance dont vous disposez.
3. **Ce qui est déjà connu sort de la liste** et devient une ligne de rappel en fin de
   rapport, hors du compte.
4. **Les points d'un rapport précédent** : ce qui est `écarté` disparaît — c'est une
   décision, elle tient. Ce qui est `traité` et réapparaît **se garde**, avec la mention
   « déjà corrigé dans audit-NN, revenu ». C'est une régression, elle vaut d'être vue.
5. **Plafond : 20 points.** Les plus graves d'abord. Ce qui déborde est annoncé en une
   ligne de compte, dans le rapport — **jamais coupé en silence**.
6. **Classement par sévérité**, du plus grave au moins grave. L'échelle est dans
   `references/audits/00-socle.md` et ne s'invente pas au cas par cas.

Les points sont numérotés `AU-01-{SLUG}`, `AU-02-{SLUG}`… **en continu d'un rapport à
l'autre** : un numéro ne se réutilise jamais. Le slug vient du titre rendu par l'audit.

**Un point sans ancre `fichier:ligne` ne passe pas la fusion.** Vous ne le repêchez pas, et
vous ne relancez pas l'audit pour l'obtenir : il tombe.

---

## Étape 5 — Le rapport

Affiché **et** écrit. Le gabarit est dans `references/gabarits.md`.

`presta/livrables/{livrable}/audits/AAAA-MM-JJ-audit-NN.md`

Prenez l'horodatage avec `date +%FT%T`, et numérotez à la suite des rapports présents dans
le dossier. **Ce fichier ne s'écrase jamais.** Si le dossier `audits/` n'existe pas,
créez-le, en silence.

Le rapport s'ouvre à l'utilisateur (`open` sur macOS, `start ""` sur Windows, `xdg-open`
sur Linux), et son chemin s'affiche de toute façon.

```
| **PRESTA — Audit** | |
|---|---|
| Rapport | presta/livrables/v1.0-portefeuille-actions/audits/2026-08-08-audit-01.md |
| Relu | 11 écrans, 6 entités, 15 règles d'architecture |

9 points. Je l'ai ouvert — le détail, les fichiers et les lignes y sont.

---

🔴 **Bloquant**

| | |
|---|---|
| AU-01-ADMIN-SANS-CONTROLE | E-11-LISTE-UTILISATEURS n'est protégé que par le masquage du lien dans le menu. Un membre qui appelle /admin/utilisateurs obtient la page. |
| AU-02-SEED-EN-PRODUCTION | Le script de seed crée des comptes à mots de passe connus et ne vérifie pas l'environnement avant de tourner. |

---

🟠 **Majeur**

| | |
|---|---|
| AU-03-VALORISATION-DUPLIQUEE | Deux calculs de la valeur d'un portefeuille, l'un ignore les frais. E-04-TABLEAU-DE-BORD et E-05-MES-ACTIONS n'affichent pas le même montant. |
| AU-04-VUE-QUI-REQUETE | market/views.py interroge la base directement, sans passer par un service — A-02-CONTROLEUR-SANS-CALCUL. |
| AU-05-COTATIONS-EN-BOUCLE | Une requête de cotation par ligne sur E-05-MES-ACTIONS : 24 requêtes pour 24 titres détenus. |
| AU-06-EXPORT-NON-BRANCHE | Le bouton « Exporter » de E-05-MES-ACTIONS ne mène à aucune route. Il est dans la spec, pas dans les urls. |

---

🔵 **Mineur**

| | |
|---|---|
| AU-07-TODO-PHASE-6 | Trois `// TODO phase 6` dans market/services.py, alors que P-06-COTATIONS est validée. |
| AU-08-DATE-SERVEUR-EN-TRI | Les transactions sont triées sur CreatedAt. Le contrat de M-06-TRANSACTION l'interdit : c'est ExecutedAt qui fait foi. |
| AU-09-ETAT-VIDE-MANQUANT | E-09-LISTE-SYMBOLES affiche un tableau vide sans message. La spec en décrit un. |

---

⚪ **Déjà connu, pour mémoire** — hors des 9 points

| | |
|---|---|
| E-11-LISTE-UTILISATEURS | La suppression d'un utilisateur n'est pas livrée. Écart accepté le 07/08/2026. |
| D-04-ENVOI-EMAILS | Les e-mails de réinitialisation s'affichent en console. Hypothèse forcée. |

---

Dites-moi les points que vous souhaitez corriger. Je peux aussi corriger les
deux bloquants directement, et vous gardez la main sur le reste.
```

**[PANNEAU]** — *Corrigez les 2 bloquants* / *Je vous dis quels points corriger* / *Rien
pour l'instant, je relis*. L'option libre sert à donner sa liste tout de suite.

Quatre règles sur cet affichage :

- **Une ligne par point, jamais sa fiche.** L'ancre `fichier:ligne`, l'extrait et la
  suggestion vivent dans le rapport, qui vient d'être ouvert. Recopier les fiches dans la
  conversation, c'est payer deux fois et rendre le tout illisible.
- **La ligne dit la conséquence, pas le nom du défaut.** « Un membre obtient la page en
  appelant l'URL », pas « contrôle d'accès manquant ».
- **Les bulles portent la sévérité** : 🔴 bloquant, 🟠 majeur, 🔵 mineur, ⚪ déjà connu.
- **« Corriger les bloquants » est une option, jamais un défaut.** C'est le seul endroit
  où du code bougerait sans que l'utilisateur ait lu la fiche : ça se propose, ça ne se
  déclenche pas tout seul.

### Le cas « rien à signaler »

Ne dites jamais que le code est bon. Montrez ce qui a été relu :

```
Les six audits n'ont rien remonté au-dessus du seuil.

Ce qui a été relu : les 15 règles d'architecture contre le code, les 11 écrans
et leurs actions, les accès de chaque rôle, la duplication sur l'ensemble du
dépôt, les contrats des 6 entités, et les requêtes des écrans de liste.

Ça ne veut pas dire que le code est sans défaut — ça veut dire que rien de ce
que je sais chercher n'est visible dedans.

Le rapport est écrit quand même : presta/livrables/v1.0-portefeuille-actions/audits/2026-08-08-audit-01.md
```

Le rapport s'écrit dans tous les cas, et la section sécurité de `mise-en-production.md`
aussi — elle ne dépend pas des points trouvés (étape 7).

---

## Étape 6 — Le traitement et les corrections

L'utilisateur descend la liste. Il peut répondre **en vrac** (« corrige AU-02, AU-03 et
AU-05, j'écarte AU-04 ») : suivez-le, ne le forcez pas à trancher un point à la fois.

**Jamais de panneau dans cette étape.** L'utilisateur descend une liste qu'il a sous les
yeux et dans un fichier ; un panneau le ramènerait à un point à la fois.

### Avant la première correction, s'il n'y a pas de tests

```
Il n'y a pas de suite de tests dans ce projet. Je peux corriger, mais je ne
pourrai pas vérifier qu'une correction n'en casse pas une autre.

Ce que je fais dans ce cas : chaque correction part dans un cahier de recettes
que vous déroulez vous-même à la fin.

On continue ?
```

**[PANNEAU]** — *On continue* / *Non, on s'arrête là*.

### Ce qui se corrige ici, et ce qui remonte ailleurs

| Le point demande | Où ça part |
|---|---|
| Changer un écran, une entité, une action | `/presta-spec`, `/presta-modeles` |
| Changer une règle d'architecture | `/presta-architecture` |
| Une décision produit, un arbitrage de périmètre | `/presta-rdv` |
| Une mesure ou un essai | Une décision `D-xx` dans `spec-technique.md`, pour `/presta-essais-techniques` |
| **Une refonte qui touche plusieurs écrans ou plusieurs couches** | **`/presta-phases`** |

Le dernier est le garde-fou qui compte. Une correction lourde faite hors d'une phase n'a
ni critères de validation ni cahier de recettes : personne ne vérifie qu'elle est bonne.

```
AU-04-VUE-QUI-REQUETE touche les quatre vues de market/ et demande de créer la
couche de services qui n'existe pas. Ce n'est pas une correction, c'est une
phase.

Je le note ouvert dans le rapport, et vous le traiterez avec /presta-phases.
On continue sur les autres ?
```

Le seuil se pose **au moment du point**, pas après avoir commencé.

### Le sous-agent correcteur

**Un correcteur par point, à contexte frais.** Jamais l'audit qui a trouvé le point, jamais
le contexte principal. Le prompt est dans `references/prompt-correcteur.md`.

**Les points qui ne partagent aucun fichier partent ensemble ; ceux qui touchent les mêmes
fichiers s'enchaînent.** L'ancre `fichier:ligne` de chaque point donne exactement
l'information, c'est mécanique.

Il reçoit : la fiche du point, son ancre, `presta/regles-projet.md`, `spec-architecture.md`
et son complément, et `AGENTS.md`. Il ne reçoit ni la conversation, ni le rapport entier.

**L'interdit qui protège les specs**, écrit mot pour mot dans son prompt : un correcteur
qui conclut que le point est faux, infaisable, ou qu'il contredit une spec, **s'arrête et
le rapporte**. Il n'ajuste jamais une spec, un critère ou un test pour se débloquer.

### Après chaque lot

**Relance de la suite de tests complète**, une commande. C'est le garde-fou
anti-régression : une correction qui casse un point déjà passé se voit tout de suite.

Puis une ligne par point, et rien d'autre — pas de rapport réaffiché, pas de tableau de
statuts :

```
AU-01-ADMIN-SANS-CONTROLE traité — contrôle de rôle ajouté sur la vue et sur la route, accounts/views.py.
AU-02-SEED-EN-PRODUCTION traité — le script refuse de tourner hors DEBUG, market/management/commands/seed.py.
AU-04-VUE-QUI-REQUETE écarté — vous acceptez l'écart, la couche de services viendra en v1.1.

    87 tests, 87 passés

Il reste AU-05 à AU-09. On continue ?
```

Le tableau des statuts ne revient qu'à la sortie, étape 7.

**Plafond : 2 tours de correction par point.** Au troisième échec, ce n'est plus un
problème de code : c'est le point ou la spec qui est faux. Vous vous arrêtez, vous affichez
ce qui a été tenté, et vous rendez la main.

### Le commit

Après le dernier lot validé, et seulement si des corrections ont eu lieu :

```
git add -A
git commit -m "audit-01 — AU-01-ADMIN-SANS-CONTROLE, AU-02-SEED-EN-PRODUCTION, AU-03-VALORISATION-DUPLIQUEE"
git push
```

- **Le message porte le rapport et les points corrigés**, en identifiants complets. C'est
  ce qui rend `git log` lisible et le retour en arrière évident.
- **On ne pousse que si un dépôt distant est déjà branché.** Sinon commit local, et on n'en
  parle pas.
- **Jamais de `git push --force`.** Si l'envoi est refusé, vous vous arrêtez et vous dites
  pourquoi.

---

## Étape 7 — La sortie

### La section sécurité de `mise-en-production.md`

**Elle se régénère à chaque audit, même si rien n'a été trouvé, même si rien n'a été
corrigé.** Ce n'est pas la liste des défauts : c'est la liste des contrôles que l'humain
déroule sur l'environnement réel avant de publier.

Le partage est mécanique, et chaque audit l'a déjà tranché dans le champ
`VÉRIFIABLE PAR` de ses fiches :

| Vérifiable | Où ça va |
|---|---|
| Par un test — un contrôle d'autorisation, un champ qui fuit dans une réponse | **La correction et son test de non-régression.** Pas une ligne de checklist |
| Par l'environnement — `DEBUG` actif, variables absentes, HTTPS, seed présent sur le serveur, trace visible sur une page d'erreur | **`mise-en-production.md`, section sécurité** |

Demander à l'humain de rejouer à la main ce qu'une commande vérifie gratuitement, c'est le
meilleur moyen qu'il ne le fasse plus au bout de deux livraisons.

Le gabarit de la section est dans `references/gabarits.md`. Elle **remplace** la
précédente, en entier — c'est un fichier déduit.

### Le message de sortie

```
| **PRESTA — Audit** |
|---|

C'est enregistré.

| Point | Statut | |
|---|---|---|
| AU-01-ADMIN-SANS-CONTROLE | traité | accounts/views.py, accounts/urls.py |
| AU-02-SEED-EN-PRODUCTION | traité | market/management/commands/seed.py |
| AU-03-VALORISATION-DUPLIQUEE | traité | portfolio/services.py, market/views.py |
| AU-04-VUE-QUI-REQUETE | ouvert | demande une phase — à traiter avec /presta-phases |
| AU-05-COTATIONS-EN-BOUCLE | traité | market/services.py |
| AU-06-EXPORT-NON-BRANCHE | écarté | l'export passe en v1.1 |

    87 tests, 87 passés — commit 4b21e0f

---

| Fichier | Ce qui a changé |
|---|---|
| presta/livrables/v1.0-portefeuille-actions/audits/2026-08-08-audit-01.md | rapport à jour |
| presta/livrables/v1.0-portefeuille-actions/mise-en-production.md | section sécurité, 5 contrôles |
| presta/specs/spec-technique.md | D-07-ROTATION-CLES ouverte |

---

**Un point reste ouvert**

AU-04-VUE-QUI-REQUETE demande une couche de services qui n'existe pas. C'est une
phase, pas une correction.


Prochaine étape : le découpage de cette reprise, avec /presta-phases.
```

**Ce que fait la dernière ligne dépend de ce qui reste.** Un point `ouvert` renvoie vers la
skill qui le porte. Rien d'ouvert : pas de « prochaine étape », l'audit ne mène nulle part
par construction — vous rappelez seulement que la skill est relançable.

Cette skill **ne fait pas avancer `etape:`** dans `presta/status.md`. Elle est relançable
autant de fois qu'on veut, et une relance lit le dernier rapport avant de proposer quoi que
ce soit.

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
| Sous-agents en parallèle | Les six audits ensemble, contextes séparés | Les lancer l'un après l'autre. Ne dites rien, seul le temps change |
| Sous-agents | Un audit par sous-agent | Les six passes dans le contexte principal, **avec l'avertissement** ci-dessous |
| Lecture de `references/` par le sous-agent | Lui donner les deux chemins absolus | Lire les deux fichiers vous-même et les coller dans son prompt. Ça coûte, c'est le dernier recours |
| Suite de tests | Relancée après chaque lot de corrections | Le dire avant de corriger, et empiler les corrections dans un cahier de recettes |
| Ouverture de fichier | Ouvrir le rapport | Afficher son chemin |
| Git | Commit après le dernier lot | Afficher les commandes exactes à jouer |
| Panneau de questions | `AskUserQuestion` aux endroits marqués **[PANNEAU]** | Les mêmes options en texte simple |

**Sans sous-agents, il faut le dire** — le résultat baisse vraiment :

```
Votre agent ne permet pas de lancer des sous-agents. Je vais faire les six
audits moi-même, à la suite.

Vous aurez la même liste, mais moins fiable : à partir du deuxième audit je
connais déjà votre code, et on ne repère pas un défaut dans ce qu'on vient de
lire en entier. C'est exactement l'angle mort que six lectures indépendantes
existent pour éviter.

Vous confirmez ?
```

**[PANNEAU]** — *Je confirme, faites les six audits* / *Non, j'arrête ici*.

---

## Ce que cette skill ne fait pas

- **Ce n'est pas un test d'intrusion.** Elle lit du code contre des specs ; elle n'attaque
  rien, ne scanne rien, ne teste aucune charge. Pour aller plus loin, il existe de
  l'outillage dédié — un plugin `claude-security` et son workflow de scan.
- Elle ne juge pas la qualité de code générique : lisibilité, complexité, nommage, style.
  C'est subjectif, un linter le fait mieux et pour zéro jeton, et ça noierait les six
  audits sous du bruit.
- Elle ne définit ni les écrans, ni les modèles, ni l'architecture, ni les phases. Elle les
  lit et contrôle le code contre eux.
- Elle ne modifie jamais une spec, un critère ou un test pour faire passer une correction.
  Ce qui cloche remonte à la skill qui l'a produit.
- Elle ne refond rien : une correction qui touche plusieurs écrans ou plusieurs couches
  devient une phase, dans `/presta-phases`.
- Elle n'implémente aucune fonctionnalité manquante — elle signale qu'elle manque.
- Elle ne déclare jamais un code conforme, propre ou sécurisé.
- Elle ne fait pas avancer `etape:`, ne crée aucun dépôt distant, ne force aucun envoi.
- Elle n'écrit aucun secret dans `presta/` et ne touche à aucun `settings.json`.
