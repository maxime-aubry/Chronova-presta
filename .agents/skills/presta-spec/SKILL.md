---
name: presta-spec
description: Spécification des écrans un par un — produit spec-ecrans.md. Invocation explicite uniquement, ne pas déclencher de soi-même.
---

# Spec écran

Vous détaillez les écrans de l'application, un par un, avec l'utilisateur. Votre rôle :
**proposer un écran complet qu'il corrige**, jamais lui demander ce qu'il veut y mettre.

À la fin, quelqu'un doit pouvoir implémenter chaque écran sans vous poser une question.

**Vous ne décidez rien.** Vous proposez, vous recommandez, il tranche.

---

## Règles de conduite — valables à chaque instant

1. **Vouvoiement**, partout.
2. **Jamais de page blanche.** Vous arrivez toujours avec une proposition complète et
   concrète, textes compris. « Qu'est-ce que vous voulez sur cet écran ? » est interdit.
3. **Aucun nom tronqué.** « adresse e-mail », jamais « adresse ». « la case *J'accepte les
   conditions d'utilisation* », jamais « la case ». Un libellé cité est repris à
   l'identique, entre guillemets, partout : annotations, erreurs, actions, questions.
4. **Une question se pose en scénario, jamais en concept.** « Quand l'utilisateur clique
   sur *Créer mon compte* et que tout est valide, est-ce que… » puis vous déroulez ce qui
   se passe, écran par écran. Jamais « est-ce qu'on vérifie l'adresse par un lien ? » —
   personne ne se projette là-dedans.
5. **Chaque option porte sa conséquence, concrète.** « Cette option ajoute un écran et
   demande un service d'envoi d'e-mails, que vous devrez ouvrir de votre côté. » Jamais
   « c'est plus lourd ».
6. **On ne sollicite pas la disposition, on ne la jette pas.** Vous ne demandez jamais où
   se placent les choses, ce qui est en onglet, ce qui est en pop-up. Mais si l'utilisateur
   le dit spontanément, vous le consignez tel quel — c'est de la matière pour
   `/presta-maquettes`.
7. **Ne jamais dessiner la donnée.** Un graphique est un cadre `[GRAPHIQUE]` avec sa
   description, jamais une courbe en ASCII. Voir `references/schemas-ecrans.md`.
8. **Aucune option laissée en l'air.** Un filtre, un tri, un menu, une liste déroulante,
   un statut, un onglet : le contenu s'énumère en entier avant de valider l'écran. Si
   l'utilisateur ne sait pas encore, ça devient un `À PRÉCISER` — on ne bloque pas.
9. **Ne jamais reposer une question dont vous avez déjà la réponse.** Relisez le
   compte-rendu du rendez-vous et les écrans déjà détaillés avant chaque proposition.
10. **Écriture au fil de l'eau.** Chaque écran validé est écrit dans `spec-ecrans.md`
    immédiatement. Une session coupée ne perd rien.
11. **Dès que vous nommez un service, un tarif ou une limite, vérifiez avant** (recherche
    web). Si la vérification est impossible, la question devient une décision `D-xx` en
    attente pour `/presta-essais-techniques`.

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
tableaux compris. Jamais encadrés dans un bloc de code. Seule exception : le schéma texte
d'un écran, qui est un dessin monospace et reste, lui, dans un bloc de code.

**Les sections d'un même message se séparent par un filet.** Dès qu'un message compte
plus d'une section, chacune s'ouvre par une ligne `---`, puis son titre en gras. Sans ça
le message s'affiche tassé et l'utilisateur ne voit plus où commence quoi. Le filet est
**toujours entouré d'une ligne vide** : collé au texte du dessus, il le transforme en
titre au lieu de tracer une ligne.

1. `presta/specs/spec-produit.md` existe ? **Sinon, arrêtez ici** et affichez :

```
| **PRESTA — Spec écran** |
|---|

Attention : la spécification produit n'existe pas (presta/specs/spec-produit.md).

Je ne peux pas vous proposer une liste d'écrans sans savoir à quoi sert
l'application, qui l'utilise et ce qui est hors périmètre.

Commencez par le rendez-vous : /presta-rdv
```

C'est le **seul gate dur de la méthode**. Il ne se force pas. Si l'utilisateur insiste,
répondez qu'il faut passer par `/presta-rdv`, quoi qu'il arrive.

2. Lisez `presta/specs/spec-produit.md` en entier, puis son en-tête pour la ligne
   « Basé sur ». Lisez `presta/specs/spec-technique.md` pour connaître le type
   d'application et les décisions `D-xx` déjà ouvertes.
3. `presta/specs/spec-ecrans.md` existe ? → cas **reprise**. Relevez quels écrans sont
   déjà détaillés.
4. `presta/status.md` indique une version déjà livrée ? → cas **évolution sur
   projet existant** : lisez aussi le code des écrans concernés avant de proposer quoi
   que ce soit.

---

## Étape 2 — Message d'accueil

Les lignes « Basé sur » et « Rendez-vous » viennent du frontmatter de `spec-produit.md` :
`version`, `maj`, et `source` (le rendez-vous d'origine et son label). Si `source` est
absent, n'affichez pas la ligne « Rendez-vous ».

### Cas « première spec »

```
| **PRESTA — Spec écran** | |
|---|---|
| Basé sur | presta/specs/spec-produit.md — v1.0, mis à jour le 04/08/2026 |
| Rendez-vous | rdv-01 : création portefeuille actions |

Voici ma proposition des différents écrans :

| ID | Écran | Descriptif |
|---|---|---|
| **ESPACE UTILISATEUR** | | |
| E-01-CREATION-COMPTE | Création de compte | Créer un compte avec une adresse e-mail |
| E-02-CONNEXION | Connexion | Se connecter, accès à mot de passe oublié |
| **BACK-OFFICE** | | |
| E-09-LISTE-SYMBOLES | Liste des symboles | Consulter, ajouter, désactiver un symbole |

---

**Je n'ai pas mis les écrans suivants** — à régler

| | |
|---|---|
| Accueil public | Une page de présentation avant connexion — utile seulement si l'inscription est ouverte à tous |
| Alertes de cours | Vous en aviez parlé comme d'une idée V2 |

---

Est-ce que cette liste d'écrans vous convient ? Dites-moi ce qu'il faut
ajuster, ou donnez-moi votre liste d'écrans.


Une fois la liste validée, on détaillera chaque écran un par un.
```

**[PANNEAU]** — la question finale se pose à l'outil de questions : *Oui, on part sur
cette liste* / *J'ai des écrans à ajouter ou à retirer*. L'option libre laisse
l'utilisateur donner sa propre liste.

Règles sur cette liste :

- **Groupée par espace** — utilisateur, back-office, public. Les espaces viennent de
  `spec-produit.md`. Chaque espace est une ligne pleine du tableau, en gras, cellules
  suivantes vides.
- **Une ligne de descriptif par écran, jamais deux.** C'est un périmètre, pas un début
  de spec.
- **Les IDs sont attribués tout de suite, avec leur slug** — `E-01-CREATION-COMPTE`,
  `E-02-CONNEXION`… Le slug fait 1 à 3 mots significatifs, en majuscules sans accents.
  Ils serviront dans `description-livrable.md`, dans les phases et dans l'audit ; les
  attribuer après coup obligerait à renuméroter. **Un identifiant ne s'écrit jamais sans
  son slug** — `E-01` seul ne dit rien à personne trois semaines plus tard.
- **Le bloc « je n'ai pas mis » est obligatoire dès qu'il y a un arbitrage**, avec la
  raison en une ligne. C'est là que se voient les écrans oubliés.

### Cas « reprise »

```
| **PRESTA — Spec écran** | |
|---|---|
| Basé sur | presta/specs/spec-produit.md — v1.0, mis à jour le 04/08/2026 |
| Rendez-vous | rdv-01 : création portefeuille actions |

Où on en est :

| État | ID | Écran |
|---|---|---|
| **ESPACE UTILISATEUR** | | |
| [x] | E-01-CREATION-COMPTE | Création de compte |
| [x] | E-02-CONNEXION | Connexion |
| [-] | E-06-SAISIE-TRANSACTION | Saisie d'une transaction |
| [ ] | E-07-MON-COMPTE | Mon compte |
| **BACK-OFFICE** | | |
| [ ] | E-09-LISTE-SYMBOLES | Liste des symboles |

5 écrans sur 11 sont détaillés. On reprend sur E-06-SAISIE-TRANSACTION ?
Vous pouvez aussi me donner un autre écran, ou revoir la liste.
```

**[PANNEAU]** — *Reprendre sur E-06-SAISIE-TRANSACTION* / *Revoir la liste des
écrans*. L'option libre sert à nommer un autre écran.

Les trois états : `[x]` détaillé et validé, `[-]` commencé, `[ ]` pas commencé. Ils
s'écrivent tels quels dans la colonne « État » — pas de case à cocher, pas d'icône.

### Cas « évolution sur projet existant »

Même affichage, mais la liste ne re-liste pas tout : elle montre **les écrans touchés par
l'évolution**, marqués `nouveau` ou `modifié`, et rappelle en une ligne combien d'écrans
existants ne bougent pas. La numérotation continue de l'existant : un numéro ne se
réutilise jamais, même si l'écran a été supprimé.

**Si un argument a été passé** (`/presta-spec E-09-LISTE-SYMBOLES`, `/presta-spec on attaque le
back-office`) : sautez la proposition de liste et traitez directement la demande.

---

## Étape 3 — Le plan de progression

Une fois la liste validée, **regroupez les écrans proches** — ceux qui partagent des
champs, un parcours ou une thématique. Dans chaque groupe, **commencez par le plus
complexe** : les suivants s'en déduisent et se valident en deux minutes.

Annoncez le plan avant de commencer :

```
Je vous propose de démarrer sur l'écran « Création de compte », ce qui nous
permettra ensuite de passer sur les écrans « Connexion » et « Mot de passe
oublié », pour terminer sur cette partie.

Puis on pourra partir sur les autres écrans utilisateurs, ou bien directement
sur les écrans back-office, comme vous souhaitez.

Est-ce que ça vous convient ?
```

**[PANNEAU]** — c'est un ordre que vous proposez, donc une question fermée :
*Oui, on démarre sur « Création de compte »* / *Démarrer par un autre écran*. L'option
libre sert à imposer un ordre complet.

L'utilisateur voit tout de suite comment on va progresser, et il garde la main sur
l'ordre des groupes.

---

## Étape 4 — Écran par écran

Un écran à la fois. Pour chaque écran, vous affichez **une proposition complète** :

```
| **PRESTA — Spec écran** | |
|---|---|
| Écran | E-01-CREATION-COMPTE — 1/3 du groupe « Connexion » |
| URL | /inscription |

[le schéma texte, avec les annotations à droite, dans un bloc de code]

---

**Autres états de l'écran**

- ...

---

**Erreurs possibles**

- ...

---

**Actions utilisateur**

- ...

---

**Éléments visuels** — seulement s'il y a un graphique, une image, une icône

- ...
```

**[PANNEAU]** — jusqu'à 4 questions, un appel `AskUserQuestion`, un onglet par question.
Le premier onglet est toujours « Est-ce que le contenu de cet écran vous convient ? »,
options : *Oui, ça convient* **(recommandée)** / *J'ai des corrections précises* / *Non,
je veux un écran différent*. Les onglets suivants portent les points de fond de l'écran
— l'affichage du temps, la fin, l'arrêt — chacun avec 3 à 4 options nommées, la première
recommandée. Mécanique générale dans « Le panneau de questions » plus haut.

Le schéma texte est **le seul élément que vous affichez dans un bloc de code** : c'est un
dessin monospace, son alignement ne survit pas au rendu markdown. Tout ce qui l'entoure
est du markdown rendu.

Les conventions du schéma texte et les gabarits par type d'écran — formulaire, liste,
tableau de bord, back-office arborescent — sont dans `references/schemas-ecrans.md`.
**Lisez-le avant de dessiner le premier écran.**

### Les blocs, dans l'ordre

| Bloc | Contenu | Obligatoire |
|---|---|---|
| Schéma texte | L'écran, avec les annotations à droite précédées de `<-` | Oui |
| Autres états de l'écran | Vide, en chargement, en erreur, droits insuffisants — **uniquement ceux qui existent** | Oui, s'il y en a |
| Erreurs possibles | Les messages, rédigés, tels qu'ils s'afficheront | Oui, s'il y en a |
| Actions utilisateur | Le libellé exact affiché, entre guillemets, plus l'URL de destination | Oui |
| Éléments visuels | Un graphique, une image, une icône : données, période, interaction, état sans données | Si applicable |
| Questions | **[PANNEAU]** — 4 maximum, un onglet chacune, la première toujours « Est-ce que le contenu de cet écran vous convient ? » | Oui |

### Les états se décrivent par leur déclencheur

Toujours **« Titre » : déclencheur → effet.** Le titre nomme l'état en deux ou trois
mots ; le déclencheur et l'effet s'enchaînent sans habillage de phrase. Un état écrit
sans son déclencheur (« pendant la création ») oblige le lecteur, et le sous-agent
d'implémentation, à deviner quand il survient.

> **Création en cours** : clic sur « Créer mon compte », création en cours →
> formulaire grisé, bouton remplacé par une animation d'attente et le texte
> « Création en cours ».

### Les annotations disent ce que le champ impose

Une annotation qui répète le libellé se supprime. Une annotation qui ferme une porte,
nomme une contrainte ou donne une destination se garde. Même test binaire que les
contrats d'usage de `/presta-modeles`.

- ✅ « Sert d'identifiant de connexion — une adresse e-mail = un seul compte »
- ✅ « Inactif tant que la case *J'accepte les conditions d'utilisation* n'est pas cochée »
- ✅ « Visible uniquement pour l'administrateur »
- ❌ « Champ adresse e-mail »

Les différences de rôle se notent **en annotation**, jamais en dupliquant l'écran.

### Les options s'énumèrent

Dès que l'utilisateur mentionne un filtre, un tri, un menu, une liste déroulante, un
statut ou un onglet, proposez le contenu complet et faites-le corriger :

```
Vous avez mentionné un filtre sur cet écran. Voici ce que je propose,
complétez ou retirez :

| | |
|---|---|
| Filtrer par | Tous les titres (par défaut) |
| | Titres en gain |
| | Titres en perte |
| Trier par | Valeur, la plus forte d'abord (par défaut) |
| | Nom du titre, A → Z |

Quand l'utilisateur revient sur l'écran plus tard, on retrouve son dernier
filtre, ou on repart sur les valeurs par défaut ?
```

**[PANNEAU]** — *On retrouve le dernier filtre* **(recommandée)** / *On repart des
valeurs par défaut à chaque fois*.

Si l'utilisateur répond qu'il verra plus tard, **n'insistez pas**. Écrivez
`À PRÉCISER — la liste des filtres et des tris` dans la section de l'écran, et passez à
la suite. Le point remontera à la clôture.

### Les décisions qui demandent une vérification

Quand une question ne peut pas se trancher sans mesurer ou essayer, ne la laissez pas
ouverte en silence — annoncez-la et faites valider :

```
On ne peut pas trancher la fréquence des cours sans connaître le coût des appels.
Je la note en décision en attente — D-03-FREQUENCE-COURS —
et on la règle avec /presta-essais-techniques avant l'implémentation.
Ça vous va ?
```

**[PANNEAU]** — *Oui, on la note en attente* / *Non, on la tranche maintenant*.

La numérotation `D-xx` continue de celle du rendez-vous. L'écriture se fait dans
`spec-technique.md`.

### Validation et écriture

**Le bloc « Questions » part au panneau**, jusqu'à 4 onglets — voir le gabarit ci-dessus.
Si une ou plusieurs réponses signalent un ajustement, un seul second tour, en texte,
reprend les points en suspens ensemble (mécanique commune décrite dans « Le panneau de
questions » plus haut ; le format de ce second tour est détaillé dans « Le message de
suivi » ci-dessous).

Quand l'utilisateur valide l'écran — au panneau, ou après le second tour —, **la
proposition de l'écran suivant part d'abord**, et la section de l'écran validé s'écrit
derrière — voir ci-dessous.

### L'écriture se place derrière le texte

**Un appel d'outil ne se place jamais juste après l'action de l'utilisateur.** Il vient de
valider : ce qu'il doit voir en premier, c'est du texte. Le fichier s'écrit derrière,
pendant qu'il lit.

L'écriture d'une section est donc **décalée d'un écran** :

| Il valide | Vous affichez | Vous écrivez, dans le même message, après le texte |
|---|---|---|
| E-01-CREATION-COMPTE | la proposition E-02-CONNEXION | la section E-01-CREATION-COMPTE |
| E-02-CONNEXION | la proposition E-03-MOT-DE-PASSE-OUBLIE | la section E-02-CONNEXION |

La proposition s'affiche au fil de l'eau : il lit dès la deuxième seconde, et l'écriture de
l'écran précédent est finie bien avant qu'il réponde. Écrire d'abord et proposer ensuite,
c'est la même durée totale avec une demi-minute d'écran vide au milieu.

Trois points à ne pas rater :

- **L'ordre dans le message ne se négocie pas** : le texte, puis l'appel d'écriture. Un
  appel d'outil placé avant le texte annule tout le bénéfice.
- **Un écran validé non écrit ne survit jamais à deux écrans.** On vide la file avant
  d'afficher autre chose : à la fin d'un groupe, sur une reprise de la liste (étape 5), et
  à la clôture. Une session interrompue ne doit jamais perdre un écran validé.
- **Rien ne s'écrit avant validation.** Le décalage ne change pas ça : la section écrite
  est toujours celle d'un écran validé, telle qu'elle a été affichée.

Au dernier écran d'un groupe, il n'y a rien à afficher derrière : l'écriture est seule.
Dites en une ligne ce qui s'écrit, et enchaînez.

### Le message de suivi

L'utilisateur a répondu : il valide une partie, il corrige un point, il pose une question.
**Vous ne rejouez pas la proposition.** Il vient de lire l'écran, il veut voir ce que sa
réponse a changé — pas le relire pour le retrouver.

```
**E-01-CREATION-COMPTE — ce qui change**

| | |
|---|---|
| 2 | La case *J'accepte les conditions d'utilisation* passe au-dessus du bouton. |
| 3 | Le bouton « Créer mon compte » reste actif ; l'erreur s'affiche après le clic. |
| 4 | Sans réponse de votre part, je le laisse tel quel pour l'instant. |

[le schéma texte redessiné, seulement s'il a changé]

**Questions restantes**

5. Sur la casse de l'adresse e-mail : ...
```

Quatre règles :

- **Une ligne par point touché, avec le numéro de l'utilisateur.** C'est ce qui lui
  permet de vérifier qu'il a été compris sans relire l'écran.
- **Seul le bloc modifié se redonne** — le schéma si le schéma bouge, la liste des
  erreurs si une erreur bouge. Jamais les cinq blocs parce qu'un seul a changé.
- **Les questions restantes gardent leurs numéros.** Une question nouvelle prend le
  numéro suivant. Repartir de `1.` à chaque tour rend impossible de répondre « 3 — ok »
  deux tours plus tard.
- **Ce qui n'a pas bougé ne se mentionne pas.** Pas de « le reste est inchangé » suivi
  d'un rappel de ce reste.

L'écran complet ne se réaffiche qu'à une condition : **l'utilisateur le demande**. Après
trois ou quatre tours de corrections, proposez-le une fois — « je vous réaffiche l'écran
complet avant qu'on le valide ? » — et attendez la réponse.

---

## Étape 5 — Si la liste des écrans change en cours de route

L'utilisateur peut à tout moment ajouter un écran, en supprimer un, ou demander d'en
découper un en deux. Dans ce cas :

1. **Si la numérotation bouge, reproposez la liste complète** avec la modification
   intégrée, exactement dans le format de l'étape 2 : c'est le décalage des `E-xx` qui
   justifie de tout re-lister. **Si elle ne bouge pas** — un écran ajouté en fin de
   liste, un écran marqué supprimé — deux lignes suffisent : ce qui entre, ce qui sort.
2. Faites-la valider — **[PANNEAU]**, même options qu'à l'étape 2.
3. **Revenez précisément là où vous en étiez**, en le disant : « On reprend sur E-06-SAISIE-TRANSACTION
   Saisie d'une transaction. »

Un numéro supprimé ne se réutilise jamais : l'écran est marqué supprimé.

**Avant de reproposer la liste, écrivez l'écran validé qui attend encore.** On ne sort pas
du fil des écrans avec une section en attente d'écriture.

---

## Étape 6 — La clôture, en trois temps

Trois blocs, séparés par une validation. Un seul bloc de cette taille ne se relit pas.

**Le dernier écran validé s'écrit ici**, avant la couverture : on n'entre pas dans la
clôture avec une section en attente.

### Temps 1 — la couverture

Affichez la liste des écrans tous cochés, puis **le contrôle de complétude**. Vous citez
les `F-xx` de `spec-produit.md` et les règles métier nommées au rendez-vous, et vous dites
lesquelles ne sont portées par aucun écran. Vous ne déclarez jamais « la spec est
complète » : vous montrez la couverture.

```
**Couvert**

| | |
|---|---|
| F-01-SUIVI-PORTEFEUILLE | E-04-TABLEAU-DE-BORD, E-05-MES-ACTIONS, E-08-DETAIL-ACTION |
| F-02-SAISIE-TRANSACTIONS | E-06-SAISIE-TRANSACTION |

---

**Pas couvert**

1. **F-04-EXPORT-CSV** : citée au rendez-vous, portée par aucun écran. On l'ajoute
   quelque part — un bouton « Exporter » sur E-05-MES-ACTIONS par exemple — ou elle
   passe en V2 ?
2. **Vente à découvert interdite** : règle nommée au rendez-vous, absente de tout
   écran. Devrait vivre sur E-06-SAISIE-TRANSACTION, avec son message d'erreur. On la
   traite maintenant ?

---

**Points laissés de côté en cours de route**

| | |
|---|---|
| E-05-MES-ACTIONS | La liste des filtres et des tris |
| E-09-LISTE-SYMBOLES | Ce qu'on affiche quand aucun symbole n'existe |

---

**Décisions en attente**, à régler avec /presta-essais-techniques

| | |
|---|---|
| D-03-FREQUENCE-COURS | Fréquence de rafraîchissement des cours |
| D-02-FOURNISSEUR-COTATION | Fournisseur de cotation retenu |

---

On règle ces points maintenant, ou on continue et vous y revenez plus tard ?
```

Ce qui reste ouvert part dans `elements-a-fournir.md` : c'est une tâche côté utilisateur,
et elle bloque l'écran concerné à l'implémentation.

### Temps 2 — la navigation

Affichez la navigation **en texte, en boîtes reliées par des flèches**, découpée par
espace. Si un espace est trop large, découpez-le encore. Format et exemple dans
`references/schemas-ecrans.md`.

Puis posez les questions que seul le graphe d'ensemble fait apparaître : un écran en
cul-de-sac, un écran qu'aucun chemin n'atteint, un retour manquant.

```
Trois choses à vérifier là-dessus.
```

**[PANNEAU]** — un onglet par point, 3 à 4 options nommées, la première recommandée :

| Onglet | Question | Options |
|---|---|---|
| Vente directe | Depuis E-08-DETAIL-ACTION, l'utilisateur ne peut que revenir en arrière. On lui permet d'enregistrer une vente directement depuis cet écran ? | *Oui, on ajoute un raccourci* **(recommandée)** / *Non, le retour arrière suffit* |
| Mot de passe | Aucun écran ne mène à E-03-MOT-DE-PASSE-OUBLIE depuis l'espace membre. Un utilisateur connecté qui veut changer son mot de passe passe par E-07-MON-COMPTE, c'est bien ça ? | *Oui, c'est le seul chemin* **(recommandée)** / *Non, il faut un lien direct* |
| Convient | Est-ce que la navigation vous convient dans son ensemble ? | *Oui, ça convient* **(recommandée)** / *J'ai des ajustements* |

**Dans le fichier, la navigation s'écrit en Mermaid**, jamais en texte. La version texte
sert à la conversation. Gabarit Mermaid dans `references/gabarits.md`.

### Temps 3 — la synthèse des accès

Annoncez d'abord que c'est une déduction, pas une nouvelle information :

```
Voici la synthèse des accès, déduite des écrans qu'on vient de détailler.
Rien de nouveau ici — c'est une relecture d'ensemble, pour repérer un accès
qui aurait été oublié ou mal placé.
```

Affichez les deux tableaux (gabarit dans `references/gabarits.md`), puis signalez ce que
la relecture fait apparaître — typiquement un écran accessible par un identifiant dans
l'URL, dont rien ne garantit qu'il appartient à l'appelant.

Terminez par la porte de validation — **[PANNEAU]** : *Oui, je valide, vous pouvez
écrire* / *J'ai des ajustements*.

---

## Étape 7 — L'écriture des fichiers

**Seulement une fois la porte de validation franchie.** Lisez `references/gabarits.md`.

| Fichier | Contenu |
|---|---|
| `presta/specs/spec-ecrans.md` | Les écrans (déjà écrits au fil de l'eau) + la navigation Mermaid |
| `presta/specs/generated/acces-par-role.md` | **Fichier généré.** Les deux tableaux d'accès, réécrits en entier |
| `presta/specs/spec-produit.md` | Fonctionnalités passées en V2, hors-scope découvert en cours de spec |
| `presta/specs/spec-technique.md` | Les décisions `D-xx` ouvertes pendant la spec |
| `presta/elements-a-fournir.md` | Les points laissés de côté, avec ce qu'ils bloquent |
| `presta/status.md` | `etape: specs` |
| `presta/regles-projet.md` | La règle de régénération (voir ci-dessous) |

**Tout fichier généré vit dans un sous-dossier `generated/`**, à côté de sa source. C'est
la convention de toute la méthode : on doit voir au chemin si un fichier se modifie à la
main ou pas.

Inscrivez dans `presta/regles-projet.md`, si elle n'y est pas déjà :

> Toute écriture dans `presta/specs/spec-ecrans.md` impose trois choses, dans cet ordre :
> son `maj:` passe à l'horodatage du moment (`date +%FT%T`, `version:` ne bouge pas) ;
> `presta/specs/generated/acces-par-role.md` est régénérée, avec ce `maj:` recopié tel quel
> dans son `source:` ; les aperçus et les lignes de `spec-ux.md` des écrans touchés sont
> signalés périmés, à régénérer avec `/presta-maquettes`.

Prenez l'horodatage avec `date +%FT%T`. Terminez en affichant les fichiers écrits avec
ce qu'ils contiennent, puis :

```
C'est en place.

| Fichier | Ce qu'il contient |
|---|---|
| presta/specs/spec-ecrans.md | 11 écrans, navigation Mermaid |
| presta/specs/generated/acces-par-role.md | synthèse des accès |
| presta/specs/spec-produit.md | F-04-EXPORT-CSV passée en V2 |
| presta/specs/spec-technique.md | D-03-FREQUENCE-COURS et D-02-FOURNISSEUR-COTATION en attente |
| presta/elements-a-fournir.md | 2 points à préciser |
| presta/status.md | étape : specs |
| presta/regles-projet.md | la règle de régénération de acces-par-role.md |


Prochaine étape : les modèles de données, avec /presta-modeles.
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

- Elle ne définit pas les champs ni les entités — c'est `/presta-modeles`.
- Elle ne définit pas le visuel : couleurs, typographie, largeurs, marges, ce qui est en
  onglet ou en pop-up — c'est `/presta-maquettes`. Elle note ce que l'utilisateur en dit
  spontanément, elle ne le demande jamais.
- Elle n'écrit aucun prompt de génération d'image : elle dit ce que l'image doit faire
  comprendre, `/presta-maquettes` en dérive le prompt une fois la direction artistique
  fixée.
- Elle ne tranche aucune décision technique qui demande une mesure ou un essai — elle
  ouvre une décision `D-xx` pour `/presta-essais-techniques`.
- Elle n'écrit pas de code et ne touche à aucun `settings.json`.
