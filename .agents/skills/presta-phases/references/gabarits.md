# Gabarits des fichiers produits par `/presta-phases`

Règles communes :

- **Vouvoiement** dans tout ce qui s'adresse au lecteur.
- **Markdown pur.** Ça doit se lire en texte brut et se differ dans git.
- **Aucune supposition écrite.** Ce qui n'a pas été validé n'apparaît pas, ou apparaît en
  `point ouvert`.
- **Identifiants** : préfixe + numéro + slug, en majuscules, sans accents —
  `E-01-CREATION-COMPTE`, `M-06-TRANSACTION`, `P-03-COMPTES-ET-CONNEXION`. Le slug fait
  1 à 3 mots significatifs, sans article. **Il n'existe pas de forme courte** : un
  identifiant s'écrit toujours en entier, partout, y compris dans la conversation. Dans
  un nom de fichier, le même identifiant s'écrit en minuscules :
  `phases/p-03-comptes-et-connexion.md`.
- **Une plage ne s'écrit pas avec des slugs** : on énumère les identifiants, séparés par
  des virgules. Jamais « M-01-… à M-06-… ».
- **La numérotation des phases est unique sur toute la vie du projet.** Elle ne repart
  pas à 1 au livrable suivant, et un numéro ne se réutilise jamais.
- **Le statut d'une phase vit dans le champ `etat:` de son fichier**, et nulle part
  ailleurs. Ni l'index, ni `description-livrable.md` ne le portent.

Arborescence produite :

```
presta/livrables/v1.0-portefeuille-actions/
  description-livrable.md
  phases/
    index.md
    p-01-setup.md
    p-02-modeles-et-donnees.md
    ...
  rapports/          ← créé vide, rempli par /presta-setup et /presta-implemente
  recettes/          ← créé vide, un cahier de recettes par phase
    generated/       ← créé vide, recette-complete-v1.0.md régénérée en fin de livrable
  audits/            ← créé vide
```

`recettes/generated/recette-complete-v{version}.md` est la concaténation des cahiers de
recettes de chaque phase. C'est un fichier déduit : il ne se modifie jamais à la main, et
`/presta-implemente` le régénère en entier à la fin du livrable.
- **Horodatage** : le champ `maj:` porte la date **et l'heure à la seconde**, en
  ISO-8601 — `2026-08-20T14:32:07`, obtenu avec `date +%FT%T`. C'est ce qui permet à un
  fichier dérivé de savoir qu'il est périmé : deux écritures du même jour se distinguent.
  Les noms de fichiers, eux, ne portent que la date.

---

## `phases/p-xx-{slug}.md`

Écrit **au fil de l'eau** : chaque phase validée est écrite immédiatement, décalée d'une
phase (voir `SKILL.md`, étape 3).

````markdown
---
phase: P-03-COMPTES-ET-CONNEXION
livrable: v1.0-portefeuille-actions
etat: à faire
ecrans: [E-01-CREATION-COMPTE, E-02-CONNEXION]
modeles: [M-01-USER]
depend_de: [P-02-MODELES-ET-DONNEES]
maj: AAAA-MM-JJTHH:MM:SS
---

# P-03-COMPTES-ET-CONNEXION

{Deux ou trois lignes en langage courant : ce qu'on pourra faire une fois la phase
développée. Pas de vocabulaire technique, pas de liste de tâches.}

## Critères de validation

1. {**Titre en deux ou trois mots** : l'assertion, sans habillage de phrase, ancrée.
   « **Création compte valide** : E-01-CREATION-COMPTE, adresse valide + CGU cochées →
   compte rôle membre, redirection E-04-TABLEAU-DE-BORD. »}
2. ...

## Bouts non branchés

- {Ce qui reste en placeholder, et vers quelle phase. « Le lien *Mot de passe oublié*
  de E-02-CONNEXION mène à E-03-MOT-DE-PASSE-OUBLIE, développé en P-04-MOT-DE-PASSE.
  Placeholder *Écran à venir — P-04-MOT-DE-PASSE*. »}

## Points ouverts

- {Une décision `D-xx` en attente ou un élément à fournir, et **ce que ça rend non
  vérifiable**. « D-04-ENVOI-EMAILS : le lien de réinitialisation s'affiche en console
  en développement. Le critère 5 reste vérifiable, l'envoi réel ne l'est pas. »}
````

Le champ `etat:` vaut `à faire`, `en cours` ou `validée`. **`/presta-phases` l'écrit à
`à faire` et n'y retouche jamais** : il appartient ensuite à `/presta-setup` et
`/presta-implemente`.

Les sections `Bouts non branchés` et `Points ouverts` disparaissent quand elles sont
vides. Une section vide se lit comme un oubli.

---

## `phases/index.md`

````markdown
---
livrable: v1.0-portefeuille-actions
phases: 10
maj: AAAA-MM-JJTHH:MM:SS
---

# Phases — v1.0-portefeuille-actions

Le statut de chaque phase vit dans le frontmatter de son fichier. Cet index ne le porte
pas : il donne l'ordre et le regroupement.

## Socle

| ID | Phase | Contenu |
|---|---|---|
| P-01-SETUP | Setup | Projet initialisé, il se lance, l'agent y accède au navigateur |
| P-02-MODELES-ET-DONNEES | Modèles et jeu de données | M-01-USER, M-02-PORTFOLIO, M-03-SYMBOL-CATEGORY, M-04-SYMBOL, M-05-QUOTE, M-06-TRANSACTION, migrations, jeu de données |
| P-03-COMPTES-ET-CONNEXION | Comptes et connexion | E-01-CREATION-COMPTE, E-02-CONNEXION, droits par rôle |
| P-04-MOT-DE-PASSE | Mot de passe et compte | E-03-MOT-DE-PASSE-OUBLIE, E-07-MON-COMPTE |

{Le paragraphe de situation du bloc, tel qu'il a été validé en conversation.}

## Back-office

...

## Espace membre

...

## P-01-SETUP

Développée et validée par `/presta-setup`, pas par `/presta-implemente`. Elle porte ses
critères comme les autres et produit son rapport.
````

L'index se réécrit en entier à chaque fois que le découpage change. Il ne se modifie
jamais ligne à ligne.

---

## `description-livrable.md`

Le devis détaillé du livrable : **ce qui est dedans, ce qui ne l'est pas**. Ce n'est pas
le découpage — les phases vivent dans `phases/`, et ce fichier ne fait que pointer vers
elles.

Deux lecteurs : l'utilisateur, des semaines plus tard, quand il se demande ce qui a été
livré ; le sous-agent vérificateur, qui y lit ce qu'il doit contrôler.

````markdown
---
livrable: v1.0-portefeuille-actions
version: 1.0
etat: en cours
source: rdv-01 — création portefeuille actions
maj: AAAA-MM-JJTHH:MM:SS
---

# Livrable v1.0 — {Nom du projet}

{Trois ou quatre lignes : ce que ce livrable apporte, pour qui.}

## Écrans

| ID | Écran | État |
|---|---|---|
| E-01-CREATION-COMPTE | Création de compte | nouveau |
| E-05-MES-ACTIONS | Mes actions | nouveau |

## Modèles

| ID | Entité | État |
|---|---|---|
| M-01-USER | User | nouveau |

## Fonctionnalités

| ID | Fonctionnalité | État |
|---|---|---|
| F-01-SUIVI-PORTEFEUILLE | Suivi du portefeuille | nouveau |

## Ce qui n'est pas dans ce livrable

- F-04-EXPORT-CSV — export du portefeuille, passé en V2 au rendez-vous.
- {Ce qui a été explicitement écarté, avec la raison en une ligne.}

## Limites acceptées

- {Une limite décidée avec sa décision d'origine. « 25 appels par jour chez le
  fournisseur de cotation, soit 25 symboles suivis au maximum. Palier suivant à 15 $
  par mois. Décidé en D-02-FOURNISSEUR-COTATION. »}

## Découpage

{n} phases — voir `phases/index.md`.

## Hypothèses forcées

*(aucune à ce stade)*

## Écarts au périmètre

*(aucun à ce stade)*

## Journal de livraison

*(rempli à la livraison)*
````

La colonne **État** vaut `nouveau`, `modifié`, `inchangé` ou `supprimé`. Sur un premier
livrable, tout est `nouveau` et la colonne semble inutile — elle prend tout son sens au
livrable suivant, où elle dit au vérificateur ce qu'il doit retester.

**Sur un livrable d'évolution**, les tableaux ne listent que ce que l'évolution touche,
plus les écrans et entités qui le référencent, marqués `inchangé`. Un écran qu'aucun
chemin ne relie à l'évolution n'y figure pas.

### Ce que les autres skills y écrivent

`/presta-phases` crée ce fichier et écrit tout ce qui précède `Hypothèses forcées`.
**Elle n'y revient jamais.** Les trois dernières sections appartiennent à
`/presta-implemente`, qui n'y écrit **que ce qui s'écarte du devis** :

````markdown
## Hypothèses forcées

- **P-03-COMPTES-ET-CONNEXION** — l'envoi d'e-mail réel n'a pas été prouvé.
  D-04-ENVOI-EMAILS était encore en attente ; le lien de réinitialisation s'affiche en
  console en développement. Commentaire `// HYPOTHÈSE` posé dans le service d'envoi.
  **Reste à vérifier avant mise en production.**

## Écarts au périmètre

- **E-11-LISTE-UTILISATEURS** — la désactivation d'un utilisateur est livrée, la
  suppression ne l'est pas : elle casserait ses transactions. Écart signalé en
  P-07-UTILISATEURS, accepté le AAAA-MM-JJ.

## Journal de livraison

| Phase | Terminée le | Commit |
|---|---|---|
| P-01-SETUP | AAAA-MM-JJ | a3f19c2 |

Livré le AAAA-MM-JJ, tag `v1.0`.
Cahier de recettes cumulé : `recettes/generated/recette-complete-v1.0.md`.
Mise en production : `mise-en-production.md`.
````

Et l'en-tête passe à `etat: livré`.

**Ce qui ne va jamais dans ce fichier** : l'avancement des phases (il vit dans le champ
`etat:` de chaque phase), les critères de validation (ils vivent dans `phases/`), et le
détail de ce qui a été développé (c'est le rôle des rapports de phase). Trois copies de
la même information divergent toujours.

---

## `presta/status.md`

- `etape: phases` dans l'en-tête.
- `livrable_courant: v1.0-portefeuille-actions` — le nom du dossier créé sous
  `presta/livrables/`. C'est cette skill qui le pose ; les suivantes le lisent au lieu de
  recomposer `v{version}-{slug}` de leur côté.
