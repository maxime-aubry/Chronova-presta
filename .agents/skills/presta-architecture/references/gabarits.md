# Gabarits des fichiers produits par `/presta-architecture`

Règles communes :

- **Vouvoiement** dans tout ce qui s'adresse au lecteur.
- **Markdown pur.** Les arborescences sont des blocs de code, le reste est en tableaux.
- **Identifiants** : préfixe + numéro + slug, en majuscules, sans accents —
  `E-05-MES-ACTIONS`, `M-06-TRANSACTION`, `A-06-SANS-REPOSITORY`,
  `S-02-SERVICES-EN-DOSSIER`. Le slug fait 1 à 3 mots significatifs, sans article.
  **Il n'existe pas de forme courte** : un identifiant s'écrit toujours en entier, partout,
  y compris dans la conversation, et il se suffit à lui-même — on ne répète pas le libellé
  derrière. Le numéro ne se réutilise jamais et reste unique sur toute la vie du projet.
  Dans un nom de fichier, le même identifiant s'écrit en minuscules :
  `phases/p-03-comptes-et-connexion.md`.
- **Tout ce qui peut être enfreint porte un identifiant** : `A-xx-{SLUG}` dans le fichier
  agnostique, `S-xx-{SLUG}` dans le complément.
- **Aucune supposition écrite.** Ce qui n'a pas été validé n'apparaît pas, ou apparaît en
  `À PRÉCISER`.
- Sur projet existant, ces fichiers se **modifient**. Jamais de copie `v1/`, `v2/`.
- Rédaction concise. Les explications longues sont réservées aux points qui en demandent.

**Le nom du complément** porte le framework qui structure le code, pas le langage ni la
plateforme : `django`, `blazor`, `nextjs`, `laravel`. Pas `python`, pas `dotnet`. En
minuscules, sans point, sans numéro de version.
- **Horodatage** : le champ `maj:` porte la date **et l'heure à la seconde**, en
  ISO-8601 — `2026-08-20T14:32:07`, obtenu avec `date +%FT%T`. C'est ce qui permet à un
  fichier dérivé de savoir qu'il est périmé : deux écritures du même jour se distinguent.
  Les noms de fichiers, eux, ne portent que la date.

---

## `presta/specs/spec-architecture.md`

Indépendant de la stack. C'est le fichier qui suit le projet en cas de portage.

````markdown
---
version: 1.0
maj: AAAA-MM-JJTHH:MM:SS
complement: spec-architecture-complement-django.md
---

# Architecture — {Nom du projet}

Ce fichier est indépendant de la stack. Les dossiers, les noms de fichiers et les
conventions du framework sont dans le complément.

## Structure

{Nom de la structure retenue}. {Une à deux lignes : ce qu'elle sépare, et pourquoi.}

| Couche | Rôle | Interdits |
|---|---|---|
| Présentation | Affiche, reçoit les entrées | A-01-PRESENTATION-SANS-METIER — aucune règle métier, aucune requête composée |
| Contrôleur | Lit l'entrée, appelle un service, rend | A-02-CONTROLEUR-SANS-CALCUL — aucun calcul |
| Métier | Les règles du produit | A-03-METIER-SANS-HTTP — ne connaît ni HTTP ni gabarit |
| Données | Les modèles et leurs requêtes | A-04-DONNEES-SANS-RESEAU — aucun appel réseau |
| Intégration | Les services externes | A-05-INTEGRATION-DEPUIS-METIER — appelée depuis le métier uniquement |

A-06-SANS-REPOSITORY — Pas de couche repository. Toute requête autre qu'un accès par
identifiant est écrite avec le modèle, jamais dans une vue.

## Tâches de fond

{Qui déclenche, où vit le code, ce qui se passe en cas d'échec. Section absente s'il n'y
en a aucune.}

## Regroupement des fichiers

A-07-REGROUPEMENT-FONCTIONNALITE — Les fichiers se regroupent par fonctionnalité, pas par
type technique.
A-08-SANS-IMPORT-CROISE — Une fonctionnalité n'en importe jamais une autre. Ce qui est
partagé descend d'un niveau.

{Unités dont on sait ici qu'elles dépasseront le seuil de A-15 : elles se listent découpées
avant la première ligne de code, et s'écrivent ainsi dès leur première ligne. Un fichier
unique qu'une phase ultérieure démonte est un écart, pas une correction. Tableau absent
s'il n'y en a aucune.}

| Unité | Fichiers, dès l'écriture | Phase qui les crée |
|---|---|---|

## Parcours fonctionnalité

Les étapes, dans l'ordre. Les fichiers correspondants sont dans le complément.

**A — un écran qui affiche** — E-04-TABLEAU-DE-BORD, E-05-MES-ACTIONS,
E-08-DETAIL-ACTION, E-09-LISTE-SYMBOLES

1. La fonction qui prépare les données : requêtes et calculs
2. La vue, qui appelle cette fonction
3. La route
4. Le gabarit, repris de l'aperçu validé en maquette
5. Le test de la fonction
6. Le lien de navigation, si l'écran s'atteint par le menu

**B — un écran qui enregistre** — E-01-CREATION-COMPTE, E-06-SAISIE-TRANSACTION,
E-10-FICHE-SYMBOLE

{...}

**C — une synchronisation** — la récupération quotidienne des cours
(D-03-FREQUENCE-COURS)

{...}

A-09-SERVICE-AVANT-VUE — Le service est développé avant la vue. La vue dépend du service.

## Règles de code

| ID | Règle | Ce qui se constate |
|---|---|---|
| A-10-UNE-SEULE-FACON | Une seule façon de faire | Deux manières de récupérer des données coexistent |
| A-11-DRY-SEUIL-3 | DRY à partir de 3 | Le même code à trois endroits |
| A-12-YAGNI | YAGNI | Interface à une seule implémentation, option non utilisée |
| A-13-UN-SEUL-ENDROIT | Un seul endroit par sujet | Autorisation vérifiée hors du fichier prévu |
| A-14-ECHOUER-BRUYAMMENT | Échouer bruyamment | Un `catch` qui renvoie une valeur par défaut |
| A-15-UNE-RESPONSABILITE | Une responsabilité par fichier | Un fichier au-delà de {seuil} lignes — ou un fichier démonté après coup, alors que son dépassement était prévisible |

## Patterns

Aucun patron de conception n'est décidé à l'avance. Un patron s'ajoute le jour où un
problème le demande, et il est alors écrit ici.
````

---

## `presta/specs/spec-architecture-complement-{stack}.md`

````markdown
---
version: 1.0
maj: AAAA-MM-JJTHH:MM:SS
base: spec-architecture.md
stack: Django
version_stack: "6.1"
connaissance: non vérifiée — écrit d'après Django 6.0
source: annexes/architecture-system.md
---

# Complément Django — {Nom du projet}

Se lit avec `spec-architecture.md`. En cas de contradiction, ce fichier l'emporte.

⚠ Les conventions ci-dessous sont écrites d'après Django 6.0. Le projet est en
Django 6.1, et l'écart n'a pas été vérifié.

## Arborescence

```
delta/
  config/       réglages, urls racine, tâches planifiées
  accounts/     E-01-CREATION-COMPTE, E-02-CONNEXION, E-03-MOT-DE-PASSE-OUBLIE,
                E-07-MON-COMPTE, E-11-LISTE-UTILISATEURS
  portfolio/    E-04-TABLEAU-DE-BORD, E-05-MES-ACTIONS, E-06-SAISIE-TRANSACTION,
                E-08-DETAIL-ACTION
  market/       E-09-LISTE-SYMBOLES, E-10-FICHE-SYMBOLE, les cotations,
                la synchronisation quotidienne
  common/       ce qui sert à plusieurs applications
  templates/    base.html, en-tête, pied de page
  static/       design-system.css, images
```

## Contenu type d'une application

```
portfolio/
  models.py     M-02-PORTFOLIO, M-06-TRANSACTION
  views.py      une vue par écran
  forms.py      les formulaires
  services.py   les règles métier
  urls.py       les URLs de l'application
  templates/portfolio/
  tests/
```

## Où vivent les couches

| Couche de `spec-architecture.md` | En Django |
|---|---|
| Présentation | `templates/`, `forms.py` |
| Contrôleur | `views.py` |
| Métier | `services.py` |
| Données | `models.py` |
| Intégration | `integrations.py` |

## Parcours fonctionnalité — les fichiers

**A — un écran qui affiche**

| | |
|---|---|
| **1** | `services.py` — la fonction qui prépare les données |
| **2** | `views.py` — la vue |
| **3** | `urls.py` — la route |
| **4** | `templates/{app}/{ecran}.html` — le gabarit |
| **5** | `tests/test_services.py` — le test de la fonction |
| **6** | `templates/base.html` — le lien de navigation |

{Puis B, puis C.}

## Conventions Django

S-01-NOMS-EN-ANGLAIS — Les noms de dossiers et de fichiers sont en anglais.
S-02-SERVICES-EN-DOSSIER — `services.py` devient un dossier `services/` au-delà de
300 lignes.
S-03-{SLUG} — {...}

## Dérogations

Aucune.

{Ou : S-07-{SLUG} déroge à A-06-SANS-REPOSITORY — {la raison, en une ligne}.}
````

### Les trois lignes de frontmatter à ne pas manquer

| Champ | Valeur |
|---|---|
| `connaissance` | `vérifiée par recherche le AAAA-MM-JJ`, ou `non vérifiée — écrit d'après {version}` |
| `source` | présent uniquement en porte 3, pointe vers le document rapporté |
| `base` | toujours `spec-architecture.md` |

Le bloc `⚠` en tête du corps n'apparaît **que** dans le cas non vérifié. Dans le cas
vérifié, la ligne de frontmatter suffit.

---

## Les deux lignes à inscrire dans `presta/regles-projet.md`

> Avant d'écrire du code, lire `presta/specs/spec-architecture.md` et
> `presta/specs/spec-architecture-complement-{stack}.md`. En cas de contradiction, le
> complément l'emporte.

> Toute dérogation à ces fichiers est écrite dans le rapport de la phase concernée.

La première sert aux sous-agents de `/presta-implemente`. La seconde rend le contrôle de
conformité de `/presta-audit` applicable : sans elle, une dérogation décidée et un écart
involontaire se ressemblent.

---

## `presta/status.md`

`etape:` passe à `architecture`.
