# Gabarits des fichiers produits par `/presta-implemente`

Règles communes :

- **Vouvoiement** dans tout ce qui s'adresse au lecteur.
- **Markdown pur.** Ça doit se lire en texte brut et se differ dans git.
- **Aucune supposition écrite.** Ce qui n'a pas été prouvé n'apparaît pas comme prouvé.
- **Identifiants** : préfixe + numéro + slug, en majuscules, sans accents —
  `E-03-MOT-DE-PASSE-OUBLIE`, `P-04-MOT-DE-PASSE`. **Il n'existe pas de forme courte.**
  Dans un nom de fichier, le même identifiant s'écrit en minuscules :
  `rapports/p-04-mot-de-passe-implementation.md`.
- **Aucun champ de statut dans un frontmatter de rapport ou de recette.** Le statut d'une
  phase vit dans le champ `etat:` de `phases/p-xx-{slug}.md`, et nulle part ailleurs. Un
  rapport qui porterait `statut:` créerait une deuxième vérité, qui divergerait.

Fichiers produits, sous `presta/livrables/{livrable}/` :

```
rapports/
  p-04-mot-de-passe-implementation.md   ← écrit par le sous-agent implémenteur
  p-04-mot-de-passe-verification.md     ← écrit par le sous-agent vérificateur
recettes/
  p-04-mot-de-passe.md                  ← écrit par le sous-agent vérificateur
  generated/
    recette-complete-v1.0.md            ← régénérée en fin de livrable
description-livrable.md                 ← trois sections seulement, voir plus bas
mise-en-production.md                   ← créé en fin de livrable
```

Plus, hors du livrable : `presta/status.md`, `presta/elements-a-fournir.md`, et le champ
`etat:` du fichier de phase.
- **Horodatage** : le champ `maj:` porte la date **et l'heure à la seconde**, en
  ISO-8601 — `2026-08-20T14:32:07`, obtenu avec `date +%FT%T`. C'est ce qui permet à un
  fichier dérivé de savoir qu'il est périmé : deux écritures du même jour se distinguent.
  Les noms de fichiers, eux, ne portent que la date.

---

## `rapports/{phase-slug}-implementation.md`

Écrit par le sous-agent implémenteur, jamais par le contexte principal.

```markdown
---
phase: P-04-MOT-DE-PASSE
livrable: v1.0-portefeuille-actions
date: 2026-08-07
---

# P-04-MOT-DE-PASSE — implémentation

## Ce qui a été développé

| | |
|---|---|
| E-03-MOT-DE-PASSE-OUBLIE | Le formulaire de demande, la page de choix du nouveau mot de passe, et le lien signé qui relie les deux |
| E-07-MON-COMPTE | Changement d'adresse et de mot de passe |
| Service | `accounts/services/password_reset.py` — génération et vérification du lien signé, durée de validité 2 h |

## Fichiers touchés

- `accounts/services/password_reset.py` — nouveau
- `accounts/views.py` — 3 vues ajoutées
- `accounts/urls.py` — 3 routes
- `templates/accounts/` — 3 gabarits, repris des aperçus validés

## Bouts non branchés

- Aucun.

## Hypothèses forcées

- **L'envoi d'e-mail.** D-04-ENVOI-EMAILS est en attente : le lien s'affiche dans la
  console du serveur au lieu d'être envoyé. Commentaire `// HYPOTHÈSE` posé dans
  `password_reset.py`, à l'endroit de l'envoi.

## Écarts à l'architecture

- Aucun.
```

Trois règles :

- **La section « écarts à l'architecture » est obligatoire, même vide.** C'est là que se
  déclare une dérogation à `spec-architecture.md` ou à son complément. Une dérogation non
  déclarée est ce que `/presta-audit` trouvera trois semaines plus tard.
- **Les hypothèses forcées apparaissent aux trois endroits** : ici, en commentaire
  `// HYPOTHÈSE` dans le code, et dans `description-livrable.md`. C'est exactement ce qu'on
  oublie.
- **Sur une reprise ou une correction**, le fichier se **complète**, il ne s'écrase pas.
  Une correction ajoute une section :

```markdown
## Correction — tour 1

Critère 3. Champ « Mot de passe actuel » ajouté à `templates/accounts/mon-compte.html`
et vérifié dans `accounts/services/account.py`. Le projet compile, les 12 tests de la
phase passent.
```

---

## `rapports/{phase-slug}-verification.md`

Écrit par le sous-agent vérificateur.

```markdown
---
phase: P-04-MOT-DE-PASSE
livrable: v1.0-portefeuille-actions
date: 2026-08-07
---

# P-04-MOT-DE-PASSE — vérification

## Les critères

| | Critère | Verdict | Preuve |
|---|---|---|---|
| 1 | La demande envoie un lien de réinitialisation | validé | `pytest accounts/tests/test_password_reset.py::test_link_sent` → passed |
| 2 | Un lien expiré est refusé | validé | même fichier, `::test_link_expired` → passed. Message affiché : « Ce lien n'est plus valide » |
| 3 | Le mot de passe change depuis E-07-MON-COMPTE | écart | Le formulaire ne demande pas le mot de passe actuel. Quelqu'un qui trouve une session ouverte peut changer le mot de passe sans le connaître |
| 4 | E-03-MOT-DE-PASSE-OUBLIE correspond à sa maquette | validé | capture `presta/annexes/p-04-e-03.png`, comparée à `presta/maquettes/apercus/e-03-mot-de-passe-oublie.html` |
| 5 | L'e-mail part réellement | bloqué | D-04-ENVOI-EMAILS en attente, aucun service d'envoi configuré. Le lien s'affiche en console |

## La suite de tests

    pytest → 12 tests, 12 passés, 1,8 s

4 tests ajoutés pour cette phase.

## Le coup d'œil navigateur

E-03-MOT-DE-PASSE-OUBLIE, capture `presta/annexes/p-04-e-03.png`. La page s'affiche,
les styles sont appliqués, rien ne déborde, les éléments annoncés par la spec-écran
sont présents.

Un point part au cahier de recettes : le message de confirmation est plus long que
dans l'aperçu et passe sur deux lignes. À votre appréciation.

## Corrections

*(aucune — mode pas à pas)*

## Cahier de recettes

`presta/livrables/v1.0-portefeuille-actions/recettes/p-04-mot-de-passe.md` — 5 étapes.
```

Quatre règles :

- **Une preuve par critère validé, citée en ligne.** Une commande et sa sortie, une URL et
  ce qui s'est affiché, un chemin de capture. Pas de preuve, pas de `validé`.
- **`écart` et `bloqué` ne se confondent jamais.** Le premier se corrige, le second demande
  quelque chose que personne ici ne peut fournir.
- **La section « corrections » est obligatoire, même vide.** En mode auto elle porte une
  ligne par correction : le critère visé, ce qui a changé, le résultat. Une correction non
  journalisée est une dérive invisible.
- **Ce que le coup d'œil navigateur trouve part au cahier de recettes**, jamais en verdict.
  L'humain reste juge du visuel.

---

## `recettes/{phase-slug}.md`

Écrit par le sous-agent vérificateur, déroulé par l'humain. **5 à 8 étapes**, avec les
vrais libellés et les vraies routes.

```markdown
---
phase: P-04-MOT-DE-PASSE
livrable: v1.0-portefeuille-actions
date: 2026-08-07
---

# P-04-MOT-DE-PASSE — cahier de recettes

Comptes du jeu de données :

| Rôle | Identifiant | Mot de passe |
|---|---|---|
| Membre | membre@delta.test | motdepasse |
| Administrateur | admin@delta.test | motdepasse |

Pour repartir d'une base propre : `python manage.py db_reset && python manage.py db_seed`

## Les étapes

1. Sur `/connexion`, cliquez « Mot de passe oublié ». Vous arrivez sur
   `/mot-de-passe-oublie`.
2. Saisissez `membre@delta.test` et validez. Le message « Si un compte existe, un lien
   vient d'être envoyé » s'affiche.
3. Le lien s'affiche dans la console du serveur — voir « Ce qui n'est pas branché ».
   Ouvrez-le.
4. Choisissez un nouveau mot de passe, validez. Vous êtes redirigé vers `/connexion`.
5. Connectez-vous avec le nouveau mot de passe. Vous arrivez sur `/tableau-de-bord`.

## À regarder au passage

- Sur `/mot-de-passe-oublie`, le message de confirmation passe sur deux lignes alors
  que l'aperçu le montre sur une. À votre appréciation.

## Ce qui n'est pas branché

- **L'envoi d'e-mail.** D-04-ENVOI-EMAILS n'est pas tranchée : rien ne part par
  e-mail, le lien s'affiche dans la console du serveur. Ce n'est pas un bug.
```

Quatre règles :

- **Les identifiants du jeu de données sont en en-tête.** C'est là que l'humain les
  cherchera, et c'est le deuxième des deux endroits où ils sont écrits — l'autre est
  `AGENTS.md`.
- **Les vrais libellés, entre guillemets, et les vraies routes.** Une recette qui dit
  « cliquez sur *Créer* » quand le bouton s'appelle *Nouveau* décrédibilise tout le reste.
- **La section « ce qui n'est pas branché » est obligatoire dès qu'il y a un bout non
  branché ou une hypothèse forcée.** Sans elle, l'utilisateur clique, rien ne se passe, et
  il remonte un faux bug.
- **Aucune étape ne demande de lire le code.** C'est une recette d'usage, pas une relecture.

---

## `recettes/generated/recette-complete-v{version}.md`

Fichier **déduit**, régénéré en entier à la fin du livrable. Il ne se modifie jamais à la
main.

```markdown
---
genere_par: /presta-implemente
source: presta/livrables/v1.0-portefeuille-actions/recettes/ — 10 cahiers de phase
maj: 2026-08-07T16:41:22
---

> Ce fichier est généré. Ne le modifiez pas : corrigez le cahier de la phase concernée
> dans `recettes/`, puis relancez `/presta-implemente`.

# Recette complète — v1.0-portefeuille-actions

Comptes du jeu de données :

| Rôle | Identifiant | Mot de passe |
|---|---|---|
| Membre | membre@delta.test | motdepasse |
| Administrateur | admin@delta.test | motdepasse |

Pour repartir d'une base propre : `python manage.py db_reset && python manage.py db_seed`

## P-02-MODELES-ET-DONNEES

{les étapes du cahier de la phase, telles quelles}

## P-03-COMPTES-ET-CONNEXION

...

## Ce qui n'est pas branché, tous cahiers confondus

- **L'envoi d'e-mail** — D-04-ENVOI-EMAILS non tranchée. P-04-MOT-DE-PASSE.
```

Deux règles :

- **Les identifiants et la commande de remise à zéro ne se répètent pas à chaque phase** :
  une fois en tête, c'est tout. Répétés dix fois, ils ne se lisent plus.
- **Les « ce qui n'est pas branché » de toutes les phases se regroupent en fin de fichier.**
  À la fin du livrable, la question n'est plus « qu'est-ce qui manque à cette phase » mais
  « qu'est-ce qui manque à l'application ».

---

## `description-livrable.md` — les trois dernières sections

Le fichier appartient à `/presta-phases`. **`/presta-implemente` n'écrit que ce qui
s'écarte du devis**, et l'en-tête `etat:` qui passe à `livré`. Le gabarit complet est dans
`presta-phases/references/gabarits.md`.

```markdown
## Hypothèses forcées

- **P-04-MOT-DE-PASSE** — l'envoi d'e-mail réel n'a pas été prouvé.
  D-04-ENVOI-EMAILS était encore en attente ; le lien de réinitialisation s'affiche en
  console en développement. Commentaire `// HYPOTHÈSE` posé dans le service d'envoi.
  **Reste à vérifier avant mise en production.**

## Écarts au périmètre

- **E-11-LISTE-UTILISATEURS** — la désactivation d'un utilisateur est livrée, la
  suppression ne l'est pas : elle casserait ses transactions. Écart signalé en
  P-07-UTILISATEURS, accepté le 07/08/2026.

## Journal de livraison

| Phase | Terminée le | Commit |
|---|---|---|
| P-01-SETUP | 2026-08-07 | a3f19c2 |
| P-02-MODELES-ET-DONNEES | 2026-08-07 | 7d1e4b8 |

Livré le 2026-08-07, tag `v1.0`.
Cahier de recettes cumulé : `recettes/generated/recette-complete-v1.0.md`.
Mise en production : `mise-en-production.md`.
```

**Un écart accepté porte sa date.** C'est une décision de l'utilisateur, pas un oubli, et
c'est ce qui la distingue d'un critère en échec.

**Rien d'autre ne s'écrit dans ce fichier** : ni l'avancement des phases, ni les critères,
ni le détail de ce qui a été développé. Trois copies de la même information divergent
toujours.

---

## `mise-en-production.md`

Créé **en fin de livrable**, dans le dossier du livrable. Il tient la promesse « jusqu'à la
mise en production » sans skill supplémentaire.

Il se consolide depuis ce qui existe déjà — `spec-technique.md` pour l'hébergement et les
dépendances externes, `.env.example` pour les variables, `elements-a-fournir.md` pour ce
qui reste côté utilisateur, `description-livrable.md` pour les hypothèses forcées. **Vous
n'inventez aucune contrainte** : ce qu'aucune spec ne dit devient une ligne « à décider »,
pas une recommandation sortie de nulle part.

```markdown
---
livrable: v1.0-portefeuille-actions
maj: 2026-08-07T16:41:22
---

# Mise en production — v1.0-portefeuille-actions

Checklist à dérouler avant d'ouvrir l'application à vos utilisateurs. Chaque ligne se
coche à la main.

## Avant de déployer

| | | Décidé dans |
|---|---|---|
| [ ] | Base PostgreSQL de production, même moteur qu'en développement | spec-technique.md |
| [ ] | Variables d'environnement du `.env.example` renseignées en production | .env.example |
| [ ] | `DEBUG` à faux, et la clé secrète du framework régénérée | — |
| [ ] | Le script de jeu de données refuse de s'exécuter hors développement | à vérifier |

## Les hypothèses à lever

| | | |
|---|---|---|
| [ ] | L'envoi d'e-mail | D-04-ENVOI-EMAILS n'est pas tranchée. En l'état, aucun e-mail ne part : E-03-MOT-DE-PASSE-OUBLIE ne fonctionne pas en production. **Bloquant.** |

## Ce qui reste de votre côté

| | | Bloque |
|---|---|---|
| [ ] | Clé Fournisseur A | La récupération des cours, donc E-04-TABLEAU-DE-BORD |
| [ ] | Nom de domaine et certificat | L'accès public |

## Les limites acceptées

- 25 appels par jour chez le fournisseur de cotation, soit 25 symboles suivis au
  maximum. Palier suivant à 15 $ par mois. Décidé en D-02-FOURNISSEUR-COTATION.

## Sécurité

*(cette section est produite par `/presta-audit`, elle n'est pas encore écrite)*
```

Trois règles :

- **Une ligne bloquante se dit bloquante.** Une hypothèse forcée qui casse un écran en
  production n'est pas au même niveau qu'un certificat à renouveler.
- **Chaque ligne cite d'où elle vient** quand elle vient de quelque part. Sans ça
  l'utilisateur ne peut pas la contester, et il ne saura pas où aller corriger.
- **La section sécurité s'ouvre vide, avec sa mention.** Elle appartient à
  `/presta-audit` : la laisser absente donnerait à croire qu'il n'y a rien à vérifier.

---

## `presta/status.md` — la section « Avancement des phases »

C'est un **report**. Le statut d'une phase fait autorité dans le champ `etat:` de son
fichier : en cas de doute, c'est là qu'on relit, et c'est de là que le report se refait.

```markdown
## Avancement des phases

| | |
|---|---|
| Livrable | v1.0-portefeuille-actions |
| Mode | manuel |
| Phase courante | P-04-MOT-DE-PASSE — 4 / 10 |
| Validées | 3 |
```

Deux règles :

- **Pas de tableau phase par phase ici.** Il ferait doublon avec les champs `etat:` et
  divergerait au premier oubli. Quatre lignes suffisent à reprendre après une coupure : le
  reste se relit.
- **`mode:` s'écrit ici, une seule fois**, au premier lancement. Il ne se redemande plus.
  Valeurs : `manuel` ou `auto`.

Le frontmatter passe à `etape: implementation` au premier lancement, et à `etape: livre`
en fin de livrable.

---

## `phases/{phase-slug}.md` — le champ `etat`

Ce fichier appartient à `/presta-phases`. **`/presta-implemente` n'y touche qu'à une ligne
du frontmatter :**

```markdown
---
phase: P-04-MOT-DE-PASSE
etat: validée
---
```

| Ce qui a été constaté | `etat` |
|---|---|
| Tous les critères `validé`, ou `validé` et écarts acceptés | `validée` |
| Un critère en `écart` ou en `bloqué` non accepté | `en cours` |
| La phase n'a pas encore été ouverte | `à faire` |

**Les critères de validation ne se modifient jamais ici**, même si l'un d'eux s'avère mal
formulé pendant l'implémentation. Ils appartiennent à la phase, et un implémenteur qui
réécrit ses propres critères ne prouve plus rien.

---

## `presta/elements-a-fournir.md`

`/presta-implemente` y ajoute ce que l'implémentation fait apparaître. **Elle n'y coche
jamais rien et n'y retire jamais une ligne** : le fichier appartient à l'utilisateur, c'est
lui qui coche. Une tâche fournie se constate au fait que la clé est dans `.env` ou que le
compte répond, jamais au fait que la case soit cochée.

**Le format du fichier est défini dans les gabarits de `/presta-rdv`** — une puce `- [ ]`,
dans la section de priorité qui convient. Une ligne ajoutée porte **ce qu'elle bloque, en
identifiant complet**, et à quelle phase ça se voit :

```markdown
- [ ] **Compte SMTP** — `.env`, ligne `EMAIL_HOST_USER=`. Bloque
  E-03-MOT-DE-PASSE-OUBLIE, développé en P-04-MOT-DE-PASSE. Sans lui, le lien de
  réinitialisation s'affiche en console et ne part pas.
```
