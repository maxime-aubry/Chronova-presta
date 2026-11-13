# Audit 3 — Sécurité

**L'autorisation en tête.** La question n'est pas « ce code est-il sécurisé » dans
l'absolu : c'est « chaque écran et chaque action sont-ils réservés à qui les specs
réservent, et le contrôle est-il **côté serveur** ».

Un bouton masqué n'est pas un contrôle. Un menu qui n'affiche pas le lien n'est pas un
contrôle. Le seul contrôle qui compte est celui qu'on ne peut pas contourner en tapant
l'URL.

**Ce n'est pas un test d'intrusion.** Vous lisez du code, vous n'attaquez rien, vous ne
scannez rien, vous ne lancez aucune requête.

---

## Vos fichiers

| | |
|---|---|
| `presta/specs/generated/acces-par-role.md` | **Votre source de vérité des accès.** Qui entre où, qui fait quoi |
| `presta/specs/spec-ecrans.md` | Les annotations de rôle écran par écran |
| `presta/specs/spec-modeles.md` | Les commentaires de contrat, en particulier « ne jamais renvoyer au client », « ne jamais logger » |
| `presta/specs/spec-technique.md` | Les dépendances externes et les clés attendues |
| `.env.example`, `.gitignore` | Ce qui est censé être secret, et ce qui est censé être ignoré |
| Le code | Routes, vues ou contrôleurs, intergiciels, sérialiseurs, gabarits, script de seed |

### Premier geste : la fraîcheur de la matrice

`acces-par-role.md` porte dans son frontmatter un champ `source:` qui dit de quelle version
de `spec-ecrans.md` elle est tirée. **Comparez-le à `spec-ecrans.md` avant toute
conclusion.**

- **Elle est à jour** → vous vous appuyez dessus, écran par écran, action par action.
- **Elle est périmée** → vous ne concluez pas dessus. Vous vous rabattez sur les
  annotations de rôle de `spec-ecrans.md`, et **votre premier point est la matrice
  elle-même**, en `majeur`, avec les deux versions citées.
- **Elle est absente** → mêmes annotations, et vous le dites dans un point `mineur`.

Une matrice fausse est pire qu'une matrice absente : elle donne l'impression que le
contrôle a eu lieu.

---

## Ce que vous cherchez

**Le bloc 1 est le cœur. Faites-le en entier avant de passer au bloc 2.**

### Bloc 1 — L'autorisation

| # | Critère | Ce qui se constate |
|---|---|---|
| 1 | **Pour chaque ligne de la matrice** : le contrôle existe-t-il côté serveur, sur la route et sur l'action ? | Un écran réservé à l'administrateur dont la vue ne vérifie que l'authentification, pas le rôle |
| 2 | **Le masquage seul** : un lien, un bouton ou une colonne caché côté client, sans contrôle serveur derrière | Le menu n'affiche pas l'entrée, l'URL répond quand même |
| 3 | **La ressource d'autrui** : toute route qui prend un identifiant vérifie-t-elle que la ressource appartient à l'appelant ? | `/portefeuille/{id}` qui sert le portefeuille de n'importe qui |
| 4 | **L'action, pas seulement l'écran** : suppression, modification, export, envoi — chacune porte-t-elle son contrôle ? | La page est protégée, le point d'entrée qui supprime ne l'est pas |
| 5 | **La cohérence du mécanisme** : un seul endroit décide de l'autorisation, et il est utilisé partout | Trois vues sur quatre passent par le décorateur, la quatrième vérifie à la main |

### Bloc 2 — Les faiblesses connues du code généré

| # | Critère | Ce qui se constate |
|---|---|---|
| 6 | **La validation côté serveur** : ce que le client valide, le serveur le revalide-t-il ? | Un champ obligatoire vérifié uniquement en JavaScript |
| 7 | **Les champs marqués « ne jamais renvoyer au client »** apparaissent-ils dans une réponse, un gabarit, une réponse d'API, un journal ? | Un hachage de mot de passe sérialisé dans la réponse du profil |
| 8 | **Les secrets** : une clé, un jeton, un mot de passe en dur dans le code, dans un gabarit, dans un fichier versionné, ou envoyé au client | Une clé d'API dans le bundle, un `.env` absent du `.gitignore` |
| 9 | **Le script de seed** : refuse-t-il de s'exécuter hors développement ou test ? | Des comptes à mots de passe connus, créables en production |
| 10 | **Les pages et réponses d'erreur** laissent-elles fuir une trace, une requête, un chemin de fichier ? | Le mode debug actif, ou une trace renvoyée dans une réponse d'erreur |
| 11 | **Les mots de passe et jetons du projet** : stockage en clair, hachage fait maison, jeton de réinitialisation sans expiration | Seulement si c'est du code du projet, pas celui du framework |

---

## Le partage avec les autres audits

| Ce que vous voyez | À qui c'est |
|---|---|
| Un écran spécifié qui n'existe pas du tout | **Audit 2** |
| Le contrôle d'autorisation écrit ailleurs que dans l'endroit prévu, mais présent | **Audit 1** — pour vous, l'important est qu'il existe |
| Deux implémentations du même contrôle | **Audit 4**, sauf si elles divergent : alors c'est vous, en `bloquant` |
| Un contrat de champ non tenu **sans** conséquence de confidentialité | **Audit 5** |

---

## `VÉRIFIABLE PAR` — c'est ici que le champ compte le plus

| Ce que vous trouvez | Valeur |
|---|---|
| Un contrôle d'autorisation absent, une ressource d'autrui accessible, un champ qui fuit dans une réponse, une validation serveur manquante | `test` |
| `DEBUG` actif, une variable d'environnement absente, HTTPS, le seed présent sur le serveur, une trace visible sur la page d'erreur de production | `environnement` |

**Dans le doute, `test`.** Un contrôle d'accès se teste en trois lignes ; en faire une
étape manuelle, c'est le perdre à la troisième livraison.

---

## Faux positifs à ne pas produire

- **Refaire le travail du framework.** Ne signalez pas l'absence de protection CSRF,
  d'échappement des gabarits ou de hachage des mots de passe sans montrer la ligne qui les
  désactive.
- **Une pratique théorique sans route concernée.** Pas de « il faudrait durcir les
  en-têtes » sans dire ce qui est exposé.
- **Un durcissement générique que rien ne demande** — en-têtes, politique de contenu,
  limitation de débit. Au plus un point `mineur`, groupé, `VÉRIFIABLE PAR : environnement`.
- **Signaler un accès manquant depuis une matrice périmée.** Vous ne savez plus qui a
  droit à quoi : dites-le, ne concluez pas.
- **Confondre absence de contrôle et contrôle porté ailleurs** — un intergiciel global, une
  classe de base, un décorateur appliqué au niveau du routeur. Lisez avant de conclure.
- Proposer une refonte du modèle d'autorisation. Vous signalez un trou, vous ne redessinez
  pas le système.
