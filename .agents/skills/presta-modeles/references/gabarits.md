# Gabarits des fichiers produits par `/presta-modeles`

Règles communes :

- **Vouvoiement** dans tout ce qui s'adresse au lecteur.
- **Markdown pur.** Les entités sont des blocs de code. Pas de diagramme : les relations
  s'écrivent en texte, dans le même bloc que celui montré en conversation.
- **Aucune supposition écrite.** Ce qui n'a pas été validé n'apparaît pas, ou apparaît en
  `À PRÉCISER`.
- **Identifiants** : préfixe + numéro + slug, en majuscules, sans accents —
  `E-01-CREATION-COMPTE`, `M-06-TRANSACTION`, `D-02-FOURNISSEUR-COTATION`. Le slug fait
  1 à 3 mots significatifs, sans article. **Il n'existe pas de forme courte** : un
  identifiant s'écrit toujours en entier, partout, y compris dans la conversation. Le
  numéro ne change jamais et ne se réutilise jamais. Dans un nom de fichier, le même
  identifiant s'écrit en minuscules : `apercus/e-05-mes-actions.html`.
- Sur projet existant, ces fichiers se **modifient**. Jamais de copie `v1/`, `v2/`.
- **Horodatage** : le champ `maj:` porte la date **et l'heure à la seconde**, en
  ISO-8601 — `2026-08-20T14:32:07`, obtenu avec `date +%FT%T`. C'est ce qui permet à un
  fichier dérivé de savoir qu'il est périmé : deux écritures du même jour se distinguent.
  Les noms de fichiers, eux, ne portent que la date.

---

## `presta/specs/spec-modeles.md`

Écrit **au fil de l'eau** : chaque entité validée est ajoutée immédiatement. Les
relations et les énumérations sont consolidées à la clôture.

````markdown
---
version: 1.0
maj: AAAA-MM-JJTHH:MM:SS
source: spec-ecrans.md — v1.0, AAAA-MM-JJTHH:MM:SS
---

# Modèles de données — {Nom du projet}

## Liste des entités

| ID | Entité | Domaine | Rôle | État |
|---|---|---|---|---|
| M-01-USER | User | Compte | Le compte : e-mail, mot de passe, devise, rôle | validé |
| M-04-SYMBOL | Symbol | Marché | Un titre cotable : ticker, nom, place de cotation | validé |
| M-06-TRANSACTION | Transaction | Mouvements | Un achat ou une vente | validé |

La colonne **État** vaut `validé`, `en cours`, `à faire` ou `supprimé`.

## Comment ça s'articule

{Le paragraphe présenté à l'ouverture, tel quel — concret, avec des exemples réels,
problème puis solution. C'est ce qui permet à quelqu'un qui ouvre le fichier six mois
plus tard de comprendre le modèle sans le déchiffrer entité par entité.}

## Les relations

```
User            Peut posséder plusieurs portefeuilles
Portfolio       Rattaché à un seul utilisateur
                Contient plusieurs transactions
Symbol          Rattaché à une seule catégorie
                Peut apparaître dans les transactions de plusieurs portefeuilles
Transaction     Rattachée à un seul portefeuille
                Porte sur un seul symbole
```

---

## M-01-USER — User

**Rôle** : le compte utilisateur.
**Écrans** : E-02-CONNEXION, E-07-MON-COMPTE, E-11-LISTE-UTILISATEURS.

```
User
   string     Id
   string     Email
   string     PasswordHash       // ne jamais renvoyer au client, ne jamais logger
   string     DisplayName
   string     DisplayCurrency    // préférence d'affichage — ne jamais convertir
                                 // un montant stocké avec
   bool       IsAdmin
   bool       IsActive           // bloque la connexion, ne supprime aucune donnée
   DateTime   CreatedAt
   DateTime?  EmailVerifiedAt    // null = jamais vérifié, ≠ compte désactivé

   // Propriétés de navigation
   List<Portfolio>  Portfolios
```

### À préciser
- {Le point laissé de côté, en une ligne. Rubrique absente s'il n'y en a pas.}

---

## M-02-PORTFOLIO — Portfolio

...

---

## Énumérations

```
TransactionType
    Buy
    Sell
```

## Ce qui n'est pas stocké

| Donnée | Où elle s'affiche | D'où elle se calcule |
|---|---|---|
| Quantité et prix moyen d'une ligne détenue | E-05-MES-ACTIONS | Les transactions du symbole |
| Valeur du portefeuille | E-04-TABLEAU-DE-BORD | Les transactions et les cotations |

Cette section est **importante** : sans elle, le premier agent qui ouvre le fichier
recrée les champs manquants en croyant combler un oubli.
````

---

## Mises à jour des autres fichiers

### `presta/specs/spec-ecrans.md`

Les ajustements décidés pendant la modélisation — un écran dont la couverture a montré
qu'il promettait une donnée que rien ne porte. Une ligne dans la section de l'écran
concerné, avec la date.

Si l'ajustement est plus large qu'une ligne, ne le faites pas ici : dites à l'utilisateur
de repasser par `/presta-spec` sur cet écran.

**Écrire dans `spec-ecrans.md` engage trois choses** — `maj:` à l'horodatage du moment,
`acces-par-role.md` régénérée, les aperçus périmés signalés. La règle complète est dans
les gabarits de `/presta-spec`, section « La règle de propagation de `spec-ecrans.md` ».

### `presta/specs/spec-technique.md`

Les décisions ouvertes pendant la modélisation, dans la section « décisions techniques »,
numérotées `D-xx` à la suite des précédentes. Le format est celui de `/presta-rdv` :

```markdown
### D-05-HISTORIQUE-COTATIONS — Profondeur de l'historique des cotations
Statut : en attente
Enjeu : la courbe de progression de E-04-TABLEAU-DE-BORD suppose une cotation par jour et par symbole ;
le volume et le coût dépendent de ce que le fournisseur autorise en historique.
Piste : deux ans de recul suffisent peut-être — à vérifier.
Ouvert le AAAA-MM-JJ par /presta-modeles, entité M-05-QUOTE.
```

### `presta/elements-a-fournir.md`

Les points laissés de côté à la clôture, avec ce qu'ils bloquent. **Le format du fichier
est défini dans les gabarits de `/presta-rdv`** — une puce `- [ ]`, dans la section de
priorité qui convient. L'IA n'y coche jamais rien.

```markdown
- [ ] **Liste des catégories de symboles créées au démarrage** — à définir avec vous.
  Bloque le jeu de données initial de M-03-SYMBOL-CATEGORY, et l'affichage de la
  répartition sur E-04-TABLEAU-DE-BORD.
```

### `presta/status.md`

- `etape: modeles` dans l'en-tête.

### `presta/regles-projet.md`

- Dans les décisions figées, si elle n'y est pas déjà :

> Tout commentaire de `presta/specs/spec-modeles.md` est recopié dans le code, sur le
> champ concerné. Un champ dont le contrat n'est pas visible à l'endroit où on l'utilise
> sera mal utilisé.

- Et, si le projet a tranché des conventions durables pendant la modélisation — l'argent
  en `decimal`, la devise unique, l'absence de données calculées stockées — elles
  s'inscrivent ici, une ligne chacune.
