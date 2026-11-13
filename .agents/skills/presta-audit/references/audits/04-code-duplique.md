# Audit 4 — Code dupliqué

Vous cherchez la même chose écrite deux fois.

**C'est le mode d'échec propre à la méthode.** Les phases sont développées par des
sous-agents à contexte frais, qui ne connaissent pas ce qui a été écrit trois phases plus
tôt. Ils réécrivent, de bonne foi, ce qui existait déjà. Un audit qui ne cherche pas ça
passe à côté de ce que l'architecture par phases fabrique toute seule.

Le cas qui coûte le plus cher n'est pas la duplication : c'est la **divergence**. Deux
implémentations de la même règle, dont une seule a été corrigée.

---

## Vos fichiers

| | |
|---|---|
| `presta/specs/spec-architecture.md` | La règle de duplication du projet et **son seuil chiffré** (`A-11-DRY-SEUIL-3` ou son équivalent) |
| `presta/specs/spec-architecture-complement-{stack}.md` | L'arborescence, pour savoir où chercher |
| `presta/livrables/{livrable}/phases/index.md` | L'ordre des phases — utile pour dire laquelle a réécrit l'autre |
| Le code | Services, vues, utilitaires, gabarits ou composants |

Ne lisez pas les specs d'écrans ni de modèles : vous comparez du code à du code.

---

## Ce que vous cherchez

| # | Critère | Ce qui se constate |
|---|---|---|
| 1 | **La même logique métier écrite deux fois ou plus**, dans des fichiers différents | Le calcul de la valeur d'un portefeuille dans un service et dans une vue |
| 2 | **Deux fonctions au nom différent qui font la même chose** | `compute_total` et `get_portfolio_value`, même corps à deux mots près |
| 3 | **Deux façons de récupérer la même donnée** | Une requête directe ici, un appel de service là, pour le même besoin |
| 4 | **Une constante ou une règle recopiée** | Un taux, un seuil, un format de date, une liste de statuts écrits en dur à plusieurs endroits |
| 5 | ⭐ **Deux implémentations qui divergent** — même intention, résultats différents | Un calcul qui inclut les frais, l'autre non. **Toujours `bloquant` ou `majeur`, jamais `mineur`** |
| 6 | **Un gabarit ou un fragment d'interface recopié** au lieu d'être inclus | Le même bloc de tableau dans trois gabarits, avec une colonne de plus dans l'un |
| 7 | **Une conversion, une validation ou un formatage réécrit** à chaque point d'usage | Le parsing d'un prix en texte fait à trois endroits, avec trois arrondis |

### Le seuil

Il vient de `spec-architecture.md`, en général trois occurrences. Respectez-le :

- **Trois occurrences ou plus** → point, quelle que soit la divergence.
- **Deux occurrences** → point **seulement si elles divergent** (critère 5), ou si la règle
  qu'elles portent est appelée à changer — un taux, une durée, un montant.
- **Deux occurrences identiques et stables** → pas de point. Factoriser à deux, c'est
  souvent créer un couplage pour rien.

### Le test qui départage une vraie duplication d'une ressemblance

**Si l'une des deux règles change, l'autre doit-elle changer aussi ?**

- Oui → c'est une duplication. Point.
- Non → c'est une ressemblance. Deux règles métier distinctes qui se ressemblent
  aujourd'hui. Les factoriser les couplerait à tort. **Pas de point.**

Ce test se pose sur chaque candidat, et il élimine la majorité des faux positifs de cet
angle.

---

## Comment chercher

1. Partez des **services et des utilitaires** : c'est là que vit la logique, et c'est là
   que la duplication coûte.
2. Puis des **vues ou contrôleurs** : le lieu classique où une logique de service est
   réécrite parce que le sous-agent ne l'a pas trouvée.
3. Cherchez par **intention**, pas par ressemblance textuelle. Les noms diffèrent presque
   toujours — c'est justement parce que le second auteur ne connaissait pas le premier.
4. **Ouvrez les deux emplacements avant de conclure.** Deux fonctions de même nom peuvent
   faire deux choses différentes ; deux corps différents peuvent faire la même chose.

---

## Le partage avec les autres audits

| Ce que vous voyez | À qui c'est |
|---|---|
| Du code au mauvais endroit, sans duplication | **Audit 1** |
| Deux contrôles d'autorisation qui divergent | **Audit 3** — la divergence y est une faille |
| Une requête refaite en boucle | **Audit 6** |
| Une valeur calculée stockée en base alors que la spec l'interdit | **Audit 5** |

Vous, vous ne signalez que **la même chose écrite plusieurs fois**.

---

## Faux positifs à ne pas produire

- **Deux morceaux qui se ressemblent et répondent à deux règles différentes.** C'est le
  faux positif dominant de cet angle : appliquez le test ci-dessus, systématiquement.
- Le code répétitif que le framework impose : déclarations de routes, migrations,
  configurations, fichiers générés.
- Les tests. Un test qui répète la mise en place d'un autre test n'est pas une duplication à
  corriger — la lisibilité d'un test prime sur sa factorisation.
- Deux appels identiques à une même fonction. Ça, c'est un usage, pas une duplication.
- Proposer une abstraction générique pour trois cas particuliers. Votre suggestion tient en
  deux lignes : quelle version garder, et qui appelle qui.
- Compter les lignes dupliquées ou produire un taux. On veut les emplacements.
