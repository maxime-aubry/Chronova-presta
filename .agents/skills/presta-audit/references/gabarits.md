# Gabarits des fichiers produits par `/presta-audit`

Règles communes :

- **Vouvoiement** dans tout ce qui s'adresse au lecteur.
- **Markdown pur.** Ça doit se lire en texte brut et se differ dans git.
- **Le rapport ne s'écrase jamais.** Il est daté et numéroté ; une relance produit un
  nouveau fichier. Il se **modifie** en revanche au fil du traitement : le statut de chaque
  point est mis à jour au moment où la correction est écrite, pas à la fin.
- **Identifiants du projet** : préfixe + numéro + slug, en majuscules, sans accents —
  `E-05-MES-ACTIONS`, `M-06-TRANSACTION`, `A-02-CONTROLEUR-SANS-CALCUL`. Toujours en
  entier, y compris dans la conversation.
- **Les points d'audit portent un slug**, contrairement aux `V-xx` de
  `/presta-valide-specs` : `AU-03-VALORISATION-DUPLIQUEE`. C'est qu'ils sortent de leur
  rapport — ils vont dans les messages de commit, dans les statuts, et on les nomme des
  semaines plus tard. Numérotation **en continu d'un rapport à l'autre**, un numéro ne se
  réutilise jamais.
- **Aucun secret.** Si un extrait contient une clé, un jeton ou un mot de passe, il est
  remplacé par `***` et l'altération est écrite juste en dessous.

Deux fichiers :

| | |
|---|---|
| `presta/livrables/{livrable}/audits/AAAA-MM-JJ-audit-NN.md` | Le rapport. Écrit dans tous les cas, même sans point trouvé |
| `presta/livrables/{livrable}/mise-en-production.md` | La section sécurité, **remplacée en entier** à chaque audit |
- **Horodatage** : le champ `maj:` porte la date **et l'heure à la seconde**, en
  ISO-8601 — `2026-08-20T14:32:07`, obtenu avec `date +%FT%T`. C'est ce qui permet à un
  fichier dérivé de savoir qu'il est périmé : deux écritures du même jour se distinguent.
  Les noms de fichiers, eux, ne portent que la date.

---

## `presta/livrables/{livrable}/audits/AAAA-MM-JJ-audit-NN.md`

```markdown
---
projet: {Nom}
livrable: v1.0-portefeuille-actions
date: AAAA-MM-JJ
audit: NN
base: spec-architecture 15 règles · spec-ecrans 11 écrans · spec-modeles 6 entités
audits_lances: architecture, implementation, securite, code-duplique, data, performances
destination: personnel
points: 9
statut: en cours
---

# Audit NN — {Nom du projet}, v1.0-portefeuille-actions

Relecture du code contre les spécifications du projet, sous six angles
indépendants : architecture, implémentation, sécurité, code dupliqué, data et
points manquants, performances.

Chaque point porte l'emplacement exact dans le code, ce qu'il produit
concrètement, et la correction suggérée.

Statuts : `à traiter` · `traité` · `écarté` · `ouvert` (renvoyé vers une autre skill).

## Suivi

| Point | Sévérité | Sujet | Statut |
|---|---|---|---|
| AU-01-ADMIN-SANS-CONTROLE | bloquant | E-11-LISTE-UTILISATEURS accessible à tout membre | à traiter |
| AU-02-SEED-EN-PRODUCTION | bloquant | Le seed ne vérifie pas l'environnement | à traiter |
| AU-03-VALORISATION-DUPLIQUEE | majeur | Deux calculs de valeur, résultats différents | à traiter |
| ... | | | |

---

## Bloquant

### AU-01-ADMIN-SANS-CONTROLE — E-11-LISTE-UTILISATEURS accessible à tout membre

Statut : à traiter
Concerne : E-11-LISTE-UTILISATEURS, presta/specs/generated/acces-par-role.md
Vérifiable par : test
Relevé par deux audits.

**Où.**

    accounts/views.py:88-104
    accounts/urls.py:22

**Le défaut.** La vue ne vérifie que l'authentification. La matrice des accès
réserve cet écran au rôle administrateur ; le seul contrôle présent est le
masquage du lien dans le menu de `templates/base.html`.

**Conséquence.** Un membre connecté qui appelle `/admin/utilisateurs` obtient la
liste des comptes, avec les adresses e-mail.

**Suggestion.** Ajouter le contrôle de rôle sur la vue, avec le décorateur déjà
utilisé par `market/views.py:31`. Un test qui appelle l'URL en membre et attend
un refus.

---

### AU-02-SEED-EN-PRODUCTION — ...

---

## Majeur

### AU-03-VALORISATION-DUPLIQUEE — Deux calculs de valeur, résultats différents

Statut : à traiter
Concerne : E-04-TABLEAU-DE-BORD, E-05-MES-ACTIONS, A-11-DRY-SEUIL-3
Vérifiable par : test

**Où.**

    portfolio/services.py:41-58
    market/views.py:112-126

**Le défaut.** Le calcul de la valeur d'un portefeuille existe aux deux
endroits. Celui de `market/views.py` a été écrit en P-05-MES-ACTIONS et
n'intègre pas les frais.

**Conséquence.** E-04-TABLEAU-DE-BORD et E-05-MES-ACTIONS affichent deux
montants différents pour le même portefeuille.

**Suggestion.** Garder `portfolio/services.py`, appeler le service depuis la
vue. Un test qui compare les deux écrans sur le même jeu de données.

---

## Mineur

### AU-07-TODO-PHASE-6 — ...

---

## Déjà connus, non recomptés

- E-11-LISTE-UTILISATEURS : la suppression d'un utilisateur n'est pas livrée. Écart
  accepté le 07/08/2026, `description-livrable.md`.
- D-04-ENVOI-EMAILS : les e-mails de réinitialisation s'affichent en console. Hypothèse
  forcée.

## Points au-delà du plafond

4 points mineurs supplémentaires n'ont pas été retenus (plafond de 20).
```

### Les champs de la fiche

| Champ | Règle |
|---|---|
| Titre | Ce qui ne va pas, en une ligne. Pas le nom du défaut : sa conséquence |
| `Statut` | Se met à jour au moment du traitement, pas à la fin |
| `Concerne` | Les identifiants du projet en jeu, en entier |
| `Vérifiable par` | `test`, `environnement` ou `relecture`. C'est lui qui décide de la suite |
| `Relevé par N audits` | **Seulement si N ≥ 2.** C'est le seul signal de confiance disponible |
| **Où** | Le bloc d'ancres, une ligne par emplacement. Un point sans ce bloc n'existe pas |
| **Le défaut** | Ce que le code fait, et ce que la spec demandait |
| **Conséquence** | Un fait observable. Jamais un adjectif |
| **Extrait** | Facultatif, 4 lignes maximum, seulement si l'ancre ne suffit pas |
| **Suggestion** | Deux lignes. Quelle version garder, quoi ajouter, quel test |

### Une fois le point tranché

Sa fiche gagne une ligne juste sous le statut, et le tableau de suivi est mis à jour :

```markdown
Statut : traité
Correction : contrôle de rôle ajouté sur la vue et la route — accounts/views.py,
accounts/urls.py. Test `test_admin_list_forbidden_for_member`.
```

```markdown
Statut : écarté
Raison : vous acceptez l'écart, la couche de services viendra en v1.1.
```

```markdown
Statut : ouvert
Renvoi : demande une phase — à traiter avec /presta-phases.
```

Quand tous les points sont `traité`, `écarté` ou `ouvert`, le frontmatter passe à
`statut: clos`.

### Le cas « rien à signaler »

Le rapport s'écrit quand même. Le corps remplace les sections de sévérité par :

```markdown
## Rien au-dessus du seuil

Les six audits n'ont remonté aucun point.

Ce qui a été relu : les 15 règles de spec-architecture.md contre le code, les
11 écrans et leurs actions, les accès de chaque rôle depuis acces-par-role.md,
la duplication sur l'ensemble du dépôt, les contrats des 6 entités et les
marqueurs de dette, les requêtes des écrans de liste.

Ça ne veut pas dire que le code est sans défaut : ça veut dire que rien de ce
qu'un audit sait chercher n'est visible dedans.
```

---

## La section sécurité de `presta/livrables/{livrable}/mise-en-production.md`

**Elle se régénère à chaque audit, en entier**, même si aucun point n'a été trouvé et même
si rien n'a été corrigé. C'est un fichier déduit : on ne le modifie pas à la main.

Elle ne contient **que les contrôles `VÉRIFIABLE PAR : environnement`** — ce qui ne se
vérifie que sur le serveur réel. Tout ce qui se teste par une commande a été corrigé et
couvert par un test : ça n'a rien à faire dans une checklist humaine.

Trois à sept lignes. Chacune dit **quoi faire**, pas quoi vérifier.

```markdown
## Sécurité — à dérouler sur l'environnement réel

Produit par /presta-audit le 08/08/2026, audit-01. Cette section est régénérée
à chaque audit : ne la modifiez pas à la main.

Ces contrôles ne se testent pas en local — ils portent sur la configuration du
serveur. Tout le reste est couvert par la suite de tests.

- [ ] **Le mode debug est désactivé.** Provoquez une erreur volontaire sur une
      URL inexistante : vous devez voir votre page d'erreur, pas une trace.

- [ ] **Les variables d'environnement sont toutes renseignées.** Comparez le
      `.env` du serveur à `.env.example` — 3 clés y sont attendues. Une clé
      absente fait tomber la partie cotation sans message clair.

- [ ] **Le script de seed n'est pas exécutable sur le serveur.** Il crée des
      comptes à mots de passe connus. Vérifiez qu'il refuse de tourner, ou
      qu'il n'est pas déployé.

- [ ] **Le site répond en HTTPS et redirige le HTTP.** Appelez l'adresse en
      `http://`, vous devez arriver en `https://`.

- [ ] **`.env` n'est pas dans le dépôt.** `git log --all -- .env` ne doit rien
      renvoyer. S'il renvoie quelque chose, les clés concernées sont à
      régénérer, pas seulement à retirer.
```

Trois règles sur cette section :

- **Chaque ligne se déroule sans réfléchir.** Une case qu'on ne sait pas exécuter ne sera
  jamais cochée.
- **Aucune ligne ne double un test.** Si le contrôle est testable, il a été corrigé et
  testé : il ne revient pas ici.
- **Les lignes se dérivent du projet**, pas d'une liste type. Le `.env` cité nomme les clés
  réelles, le seed n'apparaît que s'il existe.

Si le fichier `mise-en-production.md` n'existe pas encore — l'audit tourne avant la fin du
livrable — vous créez le fichier avec cette seule section, et une ligne en tête qui dit que
le reste viendra de `/presta-implemente`.
