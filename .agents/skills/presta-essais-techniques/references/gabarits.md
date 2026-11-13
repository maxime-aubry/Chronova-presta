# Gabarits des fichiers produits par `/presta-essais-techniques`

Règles communes :

- **Vouvoiement** dans tout ce qui s'adresse au lecteur.
- **Markdown pur.** Ça doit se lire en texte brut et se differ dans git.
- **Tout est daté.** Une réponse d'API, un tarif, un quota ont une durée de validité. Non
  daté, c'est un mensonge en attente.
- **Identifiants** : préfixe + numéro + slug, en majuscules, sans accents —
  `E-01-CREATION-COMPTE`, `M-06-TRANSACTION`, `D-02-FOURNISSEUR-COTATION`. Le slug fait
  1 à 3 mots significatifs, sans article. **Il n'existe pas de forme courte** : un
  identifiant s'écrit toujours en entier, partout, y compris dans la conversation. Le
  numéro ne change jamais et ne se réutilise jamais. Dans un nom de fichier, le même
  identifiant s'écrit en minuscules : `apercus/e-05-mes-actions.html`.
- **Aucun secret nulle part sous `presta/`.** Les clés vivent dans `.env`.
- **Horodatage** : le champ `maj:` porte la date **et l'heure à la seconde**, en
  ISO-8601 — `2026-08-20T14:32:07`, obtenu avec `date +%FT%T`. C'est ce qui permet à un
  fichier dérivé de savoir qu'il est périmé : deux écritures du même jour se distinguent.
  Les noms de fichiers, eux, ne portent que la date.

---

## `presta/annexes/` — les preuves

### Convention de nommage

```
d-{nn}-{sujet}-{precision}.md
```

- `d-02-fournisseur-cotation-a-nvda.md` — l'appel au Fournisseur A sur le symbole NVDA
- `d-02-fournisseur-cotation-a-btc-eur.md` — le même fournisseur sur une crypto
- `d-04-envoi-emails-service-b.md` — la page de tarifs relevée

Le dossier se lit alors sans ouvrir un seul fichier : on voit quel point a produit quelle
preuve.

### Gabarit d'une preuve d'appel

**Toujours un `.md`, jamais un `.json` brut.** Un fichier JSON ne peut pas porter
d'en-tête — pas de commentaires dans le format — et un avertissement de nettoyage détaché
de sa preuve finit par disparaître.

````markdown
# D-02-FOURNISSEUR-COTATION — Fournisseur A, cotation de NVDA

Appel du 2026-08-05
API : Fournisseur A, endpoint `/v1/quote`, documentation consultée le 2026-08-05

⚠ Remarque importante — ce fichier a été modifié avant archivage.
  La clé d'API a été remplacée par `***` dans l'URL de requête.
  Le corps de la réponse est brut, non modifié.

## Requête

```
curl "https://api.fournisseur-a.example/v1/quote?symbol=NVDA&apikey=***"
```

## Réponse

```json
{
  "symbol": "NVDA",
  "close": "182.4400",
  "date": "2026-08-04T18:00:00"
}
```

## Ce que ça impose

- `close` arrive en **texte**, pas en nombre — conversion à l'entrée (M-05-QUOTE).
- La date est en **UTC sans fuseau** — à convertir à l'affichage (E-04-TABLEAU-DE-BORD).
- Aucun champ de devise : les cotations sont dans la devise de la place de cotation.
````

Trois règles sur le bloc de réponse :

- **Brut et entier.** Jamais un extrait reformulé, jamais de champs réordonnés.
- **Si la réponse est énorme**, gardez **un élément entier** de la collection, et dites-le
  en une ligne (« réponse tronquée : 1 élément sur 250 conservé, entier »). Ce qui compte,
  c'est la forme complète d'un objet, pas un échantillon de valeurs.
- **Le nettoyage se déclare** : quoi a été remplacé, où, et ce qui n'a pas été touché.

### Gabarit d'une preuve documentaire

Pour un point de nature `vérification` — tarifs, quotas, conditions d'usage.

```markdown
# D-04-ENVOI-EMAILS — Service B, quotas du palier gratuit

Relevé le 2026-08-05
Source : https://service-b.example/pricing (page officielle)

## Ce qui est écrit

- Palier gratuit : 100 e-mails par jour, 3 000 par mois.
- Pas de carte bancaire demandée à l'inscription.
- Palier suivant : 15 $ par mois, 50 000 e-mails.

## Ce que ça donne pour ce projet

100 e-mails par jour couvrent largement les réinitialisations de mot de passe
de E-03-MOT-DE-PASSE-OUBLIE. La limite ne mordra pas avant plusieurs milliers d'utilisateurs actifs.
```

**Recopiez ce qui est écrit, séparément de ce que vous en déduisez.** Les deux blocs ne
vieillissent pas à la même vitesse.

---

## `presta/specs/spec-technique.md` — la section « Décisions techniques »

Le gabarit de la section est défini dans `/presta-rdv`. Cette skill remplit la partie
basse d'un point, ou en ouvre de nouveaux.

### Un point résolu

```markdown
### D-02-FOURNISSEUR-COTATION — Fournisseur de cotation retenu
Statut : résolu
Enjeu : sans cotation, ni valeur de portefeuille ni courbe de progression (E-04-TABLEAU-DE-BORD).
Ouvert le 2026-08-04 (rdv-01).

Décision : Fournisseur A, palier gratuit. Seul des trois candidats à couvrir les
cryptos et les monnaies, nécessaires à la répartition de E-04-TABLEAU-DE-BORD.
Limite acceptée : 25 appels par jour, soit 25 symboles suivis au maximum, tous
portefeuilles confondus. Palier suivant à 15 $ par mois.
Preuve : `presta/annexes/d-02-fournisseur-cotation-a-nvda.md`, `presta/annexes/d-02-fournisseur-cotation-b-nvda.md`
Résolu le 2026-08-05 par /presta-essais-techniques.
```

Quatre lignes indispensables : **la décision**, **sa raison**, **la limite acceptée avec
sa porte de sortie chiffrée**, **la preuve**. Sans le chiffre, la limite se redécouvre le
jour où elle mord.

### Un point ouvert par cette skill

```markdown
### D-07-EXPORT-BANQUE — Format d'export accepté par votre banque
Statut : en attente
Enjeu : l'export de E-05-MES-ACTIONS n'a d'intérêt que s'il se réimporte quelque part.
Piste : à vérifier auprès de votre banque — CSV, OFX ou QIF.
Ouvert le 2026-08-05 par /presta-essais-techniques.
```

Un point se note **même s'il n'est pas traité dans la session**. C'est ce qui fait de ce
fichier la file d'attente réelle.

### Un point dont l'essai a échoué

L'échec est un résultat : il s'écrit, et le point **reste `en attente`**.

```markdown
### D-02-FOURNISSEUR-COTATION — Fournisseur de cotation retenu
Statut : en attente
Enjeu : sans cotation, ni valeur de portefeuille ni courbe de progression (E-04-TABLEAU-DE-BORD).
Piste : aucune des trois pistes testées ne convient.
  - Fournisseur A : cryptos et monnaies absentes du palier gratuit.
  - Fournisseur B : actions américaines uniquement.
  - Fournisseur C : inscription payante obligatoire, 15 $ par mois.
  Essayé le 2026-08-05, preuves dans `presta/annexes/d-02-fournisseur-cotation-*.md`.
  Reste à trancher : palier payant, ou recentrage du produit (voir /presta-rdv).
Ouvert le 2026-08-04 (rdv-01).
```

Le prochain qui ouvrira le sujet ne recommencera pas les mêmes appels.

### Une hypothèse forcée

Si l'utilisateur choisit d'avancer sans lever le point, il **reste `en attente`**, et la
décision se propage à trois endroits — commentaire dans le code à l'endroit exact de
l'hypothèse, mention dans le rapport d'implémentation de la phase,
ligne dans `description-livrable.md`.

```markdown
Hypothèse forcée le 2026-08-06 : on implémente en supposant que le temps réel est
disponible sans compte payant. Non vérifié. Voir le commentaire dans le code.
```

---

## `presta/essais/d-xx-{slug}/` — le code de l'essai

Un dossier par point, dans le projet de l'utilisateur, **hors du code applicatif** :
jamais sous `src/`, jamais importé ni compilé avec l'application.

```
presta/essais/d-02-fournisseur-cotation/
  README.md
  appel-fournisseur-a.sh
  appel-fournisseur-b.sh
```

### `README.md`

```markdown
# Essai D-02-FOURNISSEUR-COTATION — Fournisseur de cotation

Fait le 2026-08-05. Résultat : Fournisseur A retenu (voir spec-technique.md).

## Comment le rejouer

1. Renseigner `FOURNISSEUR_A_KEY` dans le `.env` à la racine du projet.
2. `sh presta/essais/d-02-fournisseur-cotation/appel-fournisseur-a.sh`

Sur Windows, remplacer `curl` par `curl.exe` : dans Windows PowerShell, `curl` est
un alias d'`Invoke-WebRequest`, qui n'a pas la même syntaxe.

## Pourquoi on le garde

Le jour où le fournisseur change ses quotas ou son format de réponse, on relance
l'essai au lieu de le refaire.
```

Aucune clé dans les scripts : elles se lisent depuis l'environnement.

---

## `presta/specs/spec-modeles.md` — les commentaires de contrat

Ce que la réponse réelle impose s'écrit sur le champ concerné, dans la notation de
`/presta-modeles`. C'est un contrat d'usage, pas une redéfinition d'entité.

```
Quote
   decimal   Price   // le fournisseur renvoie "182.4400" en texte — conversion
                     // à l'entrée, jamais stocker la chaîne
   DateTime  Date    // UTC sans fuseau côté fournisseur — convertir à l'affichage
```

La règle de propagation de `/presta-modeles` s'applique : ces commentaires sont recopiés
dans le code, sur le champ concerné.

---

## `presta/elements-a-fournir.md`

Une puce par tâche, dans la section de priorité qui convient. **Le format du fichier est
défini dans les gabarits de `/presta-rdv`.** Ce que ça bloque est nommé en `E-xx`, `M-xx`
ou phase — jamais « le projet ». L'IA n'y coche jamais rien.

```markdown
- [ ] **Compte Fournisseur A** — créez-le, la clé ira dans `.env`, ligne
  `QUOTES_API_KEY=`. Bloque toute la récupération des cours, donc E-04-TABLEAU-DE-BORD
  et E-05-MES-ACTIONS.
  1. Créez un compte sur https://exemple.test
  2. Générez une clé dans « API keys », palier gratuit
- [ ] **Compte Service B** — l'envoi des e-mails. Bloque E-03-MOT-DE-PASSE-OUBLIE : le
  lien de réinitialisation s'affiche en console tant qu'il n'existe pas.
```

---

## `presta/status.md`

Le champ `etape:` **ne change pas** : cette skill est lançable à tout moment et ne fait pas
avancer le pipeline. Seul `maj:` est mis à jour.

---

## `presta/regles-projet.md`

À inscrire, si elle n'y est pas déjà :

> `presta/essais/` contient du code d'essai. Il ne s'importe jamais depuis le code de
> l'application et ne se compile pas avec elle.

Et dans la carte des fichiers :

```markdown
- `presta/annexes/` — les preuves des essais techniques, datées
- `presta/essais/` — le code des essais, rejouable, hors du code applicatif
```

Si la règle et ces deux lignes y sont déjà, ce fichier ne se rouvre pas.
