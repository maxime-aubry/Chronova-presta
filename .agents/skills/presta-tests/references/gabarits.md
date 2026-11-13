# Gabarits des fichiers produits par `/presta-tests`

Deux règles valables pour tous :

- **Un seul fichier fait autorité par fait.** La grille vit dans `spec-tests.md` et nulle
  part ailleurs. `AGENTS.md` porte les commandes, pas la grille. Les fichiers de phase ne
  portent rien de tout ça.
- **Horodatage** : le champ `maj:` porte la date **et l'heure à la seconde**, en ISO-8601 —
  `2026-09-11T14:32:07`, obtenu avec `date +%FT%T`. C'est ce qui permet à un fichier dérivé
  de savoir qu'il est périmé.

---

## `presta/specs/spec-tests.md`

Le fichier que lit le vérificateur de chaque phase. **Il doit tenir sans être relu deux
fois** : un vérificateur qui doit l'interpréter n'appliquera pas la même grille que le
précédent.

```markdown
---
projet: TimeTrackerPro
livrable: v1.0-suivi-temps-facturation
criteres: 243
maj: 2026-09-11T14:32:07
---

# Spécification de test — TimeTrackerPro

> Lisez ce fichier avant d'écrire le moindre test. La grille ci-dessous n'est pas une
> recommandation : c'est ce qui garantit que vingt et une phases écrivent les mêmes tests.

## La grille

Un critère se classe dans **une seule** ligne. Un critère qui en appelle deux va à la plus
coûteuse.

| Le critère demande | Mécanisme | Où ça vit |
|---|---|---|
| un message, une contrainte, un calcul, un refus | xUnit, objets en mémoire | `Services/` |
| une unicité, une cascade, une requête filtrée | xUnit + SQLite en mémoire | `Data/` |
| grisé, en italique, une colonne, un badge, un survol | bUnit | `Composants/` |
| une redirection, une garde de route, un code de retour | `WebApplicationFactory` | `Acces/` |
| un enchaînement qui n'existe que dans un navigateur | Playwright, trait `Category=Parcours` | `Parcours/` |
| « jamais réécrit », « aucun X dans un Y », un interdit de code | commande de recherche | `outils/conformite.sh` |
| une impression visuelle, un document imprimé | cahier de recettes | le vérificateur l'écrit |

## La convention de nommage

Tout test porte l'identifiant du critère qu'il prouve, en tête de son nom affiché :

    P-07/C-02 — nom en doublon refusé
    P-07/C-02 — nom en doublon refusé même si le client est archivé

`P-07` est la phase. `C-02` est le **rang** du critère dans la liste « Critères de
validation » de son fichier de phase — le deuxième critère porte `C-02`.

Trois conséquences :

- **Le préfixe est une clé de jointure, pas un identifiant unique.** Plusieurs tests
  partagent le même : c'est voulu. Découper vaut mieux qu'un gros test, parce qu'un test
  qui casse dit alors lequel des deux cas a régressé.
- **Un critère ajouté se met en fin de liste.** L'insérer au milieu décalerait le rang de
  tous les suivants, et les tests ne pointeraient plus au bon endroit.
- **Un critère sans test doit être justifié** — parti au cahier de recettes, ou marqué
  `bloqué` par le vérificateur. `outils/couverture.sh` le signale, il ne juge pas l'excuse.

## Les commandes

| | |
|---|---|
| Tests rapides | `./test.sh` — tout sauf les parcours |
| Parcours | `./test.sh --parcours` |
| Couverture des critères | `./outils/couverture.sh P-07` |
| Conformité structurelle | `./outils/conformite.sh` |

## Ce qui ne se teste pas automatiquement

Les critères ci-dessous vont au cahier de recettes. La liste est fermée : un critère qui
n'y figure pas et n'a pas de test est un oubli, pas un choix.

| Critère | Pourquoi |
|---|---|
| P-18/C-06 | La mise en page d'un PDF se juge à l'œil |
| P-18/C-07 | Idem — une facture longue, en-têtes répétés |

## Les mécanismes, et ce qui les a prouvés

| Mécanisme | Version | Preuve | Le gabarit à copier |
|---|---|---|---|
| xUnit | 4.0.0 | 1 test, 1 passé | `Services/GabaritUnitaire.cs` |
| SQLite en mémoire | — | entité créée, relue, contrainte levée | `Data/GabaritDonnees.cs` |
| bUnit | 2.10.3 | composant rendu | `Composants/GabaritRendu.cs` |
```

Quatre points à ne pas rater :

- **La grille se lit de gauche à droite, jamais l'inverse.** On part de ce que le critère
  demande, pas du mécanisme qu'on aimerait utiliser.
- **La colonne « Où ça vit » est ce qui range les tests.** Sans elle, le vérificateur de la
  phase 12 pose ses fichiers ailleurs que celui de la phase 3.
- **La section « Ce qui ne se teste pas » est fermée.** C'est ce qui permet au script de
  couverture de distinguer un choix d'un oubli.
- **La dernière section cite les versions prouvées**, avec le fichier gabarit. C'est ce
  qu'un agent frais copie.

---

## `outils/couverture.sh`

La garde. **Elle ne juge rien** : elle dit quels critères d'une phase n'ont aucun test qui
porte leur identifiant. L'excuse — cahier de recettes, critère bloqué — se lit dans le
rapport du vérificateur, pas ici.

```bash
#!/usr/bin/env bash
# Usage : ./outils/couverture.sh P-07
# Liste les critères de la phase qui n'ont aucun test portant leur identifiant.
set -euo pipefail

PHASE="${1:?usage: couverture.sh P-07}"
FICHIER=$(ls presta/livrables/*/phases/*.md | grep -i "$(echo "$PHASE" | tr 'A-Z' 'a-z')")
TOTAL=$(grep -c '^[0-9]*\. \*\*' "$FICHIER")

TESTS=$(./test.sh --liste 2>/dev/null || true)

MANQUE=0
for n in $(seq 1 "$TOTAL"); do
  ID=$(printf "%s/C-%02d" "$PHASE" "$n")
  if ! grep -q "$ID" <<< "$TESTS"; then
    echo "MANQUE $ID — $(grep '^[0-9]*\. \*\*' "$FICHIER" | sed -n "${n}p" | cut -c1-70)"
    MANQUE=$((MANQUE+1))
  fi
done

echo "---"
echo "$PHASE : $((TOTAL-MANQUE)) / $TOTAL critères couverts"
[ "$MANQUE" -eq 0 ]
```

Trois points :

- **La commande de listing des tests change avec la stack.** `--liste` ci-dessus est un
  exemple : adaptez-la à ce que l'outil retenu sait faire, et vérifiez qu'elle tourne avant
  d'écrire le fichier.
- **Le script sort en échec s'il manque un critère.** C'est ce qui le rend utilisable dans
  une boucle : un appel, un code de retour.
- **Il ne lit ni le code ni les rapports.** Il compare deux listes, et c'est tout ce qu'on
  lui demande.

---

## `AGENTS.md` — la ligne « Tests »

Elle remplace le renvoi posé par `/presta-setup`.

```markdown
| Tests | `./test.sh` — unitaires, données, rendu, accès |
| Parcours | `./test.sh --parcours` — navigateur, plus lent |
```

Plus une ligne sous le tableau, pas davantage :

```markdown
Les tests vivent dans `TimeTrackerPro.Tests`. La grille qui dit quel mécanisme prouve quel
critère est dans `presta/specs/spec-tests.md` — à lire avant d'écrire un test.
```

**`AGENTS.md` ne porte jamais la grille.** Un `AGENTS.md` de deux cents lignes n'est pas lu.

---

## `presta/regles-projet.md` — la carte des fichiers

Une ligne, à sa place dans la liste existante :

```markdown
- `presta/specs/spec-tests.md` — quel mécanisme prouve quel critère, et les commandes
```

Rien d'autre dans ce fichier. Les décisions figées n'en reçoivent pas : le choix d'un
mécanisme de test n'est pas une décision de produit.

---

## `presta/status.md`

Le frontmatter passe à `etape: tests`, et la section « Avancement des phases » reçoit une
ligne. Rien de plus : l'avancement des phases appartient à `/presta-implemente`.

```markdown
| Mécanismes de test | terminé — 6 mécanismes, 235 critères sur 243 |
```
