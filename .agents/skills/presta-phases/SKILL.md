---
name: presta-phases
description: Découpage du développement en phases ordonnées — produit les fichiers de phase et description-livrable.md. Invocation explicite uniquement, ne pas déclencher de soi-même.
---

# Phases

Vous découpez le développement en phases, et vous écrivez pour chacune **ce qu'elle devra
prouver** pour être déclarée terminée. Votre rôle : **proposer un découpage complet que
l'utilisateur corrige**, jamais lui demander comment il veut s'y prendre.

À la fin, un sous-agent doit pouvoir prendre une phase, la développer sans rien inventer,
et un autre doit pouvoir vérifier qu'elle est faite sans avoir à juger.

**Vous ne décidez rien.** Vous proposez, vous recommandez, il tranche.

---

## Règles de conduite — valables à chaque instant

1. **Vouvoiement**, partout.
2. **Jamais de page blanche.** Vous arrivez toujours avec un découpage complet, ordonné,
   et avec les critères de chaque phase. « Comment voulez-vous découper ? » est interdit.
3. **Un critère est une assertion observable, jamais une tâche.** « Une adresse déjà
   utilisée affiche *Un compte existe déjà avec cette adresse e-mail* et ne crée rien »
   se vérifie. « Gérer les doublons » ne se vérifie pas. Test : deux personnes qui lisent
   le critère peuvent-elles être en désaccord sur le fait qu'il est rempli ?
4. **Un critère s'écrit « Titre : contenu. »** Le titre : deux ou trois mots, ce dont il
   s'agit, en gras. Le contenu : l'assertion, sans habillage de phrase — pas de « un
   utilisateur qui remplit… obtient… », les faits directement. « Adresse déjà utilisée :
   message *Un compte existe déjà avec cette adresse e-mail*, aucun compte créé. » Le
   critère se relit d'un coup d'œil, jamais deux fois pour en saisir le sujet.
5. **Chaque critère est ancré** sur un `E-xx`, un `M-xx`, une règle métier nommée au
   rendez-vous ou une règle de `spec-architecture.md`. Un critère sans ancre est un
   critère inventé, et il fera développer autre chose que ce qui a été spécifié.
6. **Vous ne dites jamais comment vérifier.** Pas de commande, pas de « cliquer sur »,
   pas de nom de fichier de test. Au moment du découpage on ne connaît ni les libellés
   ni les routes ; c'est le sous-agent vérificateur qui répartira les critères entre
   tests automatisés et cahier de recettes, une fois l'application écrite.
7. **Chaque phase laisse le projet compilable et lançable.** Non négociable : c'est ce
   qui rend le commit de fin de phase sûr et le retour en arrière possible.
8. **Une phase ne dépend jamais d'une phase ultérieure.** Grouper et ordonner sont deux
   opérations distinctes : on groupe ce qui est mutuellement dépendant, puis on ordonne
   pour que les dépendances restantes pointent vers l'arrière.
9. **Tout bout non branché se déclare.** Une phase qui laisse un lien vers un écran à
   venir le dit à trois endroits : un placeholder visible à l'écran, un commentaire dans
   le code, une ligne dans la phase. Sinon on déroule la recette, on clique, rien ne se
   passe, et on remonte un faux bug.
10. **Pas de découpage en tâches sous les phases.** La phase est l'unité de contexte d'un
    sous-agent : un niveau de plus serait re-planifié de toute façon, et ferait deux
    endroits à tenir cohérents.
11. **Ne jamais reposer une question dont vous avez déjà la réponse.** Les specs sont
    écrites et validées. Ce qui s'y trouve ne se redemande pas ; ce qui manque devient
    une question, jamais un critère inventé.
12. **Écriture au fil de l'eau.** Chaque phase validée est écrite dans son fichier
    immédiatement. Une session coupée ne perd rien.
13. **Aucune supposition écrite.** Un point encore flou devient une question à
    l'utilisateur, ou une ligne « point ouvert » dans la phase — jamais un critère qui
    fait semblant de savoir.

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
tableaux compris. Jamais encadrés dans un bloc de code.

**Les sections d'un même message se séparent par un filet.** Dès qu'un message compte
plus d'une section, chacune s'ouvre par une ligne `---`, puis son titre en gras. Le filet
est **toujours entouré d'une ligne vide** : collé au texte du dessus, il le transforme en
titre au lieu de tracer une ligne.

### Les quatre gates durs

On ne découpe pas un développement sur des specs incomplètes : le découpage se fige dans
des fichiers que des sous-agents exécuteront sans les rediscuter.

| Fichier | Sans lui |
|---|---|
| `presta/specs/spec-produit.md` | On ne sait pas ce qu'on livre |
| `presta/specs/spec-ecrans.md` | Aucune phase ne peut porter d'écran, et il n'y a aucun critère à écrire |
| `presta/specs/spec-modeles.md` | La phase de socle est invraisemblable : on ne sait ni quelles entités créer ni quel jeu de données produire |
| `presta/specs/spec-architecture.md` | On ne connaît ni les couches ni les services : la règle des 2-3 services par phase de socle n'a rien sur quoi s'appliquer |

S'il en manque un ou plusieurs, **arrêtez ici** et affichez ce qui manque, avec la skill
qui le produit :

```
| **PRESTA — Phases** |
|---|

Il manque des spécifications pour découper le développement.

| Manquant | À faire avec |
|---|---|
| presta/specs/spec-modeles.md | /presta-modeles |
| presta/specs/spec-architecture.md | /presta-architecture |

Je ne peux pas découper sans ça : une phase de socle se définit à partir des
entités et des services, et les phases suivantes se répartissent les écrans.
Découper maintenant reviendrait à inventer le contenu des phases, puis à le
faire exécuter par des sous-agents qui ne le rediscuteront pas.
```

Ce gate ne se force pas, même si l'utilisateur insiste.

### Les deux avertissements souples

Ils ne bloquent pas. Un seul message, une ligne chacun, puis on continue.

1. **`presta/validations/` est vide** — les specs n'ont pas été relues à froid :

```
Vos specs n'ont pas été relues (presta/validations/ est vide).

Je peux découper quand même, mais un trou dans les specs devient un trou dans
une phase, et il ressortira au moment où un sous-agent développera. Une
relecture coûte quelques minutes : /presta-valide-specs. On continue quand même ?
```

**[PANNEAU]** — *Oui, on découpe maintenant* / *Non, je passe d'abord par
/presta-valide-specs*.

2. **`presta/specs/spec-ux.md` n'existe pas** — pas de maquettes :

```
Les écrans ne sont pas maquettés (presta/specs/spec-ux.md).

Ça ne bloque pas le découpage. Mais aucun critère ne pourra s'appuyer sur une
maquette validée, et le vérificateur n'aura rien à quoi comparer ses captures.
```

Celui-ci n'appelle pas de réponse : c'est un constat, on enchaîne.

### Ce que vous lisez, et dans quel ordre

Ne lisez jamais les onze écrans détaillés pour proposer un découpage. Vous n'avez besoin
que du périmètre.

| Quand | Quoi |
|---|---|
| Avant de proposer le découpage | La table des écrans de `spec-ecrans.md` et sa navigation, `spec-modeles.md`, `spec-architecture.md`, `presta/specs/generated/acces-par-role.md`, la section « décisions techniques » de `spec-technique.md`, `elements-a-fournir.md` |
| Au moment d'écrire les critères d'une phase | La section de `spec-ecrans.md` de **chaque écran de cette phase**, et rien d'autre |

### Le livrable et la numérotation

1. Lisez l'en-tête de `presta/status.md` : `projet`, `version`, `etape`, et le
   dernier rendez-vous avec son label.
2. Le dossier du livrable est `presta/livrables/v{version}-{slug}/`, où `{slug}` vient du
   **label du rendez-vous**, en kebab-case, deux ou trois mots — `v1.0-portefeuille-actions`,
   `v1.1-export-csv`. Si `status.md` ne porte aucun label, générez-le depuis le
   nom du projet et faites-le valider en une ligne avant d'écrire quoi que ce soit : le
   nom du dossier ne se renomme plus une fois les rapports posés dedans.
3. **La numérotation des phases est unique sur toute la vie du projet.** Elle ne repart
   jamais à 1 : si le livrable précédent s'arrête à `P-10-TABLEAU-DE-BORD`, la
   numérotation du suivant reprend à 11. Un numéro ne se réutilise jamais, même si la
   phase a été supprimée.
   Un `// TODO P-11-EXPORT-CSV` posé dans le code doit rester non ambigu trois versions
   plus tard.
4. Le dossier `phases/` du livrable courant contient déjà des fichiers ? → cas
   **reprise** (étape 2).

**Si un argument a été passé** (`/presta-phases P-05-SYMBOLES`, `/presta-phases refais le
découpage du back-office`) : sautez la proposition et traitez directement la demande.

---

## Étape 2 — Message d'accueil

La ligne « Basé sur » vient des frontmatters des specs.

### Cas « premier découpage »

```
| **PRESTA — Phases** | |
|---|---|
| Basé sur | presta/specs/spec-architecture.md — figée le 06/08/2026 |
| | presta/specs/spec-ecrans.md — 11 écrans |
| | presta/specs/spec-modeles.md — 6 entités |
| Livrable | v1.0-portefeuille-actions |

Voici ma proposition de découpage. 10 phases.

---

**SOCLE**

| ID | Phase | Contenu |
|---|---|---|
| P-01-SETUP | Setup | Projet Django initialisé, il se lance, j'y accède au navigateur |
| P-02-MODELES-ET-DONNEES | Modèles et jeu de données | M-01-USER, M-02-PORTFOLIO, M-03-SYMBOL-CATEGORY, M-04-SYMBOL, M-05-QUOTE, M-06-TRANSACTION, migrations, jeu de données |
| P-03-COMPTES-ET-CONNEXION | Comptes et connexion | E-01-CREATION-COMPTE, E-02-CONNEXION, et les droits par rôle |
| P-04-MOT-DE-PASSE | Mot de passe et compte | E-03-MOT-DE-PASSE-OUBLIE, E-07-MON-COMPTE |

Une fois le socle développé, le projet est en place et se lance, la gestion des
comptes fonctionne, la base est opérationnelle. Vous pouvez créer un compte,
vous connecter, changer votre mot de passe, et vous promener dans une
application encore vide. Tout est prêt pour accueillir les fonctionnalités.

---

**BACK-OFFICE**

| ID | Phase | Contenu |
|---|---|---|
| P-05-SYMBOLES | Symboles | E-09-LISTE-SYMBOLES, E-10-FICHE-SYMBOLE |
| P-06-COTATIONS | Cotations | La récupération des cours. Aucun écran : un service et une tâche |
| P-07-UTILISATEURS | Utilisateurs | E-11-LISTE-UTILISATEURS |

À ce stade, l'administrateur crée les titres cotables — Nvidia, le Bitcoin,
l'or — et leurs cours arrivent tous les soirs. La base se remplit de vraies
données de marché, que vous pouvez vérifier depuis le back-office. Côté membre,
rien n'a encore bougé.

---

**ESPACE MEMBRE**

| ID | Phase | Contenu |
|---|---|---|
| P-08-TRANSACTIONS | Transactions | E-06-SAISIE-TRANSACTION |
| P-09-MES-ACTIONS | Mes actions | E-05-MES-ACTIONS, E-08-DETAIL-ACTION |
| P-10-TABLEAU-DE-BORD | Tableau de bord | E-04-TABLEAU-DE-BORD |

L'application est complète : un membre saisit ses achats et ses ventes, voit ce
qu'il détient titre par titre, et retrouve sur son tableau de bord la valeur de
son portefeuille, sa répartition et sa courbe de progression. C'est la fin du
livrable v1.0.

---

**Deux choix d'ordre que je vous signale**

| | |
|---|---|
| P-05-SYMBOLES avant P-08-TRANSACTIONS | Un membre ne peut rien saisir tant qu'aucun symbole n'existe. Le back-office alimente l'espace membre. |
| P-10-TABLEAU-DE-BORD en dernier | C'est le seul écran qui a besoin des cotations et des transactions en même temps. Le développer plus tôt reviendrait à l'écrire deux fois. |

---

**Bouts non branchés à prévoir**

| | |
|---|---|
| P-08-TRANSACTIONS | La liste des titres détenus n'existe qu'en P-09-MES-ACTIONS. Après une saisie, on revient sur un placeholder « Écran à venir — P-09-MES-ACTIONS », pas sur un lien mort. |

---

**Deux points à signaler avant de valider**

| | |
|---|---|
| D-03-FREQUENCE-COURS | Toujours en attente. Elle décide si P-06-COTATIONS contient une tâche planifiée ou un simple bouton de synchronisation manuelle. Ça change le contenu de la phase, pas sa place. À régler avec /presta-essais-techniques. |
| La clé du fournisseur de cotation | Dans elements-a-fournir.md, pas encore fournie. P-06-COTATIONS sera implémentable, pas vérifiable. |

---

Est-ce que ce découpage vous convient ? Dites-moi ce qu'il faut ajuster,
regrouper ou séparer.
```

**[PANNEAU]** — la validation part toujours au panneau, que le bloc « points à signaler »
soit présent ou non : ce bloc informe, il ne pose pas de choix à trancher ici — un `D-xx`
se règle avec `/presta-essais-techniques`, un élément manquant vit dans
`elements-a-fournir.md`. *Oui, on part sur ce découpage* **(recommandée)** / *J'ai des
phases à regrouper ou à séparer*.

Règles sur ce message :

- **Groupé en blocs**, dans l'ordre imposé (voir ci-dessous), avec un tableau par bloc.
- **Une ligne de contenu par phase, jamais deux.** C'est un périmètre, pas un début de
  critères.
- **Chaque bloc est suivi d'un paragraphe de situation** : où en est le projet une fois
  ce bloc développé, et ce que l'utilisateur pourra constater lui-même. C'est ce qui rend
  le découpage discutable par quelqu'un qui ne raisonne pas en dépendances.
- **Les IDs sont attribués tout de suite, avec leur slug.** Ils serviront dans les
  rapports, les commentaires de code et l'audit.
- **Le bloc « choix d'ordre » ne contient que ce qui n'est pas évident** — deux ou trois
  lignes. Un ordre qui va de soi ne se justifie pas.
- **Le bloc « bouts non branchés » est obligatoire dès qu'il y en a un.** C'est un
  engagement pris ici et tenu à l'implémentation.
- **Le bloc « points à signaler » ne contient que ce qui touche une phase nommée** :
  une décision `D-xx` en attente, un élément à fournir. Un rappel générique n'y a pas sa
  place.

### L'ordre imposé

Les quatre premiers blocs ne se discutent pas — c'est l'ordre dans lequel un projet peut
exister.

| # | Bloc | Ce qu'il contient |
|---|---|---|
| 1 | Setup | Le projet initialisé, qui se lance, et auquel l'agent accède au navigateur |
| 2 | Socle | Les modèles, les services transverses, et **le jeu de données** |
| 3 | Comptes et droits | S'il y en a. Tout en dépend |
| 4 | Verticales | Le reste, ordonné par dépendance |

**P-01-SETUP figure toujours dans le découpage**, avec ses critères, mais elle est
exécutée et validée par `/presta-setup`, pas par `/presta-implemente`. C'est une phase
comme les autres : elle porte un statut, elle produit un rapport.

### Les cinq règles de découpage

1. **Groupez ce qui est mutuellement dépendant.** Ce qui ne peut être ni développé ni
   testé séparément va dans la même phase. **C'est le critère premier** : couper au
   milieu d'un ensemble dépendant oblige le sous-agent suivant à reconstruire un contexte
   qu'on venait de perdre.
2. **Ne découpez que si le paquet est trop gros**, et alors selon ces limites : **2 écrans
   au maximum**, pop-ups comprises — **un seul** s'il est complexe (sous-onglets,
   nombreuses options) ; **2 à 3 services au maximum** pour une phase de socle ; et pour
   une arborescence de back-office, **un découpage par niveau de navigation**.
3. **Ordonnez pour que les dépendances pointent vers l'arrière.** Une phase ne dépend
   jamais d'une phase ultérieure.
4. **Chaque phase laisse le projet compilable et lançable.**
5. **Déclarez les bouts non branchés**, dès le découpage.

Ce qui ne sert pas de critère : le nombre d'étapes de recette. Un écran à trois champs
peut porter des règles métier lourdes.

### Cas « reprise »

```
| **PRESTA — Phases** | |
|---|---|
| Basé sur | presta/livrables/v1.0-portefeuille-actions/phases/ — 6 phases sur 10 |

Où on en est :

| État | ID | Phase |
|---|---|---|
| **SOCLE** | | |
| [x] | P-01-SETUP | Setup |
| [x] | P-02-MODELES-ET-DONNEES | Modèles et jeu de données |
| [x] | P-03-COMPTES-ET-CONNEXION | Comptes et connexion |
| [x] | P-04-MOT-DE-PASSE | Mot de passe et compte |
| **BACK-OFFICE** | | |
| [x] | P-05-SYMBOLES | Symboles |
| [-] | P-06-COTATIONS | Cotations |
| [ ] | P-07-UTILISATEURS | Utilisateurs |

On reprend sur P-06-COTATIONS ? Vous pouvez aussi revoir le découpage.
```

Les trois états : `[x]` critères écrits et validés, `[-]` commencée, `[ ]` pas commencée.
Ils s'écrivent tels quels dans la colonne « État ».

**Ce sont les états du découpage, pas de l'implémentation.** L'avancement du
développement vit dans le champ `etat:` de chaque fichier de phase, tenu par
`/presta-setup` et `/presta-implemente`. Ne les confondez pas et ne les recopiez pas.

### Cas « nouveau livrable sur projet existant »

Le découpage ne re-liste jamais les phases livrées. Il porte uniquement ce que
l'évolution demande, la numérotation continue de l'existant, et le dossier du livrable
est nouveau. Une ligne rappelle ce qui a déjà été livré :

```
| Livré | v1.0-portefeuille-actions — 10 phases, tag v1.0 |
| Nouveau livrable | v1.1-export-csv |
```

Sur un livrable d'évolution, **une phase de reprise n'est pas une phase de plus** : si
l'évolution modifie un écran existant, elle vit dans la phase qui porte le nouvel écran,
et le fichier de phase le dit — « E-05-MES-ACTIONS modifié : bouton *Exporter* ajouté ».

---

## Étape 3 — Phase par phase

Une fois le découpage validé, **enchaînez directement sur les critères de la première
phase**. Ne redemandez pas l'autorisation, n'annoncez pas de plan : le découpage vient
d'être validé, l'ordre est connu.

Une ligne suffit pour dire ce qui vient, et elle se place au-dessus de la première phase :

```
On passe aux critères de validation : ce que chaque phase devra prouver pour
être déclarée terminée. C'est le sous-agent vérificateur qui s'en servira — il
n'en écrit aucun, il ne fait que les vérifier.

P-01-SETUP et P-02-MODELES-ET-DONNEES vont ensemble, elles sont courtes.
```

**Regroupez les phases courtes.** Une phase qui porte un seul écran simple, ou aucun
écran, se propose dans le même affichage qu'une autre. Dès qu'une phase soulève une vraie
question, elle a son tour à elle. Deux phases par affichage au maximum.

### L'affichage d'une phase

```
| **PRESTA — Phases** | |
|---|---|
| Phase | P-03-COMPTES-ET-CONNEXION — 3/10 |
| Écrans | E-01-CREATION-COMPTE, E-02-CONNEXION |
| Modèles | M-01-USER |
| Dépend de | P-02-MODELES-ET-DONNEES |

Un visiteur crée son compte et se connecte. Les droits par rôle sont posés ici,
et tout ce qui vient après s'appuie dessus.

---

**Critères de validation**

1. **Création compte valide** : E-01-CREATION-COMPTE, adresse valide + CGU cochées →
   compte rôle membre, redirection E-04-TABLEAU-DE-BORD.
2. **Adresse déjà utilisée** : message « Un compte existe déjà avec cette adresse
   e-mail », aucun compte créé.
3. **CGU non cochées** : bouton « Créer mon compte » inactif.
4. **Accès back-office refusé à un membre** : quelle que soit l'URL. Source :
   acces-par-role.md.
5. **Accès espace membre sans connexion** : renvoi vers E-02-CONNEXION.
6. **Comptes du jeu de données** : les trois se connectent, chacun avec son rôle.
7. **Mot de passe protégé** : jamais renvoyé au client, absent des journaux. Source :
   M-01-USER.

---

**Bout non branché**

Le lien « Mot de passe oublié » de E-02-CONNEXION mène à E-03-MOT-DE-PASSE-OUBLIE,
développé en P-04-MOT-DE-PASSE. Placeholder « Écran à venir — P-04-MOT-DE-PASSE ».

```

**[PANNEAU]** — jusqu'à 4 questions, un appel `AskUserQuestion`, un onglet par question.
Le premier onglet est toujours « Est-ce que ces critères vous conviennent ? ». Les
onglets suivants portent les points de fond, chacun avec 3 à 4 options nommées, la
première recommandée. Exemple sur un onglet « Création admin » : *L'inscription est le
seul chemin* **(recommandée)** / *L'administrateur peut aussi en créer un depuis le
back-office — ajoute un critère ici et un formulaire sur E-11-LISTE-UTILISATEURS*.

### Les blocs, dans l'ordre

| Bloc | Contenu | Obligatoire |
|---|---|---|
| En-tête | `P-xx-SLUG — n/N`, les écrans, les modèles, les phases dont elle dépend | Oui |
| Ce que la phase produit | Deux ou trois lignes, en langage courant. Ce qu'on pourra faire à la fin | Oui |
| Critères de validation | Numérotés, assertions observables, chacun ancré | Oui |
| Bouts non branchés | Ce qui reste en placeholder, et vers quelle phase | S'il y en a |
| Points ouverts | Une décision `D-xx` en attente, un élément à fournir, et ce que ça rend non vérifiable | S'il y en a |
| Ce qui n'est pas dans cette phase | **Seulement si l'absence prête à confusion** — un écran qu'on s'attendrait à trouver ici. Jamais pour décorer | Rarement |
| Questions | **[PANNEAU]** — 4 au maximum, un onglet chacune, la première toujours « Est-ce que ces critères vous conviennent ? » | Oui |

### Combien de critères

De cinq à douze par phase. En dessous de cinq sur une phase qui porte un écran, il manque
probablement les états et les erreurs. Au-dessus de douze, la phase est trop grosse : la
question à poser n'est pas « quels critères je coupe » mais « est-ce que je découpe la
phase ».

Les sources d'un critère, dans l'ordre où on les épuise :

| Source | Ce qu'on y prend |
|---|---|
| La section de l'écran dans `spec-ecrans.md` | Le parcours nominal, les autres états, les erreurs rédigées, les actions |
| Les règles métier de `spec-produit.md` | Celles que cette phase rend applicables — avec le message d'erreur exact |
| `presta/specs/generated/acces-par-role.md` | Qui accède à quoi, et ce qui doit être refusé |
| Les commentaires de contrat de `spec-modeles.md` | Ce qu'un champ interdit |
| `spec-architecture.md` | Ce que la phase ne doit pas faire : une vue qui touche la base, un service fourre-tout |
| `spec-ux.md`, s'il existe | La disposition validée, comparable à son aperçu |

### Ce que la méthode impose au socle

La plupart des critères se déduisent des specs. Quelques-uns n'y sont écrits nulle part et
ne s'inventeront jamais tout seuls : **personne ne demande un jeu de données rejouable au
rendez-vous.** Vous les posez d'office — mais seulement si l'objet existe dans ce projet.
Pas de base de données, pas de critère de base de données.

**Si la phase de socle contient un jeu de données :**

```
4. **Réinitialisation et seed** : `db:reset` → schéma neuf vide ; `db:seed` → schéma
   neuf peuplé. Commandes documentées dans AGENTS.md.
5. **Comptes par rôle** : un par rôle de spec-produit.md, identifiants fixes en en-tête
   du cahier de recettes.
6. **Rejeu stable** : `db:seed` répété deux fois donne le même état.
7. **Seed restreint** : refuse de s'exécuter hors développement et test.
```

Sans le compte par rôle, tous les écrans réservés deviennent intestables. Sans le rejeu à
l'identique, les tests deviennent instables selon l'ordre d'exécution. Le refus hors
développement évite des comptes à mots de passe connus en production — et il est contrôlé
par `/presta-audit`.

### Les questions

Quatre au maximum, numérotées, chacune introduite par son thème. Elles portent sur ce que
les specs laissent ouvert **à l'échelle de la phase** — pas sur le contenu d'un écran, qui
est validé.

Trois questions reviennent souvent, et elles sont légitimes :

- un critère qui suppose quelque chose que les specs ne disent pas ;
- un écart entre deux specs, qu'on ne voit qu'en écrivant les critères ;
- un critère qui ne pourra pas être prouvé faute d'un élément à fournir.

**Si la réponse change un écran, ne le corrigez pas.** Notez-le, la clôture le remontera
vers `/presta-spec`.

### Validation et écriture

**Le bloc « Questions » part au panneau**, jusqu'à 4 onglets. Si une ou plusieurs
réponses signalent un ajustement, un seul second tour, en texte, reprend les points en
suspens ensemble — mécanique commune décrite dans « Le panneau de questions » plus haut.

### L'écriture se place derrière le texte

**Un appel d'outil ne se place jamais juste après l'action de l'utilisateur.** Il vient de
valider : ce qu'il doit voir en premier, c'est du texte. Le fichier s'écrit derrière,
pendant qu'il lit.

L'écriture d'une phase est donc **décalée d'une phase** :

| Il valide | Vous affichez | Vous écrivez, dans le même message, après le texte |
|---|---|---|
| P-03-COMPTES-ET-CONNEXION | la proposition P-04-MOT-DE-PASSE | le fichier de P-03-COMPTES-ET-CONNEXION |
| P-04-MOT-DE-PASSE | la proposition P-05-SYMBOLES | le fichier de P-04-MOT-DE-PASSE |

Trois points à ne pas rater :

- **L'ordre dans le message ne se négocie pas** : le texte, puis l'appel d'écriture.
- **Une phase validée non écrite ne survit jamais à deux phases.** On vide la file avant
  d'afficher autre chose : sur une reprise du découpage (étape 4) et à la clôture.
- **Rien ne s'écrit avant validation.** Le décalage ne change pas ça.

Sur la dernière phase, il n'y a rien à afficher derrière : l'écriture est seule.

### Le message de suivi

L'utilisateur a répondu : il valide une partie, corrige un critère, pose une question.
**Vous ne rejouez pas la phase entière.**

```
**P-03-COMPTES-ET-CONNEXION — ce qui change**

| | |
|---|---|
| 2 | L'administrateur peut créer un compte depuis le back-office. Critère 8 ajouté ici, et le formulaire part en P-07-UTILISATEURS. |

**Critère ajouté**

8. **Création compte par admin** : adresse e-mail saisie depuis le back-office →
   compte créé sans mot de passe, lien de définition envoyé au propriétaire.

**Questions restantes**

3. Sur la durée de validité de ce lien : ...
```

Trois règles : une ligne par point touché avec le numéro de l'utilisateur ; seuls les
critères qui bougent se redonnent ; les questions restantes gardent leurs numéros.

---

## Étape 4 — Si le découpage change en cours de route

L'utilisateur peut à tout moment fusionner deux phases, en découper une, ou en déplacer
une. Dans ce cas :

1. **Si l'ordre ou la numérotation bougent, reproposez le découpage complet**, dans le
   format de l'étape 2, paragraphes de situation compris. **Sinon** — une phase ajoutée
   en fin de bloc, sans effet sur les autres — deux lignes suffisent : ce qui entre, ce
   qui sort.
2. Faites-le valider — **[PANNEAU]**, mêmes options qu'à l'étape 2.
3. **Revenez précisément là où vous en étiez**, en le disant.

Un numéro supprimé ne se réutilise jamais : la phase est marquée supprimée.

**Avant de reproposer le découpage, écrivez la phase validée qui attend encore.**

**Quand une phase déjà écrite change de contenu**, ses critères sont à revoir : ne les
laissez pas en l'état. Dites-le, et reprenez-les.

---

## Étape 5 — La clôture

**La dernière phase validée s'écrit ici**, avant le contrôle de couverture.

Un seul bloc, puis l'écriture. Vous montrez la couverture, **dans les deux sens**, et vous
nommez ce qui n'est porté par rien. Vous ne déclarez jamais que le découpage est complet.

```
| **PRESTA — Phases** |
|---|

Les 10 phases sont définies. 78 critères de validation.

| État | ID | Critères |
|---|---|---|
| [x] | P-01-SETUP | 4 |
| [x] | P-02-MODELES-ET-DONNEES | 9 |
| [x] | P-03-COMPTES-ET-CONNEXION | 8 |
| ... | | |

---

**Chaque écran est porté par une phase**

| Écran | Phase |
|---|---|
| E-01-CREATION-COMPTE | P-03-COMPTES-ET-CONNEXION |
| E-02-CONNEXION | P-03-COMPTES-ET-CONNEXION |
| E-03-MOT-DE-PASSE-OUBLIE | P-04-MOT-DE-PASSE |
| E-04-TABLEAU-DE-BORD | P-10-TABLEAU-DE-BORD |
| E-05-MES-ACTIONS | P-09-MES-ACTIONS |
| E-06-SAISIE-TRANSACTION | P-08-TRANSACTIONS |
| E-07-MON-COMPTE | P-04-MOT-DE-PASSE |
| E-08-DETAIL-ACTION | P-09-MES-ACTIONS |
| E-09-LISTE-SYMBOLES | P-05-SYMBOLES |
| E-10-FICHE-SYMBOLE | P-05-SYMBOLES |
| E-11-LISTE-UTILISATEURS | P-07-UTILISATEURS |

Les 6 entités sont créées en P-02-MODELES-ET-DONNEES, avec le jeu de données.

---

**Les règles métier du rendez-vous sont portées par un critère**

| | |
|---|---|
| « On ne peut pas vendre plus que ce qu'on détient » | P-08-TRANSACTIONS, critère 4 |
| « Une adresse e-mail = un seul compte » | P-03-COMPTES-ET-CONNEXION, critère 2 |
| « Un membre ne voit que son propre portefeuille » | P-09-MES-ACTIONS, critère 6 |

**Sauf une** — « les cours affichés datent de la veille au soir », décidée avec
D-03-FREQUENCE-COURS. Aucun critère ne la porte : c'est une mention à afficher
sur E-04-TABLEAU-DE-BORD, et spec-ecrans.md ne dit pas où. Je l'ajoute en
critère de P-10-TABLEAU-DE-BORD en l'état — « la date du dernier cours est
visible sur l'écran » — ou vous préférez la préciser d'abord avec /presta-spec ?

---

**Les bouts non branchés**

| | |
|---|---|
| P-08-TRANSACTIONS | Retour après saisie → placeholder « Écran à venir — P-09-MES-ACTIONS » |
| P-09-MES-ACTIONS | Bloc « Progression » vide, rempli en P-10-TABLEAU-DE-BORD |

---

**Ce qui bloque une phase, de votre côté**

| | |
|---|---|
| La clé du fournisseur de cotation | Bloque la vérification de P-06-COTATIONS |
| Le logo en SVG | Ne bloque rien, cosmétique |

---

**Décision encore en attente**

| | |
|---|---|
| D-03-FREQUENCE-COURS | P-06-COTATIONS sera développée avec une synchronisation manuelle. La tâche planifiée attend la décision. À régler avec /presta-essais-techniques. |
```

Le contrôle se fait dans les deux sens : chaque écran a sa phase, et chaque phase porte
au moins un écran, un service ou une entité. Une phase qui ne porte rien de tout ça est
une phase qui n'existe pas.

Une fois les manques traités — ce sont des questions ouvertes, elles restent en texte —
terminez par la porte de validation, **[PANNEAU]** : *Oui, je valide, vous pouvez écrire*
/ *J'ai des ajustements*.

---

## Étape 6 — L'écriture des fichiers

**Seulement une fois la porte de validation franchie.** Lisez `references/gabarits.md`.

| Fichier | Contenu |
|---|---|
| `presta/livrables/v{version}-{slug}/phases/p-xx-{slug}.md` | Une phase par fichier, avec ses critères (déjà écrits au fil de l'eau) |
| `presta/livrables/v{version}-{slug}/phases/index.md` | La liste groupée par bloc. **Aucun statut** |
| `presta/livrables/v{version}-{slug}/description-livrable.md` | Le périmètre du livrable : les écrans, les modèles, les fonctionnalités, ce qui n'y est pas, les limites acceptées |
| `presta/elements-a-fournir.md` | Ce qui bloque une phase, avec la phase nommée |
| `presta/status.md` | `etape: phases`, et `livrable_courant: v{version}-{slug}` |
| `presta/regles-projet.md` | Les deux règles ci-dessous |

Créez aussi les dossiers vides du livrable — `rapports/`, `recettes/`,
`recettes/generated/` et `audits/` : `/presta-setup` et `/presta-implemente` y écrivent,
et un dossier absent se traduit par un fichier posé ailleurs.

`recettes/generated/` accueille `recette-complete-v{version}.md`, la concaténation des
cahiers de recettes de chaque phase, régénérée en fin de livrable par
`/presta-implemente`. C'est un fichier déduit : il vit dans un `generated/` à côté de sa
source, comme tout fichier recalculable de la méthode.

Inscrivez dans `presta/regles-projet.md`, si elles n'y sont pas déjà :

> Le statut d'une phase fait autorité dans le champ `etat:` de son fichier, dans
> `presta/livrables/{livrable}/phases/`, où `{livrable}` est le champ `livrable_courant`
> de `presta/status.md`, lu tel quel et jamais recomposé. Ce que `presta/status.md`
> affiche de l'avancement est un report, jamais une source.

> Tout bout non branché porte un placeholder visible à l'écran et un commentaire
> `// TODO P-xx-SLUG` dans le code. Un lien mort qui ne dit rien remonte en faux bug.

Prenez l'horodatage avec `date +%FT%T`. Terminez en affichant les fichiers écrits avec ce
qu'ils contiennent, puis :

```
C'est en place.

| Fichier | Ce qu'il contient |
|---|---|
| presta/livrables/v1.0-portefeuille-actions/phases/ | 10 phases, 78 critères |
| presta/livrables/v1.0-portefeuille-actions/phases/index.md | le découpage groupé en 3 blocs |
| presta/livrables/v1.0-portefeuille-actions/description-livrable.md | 11 écrans, 6 entités, 3 fonctionnalités |
| presta/elements-a-fournir.md | 1 point ajouté, bloque P-06-COTATIONS |
| presta/status.md | étape : phases, livrable courant v1.0-portefeuille-actions |
| presta/regles-projet.md | où vit le statut d'une phase, la règle des bouts non branchés |


Prochaine étape : l'initialisation du projet, avec /presta-setup.
```

---

## Portabilité

<!-- SHARED:INVOCATION:START -->
**Invocation.** Cette skill ne se lance que sur demande explicite de l'utilisateur, jamais
d'elle-même. Claude Code : `/` suivi du nom de la skill. Codex : `$` suivi du nom, ou
`/skills` — le fichier `agents/openai.yaml` du dossier coupe l'invocation implicite.
Ailleurs : l'utilisateur nomme la skill dans sa demande.
<!-- SHARED:INVOCATION:END -->

---

## Ce que cette skill ne fait pas

- Elle ne développe rien et n'écrit aucun code, pas même un squelette — c'est
  `/presta-setup` puis `/presta-implemente`.
- Elle ne dit jamais **comment** vérifier un critère : ni commande, ni scénario cliqué,
  ni fichier de test. Le vérificateur répartit après coup.
- Elle n'écrit pas le cahier de recettes : au découpage on ne connaît ni les libellés ni
  les routes.
- Elle ne découpe pas les phases en tâches.
- Elle ne redéfinit ni les écrans, ni les entités, ni l'architecture. Elle signale ce qui
  est à reprendre et remonte vers la skill concernée.
- Elle ne tranche aucune décision qui demande une mesure ou un essai : elle dit ce que la
  décision en attente rend non vérifiable, et renvoie vers `/presta-essais-techniques`.
- Elle ne tient aucun avancement d'implémentation : le statut d'une phase appartient à
  son fichier, et c'est `/presta-setup` et `/presta-implemente` qui le font évoluer.
- Elle n'installe aucun hook et ne touche à aucun `settings.json`.
