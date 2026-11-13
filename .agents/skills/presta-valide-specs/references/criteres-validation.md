# Critères de validation — les quatre relectures

Ce fichier porte tout ce qui est envoyé aux relectures : le squelette de prompt commun,
l'échelle de sévérité, et les quatre angles avec leurs fichiers, leurs critères et leurs
faux positifs.

**Une relecture = un angle = un contexte propre.** Elle ne reçoit jamais la conversation,
ni un résumé du projet, ni ce que les autres angles ont trouvé.

---

## L'échelle de sévérité

Elle est donnée telle quelle dans chaque prompt. Sans elle, chaque relecture invente la
sienne et la fusion devient impossible.

| Sévérité | Définition |
|---|---|
| `bloquant` | L'implémenteur ne peut pas commencer, ou il produira quelque chose de faux sans le savoir |
| `majeur` | Il devra inventer, et son invention se verra à la recette |
| `mineur` | Ça se règle en implémentant, sans risque |

Deux règles qui évitent l'inflation :

- **La sévérité se justifie par une conséquence écrite.** Un point dont on ne sait pas dire
  ce qu'il casse est un point à supprimer, pas à classer `mineur`.
- **Le doute descend d'un cran.** Une relecture qui hésite entre `bloquant` et `majeur`
  écrit `majeur`. La convergence entre angles remontera le point si elle a lieu.

---

## Le squelette de prompt

Identique pour les quatre. Seuls le bloc **Votre angle**, la **liste de fichiers** et les
**critères** changent.

```
Vous relisez les spécifications d'un projet que vous ne connaissez pas, pour
y trouver ce qui empêchera de l'implémenter correctement.

Vous n'avez pas participé aux conversations qui ont produit ces documents, et
c'est voulu : vous voyez exactement ce que verra le développeur. Ce qui n'est
pas écrit n'existe pas.

VOTRE ANGLE
{le bloc de l'angle — vous ne signalez que ce qui en relève}

FICHIERS À LIRE
{la liste exacte}

Ne lisez rien d'autre. Pas de code, pas de maquette, pas d'autre fichier du
dépôt.

DÉJÀ CONNU — ne le signalez pas
{le contenu de presta/elements-a-fournir.md et la liste des décisions D-xx
ouvertes dans spec-technique.md}

CE QUE VOUS CHERCHEZ
{les critères de l'angle, tels quels}

RÈGLES
- Un point n'existe que s'il est adossé à une citation exacte des specs. Sans
  citation, ne le signalez pas.
- Maximum 8 points. Les plus coûteux d'abord.
- Ne signalez rien qui relève d'un autre angle que le vôtre.
- N'inventez pas de solution longue : une suggestion tient en deux lignes.
- Ne reformulez pas les specs, ne les résumez pas, ne les commentez pas
  globalement, ne produisez aucune synthèse finale, ne félicitez personne.
- Si vous ne trouvez rien, renvoyez une liste vide. C'est un résultat.

SÉVÉRITÉ
bloquant — l'implémenteur ne peut pas commencer, ou il produira quelque chose
           de faux sans le savoir
majeur   — il devra inventer, et son invention se verra à la recette
mineur   — ça se règle en implémentant, sans risque
En cas d'hésitation, descendez d'un cran.

FORMAT DE SORTIE
Une fiche par point, rien avant, rien après :

  SÉVÉRITÉ : bloquant | majeur | mineur
  OÙ : les identifiants concernés (E-xx, M-xx, F-xx) et les fichiers
  CITATION : la phrase exacte des specs qui établit le point
  DÉFAUT : une phrase.
  CONSÉQUENCE : ce que ça produit concrètement à l'implémentation. Un fait
  observable, pas un adjectif.
  QUESTION : la question ouverte à poser à l'utilisateur.
  SUGGESTION : la réponse que vous recommanderiez, et pourquoi en une ligne.
```

Le bloc **DÉJÀ CONNU** est ce qui coûte le moins cher et rapporte le plus : sans lui, les
quatre relectures remontent les mêmes trous déjà identifiés et la fusion passe son temps à
les jeter.

---

## Angle A — Cohérence croisée

**Fichiers :** `spec-produit.md`, `spec-ecrans.md`, `spec-modeles.md`, `spec-technique.md`,
`specs/generated/acces-par-role.md`, **et tous les comptes-rendus de `presta/rdv/`**.

C'est le seul angle avec `spec-modeles.md` complet et les comptes-rendus : sans eux, il ne
peut pas dire qu'une règle nommée au rendez-vous n'a jamais atterri nulle part.

**Bloc « votre angle » :**

> Vous vérifiez que les documents disent tous la même chose, et que rien de ce qui a été
> décidé au rendez-vous ne s'est perdu en route. Vous ne jugez ni la complétude d'un écran
> pris isolément, ni le niveau de détail : uniquement les liens entre documents.

**Critères :**

| # | Ce que vous vérifiez |
|---|---|
| 1 | Chaque fonctionnalité `F-xx` de `spec-produit.md` est portée par au moins un écran, et chaque écran se rattache à au moins une fonctionnalité |
| 2 | Chaque règle métier nommée dans un compte-rendu de rendez-vous se retrouve quelque part : un écran qui l'applique, un message qui la signale, ou un champ qui la porte |
| 3 | **La chaîne de la donnée : entrée → stockage → effet.** Toute donnée saisie quelque part produit un effet visible ailleurs, et toute valeur affichée a une source — une saisie, un calcul, un import |
| 4 | Chaque écran trouve ses données dans les entités, et chaque entité sert à au moins un écran ou à une règle |
| 5 | Chaque rôle de `spec-produit.md` apparaît dans `acces-par-role.md`, et aucun écran n'y est absent |
| 6 | Rien n'implémente ce que `spec-produit.md` déclare hors périmètre ou renvoie en V2 |
| 7 | Les libellés cités sont identiques partout — un bouton qui change de nom entre l'écran, la navigation et la synthèse des accès |
| 8 | Un seul terme par concept : le même objet appelé « titre », « symbole » ou « actif » selon le document |
| 9 | Chaque décision `D-xx` ouverte a un porteur — l'écran, l'entité ou la fonctionnalité qui bascule selon la réponse |

**Le critère 3 mérite un mot**, c'est le meilleur détecteur de fonctionnalité fantôme dont
on dispose. Un réglage de back-office que rien ne lit, c'est un écran, un champ et des
tests à écrire pour une valeur sans effet. Deux garde-fous à donner dans le prompt :

- ça se signale **en question, jamais en constat** — « où agit ce réglage ? », pas
  « réglage inutile » ;
- **l'exception est nommée** : un réglage purement technique ou interne (clé d'API, adresse
  d'expédition des e-mails, niveau de journalisation) n'a pas à être représenté côté
  utilisateur. La relecture doit le reconnaître et se taire.

**Faux positifs à interdire :** signaler qu'un document ne répète pas ce qu'un autre dit
déjà — la redondance n'est pas un critère ; réclamer un identifiant `F-xx` sur des
fonctionnalités que `spec-produit.md` n'a jamais numérotées.

---

## Angle B — Trous de la spec-écran

**Fichiers :** `spec-ecrans.md` en entier, `spec-produit.md` (rôles et périmètre),
`specs/generated/acces-par-role.md`.

Pas les modèles : cet angle juge l'écran comme un tout autonome, et la liste des champs
n'ajoute que du bruit.

**Bloc « votre angle » :**

> Vous vous mettez à la place de celui qui doit construire chaque écran, aujourd'hui, sans
> pouvoir poser de question. Vous cherchez ce qui l'obligerait à s'arrêter. Vous ne jugez
> ni le produit, ni la cohérence avec les autres documents.

**Critères :**

| # | Ce que vous vérifiez |
|---|---|
| 1 | Chaque action utilisateur a une destination ou un effet écrit |
| 2 | Chaque écran a les états qui le concernent réellement : chargement, vide, erreur, droits insuffisants |
| 3 | Chaque erreur possible a son message rédigé, tel qu'il s'affichera |
| 4 | Chaque filtre, tri, menu, liste déroulante, statut ou onglet est énuméré en entier, avec sa valeur par défaut |
| 5 | Le cycle de vie est complet : ce qui se crée peut-il se consulter, se modifier, se supprimer — et depuis quel écran |
| 6 | La navigation tient : pas d'écran en cul-de-sac, pas d'écran qu'aucun chemin n'atteint, pas de retour manquant |
| 7 | Aucun lien ni aucune URL ne pointe vers un écran qui n'existe pas dans la liste |
| 8 | Les différences de rôle sur un écran sont dites : ce que chaque rôle voit et peut faire de plus |

**Faux positifs à interdire :** réclamer un état de chargement sur un écran statique ;
réclamer un écran de modification ou de suppression quand `spec-produit.md` le place hors
périmètre ; commenter la disposition, ce qui est en onglet ou en pop-up — ça ne relève pas
des specs.

---

## Angle C — Degrés de liberté

**Fichiers :** `spec-ecrans.md` et `spec-modeles.md` uniquement, plus `spec-technique.md`.

**Surtout pas les comptes-rendus de rendez-vous** : ils sont approximatifs par
construction, y chercher des mots élastiques produirait cent faux positifs.

**Bloc « votre angle » :**

> Vous cherchez tout ce qu'un développeur devra inventer faute d'une réponse écrite. Le
> test est unique : deux développeurs qui lisent cette phrase produisent-ils la même
> chose ? Si non, c'est un degré de liberté.

**Critères :**

| # | Ce que vous vérifiez |
|---|---|
| 1 | Les mots élastiques : « pertinent », « adapté », « le cas échéant », « etc. », « … », « notamment », « simple », « rapide », « sécurisé », « responsive » |
| 2 | Les quantités jamais chiffrées : combien d'éléments par page, quelle limite, quelle profondeur d'historique, quelle taille maximale |
| 3 | Les formats jamais fixés : date, heure, nombre, devise, arrondi, fuseau |
| 4 | Les tris et les valeurs par défaut : quel ordre à l'arrivée sur une liste, quelle option présélectionnée, quel état initial d'une case |
| 5 | Ce qui est retenu entre deux visites, et ce qui repart à zéro |
| 6 | Les validations jamais dites : ce qui est obligatoire, ce qui est unique, les longueurs et les bornes acceptées |
| 7 | Les champs de `spec-modeles.md` dont l'emploi est ambigu et qui ne portent pas de commentaire de contrat |

**La règle qui fait tout le travail de cet angle :** un degré de liberté ne se signale que
s'il coûte cher. Celui qui change un modèle, un écran, un contrat ou une règle métier, oui.
Le style d'une bordure, l'épaisseur d'un trait, le libellé exact d'un texte d'aide, non —
ça relève des maquettes ou du bon sens de l'implémenteur.

**Faux positifs à interdire :** réclamer une précision sur ce qui est explicitement renvoyé
à `/presta-maquettes` ; transformer chaque champ sans commentaire en point ; signaler un
mot vague dans un paragraphe d'introduction qui ne pilote aucune implémentation.

---

## Angle D — Le contradicteur

**Fichiers :** `spec-produit.md`, `spec-ecrans.md`, `spec-modeles.md`, **et tous les
comptes-rendus de `presta/rdv/`**.

**Bloc « votre angle » :**

> Vous ne vérifiez pas la conformité, vous cherchez ce qui ne pourra pas fonctionner une
> fois construit. Vous essayez de faire tourner l'application dans votre tête, depuis une
> base vide, et de trouver l'endroit où ça se coince.

**Critères :**

| # | Ce que vous vérifiez |
|---|---|
| 1 | **Le cas « rien »** : application fraîchement installée, base vide, aucun compte, aucune donnée de référence. Comment ça démarre ? C'est le trou le plus fréquent — un back-office suppose presque toujours un administrateur que rien ne crée |
| 2 | **Les dépendances impossibles** : un écran, une entité ou un parcours qui suppose quelque chose produit ailleurs par un chemin qui passe d'abord par lui |
| 3 | Le parcours principal se raconte-t-il de bout en bout, sans trou, du premier lancement jusqu'au résultat que l'utilisateur est venu chercher ? |
| 4 | Les données de référence : d'où viennent-elles, qui les crée, qui les met à jour, et que voit l'utilisateur tant qu'elles n'existent pas |
| 5 | Ce que personne ne spécifie jamais et qui se paie toujours : suppression d'un compte et devenir de ses données, réinitialisation d'un mot de passe, sessions, qui envoie les e-mails sortants, fuseaux horaires, devises, arrondis |
| 6 | Les volumes : un écran qui affiche « la liste » sans pagination quand la donnée grossit sans limite |

**Faux positifs à interdire :** proposer des fonctionnalités qui n'ont jamais été demandées
au motif qu'elles seraient utiles ; contester le concept du produit — le rendez-vous a déjà
tranché ; signaler l'absence de quelque chose que `spec-produit.md` place explicitement en
V2 ou hors périmètre.

---

## La fusion — rappel

Elle n'est pas faite par une relecture. La skill dédoublonne par ancre, remonte d'un cran
les points trouvés par plusieurs angles, sort ce qui est déjà connu, plafonne à 15 et
classe par sévérité. Le détail est à l'étape 4 du `SKILL.md`.
