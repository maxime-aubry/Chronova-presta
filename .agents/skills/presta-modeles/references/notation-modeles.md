# Notation des modèles

La notation est **agnostique** : elle doit se lire de la même façon par quelqu'un qui
code en Python, en C# ou en TypeScript. Une base SQL est supposée dessous — les relations
passent donc par des identifiants.

---

## Le bloc d'entité

```
Transaction
   string             Id
   string             PortfolioId
   string             SymbolId
   e_TransactionType  Type
   decimal            Quantity     // toujours positive — le sens vient de Type
   decimal            UnitPrice    // prix d'une unité, hors frais
   DateTime           ExecutedAt   // date de l'opération, saisie par l'utilisateur
   string?            Note

   // Propriétés de navigation
   Portfolio  Portfolio
   Symbol     Symbol
```

Les règles de mise en forme :

- **Le nom du modèle est répété juste au-dessus des champs**, même si l'en-tête de la
  réponse le donne déjà. Le bloc doit se lire seul, une fois copié ailleurs.
- **Types et noms alignés en colonnes.** Un bloc désaligné ne se relit pas.
- **Les commentaires vont à droite**, précédés de `//`, et se poursuivent alignés sur la
  ligne suivante s'ils débordent.
- **Les propriétés de navigation sont groupées en fin de bloc**, sous
  `// Propriétés de navigation`. Elles ne portent jamais de commentaire.
- **Une entité tient sur un écran.** Au-delà de quinze champs, demandez-vous s'il n'y en
  a pas deux.

---

## Les types autorisés

| Type | Emploi |
|---|---|
| `string` | Texte, et **tous les identifiants** |
| `int` | Nombre entier de comptage — un rang, une durée en jours |
| `decimal` | **Tout montant et toute quantité.** `float` est interdit : il perd des centimes |
| `bool` | Vrai / faux |
| `DateTime` | Date, ou date et heure |
| `e_NomDuType` | Une énumération — voir plus bas |
| `Type?` | Le champ peut être vide. Le `?` porte le sens : il faut pouvoir dire ce que « vide » signifie |
| `List<Entité>` | Une propriété de navigation vers plusieurs |
| `Entité` | Une propriété de navigation vers une seule |

**L'argent est en `decimal`, dans son unité naturelle** — 140,50 et pas 14050. La
convention centimes existe et se défend, mais mélanger les deux dans un même projet
produit exactement le bug qu'on cherche à éviter. Un seul choix, tenu partout.

---

## Les énumérations

Dans le bloc de champs, le type porte le préfixe `e_` — on voit immédiatement que ce
n'est pas une entité :

```
   e_TransactionType  Type
   e_OrderStatus      Status
```

Elles se déclarent sous le bloc, une valeur par ligne, **sans le préfixe** :

```
Enums :

TransactionType
    Buy
    Sell

OrderStatus
    Draft
    Confirmed
    Shipped
    Cancelled
```

**Une énumération se déclare une seule fois**, à la première entité qui l'utilise. Dans
le fichier final, toutes les énumérations sont regroupées en fin de document.

**Énumération ou entité ?** Une liste figée que seul le développeur peut changer est une
énumération. Une liste que l'administrateur modifie depuis son interface est une entité.
C'est la seule question à poser, et elle se pose en scénario : « est-ce que
l'administrateur doit pouvoir en ajouter une depuis le back-office ? ».

---

## Le nommage

- **Entités et champs en anglais.** Commentaires en français. Cette question ne se pose
  jamais à l'utilisateur.
- **Entités au singulier** : `Transaction`, pas `Transactions`. Les propriétés de
  navigation vers plusieurs sont au pluriel : `List<Portfolio> Portfolios`.
- **Identifiant** : `Id` pour le sien, `{Entité}Id` pour une clé étrangère —
  `PortfolioId`, `SymbolId`.
- **Booléens** : `Is…`, `Has…`, `Can…` — `IsActive`, `HasVerifiedEmail`.
- **Dates** : `…At` pour un instant — `CreatedAt`, `ExecutedAt`, `EmailVerifiedAt`.
- **Jamais un mot du vocabulaire du code** pour un concept métier : classe, instance,
  objet, propriété, service, type. On dit « catégorie », pas « classe ».
- **Pas de terme nouveau sans notion nouvelle.** Une entité qui qualifie un modèle
  existant porte son nom : `SymbolCategory`, jamais `AssetCategory` — un mot inédit fait
  chercher une notion qui n'existe pas.
- **Un seul terme par concept**, répété à l'identique dans les specs, les questions et le
  code.

---

## Les contrats d'usage

**Le type d'un champ ne porte pas son contrat.** `DateTime ValidatedAt` dit la forme, pas
les règles d'emploi. Un agent lit le type et en déduit une permission qu'on ne lui a
jamais donnée — c'est ainsi qu'une date serveur finit comparée à une date venue du
navigateur, un bug invisible en lecture, invisible en test, qui ne se manifeste qu'en
production.

Pour chaque champ, la question est : **y a-t-il une règle d'usage que le type ne dit
pas ?**

| Famille | Ce que ça donne |
|---|---|
| Origine temporelle | `// horloge serveur — ne jamais comparer à une date client` |
| Unité | `// en jours calendaires, pas ouvrés` |
| Champ calculé | `// calculé — ne jamais écrire directement` |
| Copie figée | `// copie à la commande, ne pas resynchroniser depuis Client` |
| Sensibilité | `// ne jamais renvoyer au client, ne jamais logger` |
| Sens du null | `// null = jamais vérifié, ≠ compte désactivé` |
| Immuabilité | `// ne change plus après création` |
| Unicité | `// une adresse = un seul compte` |
| Signe et sens | `// toujours positive — le sens vient de Type` |

**Le test, binaire : le commentaire ferme-t-il une porte ?** S'il répète le nom du champ,
supprimez-le. Trois ou quatre commentaires sur une entité de dix champs est le bon ordre
de grandeur.

---

## Ce qu'on ne représente pas

| | Pourquoi |
|---|---|
| Les tables de liaison d'un plusieurs-à-plusieurs | `List<X>` des deux côtés suffit. La table est de l'implémentation |
| Les index et les contraintes de base | Idem — sauf l'unicité, qui est une règle métier et vit en commentaire |
| Les données calculées | Règle centrale : ce qui se déduit ne se stocke pas |
| Les tables techniques | Sessions, files d'attente, journaux applicatifs — elles viennent avec la stack |
| Le jeu de données de test | Il fait partie du socle, dans `/presta-phases` |

**Sur les données calculées, la seule exception admise est explicite** : l'utilisateur
demande le stockage pour une raison qu'il énonce, et le champ porte alors un commentaire
qui désigne la source de vérité — `// reconstructible depuis Transaction, qui fait foi —
ne jamais corriger à la main`.

**Avant d'ajouter un champ** : peut-il s'écrire comme une fonction pure des champs déjà
proposés, sans seuil arbitraire ni reconstitution d'un événement passé ? Si oui, il ne se
stocke pas — il va en « Je n'ai pas mis » avec sa formule. Si la déduction suppose un
seuil ou reconstitue pourquoi quelque chose s'est produit plutôt que ce qui s'est produit,
le champ reste légitime.

---

## Les natures d'entité qui reviennent

Pour proposer vite sans partir de rien.

**Le compte** — identité et accès.
```
User
   string     Id
   string     Email
   string     PasswordHash       // ne jamais renvoyer au client, ne jamais logger
   string     DisplayName
   bool       IsAdmin
   bool       IsActive           // bloque la connexion, ne supprime aucune donnée
   DateTime   CreatedAt
   DateTime?  EmailVerifiedAt    // null = jamais vérifié, ≠ compte désactivé
```

**Le référentiel** — une liste que quelqu'un administre.
```
Symbol
   string   Id
   string   Ticker        // identifiant du marché — unique
   string   Name
   string   Exchange
   bool     IsActive      // masqué à la recherche, conservé dans l'historique
```

**Le mouvement** — un fait daté, saisi par l'utilisateur. Il porte presque toujours deux
dates : celle de l'opération et celle de l'enregistrement. Les confondre est un classique.

**Le relevé** — une valeur mesurée à un instant, venue de l'extérieur.
```
Quote
   string    Id
   string    SymbolId
   decimal   Price        // dans la devise de cotation du symbole
   DateTime  QuotedAt     // date de la cotation, pas de la récupération
```
