# Gabarits des fichiers produits par `/presta-maquettes`

Règles communes :

- **Vouvoiement** dans tout ce qui s'adresse au lecteur.
- **Markdown pur.** Aucune image, aucune capture : les visuels sont les aperçus HTML.
- **Jamais le mot « token ».** On dit **variable**, ou **variable CSS**. Le mot est déjà
  pris par les modèles de langage, et la confusion se paie en incompréhension.
- **Aucune valeur inventée.** Une valeur qui n'a pas été validée n'apparaît pas, ou apparaît
  en `À PRÉCISER`.
- **Identifiants** : préfixe + numéro + slug, en majuscules, sans accents —
  `E-01-CREATION-COMPTE`, `M-06-TRANSACTION`, `D-02-FOURNISSEUR-COTATION`. Le slug fait
  1 à 3 mots significatifs, sans article. **Il n'existe pas de forme courte** : un
  identifiant s'écrit toujours en entier, partout, y compris dans la conversation. Le
  numéro ne change jamais et ne se réutilise jamais. Dans un nom de fichier, le même
  identifiant s'écrit en minuscules : `apercus/e-05-mes-actions.html`.
- **Une plage ne s'écrit pas avec des slugs** : on énumère les identifiants,
  séparés par des virgules. Jamais « L-01-… à L-04-… ».
- Les conventions de disposition suivent la même forme : `L-01-FILTRES-EN-BARRE`. Les
  identifiants d'écran sont repris de `spec-ecrans.md`, jamais renumérotés ici.
- Sur projet existant, ces fichiers se **modifient**. Jamais de copie `v1/`, `v2/`.
- **Le champ `base_specs`** de l'en-tête porte le `maj:` de `spec-ecrans.md` **recopié tel
  quel** au moment du dernier passage — jamais l'horloge du moment où on écrit ce
  fichier-ci, sinon il serait toujours postérieur et jamais détecté comme périmé. C'est ce
  qui permet à une reprise de dire « E-05-MES-ACTIONS a changé » sans relire tout le
  projet, et à `/presta-audit` de savoir que les aperçus ne reflètent plus les écrans.
- **Horodatage** : le champ `maj:` porte la date **et l'heure à la seconde**, en
  ISO-8601 — `2026-08-20T14:32:07`, obtenu avec `date +%FT%T`. C'est ce qui permet à un
  fichier dérivé de savoir qu'il est périmé : deux écritures du même jour se distinguent.
  Les noms de fichiers, eux, ne portent que la date.

---

## `presta/maquettes/design-system.css`

Le fichier **exploitable**, celui que lisent les gabarits d'aperçu et l'implémentation.

Format imposé : **exactement celui de `references/partis-pris/*.css`** — mêmes noms de
variables, même ordre, mêmes sections. Un fichier qui s'en écarte casse les deux gabarits.

```css
/* {Nom du projet} — {la direction en une phrase}
   Origine : parti pris « navy » / fourni par le client / extrait de {source}
   Document de lecture : design-system.md */
@import url('...');   /* seulement si une police web est employée */

:root {
  /* --- Couleurs : fonds et texte ------------------------- */
  ...
  /* --- Couleurs : marque --------------------------------- */
  ...
  /* --- Couleurs : sémantique ----------------------------- */
  ...
  /* --- Typographie --------------------------------------- */
  ...
  /* --- Espacement ---------------------------------------- */
  ...
  /* --- Rayons -------------------------------------------- */
  ...
  /* --- Ombres et relief ---------------------------------- */
  ...
  /* --- Densité et mise en page ---------------------------- */
  ...
}
```

Toute valeur **dérivée** — une couleur d'erreur qu'aucune source ne fournissait, par
exemple — porte un commentaire qui le dit. Sans ça, personne ne sait plus trois mois après
ce qui vient du client et ce qu'on a inventé.

---

## `presta/maquettes/design-system.md`

Le document que l'humain relit. Il double `design-system.css` en le rendant lisible, et il
porte ce que le CSS ne peut pas dire : les composants, les conventions, la stack, le ton.

**Il reste court.** Un design system de projet tient en 120 à 150 lignes. Au-delà, plus
personne ne le relit, et on est retombé dans le vibe coding avec une étape en plus.

````markdown
---
version: 1.0
maj: AAAA-MM-JJTHH:MM:SS
direction: {Navy | design system fourni | extrait de {source}}
base_specs: spec-ecrans.md — v1.0, AAAA-MM-JJTHH:MM:SS
source: rdv-NN — {label}
---

# Design system — {Nom du projet}

{Une à trois phrases : l'ambiance, ce que ça évoque, à qui ça s'adresse.}

**Espaces couverts** : {Espace membre, Back-office}
**Fichier exploitable** : `design-system.css`

## Variables

### Couleurs

| Rôle | Variable | Valeur | Employé pour |
|---|---|---|---|
| Fond de page | `--c-fond` | `#1c1624` | Toutes les pages, pleine largeur |
| Action principale | `--c-primaire` | `#00f575` | Le bouton principal, une fois par écran |
| Accent décoratif | `--c-accent` | `#b997ff` | Pilules et libellés de section. Jamais un bouton |

### Typographie

| Rôle | Famille | Taille | Graisse | Interlettrage |
|---|---|---|---|---|
| Titre d'écran | Inter | 24 px | 500 | −0.02em |
| Corps | Inter | 14 px | 450 | normal |

Police : {pile système | Google Fonts, `@import` dans `design-system.css`}.

### Formes, espacement, relief

- Rayons : boutons et champs {n} px, cartes {n} px, pilules {n} px
- Espacement sur une base de {n} px : {les valeurs employées}
- Hauteur des contrôles {n} px, marge intérieure des cartes {n} px
- {les ombres, ou « aucune — la profondeur vient des filets »}

## Composants

Un paragraphe par composant, en valeurs, pas en adjectifs.

### {Bouton principal}
{Fond, texte, rayon, marges, taille et graisse. Ce qui le distingue. Combien par écran.}

## Conventions de disposition

Les règles réutilisables, tirées de l'écran de référence. Elles répondent d'avance pour
tous les écrans qui n'y dérogent pas — c'est ce qui évite de discuter chaque écran.

| ID | Règle |
|---|---|
| L-01-FILTRES-EN-BARRE | Les filtres et les tris se présentent en barre au-dessus du tableau, en listes déroulantes. Jamais en colonne latérale. |
| L-02-CLIC-LIGNE-DETAIL | Un clic sur une ligne de tableau ouvre l'écran de détail correspondant. Pas de colonne d'action dédiée. |
| L-03-TRI-SYNCHRONISE | Les en-têtes de colonnes sont triables et restent synchronisés avec la liste déroulante « Trier ». |
| L-04-TABLEAU-EN-CARTES | Sous 900 px, tout tableau devient une liste de cartes, une par ligne. |
| L-05-MODALE-CONFIRMATION-DESTRUCTIVE | Les fenêtres modales sont réservées à la confirmation d'une action destructive. |

Une convention ajoutée en cours de projet **peut rendre caducs des aperçus déjà validés**.
Le cas échéant, la liste des écrans concernés est signalée à l'utilisateur.

## Contraintes de la stack

- **Librairie** : {daisyUI | Basecoat | Radzen | MudBlazor | aucune}
- **Composants disponibles** : {ce qu'on peut prendre tel quel}
- **Cher à personnaliser** : {ce qu'il vaut mieux ne pas tordre}
- **Où vivent les variables dans le projet** : {le fichier, et si elles s'expriment dans le
  système de thème de la librairie plutôt qu'en CSS libre}

Cette section évite de proposer de l'infaisable. Sans elle, on dessine des écrans que la
stack ne sait pas rendre.

## Ton éditorial

{Vouvoiement ou tutoiement, longueur des phrases, vocabulaire, formulation des erreurs.
Ne s'exprime pas en CSS, se lit dans les libellés.}

## À faire et à ne pas faire

### À faire
- {règles positives, vérifiables}

### À ne pas faire
- {interdits, vérifiables}

## Ce qui reste ouvert

- {ce qui n'a pas été tranché, et ce que ça bloque}
````

---

## `presta/specs/spec-ux.md`

L'habillage écran par écran. **Fichier séparé de `spec-ecrans.md`** : la spec écran dit ce
que fait l'écran, celle-ci dit comment il se présente. Les mélanger obligerait à réécrire
la spec à chaque décision de mise en page, et on perdrait la trace de qui a décidé quoi.

Écrit **au fil de l'eau**, comme `spec-ecrans.md`.

````markdown
---
version: 1.0
maj: AAAA-MM-JJTHH:MM:SS
direction: {Navy}
base_specs: spec-ecrans.md — v1.0, AAAA-MM-JJTHH:MM:SS
---

# Habillage des écrans — {Nom du projet}

Ce document ne redit pas ce que font les écrans — voir `presta/specs/spec-ecrans.md`.
Il dit comment ils se présentent, et ce que la mise en page a fait trancher.

## Table

| ID | Écran | Disposition | Conventions | Aperçu | Maj |
|---|---|---|---|---|---|
| E-05-MES-ACTIONS | Mes actions | Tableau pleine largeur, filtres au-dessus | L-01-FILTRES-EN-BARRE, L-02-CLIC-LIGNE-DETAIL, L-03-TRI-SYNCHRONISE, L-04-TABLEAU-EN-CARTES | `apercus/e-05-mes-actions.html` | 2026-08-05 |
| E-09-LISTE-SYMBOLES | Liste des symboles | Idem E-05-MES-ACTIONS | L-01-FILTRES-EN-BARRE, L-02-CLIC-LIGNE-DETAIL, L-03-TRI-SYNCHRONISE, L-04-TABLEAU-EN-CARTES | `apercus/e-09-liste-symboles.html` | 2026-08-05 |

---

## E-05-MES-ACTIONS — Mes actions

**Disposition** : tableau pleine largeur, barre de filtres au-dessus.
**Conventions appliquées** : L-01-FILTRES-EN-BARRE, L-02-CLIC-LIGNE-DETAIL, L-03-TRI-SYNCHRONISE, L-04-TABLEAU-EN-CARTES
**Dérogations** : aucune.

### Structure

De haut en bas :
- {élément}, {où il se place, et ce qui le distingue}

### Ce qui a été tranché ici

Les questions que la disposition a ouvertes, et leur réponse. Une ligne chacune.

- Clic sur une ligne → ouvre E-08-DETAIL-ACTION. Pas de colonne « Ouvrir ».
- Tri par en-tête de colonne **et** par la liste déroulante, les deux synchronisés.

### Responsive

Sous {n} px : {ce qui change}.

### Aperçu

`presta/maquettes/apercus/e-05-mes-actions.html` — validé le {date}.
````

**Une dérogation se justifie toujours.** « Déroge à L-01-FILTRES-EN-BARRE parce que l'écran n'a pas de
tableau » est une dérogation ; « déroge à L-01-FILTRES-EN-BARRE » tout court n'en est pas une, c'est un oubli.

---

## `presta/maquettes/prompts/{ID}.md`

Un prompt par écran, à coller dans un outil de maquettage. Gabarit et règles de remplissage
dans `references/gabarit-prompt-design.md`.

---

## Ce que la skill ajoute aux fichiers des autres skills

### `presta/elements-a-fournir.md`

Quatre besoins remontent presque toujours de la phase maquette. Ils s'ajoutent avec ce
qu'ils bloquent. **Le format du fichier est défini dans les gabarits de `/presta-rdv`** —
une puce `- [ ]`, dans la section de priorité qui convient. L'IA n'y coche jamais rien.

```markdown
- [ ] **Logo** — en SVG sur fond transparent. Bloque l'en-tête de tous les écrans : le
  prototype utilise un symbole provisoire en attendant.
- [ ] **Favicon** — en PNG 512×512 ou en SVG. Ne bloque rien, visible dans l'onglet.
- [ ] **Images de contenu** — {les écrans qui en affichent}. Bloque leur aperçu final.
- [ ] **Police commerciale {nom}** — la licence et les fichiers. Bloque la fidélité de
  tous les aperçus ; une police de repli est utilisée en attendant.
```

Les trois dernières n'apparaissent que si le projet les demande : pas d'image de contenu,
pas de ligne.

### `presta/status.md`

- `etape: maquettes`

### `presta/regles-projet.md`

- La direction retenue et sa date de figement.
- La règle de régénération :

> Toute modification d'un écran dans `spec-ecrans.md` impose de régénérer son aperçu et de
> mettre à jour sa ligne dans `spec-ux.md`.
