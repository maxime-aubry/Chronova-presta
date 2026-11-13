# Les schémas d'écran en texte

Le schéma représente **le contenu et l'ordre**, pas la mise en forme. Ce qui reste à
décider ensuite, à l'étape maquettes : les couleurs, la typographie, les largeurs, les
marges, si le formulaire est centré ou dans une carte. Dites-le une fois, au premier
écran, sinon l'utilisateur discutera le visuel tout de suite.

---

## Conventions communes

**Le cadre.** L'écran est dans une boîte en traits simples. Largeur intérieure de 50 à 66
caractères selon le contenu : plus étroit pour un formulaire, plus large pour un tableau.
Gardez la même largeur pour tous les écrans d'un même projet.

**Les annotations.** À droite du cadre, précédées de `<-`, alignées entre elles. Elles
disent ce que l'élément **impose** : une contrainte, une destination, une restriction
d'accès, une origine de donnée. Une annotation qui répète le libellé se supprime.

**Les champs de saisie** sont des boîtes imbriquées, avec une valeur d'exemple dedans —
pas un libellé générique. `Jonathan`, `vous@exemple.com`, `••••••••`.

**Les boutons** sont des boîtes ou des crochets : `[ + Ajouter ]` en ligne,
`┌───┐ Créer mon compte └───┘` en pleine largeur.

**Les cases à cocher** : `[x]` ou `[ ]` suivi du libellé complet.

**Ne jamais dessiner la donnée.** Pas de courbe en ASCII, pas de camembert. Un graphique
est un cadre réservé, dimensionné à la place qu'il occupe.

| Nature | Représentation | Détail |
|---|---|---|
| Graphique | `[GRAPHIQUE] Titre` + une ligne de description, dans un cadre | Section « Éléments visuels » |
| Image | `[IMAGE] Nom` dans un cadre | Section « Éléments visuels » |
| Icône | `[icône]` sur sa ligne, ou un caractère évident : `[⋮]`, `[+]`, `[⚙]` | Jamais de cadre |

Un graphique déclare toujours, dans « Éléments visuels » : **ses données, sa période, son
interaction, et ce qu'il affiche sans données**.

---

## Gabarit 1 — Formulaire

```
    ┌──────────────────────────────────────────────────┐
    │                                                  │
    │                     DELTA                        │
    │                                                  │
    │              Créer votre compte                  │
    │      Suivez votre portefeuille en un coup        │
    │                   d'œil.                         │
    │                                                  │
    │   Nom d'affichage                                │
    │   ┌────────────────────────────────────────┐     │ <- Le nom affiché dans l'application,
    │   │ Jonathan                               │     │    modifiable ensuite dans « Mon compte »
    │   └────────────────────────────────────────┘     │
    │                                                  │
    │   Adresse e-mail                                 │
    │   ┌────────────────────────────────────────┐     │ <- Sert d'identifiant de connexion,
    │   │ vous@exemple.com                       │     │    une adresse e-mail = un seul compte
    │   └────────────────────────────────────────┘     │
    │                                                  │
    │   Mot de passe                                   │
    │   ┌────────────────────────────────────────┐     │ <- 8 caractères minimum, dont au moins
    │   │ ••••••••                               │     │    une majuscule et un chiffre
    │   └────────────────────────────────────────┘     │
    │   8 caractères minimum                           │
    │                                                  │
    │   [x] J'accepte les conditions d'utilisation     │ <- Page des conditions, url : /cgu
    │                                                  │
    │   ┌────────────────────────────────────────┐     │ <- Inactif tant que la case
    │   │            Créer mon compte            │     │    « J'accepte les conditions
    │   └────────────────────────────────────────┘     │    d'utilisation » n'est pas cochée
    │                                                  │
    │        Vous avez déjà un compte ? Se connecter   │ <- Redirige vers /connexion
    │                                                  │
    └──────────────────────────────────────────────────┘

Autres états de l'écran :
- **Champs invalides** : clic sur « Créer mon compte » avec un ou plusieurs champs
  invalides → erreurs affichées en rouge sous le champ concerné.
- **Création en cours** : clic sur « Créer mon compte », création en cours →
  formulaire grisé, bouton remplacé par une animation d'attente et le texte
  « Création en cours ».
- **Déjà connecté** : utilisateur déjà connecté ouvrant /inscription → redirigé vers
  le tableau de bord sans voir cet écran.

Erreurs possibles :
- Cette adresse e-mail est déjà utilisée. (avec un lien « Se connecter »)
- Le mot de passe doit contenir au moins 8 caractères, une majuscule et un chiffre.
- Les deux mots de passe ne sont pas identiques.
- Vous devez accepter les conditions d'utilisation.
- Connexion au serveur impossible, réessayez. (la saisie est conservée)

Actions utilisateur :
- Remplir le formulaire et cliquer sur « Créer mon compte »
- Cocher « J'accepte les conditions d'utilisation »
- Naviguer vers « conditions d'utilisation » (/cgu)
- Naviguer vers « Se connecter » (/connexion)
```

---

## Gabarit 2 — Liste, avec état vide

L'état vide se **dessine**, il ne se décrit pas. C'est en le dessinant qu'on voit qu'il
faut un texte et un bouton, pas un tableau à zéro ligne.

```
    ┌────────────────────────────────────────────────────────────────┐
    │  DELTA     Tableau de bord   Mes actions   Mon compte          │ <- Barre de navigation, présente
    │                                                                │    sur tous les écrans connectés
    │  Mes actions                                    [ + Ajouter ]  │ <- Navigue vers
    │                                                                │    /transactions/nouvelle
    │  ┌──────────────────────────────────────────────────────────┐  │
    │  │  [GRAPHIQUE] Évolution de la valeur du portefeuille       │  │ <- Courbe, 1 point par jour,
    │  │  courbe · 6 derniers mois · valeur totale en €            │  │    6 derniers mois
    │  └──────────────────────────────────────────────────────────┘  │
    │                                                                │
    │  Total investi 12 400 €    Valeur 13 950 €       +1 550 €      │ <- Calculé à partir des lignes,
    │                                                                │    jamais saisi
    │  Titre            Qté   Prix moyen    Cours    Valeur    Gain  │
    │  ───────────────────────────────────────────────────────────   │
    │  [icône] AAPL  Apple  12  150,00 €  172,30 €  2 067 € +14,9%   │ <- Ligne cliquable, navigue
    │  [icône] MSFT  Micro   5  310,00 €  298,10 €  1 490 €  -3,8%   │    vers /actions/{symbole}
    │                                                          [⋮]   │ <- Menu de la ligne : modifier,
    │                                                                │    supprimer
    │  Cours mis à jour il y a 4 minutes         [ Rafraîchir ]      │ <- Visible uniquement pour
    │                                                                │    l'administrateur
    └────────────────────────────────────────────────────────────────┘

  Quand l'utilisateur ouvre l'écran et qu'il ne détient aucune action :

    ┌────────────────────────────────────────────────────────────────┐
    │  DELTA     Tableau de bord   Mes actions   Mon compte          │
    │                                                                │
    │  Mes actions                                    [ + Ajouter ]  │
    │                                                                │
    │            ┌──────────────────────────────────┐                │
    │            │  [IMAGE] Portefeuille vide       │                │ <- Illustration, ton encourageant
    │            └──────────────────────────────────┘                │
    │                                                                │
    │              Vous ne détenez aucune action.                    │
    │        Enregistrez votre premier achat pour suivre             │
    │                  sa progression.                               │
    │                                                                │
    │                 [ Enregistrer un achat ]                       │ <- Même destination que
    │                                                                │    « + Ajouter »
    └────────────────────────────────────────────────────────────────┘

Autres états de l'écran :
- **Chargement** : ouverture de l'écran, lignes pas encore chargées → trois lignes
  grisées en attente, sans message.
- **Service de cours injoignable** : ouverture de l'écran, cotations indisponibles →
  tableau affiché avec « Titre », « Qté » et « Prix moyen » ; colonnes « Cours »,
  « Valeur » et « Gain » à « — » ; bandeau « Cours indisponibles pour le moment. »
- **Non connecté** : visiteur non connecté ouvrant /mes-actions → redirigé vers
  /connexion.

Éléments visuels :
- GRAPHIQUE « Évolution de la valeur du portefeuille » — courbe, un point par jour sur
  les 6 derniers mois, valeur totale en euros. Au survol d'un point : la date et la
  valeur. Aucune donnée sur la période : le cadre affiche « Pas encore d'historique ».
- IMAGE « Portefeuille vide » — illustration légère, doit dire « c'est le début », pas
  « il n'y a rien ». Sera produite à l'étape maquettes.
- ICÔNE de société — logo fourni par le service de cotation. Si le logo est absent, on
  affiche les initiales du symbole.
```

Les **quatre états à toujours interroger sur une liste** : aucune donnée, en chargement,
service injoignable, filtre qui ne renvoie rien. Le dernier est celui qu'on oublie : ce
n'est pas le même écran que « aucune donnée ».

---

## Gabarit 3 — Tableau de bord

Un tableau de bord est une grille de cadres. Chaque cadre est un contenu autonome, avec
son propre état vide.

```
    ┌────────────────────────────────────────────────────────────────┐
    │  DELTA     Tableau de bord   Mes actions   Mon compte          │
    │                                                                │
    │  Bonjour Jonathan                                              │
    │                                                                │
    │  ┌────────────────────┐ ┌────────────────────┐ ┌────────────┐  │
    │  │ Valeur du          │ │ Gain total         │ │ Lignes     │  │ <- Trois indicateurs calculés,
    │  │ portefeuille       │ │                    │ │            │  │    jamais saisis
    │  │ 13 950 €           │ │ +1 550 €  (+12,5%) │ │ 3          │  │
    │  └────────────────────┘ └────────────────────┘ └────────────┘  │
    │                                                                │
    │  ┌──────────────────────────────────────────────────────────┐  │
    │  │  [GRAPHIQUE] Répartition du portefeuille                  │  │ <- Camembert par titre,
    │  │  répartition par titre, en % de la valeur totale          │  │    sur la valeur actuelle
    │  └──────────────────────────────────────────────────────────┘  │
    │                                                                │
    │  Dernières transactions                     Tout voir          │ <- Navigue vers /mes-actions
    │  ───────────────────────────────────────────────────────────   │
    │  12/07  Achat   AAPL  12 titres   1 800 €                      │
    │  03/07  Vente   TSLA   5 titres   1 020 €                      │
    └────────────────────────────────────────────────────────────────┘

Autres états de l'écran :
- **Aucune transaction** : aucune transaction enregistrée → indicateurs à 0,
  graphique « Pas encore d'historique », liste remplacée par « Aucune transaction. »
  avec un bouton « Enregistrer un achat ».
```

---

## Gabarit 4 — Back-office arborescent

Pour un back-office à plusieurs niveaux, le menu se représente en liste imbriquée à
gauche, et l'écran courant à droite.

```
    ┌────────────────────────────────────────────────────────────────┐
    │  DELTA · Administration                        Jonathan  [⚙]   │ <- Accessible uniquement
    │                                                                │    au rôle administrateur
    │  ┌────────────────────┐ ┌─────────────────────────────────────┐│
    │  │ Référentiel        │ │  Symboles                           ││
    │  │  › Symboles        │ │                                     ││ <- L'entrée du menu en cours
    │  │  › Places          │ │  [ Rechercher…      ]  [ + Ajouter ]││    est mise en avant
    │  │  › Devises         │ │                                     ││
    │  │                    │ │  Symbole  Nom        Place  Actif   ││
    │  │ Utilisateurs       │ │  ────────────────────────────────   ││
    │  │  › Comptes         │ │  AAPL     Apple      NASDAQ  Oui    ││ <- Ligne cliquable, navigue
    │  │  › Rôles           │ │  MSFT     Microsoft  NASDAQ  Oui    ││    vers /admin/symboles/{id}
    │  │                    │ │  TSLA     Tesla      NASDAQ  Non    ││
    │  └────────────────────┘ └─────────────────────────────────────┘│
    └────────────────────────────────────────────────────────────────┘
```

Si l'arborescence vient d'un tableau à trois niveaux fourni par l'utilisateur, elle se
transpose telle quelle en liste imbriquée ou en tableau Markdown — on ne la redessine pas.

---

## La navigation, en boîtes

Affichée **dans la conversation uniquement**, à la clôture. Dans le fichier, la
navigation s'écrit en Mermaid.

Découpez par espace. Si un espace dépasse cinq ou six écrans, découpez-le encore par
parcours. Un écran cité dans un autre bloc apparaît sous son seul nom, sans cadre.

```
ESPACE PUBLIC

      ┌────────────────────────┐     ┌────────────────────────┐     ┌────────────────────────────┐
      │ E-01-CREATION-COMPTE   │◀───▶│ E-02-CONNEXION         │◀───▶│ E-03-MOT-DE-PASSE-OUBLIE   │
      │ /inscription           │     │ /connexion             │     │ /mot-de-passe-oublie       │
      └───────────┬────────────┘     └───────────┬────────────┘     └────────────────────────────┘
                  │ compte créé                  │ connexion réussie
                  └───────────┬──────────────────┘
                              ▼
                    E-04-TABLEAU-DE-BORD

ESPACE MEMBRE

                       ┌────────────────────────┐
                       │ E-04-TABLEAU-DE-BORD   │
                       │ /                      │
                       └───────────┬────────────┘
                    ┌──────────────┴──────────────┐
                    ▼                             ▼
      ┌─────────────────────────┐     ┌────────────────────────┐
      │ E-05-MES-ACTIONS        │     │ E-07-MON-COMPTE        │
      │ /mes-actions            │     │ /mon-compte            │
      └───────────┬─────────────┘     └────────────────────────┘
         ┌────────┴────────────────────┐
         ▼                             ▼
   E-06-SAISIE-TRANSACTION       E-08-DETAIL-ACTION
```

Ce que le graphe d'ensemble fait apparaître, et qu'il faut interroger :

- un écran en cul-de-sac, d'où l'on ne peut que revenir en arrière ;
- un écran qu'aucun chemin n'atteint ;
- un aller sans retour entre deux espaces ;
- une navigation conditionnée par un rôle, jamais rendue explicite.
