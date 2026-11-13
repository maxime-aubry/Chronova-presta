# Gabarit de prompt design

Un prompt à copier-coller dans **Claude Design**, **Google Stitch** ou **Figma Make**.

Les trois prennent une consigne en langage naturel : le texte du prompt ne change pas d'un
outil à l'autre. Ce qui change, c'est ce qu'on peut y **rattacher** — Claude Design lit un
dépôt de code et des fichiers Figma, Figma Make vit dans Figma, Stitch part du prompt seul.

**D'où la règle qui commande tout : le prompt doit se suffire à lui-même.** Les valeurs
s'écrivent en toutes lettres dedans, jamais sous forme de renvoi à un fichier — sinon il ne
fonctionne que dans Claude Design.

---

## Quand on le propose

**Deux fois**, et à chaque fois en une seule phrase, sans liste d'écrans.

Une fois la direction visuelle retenue, en **alternative** aux dispositions HTML :

```
Si vous utilisez Claude Design, Google Stitch ou Figma Make, je peux vous
générer un « prompt design ». Vous pouvez me le demander avec votre choix
d'écran.
```

Puis **à la toute fin**, après l'écriture des fichiers, en complément de ce qui a été produit :

```
Si vous souhaitez affiner votre design avec Claude Design, Google Stitch ou
Figma Make, je peux vous générer un « prompt design ». Vous pouvez me le
demander avec votre choix d'écran.
```

Et entre les deux, à tout moment, écran par écran, quand l'utilisateur le redemande.

**Un prompt par écran.** Au-delà de deux ou trois écrans dans une même consigne, la cohérence
se dégrade. **Un prompt par espace** aussi, quand les espaces ont des directions distinctes.

---

## De quoi il se remplit

| Section | Source |
|---|---|
| Produit, à quoi il sert, pour qui, espace | `presta/specs/spec-produit.md` |
| Direction visuelle | `presta/maquettes/design-system.css` |
| Règles à respecter | `references/design-systems/<clé>.md`, do's & don'ts, plus les conventions de disposition de `design-system.md` si elles existent |
| Contenu de l'écran | la section de l'écran dans `presta/specs/spec-ecrans.md` |

**Le format ne se demande pas, il se déduit** du type d'application (`spec-technique.md`) :
application web ou application de bureau → écran de bureau, 1440 px. Application mobile →
format mobile, 390 px. Les deux seulement si le produit est explicitement les deux.

**Le prompt embarque un condensé, pas le CSS brut.** La moitié des variables ne se voient pas
dans une maquette — largeur de texte confortable, ombres subtiles, couleurs de survol. On garde
ce qui se regarde.

**Les données du tableau ou de la liste s'écrivent en vrai.** Jusqu'à dix lignes, on les met
toutes ; au-delà, cinq lignes suivies de « et N autres du même genre ». Jamais de lorem ipsum,
jamais d'« Exemple 1 » : c'est ce qui rend la maquette utilisable comme référence
d'implémentation.

---

## Le gabarit

```
Tu produis la maquette de l'écran « {nom} » pour {produit}, {une phrase sur ce
que fait le produit et pour qui}.

Espace : {public | membre | back-office}.   Format : {web bureau, 1440 px | mobile, 390 px}.

## Direction visuelle

{le parti pris en une phrase : l'ambiance, ce que ça évoque}

Couleurs
- Fond de page {#hex}, carte {#hex}, panneau élevé {#hex}
- Bordures {valeur} — {si la profondeur vient du filet ou de l'ombre}
- Titres {#hex}, corps {#hex}, secondaire {#hex}, mentions {#hex}
- Action principale {#hex}, avec du texte {#hex} dessus
- Accent décoratif {#hex} — {où il a le droit d'apparaître, et où il ne l'a pas}
- États : succès {#hex}, avertissement {#hex}, erreur {#hex}

Typographie
- {famille(s), et leur rôle}
- Titre d'écran {n} px graisse {n} · titre de carte {n} px graisse {n}
- Corps {n} px graisse {n} · étiquettes {n} px graisse {n}, {capitales ?},
  interlettrage {n}em
- Interlettrage des titres {n}em, interligne {n}

Formes et espacement
- Rayons : boutons et champs {n} px, cartes {n} px, pilules {n} px
- Espacement sur une base de {n} px : {les valeurs employées}
- Hauteur des contrôles {n} px, marge intérieure des cartes {n} px
- {les ombres, ou « aucune ombre portée »}

## Règles à respecter

{3 à 6 règles, formulées en interdits vérifiables}

## Contenu de l'écran

{Les éléments de haut en bas, avec les libellés exacts entre guillemets.
Reprendre le schéma texte de spec-ecrans.md. Ne rien laisser à l'invention de
l'outil : titres, boutons, en-têtes de colonnes, messages d'erreur, états vides.}

Données à afficher : {des valeurs réalistes, selon la règle des dix lignes.}

États à montrer : {l'état normal, et ceux qui comptent — vide, chargement, erreur}

## Ce qu'il ne faut pas faire

- Ne pas inventer de colonne, de bouton ou de fonctionnalité absente ci-dessus.
- Ne pas remplacer les libellés fournis par des équivalents.
- Ne pas ajouter de dégradé, d'illustration ni d'icône décorative non demandée.
- Ne pas dessiner de courbe ni de donnée chiffrée dans un graphique : poser un
  cadre légendé à la place.

## Attendu

{une maquette haute fidélité de cet écran, en {n} px de large}
```

---

## Ce qu'on dit en le donnant

Le prompt s'écrit dans `presta/maquettes/prompts/{ID}.md` et s'affiche dans la conversation.
On rappelle deux choses en le remettant :

- **Joindre `presta/specs/spec-produit.md` à l'outil** s'il accepte les fichiers. Le prompt se
  suffit à lui-même, mais la spec produit donne le contexte du produit entier — ce qu'il fait,
  pour qui, ce qu'il ne fait pas — et la maquette y gagne.
- Le prompt contient les valeurs **en toutes lettres**, ce qui le rend portable : Stitch et
  Figma Make ne lisent pas le dépôt.

---

## Trois pièges, dans l'ordre de fréquence

1. **Écrire « moderne », « épuré », « professionnel »** — ces mots ne contraignent rien et
   ramènent la moyenne d'internet. Chaque intention se traduit en valeur : une couleur, une
   graisse, un rayon.
2. **Laisser les libellés à l'outil** — il produira des textes plausibles mais faux, et c'est
   ce qui rendra la maquette inutilisable comme référence d'implémentation.
3. **Empiler les écrans dans un seul prompt** — un prompt par écran, ou par parcours court.
