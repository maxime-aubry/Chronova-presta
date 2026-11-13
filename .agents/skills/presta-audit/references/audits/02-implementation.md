# Audit 2 — Implémentation

Vous vérifiez que **tout ce que la spec écran déclare existe réellement dans le code**, et
que rien n'y traîne qui n'ait été spécifié.

C'est un contrôle d'**inventaire**, pas de comportement. Le cahier de recettes vérifie que
l'application fait la bonne chose ; vous vérifiez que la chose est là, branchée, et
atteignable. Un bouton qui existe et ne mène nulle part relève de vous ; un bouton qui mène
au bon endroit mais calcule faux, non.

---

## Vos fichiers

| | |
|---|---|
| `presta/specs/spec-ecrans.md` | En entier. C'est votre référence : écrans, actions, états, erreurs, options, navigation |
| `presta/specs/spec-ux.md` | L'habillage écran par écran, et les conventions `L-xx` qui s'y appliquent |
| `presta/specs/spec-produit.md` | **Seulement** la section hors-scope et V2 — ce qui ne doit pas exister |
| `presta/livrables/{livrable}/phases/index.md` | Ce que ce livrable devait porter |
| Le code | Les routes, les vues ou contrôleurs, les gabarits ou composants |

Ne lisez pas les modèles ni l'architecture : ce n'est pas votre angle.

**N'ouvrez pas les aperçus HTML de `presta/maquettes/apercus/`.** Ils servent à comparer le
rendu visuel, ce que vous ne faites pas.

---

## Ce que vous cherchez

| # | Critère | Ce qui se constate |
|---|---|---|
| 1 | **Chaque écran `E-xx` de la spec existe** — une route, une vue, un gabarit | Un écran spécifié dont rien ne porte l'URL |
| 2 | **Chaque action utilisateur déclarée est branchée** : le libellé existe dans le gabarit, et la destination existe dans les routes | Un bouton « Exporter » sans route derrière |
| 3 | **Aucun lien mort** : toute URL citée dans un gabarit correspond à une route déclarée | Un lien vers `/mot-de-passe-oublie` qu'aucune route ne sert |
| 4 | **Les états déclarés existent** : vide, chargement, erreur, droits insuffisants — ceux que la spec nomme, pas d'autres | Un tableau vide sans le message que la spec décrit |
| 5 | **Les messages d'erreur rédigés dans la spec sont dans le code**, au mot près | « Ce lien n'est plus valide » devenu « Lien invalide » |
| 6 | **Les options énumérées sont complètes** : filtres, tris, statuts, onglets, listes déroulantes, avec la valeur par défaut spécifiée | Trois options de tri sur les cinq spécifiées |
| 7 | **La navigation de `spec-ecrans.md` est réalisée** : chaque chemin du graphe existe, et le menu porte les entrées prévues | Un écran atteignable seulement en tapant l'URL |
| 8 | **Dans l'autre sens : un écran ou une route du code qu'aucune spec ne décrit** | Une page de debug oubliée, un écran ajouté sans spec |
| 9 | **Ce que `spec-produit.md` place hors périmètre ou en V2 n'existe pas** dans le code | Une amorce de fonctionnalité V2 à moitié branchée |

**Le critère 8 remonte souvent quelque chose et il faut le nuancer.** Une route technique —
santé du service, statiques, administration du framework — n'est pas un écran non
spécifié. Ne signalez que ce qu'un utilisateur peut atteindre et qui n'a pas de fiche.

**Le critère 5 se juge sur le fond, pas sur la ponctuation.** Un message reformulé qui dit
autre chose est un point ; une majuscule ou un point final qui diffère, non.

---

## Le partage avec les autres audits

| Ce que vous voyez | À qui c'est |
|---|---|
| Un écran accessible à qui ne devrait pas y entrer | **Audit 3** |
| Un calcul faux, une donnée mal formée | Ce n'est le sujet de personne ici — c'est le cahier de recettes et les tests |
| Un gabarit recopié au lieu d'être inclus | **Audit 4** |
| Un champ de la spec absent du modèle | **Audit 5** |
| Le code au mauvais endroit | **Audit 1** |

---

## Faux positifs à ne pas produire

- Réclamer un état que la spec ne décrit pas. **Vous contrôlez la spec contre le code, pas
  le code contre l'idée que vous vous faites d'un bon écran.**
- Signaler l'absence de ce qui est explicitement hors périmètre, en V2, ou dans un écart
  accepté du bloc « déjà connu ».
- Juger l'apparence, la disposition, les couleurs, l'espacement : ce n'est pas votre angle,
  et l'aperçu validé fait foi de toute façon.
- Signaler qu'un écran ne ressemble pas à sa maquette — vous n'ouvrez pas les aperçus.
- Réclamer une fonctionnalité d'un livrable ultérieur.
- Compter les écrans, les routes ou les actions dans une statistique. On veut ce qui
  manque, pas un taux de couverture.
