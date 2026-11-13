# Audit 5 — Data et points manquants

Deux sujets qui se tiennent : **les contrats d'usage des champs** sont-ils recopiés et
respectés dans le code, et **les dettes déclarées** — `// HYPOTHÈSE`, `// TODO phase N` —
sont-elles encore justifiées.

C'est l'angle qui trouve les bugs silencieux. Un champ dont le contrat dit « horloge
serveur, ne jamais s'en servir pour un calcul de portefeuille » et qui sert de clé de tri
ne casse rien de visible : il donne juste un ordre faux, un jour sur trente.

Et c'est l'angle le moins cher : un `// TODO phase 6` qui traîne alors que la phase 6 est
validée se trouve en une commande.

---

## Vos fichiers

| | |
|---|---|
| `presta/specs/spec-modeles.md` | **Les entités, leurs champs, leurs commentaires de contrat, leurs énumérations.** C'est votre référence |
| `presta/regles-projet.md` | La règle de propagation des commentaires dans le code |
| `presta/livrables/{livrable}/phases/index.md` | Quelles phases sont `validée` — c'est ce qui périme un `// TODO phase N` |
| `presta/livrables/{livrable}/description-livrable.md` | Les hypothèses forcées déclarées |
| `presta/specs/spec-technique.md` | Les décisions `D-xx` et leur statut |
| Le code | Les modèles, les migrations, les services qui manipulent ces champs |

---

## Ce que vous cherchez

### Bloc 1 — Les contrats de champ

`presta/regles-projet.md` porte cette règle, posée par `/presta-modeles` :

> Tout commentaire de `spec-modeles.md` est recopié dans le code, sur le champ concerné. Un
> champ dont le contrat n'est pas visible à l'endroit où on l'utilise sera mal utilisé.

| # | Critère | Ce qui se constate |
|---|---|---|
| 1 | **Chaque commentaire de contrat est-il recopié** dans le code, sur le champ ? | `CreatedAt` sans son commentaire dans le modèle |
| 2 | ⭐ **Chaque contrat est-il respecté** partout où le champ est employé ? | Un tri, un filtre ou un calcul qui utilise un champ que le contrat interdit pour ça |
| 3 | **Une donnée calculée a-t-elle été stockée** alors que la spec la refuse ? | Un `total` en base que les lignes suffisent à reconstituer |
| 4 | **Les champs du code et de la spec correspondent-ils ?** | Un champ du modèle absent de `spec-modeles.md`, ou l'inverse |
| 5 | **Les énumérations** : les valeurs du code sont-elles celles de la spec ? | Une valeur en plus, une valeur renommée, un ordre qui porte du sens et qui a changé |
| 6 | **Les types** : ce que la spec dit, ce que le modèle fait | Un `decimal` devenu flottant sur un montant |

**Le critère 2 est le plus rentable de cet audit.** C'est là qu'est le bug de date, et il
ne se voit qu'en croisant le contrat et ses usages. Pour chaque champ portant un contrat
restrictif, cherchez tous ses usages, et lisez-les.

### Bloc 2 — Les dettes déclarées

| # | Critère | Ce qui se constate |
|---|---|---|
| 7 | **Chaque `// HYPOTHÈSE` du code** correspond-il à une hypothèse forcée écrite dans `description-livrable.md` ? | Une hypothèse dans le code que le document ne connaît pas : personne ne la lèvera |
| 8 | **Chaque `// TODO phase N`** : la phase N est-elle encore à faire ? | Un `// TODO phase 6` alors que P-06 est `validée`. **Oubli certain** |
| 9 | **Les marqueurs nus** — `TODO`, `FIXME`, `HACK`, `XXX` sans phase ni hypothèse | Une dette que rien ne rattache à une décision |
| 10 | **Les contournements liés à une décision `D-xx`** : la décision est-elle passée `résolu` sans que le code ait suivi ? | L'envoi d'e-mails toujours en console alors que D-04 est tranchée |
| 11 | **Les valeurs en dur qui attendaient une décision** | Une durée, une clé de test, une URL de bac à sable restée dans le code |

**Le critère 8 est mécanique et il se trouve en une commande.** Ne le sautez pas parce
qu'il paraît trivial : c'est exactement le genre d'oubli qui part en production.

Un `// HYPOTHÈSE` correctement déclaré dans `description-livrable.md` **n'est pas un
point** : c'est une décision prise. Il figure d'ailleurs dans votre bloc « déjà connu ».

---

## Le partage avec les autres audits

| Ce que vous voyez | À qui c'est |
|---|---|
| Un champ « ne jamais renvoyer au client » qui fuit dans une réponse | **Audit 3** — c'est une fuite avant d'être un contrat |
| La même conversion de champ écrite trois fois | **Audit 4** |
| Un champ absent qui empêche un écran de fonctionner | **Audit 2** |
| Le modèle rangé au mauvais endroit | **Audit 1** |

Votre angle, c'est **le contrat et la dette**, pas la structure ni la confidentialité.

---

## Faux positifs à ne pas produire

- **Réclamer un commentaire sur un champ que `spec-modeles.md` n'en dote pas.** La méthode
  interdit les commentaires évidents : un champ sans contrat est un champ normal.
- Signaler un `// TODO` rattaché à une phase encore à faire, ou à un livrable ultérieur.
- Signaler une hypothèse forcée correctement déclarée. Elle est dans le « déjà connu ».
- Réclamer un champ de traçabilité — dates de création, auteur, version — que personne n'a
  spécifié.
- Signaler un écart entre le modèle et une migration ancienne : c'est l'état courant du
  modèle qui compte.
- Proposer une refonte du schéma. Vous signalez un écart entre la spec et le code, dans un
  sens ou dans l'autre.
