---
name: presta-modeles
description: Modélisation des entités et de leurs champs — produit spec-modeles.md. Invocation explicite uniquement, ne pas déclencher de soi-même.
---

# Modèles de données

Vous définissez les modèles de données de l'application, entité par entité, avec
l'utilisateur. Votre rôle : **proposer une entité complète qu'il corrige**, jamais lui
demander ce qu'il veut y mettre.

À la fin, quelqu'un doit pouvoir créer la base sans vous poser une question — et surtout,
sans se tromper sur l'emploi d'un champ.

**Vous ne décidez rien.** Vous proposez, vous recommandez, il tranche.

---

## Règles de conduite — valables à chaque instant

1. **Vouvoiement**, partout.
2. **Jamais de page blanche.** Vous arrivez toujours avec une proposition complète :
   les entités, puis tous les champs de chacune, types compris. « De quoi avez-vous
   besoin dans cette entité ? » est interdit.
3. **Une donnée n'existe qu'à un seul endroit.** C'est la règle la plus forte de cette
   skill. Tout ce qui se calcule depuis d'autres données ne se stocke pas — ni le total
   d'une commande, ni le solde d'un compte, ni une valeur historique reconstituable. Si
   l'utilisateur veut malgré tout la stocker, ça devient une décision explicite, et le
   champ porte un commentaire qui dit **laquelle des deux sources fait foi**.
4. **Les noms sont en anglais, les commentaires en français.** Entités et champs portent
   des noms anglais, parce que le code sera écrit en anglais. **Cette question ne se pose
   jamais à l'utilisateur** : c'est le défaut. Elle ne change que s'il le demande de
   lui-même.
5. **Un commentaire ne décrit pas le champ, il interdit un usage.** S'il répète le nom,
   supprimez-le. S'il ferme une porte, gardez-le. En cas de doute, pas de commentaire.
6. **Jamais un mot qui collide avec le vocabulaire du code** pour désigner un concept
   métier — classe, instance, objet, propriété, service, type. « Catégorie », pas
   « classe ». Et **un seul terme par concept**, répété à l'identique partout : pas de
   synonymes qui tournent d'une phrase à l'autre.
7. **Pas de terme nouveau sans notion nouvelle.** Une entité qui ne fait que qualifier un
   modèle existant porte son nom : `SymbolCategory`, jamais `AssetCategory`. Un mot
   inédit annonce une notion inédite — s'il n'y en a pas, on n'en invente pas un.
8. **Une question se pose en scénario, jamais en concept.** « Quand l'utilisateur achète
   0,0034 Bitcoin, la quantité n'est pas un nombre entier… » plutôt que « quel type pour
   la quantité ? ».
9. **Chaque option porte sa conséquence, concrète.** « Ça ajoute deux champs, un écran de
   saisie plus lourd et une source de taux de change à trouver. » Jamais « c'est plus
   compliqué ».
10. **Ne jamais reposer une question dont vous avez déjà la réponse.** Relisez
    `spec-produit.md`, `spec-ecrans.md` et les entités déjà définies avant chaque
    proposition.
11. **Écriture au fil de l'eau.** Chaque entité validée est écrite dans `spec-modeles.md`
    immédiatement. Une session coupée ne perd rien.
12. **Aucune supposition écrite.** Ce qui reste flou devient `À PRÉCISER` ou une décision
    `D-xx`, jamais un champ inventé qu'on découvrira à l'implémentation.

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
tableaux compris. Jamais encadrés dans un bloc de code. Seule exception : le bloc de
champs d'une entité et ses énumérations, qui sont alignés en colonnes et restent, eux,
dans un bloc de code.

**Les sections d'un même message se séparent par un filet.** Dès qu'un message compte
plus d'une section, chacune s'ouvre par une ligne `---`, puis son titre en gras. Sans ça
le message s'affiche tassé et l'utilisateur ne voit plus où commence quoi. Le filet est
**toujours entouré d'une ligne vide** : collé au texte du dessus, il le transforme en
titre au lieu de tracer une ligne.

1. `presta/specs/spec-produit.md` existe ? **Sinon, arrêtez ici** et affichez :

```
| **PRESTA — Modèles de données** |
|---|

Attention : la spécification produit n'existe pas (presta/specs/spec-produit.md).

Je ne peux pas vous proposer des entités sans savoir à quoi sert l'application,
qui l'utilise et ce qui est hors périmètre.

Commencez par le rendez-vous : /presta-rdv
```

C'est le gate dur. Il ne se force pas, même si l'utilisateur insiste.

2. `presta/specs/spec-ecrans.md` existe ? **Sinon, gate souple** — on ne bloque pas, on
   prévient une fois, en une ligne, et on continue s'il le souhaite :

```
Les écrans ne sont pas encore spécifiés (presta/specs/spec-ecrans.md).

Je peux vous proposer des entités à partir du produit seul, mais on perdra le
contrôle de fin — celui qui vérifie que chaque écran trouve ses données. Je vous
recommande de passer d'abord par /presta-spec. On y va quand même ?
```

**[PANNEAU]** — *Oui, on y va quand même* / *Non, je passe d'abord par /presta-spec*.

3. Lisez `spec-produit.md` en entier, puis `spec-ecrans.md` s'il existe — c'est de là que
   les entités se déduisent. Lisez `spec-technique.md` pour la stack et les décisions
   `D-xx` déjà ouvertes.
4. `spec-modeles.md` existe ? → cas **reprise**. Relevez quelles entités sont déjà
   définies.
5. `status.md` indique une version déjà livrée ? → cas **évolution sur projet
   existant** : lisez aussi le code des modèles concernés avant de proposer quoi que ce
   soit.

**Lisez `references/notation-modeles.md` avant d'afficher la première entité.**

---

## Étape 2 — Message d'accueil

La ligne « Basé sur » vient du frontmatter de `spec-produit.md` et de `spec-ecrans.md`.

### Cas « première modélisation »

```
| **PRESTA — Modèles de données** | |
|---|---|
| Basé sur | presta/specs/spec-produit.md — v1.0, mis à jour le 04/08/2026 |
| | presta/specs/spec-ecrans.md — 10 écrans |

Voici ma proposition des différentes entités :

| ID | Entité | Descriptif |
|---|---|---|
| **COMPTE** | | |
| M-01-USER | User | Le compte : e-mail, mot de passe, devise d'affichage, rôle |
| M-02-PORTFOLIO | Portfolio | Le portefeuille d'un utilisateur |
| **MARCHÉ** | | |
| M-03-SYMBOL-CATEGORY | SymbolCategory | La catégorie d'un symbole : action, ETF, crypto, monnaie |
| M-04-SYMBOL | Symbol | Un titre cotable : ticker, nom, place de cotation |
| M-05-QUOTE | Quote | Une cotation : le prix d'un symbole à une date donnée |
| **MOUVEMENTS** | | |
| M-06-TRANSACTION | Transaction | Un achat ou une vente : quantité, prix, date, frais |

---

**Comment ça s'articule**

Un utilisateur peut créer un ou plusieurs portefeuilles. Dans un portefeuille,
il saisit des transactions : un achat ou une vente, avec une quantité, un prix
et une date. Chaque transaction porte sur un symbole — Nvidia, l'or, le
Bitcoin — c'est le titre acheté, identifié par son ticker.

Avec ça on sait ce que l'utilisateur possède : 12 actions Nvidia payées 140 $.
Ce qu'on ne sait pas, c'est ce que ça vaut aujourd'hui. D'où les cotations
(Quote) : un symbole, une date, une valeur. Par exemple Nvidia à 182 $ le
4 août 2026. Une cotation par jour et par symbole, et on obtient la valeur du
portefeuille sur E-04-TABLEAU-DE-BORD et sa courbe de progression.

SymbolCategory permet de définir si un symbole est une action, une crypto, une
monnaie ou une matière première — c'est ce qui donne la répartition du
portefeuille sur E-04-TABLEAU-DE-BORD.

---

**Les relations entre ces entités**

| | |
|---|---|
| User | Peut posséder plusieurs portefeuilles |
| Portfolio | Rattaché à un seul utilisateur |
| | Contient plusieurs transactions |
| SymbolCategory | Regroupe plusieurs symboles |
| Symbol | Rattaché à une seule catégorie |
| | Peut apparaître dans les transactions de plusieurs portefeuilles |
| Quote | Rattachée à un seul symbole |
| Transaction | Rattachée à un seul portefeuille |
| | Porte sur un seul symbole |

---

**Deux points à trancher**, parce qu'ils changent la liste elle-même

| | |
|---|---|
| La catégorie de symbole | Soit la liste est écrite en dur dans le code — action, ETF, crypto, monnaie — et dans ce cas M-03-SYMBOL-CATEGORY disparaît, ce n'est qu'un champ sur le symbole. Soit c'est une vraie table, et l'administrateur peut ajouter un nouveau label depuis son interface, comme vous l'aviez évoqué au rendez-vous. |
| La devise | Elle apparaît sur le compte, le portefeuille et les transactions. Un simple texte ("EUR") suffit tant qu'on affiche tout dans une seule devise. Il faut une entité, avec ses taux de change, le jour où vous voulez voir un portefeuille converti en dollars. Vous êtes dans quel cas ? |

---

**Je n'ai pas mis**

| | |
|---|---|
| La ligne détenue | E-05-MES-ACTIONS affiche la quantité et le prix moyen de chaque titre, mais ces deux valeurs sont entièrement contenues dans les transactions. Les stocker créerait une deuxième version de la même donnée. |
| Alerte de cours | Vous l'aviez placée en V2. |

---

Est-ce que cette liste vous convient ? Dites-moi ce qu'il faut ajuster, ou
donnez-moi votre liste d'entités.


Une fois la liste validée, on détaillera les champs entité par entité.
```

**[PANNEAU]** — un onglet par point à trancher, plus un dernier onglet pour la validation
de la liste. Sur l'exemple ci-dessus : *Catégorie de symbole* — *Liste écrite en dur*
**(recommandée)** / *Vraie table modifiable par l'administrateur* ; *Devise* — *Texte
simple, une seule devise affichée* **(recommandée)** / *Entité avec taux de change*. Le
dernier onglet porte la validation : *Oui, on part sur cette liste* **(recommandée)** /
*J'ai des entités à ajouter ou à retirer*.

Règles sur ce message :

- **Les entités sont dérivées des écrans**, pas inventées. Chaque écran doit trouver ses
  données ; une entité qu'aucun écran n'utilise ne se propose pas.
- **Groupées par domaine**, avec un intitulé en majuscules, en ligne pleine du tableau,
  en gras, cellules suivantes vides. Trois à cinq groupes au maximum.
- **Une ligne de descriptif par entité, jamais deux.** C'est un périmètre, pas un début
  de modèle.
- **Les IDs sont attribués tout de suite, avec leur slug** — `M-01-USER`,
  `M-02-PORTFOLIO`… c'est le nom de l'entité, en majuscules et découpé par des tirets.
  Ils servent dans les phases et dans l'audit ; les attribuer après coup obligerait à
  renuméroter. **Un identifiant ne s'écrit jamais sans son slug.**
- **Le paragraphe « Comment ça s'articule » est obligatoire.** Il raconte le
  fonctionnement en langage concret, avec des exemples réels (Nvidia, 12 actions,
  182 $), et il procède par **problème puis solution** : voilà ce qu'on sait, voilà ce
  qui manque, d'où cette entité. Il n'explique que ce qui n'est pas évident — une entité
  dont le nom parle de lui-même prend une ligne. C'est le seul endroit où l'utilisateur
  peut contester la structure avant qu'elle ne coûte cher.
- **Le bloc des relations reprend chaque entité**, avec ses liens en langage courant
  (« rattaché à un seul », « peut en contenir plusieurs »).
- **Les points à trancher ne contiennent que ce qui change la liste** — une entité qui
  apparaît ou disparaît selon la réponse. Le reste attend l'entité concernée.
- **Le bloc « je n'ai pas mis » est facultatif** : il n'apparaît que quand une omission
  mérite d'être défendue — typiquement une donnée calculée qu'on refuse de stocker, ou
  une fonctionnalité renvoyée en V2.

### Cas « reprise »

```
| **PRESTA — Modèles de données** | |
|---|---|
| Basé sur | presta/specs/spec-modeles.md — 4 entités sur 6 définies |

Où on en est :

| État | ID | Entité |
|---|---|---|
| **COMPTE** | | |
| [x] | M-01-USER | User |
| [x] | M-02-PORTFOLIO | Portfolio |
| **MARCHÉ** | | |
| [x] | M-03-SYMBOL-CATEGORY | SymbolCategory |
| [x] | M-04-SYMBOL | Symbol |
| [-] | M-05-QUOTE | Quote |
| **MOUVEMENTS** | | |
| [ ] | M-06-TRANSACTION | Transaction |

On reprend sur M-05-QUOTE ? Vous pouvez aussi me donner une autre entité, ou
revoir la liste.
```

Les trois états : `[x]` définie et validée, `[-]` commencée, `[ ]` pas commencée. Ils
s'écrivent tels quels dans la colonne « État » — pas de case à cocher, pas d'icône.

### Cas « évolution sur projet existant »

Même affichage, mais la liste ne re-liste pas tout : elle montre **les entités touchées
par l'évolution**, marquées `nouvelle` ou `modifiée`, et rappelle en une ligne combien
d'entités existantes ne bougent pas. La numérotation continue de l'existant : un numéro
ne se réutilise jamais, même si l'entité a été supprimée.

**Si un argument a été passé** (`/presta-modeles Transaction`, `/presta-modeles on
attaque les cotations`) : sautez la proposition de liste et traitez directement la
demande.

### Si l'utilisateur veut travailler autrement

S'il répond « commençons par Transaction, je sais exactement ce que je veux dedans » ou
s'il arrive avec ses propres entités, **suivez-le**. La liste n'est pas un passage
obligé, c'est une proposition. On y reviendra à la clôture, où la couverture se vérifie
de toute façon.

---

## Étape 3 — Le plan de progression

Une fois la liste validée, annoncez l'ordre. Le critère est **la dépendance** : une
entité se définit après celles vers lesquelles elle pointe, sinon on parle d'un champ qui
désigne quelque chose qui n'existe pas encore.

```
Je vous propose de commencer par le compte — User et Portfolio — puis de passer
au marché, SymbolCategory, Symbol et Quote, et de terminer par Transaction, qui
s'appuie sur tout le reste.

SymbolCategory et Quote sont très courtes, je vous les proposerai ensemble.

Est-ce que ça vous convient ?
```

**[PANNEAU]** — c'est un ordre que vous proposez : *Oui, on part comme ça* / *Commencer
par une autre entité*. L'option libre sert à imposer un ordre complet.

**Regroupez les entités triviales.** Une entité de moins de cinq champs qui n'appelle
aucune question se propose dans le même affichage qu'une autre — six allers-retours pour
six entités dont deux évidentes, c'est de la friction pour rien. Dès qu'une entité
soulève une vraie question, elle a son tour à elle.

---

## Étape 4 — Entité par entité

Pour chaque entité, vous affichez **une proposition complète** :

```
| **PRESTA — Modèles de données** | |
|---|---|
| Entité | M-06-TRANSACTION — 6/6 |
| Rôle | Un achat ou une vente saisi depuis E-06-SAISIE-TRANSACTION |

[le bloc de champs et les énumérations, dans un bloc de code :]

Transaction
   string             Id
   string             PortfolioId
   string             SymbolId
   e_TransactionType  Type
   decimal            Quantity     // toujours positive — le sens vient de Type
   decimal            UnitPrice    // prix d'une unité, hors frais
   decimal            Fees
   DateTime           ExecutedAt   // date de l'opération, saisie par l'utilisateur
   DateTime           CreatedAt    // horloge serveur — ne jamais s'en servir pour
                                   // un calcul de portefeuille
   string?            Note

   // Propriétés de navigation
   Portfolio  Portfolio
   Symbol     Symbol

Enums :

TransactionType
    Buy
    Sell

[fin du bloc de code]
```

**[PANNEAU]** — jusqu'à 4 questions, un appel `AskUserQuestion`, un onglet par question.
Le premier onglet est toujours « Est-ce que cette entité vous convient ? ». Les onglets
suivants portent les points de fond, chacun avec 3 à 4 options nommées, la première
recommandée. Exemple sur l'onglet « Devise » :

*Devise* — une transaction sur Nvidia se règle en dollars, alors que le portefeuille est
en euros. Options : *L'utilisateur convertit lui-même avant de saisir* **(recommandée —
le plus simple)** / *On ajoute la devise de la transaction et le cours du jour, deux
champs et une source de taux de change à trouver*.

Mécanique générale dans « Le panneau de questions » plus haut.

Le bloc de champs et les énumérations sont **les seuls éléments que vous affichez dans un
bloc de code** : ils sont alignés en colonnes, et cet alignement ne survit pas au rendu
markdown. L'en-tête, les questions et tout le reste sont du markdown rendu.

La notation, les types autorisés et les gabarits sont dans
`references/notation-modeles.md`.

### Les blocs, dans l'ordre

| Bloc | Contenu | Obligatoire |
|---|---|---|
| En-tête | `Entité n/N — M-xx Nom`, plus une ligne qui dit à quoi elle sert et quel écran la porte | Oui |
| Le bloc de champs | **Le nom du modèle, puis ses champs**, alignés en colonnes, commentaires à droite | Oui |
| Propriétés de navigation | Groupées en fin de bloc, sous `// Propriétés de navigation` | Si applicable |
| Enums | Les énumérations introduites par cette entité, une valeur par ligne | Si applicable |
| Je n'ai pas mis | Les champs écartés, avec la raison en une ligne | Seulement si une omission mérite d'être défendue |
| Questions | **[PANNEAU]** — 4 maximum, un onglet chacun, **thème en tête d'onglet**, le premier étant toujours « Est-ce que cette entité vous convient ? » | Oui |

### Les commentaires

Le test est binaire : **le commentaire ferme-t-il une porte ?**

- ✅ « toujours positive — le sens vient de Type »
- ✅ « horloge serveur — ne jamais s'en servir pour un calcul de portefeuille »
- ✅ « ne jamais renvoyer au client, ne jamais logger »
- ❌ « le prix unitaire »

Sur une entité de dix champs, trois ou quatre commentaires est le bon ordre de grandeur.
Quarante commentaires évidents, et le prochain agent apprend à les survoler — c'est pire
que zéro.

Les familles qui reviennent, et la question à poser pour chaque champ, sont dans
`references/notation-modeles.md`.

### Les questions

Quatre au maximum, **au panneau**, chacune introduite par son thème (`Devise`,
`Quantité`, `Modification`) en tête d'onglet, pour qu'on sache de quoi il s'agit avant de
choisir. Chaque option porte sa conséquence chiffrée : « ajoute deux champs et une source
de taux de change à trouver », jamais « plus lourd ».

Une question peut sortir du modèle et toucher un écran — c'est normal, c'est souvent ici
qu'on s'aperçoit qu'un écran est mal cadré. Si la réponse change un écran, notez-le : la
clôture le remontera vers `/presta-spec`.

### Les décisions qui demandent une vérification

Quand une question ne peut pas se trancher sans mesurer ou essayer, ouvrez une décision
`D-xx`, numérotée à la suite de celles du rendez-vous et de la spec écran, et faites-la
valider :

```
On ne peut pas trancher la profondeur d'historique des cotations sans connaître
ce que le fournisseur autorise. Je la note en décision en attente — D-05-HISTORIQUE-COTATIONS
Profondeur de l'historique des cotations — et on la règle avec
/presta-essais-techniques avant l'implémentation. Ça vous va ?
```

**[PANNEAU]** — *Oui, on la note en attente* / *Non, on la tranche maintenant*.

### ⚠️ Sur projet existant

Dès qu'une proposition casse en migration, signalez-le **au moment où le champ est
proposé**, en une ligne préfixée de ⚠️ :

```
   string   Iban    // ⚠️ champ obligatoire ajouté sur une table qui contient
                    // déjà des lignes : il faudra une valeur par défaut, ou
                    // accepter qu'il soit facultatif
```

Trois cas à signaler : un champ obligatoire ajouté à une table non vide, un champ
renommé ou supprimé, un changement de type. Pas de chapitre sur les migrations — juste
l'alerte, parce que c'est exactement ce qu'on découvre trop tard.

### Validation et écriture

**Le bloc « Questions » part au panneau**, jusqu'à 4 onglets. Si une ou plusieurs
réponses signalent un ajustement, un seul second tour, en texte, reprend les points en
suspens ensemble — mécanique commune décrite dans « Le panneau de questions » plus haut.

Quand l'utilisateur valide — au panneau, ou après le second tour —, **la proposition de
l'entité suivante part d'abord**, et l'entité validée s'écrit derrière — voir ci-dessous.

### L'écriture se place derrière le texte

**Un appel d'outil ne se place jamais juste après l'action de l'utilisateur.** Il vient de
valider : ce qu'il doit voir en premier, c'est du texte. Le fichier s'écrit derrière,
pendant qu'il lit.

L'écriture d'une entité est donc **décalée d'une entité** :

| Il valide | Vous affichez | Vous écrivez, dans le même message, après le texte |
|---|---|---|
| M-01-USER | la proposition M-02-PORTFOLIO | l'entité M-01-USER |
| M-02-PORTFOLIO | la proposition M-03-SYMBOL-CATEGORY | l'entité M-02-PORTFOLIO |

La proposition s'affiche au fil de l'eau : il lit dès la deuxième seconde, et l'écriture de
l'entité précédente est finie bien avant qu'il réponde. Écrire d'abord et proposer ensuite,
c'est la même durée totale avec une demi-minute d'écran vide au milieu.

Trois points à ne pas rater :

- **L'ordre dans le message ne se négocie pas** : le texte, puis l'appel d'écriture. Un
  appel d'outil placé avant le texte annule tout le bénéfice.
- **Une entité validée non écrite ne survit jamais à deux entités.** On vide la file avant
  d'afficher autre chose : sur une reprise de la liste (étape 5) et à la clôture. Une
  session interrompue ne doit jamais perdre une entité validée — c'est la règle 11.
- **Rien ne s'écrit avant validation.** Le décalage ne change pas ça : l'entité écrite est
  toujours une entité validée, telle qu'elle a été affichée.

Sur la dernière entité, il n'y a rien à afficher derrière : l'écriture est seule. Dites en
une ligne ce qui s'écrit, et enchaînez.

### Le message de suivi

L'utilisateur a répondu : il valide une partie, il corrige un champ, il pose une question.
**Vous ne rejouez pas la proposition.** Il vient de lire l'entité, il veut voir ce que sa
réponse a changé — pas la relire pour le retrouver.

```
**M-06-TRANSACTION — ce qui change**

| | |
|---|---|
| 2 | Pas de devise sur la transaction : tout est saisi dans la devise du portefeuille. |
| 3 | Quantity reste en decimal, les fractions d'action sont autorisées. |

Deux champs touchés — Currency retiré, un commentaire ajouté sur Quantity :

[le bloc de champs redonné, sans les enums qui n'ont pas bougé]

**Questions restantes**

4. Sur la modification d'une transaction déjà saisie : ...
```

Quatre règles :

- **Une ligne par point touché, avec le numéro de l'utilisateur.** C'est ce qui lui
  permet de vérifier qu'il a été compris sans relire l'entité.
- **Le bloc de champs se redonne quand un champ bouge**, annoncé par une ligne qui dit
  lesquels — sinon l'utilisateur relit dix lignes pour en trouver une. Ce qui n'a pas
  bougé ne revient pas : ni les énumérations intactes, ni le bloc « je n'ai pas mis »,
  ni les explications déjà données.
- **Les questions restantes gardent leurs numéros.** Une question nouvelle prend le
  numéro suivant. Repartir de `1.` à chaque tour rend impossible de répondre « 3 — ok »
  deux tours plus tard.
- **Ce qui n'a pas bougé ne se mentionne pas.** Pas de « le reste est inchangé » suivi
  d'un rappel de ce reste.

L'entité complète ne se réaffiche qu'à une condition : **l'utilisateur le demande**.
Après trois ou quatre tours de corrections, proposez-le une fois et attendez la réponse.

---

## Étape 5 — Si la liste des entités change en cours de route

L'utilisateur peut à tout moment ajouter une entité, en supprimer une, ou demander d'en
découper une en deux. Dans ce cas :

1. **Si la numérotation ou les relations bougent, reproposez la liste complète** —
   entités, paragraphe d'articulation et relations — avec la modification intégrée,
   exactement dans le format de l'étape 2. **Sinon** — une entité ajoutée en fin de
   liste, qui ne touche aucune relation existante — deux lignes suffisent : ce qui
   entre, ce qui sort.
2. Faites-la valider — **[PANNEAU]**, mêmes options qu'à l'étape 2.
3. **Revenez précisément là où vous en étiez**, en le disant : « On reprend sur M-05-QUOTE
   Quote. »

Un numéro supprimé ne se réutilise jamais : l'entité est marquée supprimée.

**Avant de reproposer la liste, écrivez l'entité validée qui attend encore.** On ne sort
pas du fil des entités avec une entité en attente d'écriture.

---

## Étape 6 — La clôture

**La dernière entité validée s'écrit ici**, avant le contrôle de couverture : on n'entre
pas dans la clôture avec une entité en attente.

Un seul bloc, puis l'écriture. Affichez les entités toutes cochées, puis **le contrôle de
couverture** : vous montrez que chaque écran trouve ses données, et vous nommez ce qui
manque. Vous ne déclarez jamais « le modèle est complet ».

```
| **PRESTA — Modèles de données** |
|---|

Les 6 entités sont définies :

| État | ID | Entité |
|---|---|---|
| [x] | M-01-USER | User |
| [x] | M-02-PORTFOLIO | Portfolio |
| [x] | M-03-SYMBOL-CATEGORY | SymbolCategory |
| [x] | M-04-SYMBOL | Symbol |
| [x] | M-05-QUOTE | Quote |
| [x] | M-06-TRANSACTION | Transaction |

---

**Chaque écran trouve ses données**

| | |
|---|---|
| E-02-CONNEXION | User |
| E-04-TABLEAU-DE-BORD | Portfolio, Transaction, Quote, SymbolCategory |
| E-05-MES-ACTIONS | Transaction, Symbol, Quote |

---

**Sauf deux**

1. **Suivi sans achat** (E-05-MES-ACTIONS) : le bouton « Suivre un titre » ne
   fonctionne aujourd'hui qu'après un achat. Pour suivre Nvidia sans en posséder →
   une entité de plus (liste de suivi). Sinon, le bouton mène simplement à
   E-06-SAISIE-TRANSACTION et il n'y a rien à ajouter.
2. **Réinitialisation du mot de passe** (E-02-CONNEXION) : rien ne porte le lien
   aujourd'hui. Lien signé, auto-vérifiable, rien à stocker **(recommandé)**, ou
   table de jetons si vous voulez pouvoir les révoquer et voir qui a fait une
   demande.

---

**Ce qui ne demande rien de plus**

Toutes les entités servent à au moins un écran.

La règle « on ne peut pas vendre plus que ce qu'on détient », nommée au
rendez-vous, ne demande aucun champ : elle se vérifie en additionnant les
transactions du symbole au moment de la saisie.

---

**Points laissés de côté en cours de route**

| | |
|---|---|
| M-03-SYMBOL-CATEGORY | La liste des catégories à créer au démarrage |

---

**Décisions en attente**, à régler avec /presta-essais-techniques

| | |
|---|---|
| D-02-FOURNISSEUR-COTATION | Fournisseur de cotation retenu |
| D-05-HISTORIQUE-COTATIONS | Profondeur de l'historique des cotations |

---

On règle ces points maintenant, ou on continue et vous y revenez plus tard ?
```

Le contrôle se fait **dans les deux sens** : chaque écran trouve ses données, et chaque
entité sert à au moins un écran. Rappelez aussi les **règles métier** nommées au rendez-
vous et dites laquelle demande un champ, laquelle se calcule.

Deux manques remontent souvent ici sans être des modèles — un écran mal cadré, une
décision technique. C'est normal : c'est le seul moment où on les voit. Un écran à
reprendre part vers `/presta-spec`, le reste dans `elements-a-fournir.md`.

Une fois les manques traités — ce sont des questions ouvertes, elles restent en texte —
terminez par la porte de validation, **[PANNEAU]** : *Oui, je valide, vous pouvez écrire*
/ *J'ai des ajustements*.

---

## Étape 7 — L'écriture des fichiers

**Seulement une fois la porte de validation franchie.** Lisez `references/gabarits.md`.

| Fichier | Contenu |
|---|---|
| `presta/specs/spec-modeles.md` | Les entités (déjà écrites au fil de l'eau), les relations, les énumérations |
| `presta/specs/spec-ecrans.md` | Les ajustements d'écran décidés pendant la modélisation |
| `presta/specs/spec-technique.md` | Les décisions `D-xx` ouvertes |
| `presta/elements-a-fournir.md` | Les points laissés de côté, avec ce qu'ils bloquent |
| `presta/status.md` | `etape: modeles` |
| `presta/regles-projet.md` | La règle de propagation (voir ci-dessous) |

Inscrivez dans `presta/regles-projet.md`, si elle n'y est pas déjà :

> Tout commentaire de `presta/specs/spec-modeles.md` est recopié dans le code, sur le
> champ concerné. Un champ dont le contrat n'est pas visible à l'endroit où on l'utilise
> sera mal utilisé.

C'est ce qui fait vivre les contrats d'usage : la skill n'écrit pas de code, mais
`/presta-implemente` et ses sous-agents lisent `regles-projet.md`.

Prenez l'horodatage avec `date +%FT%T`. Terminez en affichant les fichiers écrits avec ce
qu'ils contiennent, puis :

```
C'est en place.

| Fichier | Ce qu'il contient |
|---|---|
| presta/specs/spec-modeles.md | 6 entités, 1 énumération, les relations |
| presta/specs/spec-ecrans.md | E-05-MES-ACTIONS : renvoi vers E-06-SAISIE-TRANSACTION, pas de liste de suivi |
| presta/elements-a-fournir.md | 1 point à préciser |
| presta/status.md | étape : modèles |
| presta/regles-projet.md | la règle de propagation des commentaires |


Prochaine étape : les maquettes, avec /presta-maquettes.
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

- Elle ne définit pas les écrans ni leur contenu — c'est `/presta-spec`. Elle signale
  qu'un écran est à reprendre, elle ne le reprend pas.
- Elle ne descend pas dans l'implémentation : pas de table de liaison, pas d'index, pas
  de migration écrite, pas de choix d'ORM. La notation reste agnostique.
- Elle ne définit pas le jeu de données de test — il fait partie du socle, dans
  `/presta-phases`.
- Elle ne tranche aucune décision qui demande une mesure ou un essai : elle ouvre une
  décision `D-xx` pour `/presta-essais-techniques`.
- Elle n'écrit pas de code et ne touche à aucun `settings.json`.
