# Gabarits des fichiers produits par `/presta-valide-specs`

Règles communes :

- **Vouvoiement** dans tout ce qui s'adresse au lecteur.
- **Markdown pur.** Ça doit se lire en texte brut et se differ dans git.
- **Ces deux fichiers ne s'écrasent jamais.** Ils sont datés et numérotés, et
  l'utilisateur coche la checklist à la main. Une relance produit une nouvelle paire.
- **Identifiants** : préfixe + numéro + slug, en majuscules, sans accents —
  `E-01-CREATION-COMPTE`, `M-06-TRANSACTION`, `D-02-FOURNISSEUR-COTATION`. Le slug fait
  1 à 3 mots significatifs, sans article. **Il n'existe pas de forme courte** : un
  identifiant s'écrit toujours en entier, partout, y compris dans la conversation. Le
  numéro ne change jamais et ne se réutilise jamais. Dans un nom de fichier, le même
  identifiant s'écrit en minuscules : `apercus/e-05-mes-actions.html`.
- **Les points d'un rapport sont la seule exception à cette règle.** Ils sont numérotés
  `V-01`, `V-02`… **sans slug**, en continu d'un rapport à l'autre, et un numéro ne se
  réutilise jamais, même si le point a été écarté. Ils ne sortent jamais de leur rapport
  et sont toujours suivis de leur titre — c'est ce qui les rend lisibles sans slug.
- Le rapport se **modifie** au fil du traitement : le statut de chaque point est mis à jour
  au moment où la correction est écrite, pas à la fin.
- **Horodatage** : le champ `maj:` porte la date **et l'heure à la seconde**, en
  ISO-8601 — `2026-08-20T14:32:07`, obtenu avec `date +%FT%T`. C'est ce qui permet à un
  fichier dérivé de savoir qu'il est périmé : deux écritures du même jour se distinguent.
  Les noms de fichiers, eux, ne portent que la date.

---

## `presta/validations/AAAA-MM-JJ-validation-NN.md`

```markdown
---
projet: {Nom}
date: AAAA-MM-JJ
validation: NN
base: spec-produit v1.0 · spec-ecrans 11 écrans · spec-modeles 6 entités
points: 9
statut: en cours
---

# Validation des specs NN — {Nom du projet}

Relecture à froid des spécifications, sous quatre angles indépendants :
cohérence croisée, trous de la spec-écran, degrés de liberté, contradiction.

Les points sont classés du plus grave au moins grave. Chaque point porte la
citation qui l'établit, ce qu'il coûte à l'implémentation, la question posée
et la suggestion faite.

Statuts : `à traiter` · `traité` · `écarté` · `ouvert` (renvoyé vers une autre skill).

## Suivi

| Point | Sévérité | Sujet | Statut |
|---|---|---|---|
| V-01 | bloquant | Aucun administrateur au premier lancement | à traiter |
| V-02 | majeur | Le réglage « frais par défaut » n'agit nulle part | à traiter |
| ... | | | |

---

## Bloquant

### V-01 — Aucun administrateur n'existe au premier lancement

Statut : à traiter
Concerne : E-09-LISTE-SYMBOLES, E-10-FICHE-SYMBOLE, M-01-USER
Relevé par trois relectures sur quatre.

**Citation.** « Le back-office est accessible aux comptes dont le rôle est
administrateur » — `spec-ecrans.md`, E-09-LISTE-SYMBOLES.

**Le défaut.** E-01-CREATION-COMPTE ne produit que des comptes utilisateur, et
M-01-USER ne dit rien du rôle attribué à l'inscription.

**Conséquence.** Sur une base neuve, personne n'entre dans le back-office. Donc aucun
symbole n'est créé. Donc aucune transaction n'est saisissable : le produit entier est
bloqué.

**Question.** Le premier administrateur, on le crée comment ?

**Suggestion.** Une commande à lancer une fois à l'installation, qui crée le compte
depuis une adresse e-mail et un mot de passe fournis. Rien à ajouter aux écrans, et ça
reste rejouable en cas de perte d'accès.

---

## Majeur

### V-02 — ...

---

## Mineur

### V-05 — ...

---

## Déjà connus, non recomptés

- Les filtres de E-05-MES-ACTIONS et le contenu vide de E-09-LISTE-SYMBOLES sont dans `elements-a-fournir.md`.
- D-02-FOURNISSEUR-COTATION et D-03-FREQUENCE-COURS sont ouvertes dans `spec-technique.md`.

## Points au-delà du plafond

3 points mineurs supplémentaires n'ont pas été retenus (plafond de 15).
```

Une fois un point tranché, sa fiche gagne une ligne, juste sous le statut :

```markdown
Statut : traité
Correction : message d'erreur ajouté sur E-06-SAISIE-TRANSACTION — `spec-ecrans.md`
```

ou :

```markdown
Statut : écarté
Raison : vous préférez fixer la période à 1 an, sans sélecteur.
```

Quand tous les points sont `traité`, `écarté` ou `ouvert`, le frontmatter passe à
`statut: clos`.

---

## `presta/validations/AAAA-MM-JJ-validation-NN-checklist.md`

Elle ne contient **que** ce qu'une relecture automatique ne peut pas juger : le jugement
produit, les priorités, ce que seul quelqu'un qui connaît le métier peut trancher. Elle
n'attend aucune réponse et rien ne dépend d'elle pour continuer.

Cinq à sept cases. **Trois sont invariantes** — celle de l'écran validé trop vite, celle du
premier écran, celle de la coupe V1 — les autres se dérivent du projet : ses chiffres, son
métier, ce qui a été laissé de côté.

Chaque case dit **quoi faire**, pas seulement quoi vérifier. Une case qu'on ne sait pas
dérouler ne se coche jamais.

```markdown
---
projet: {Nom}
date: AAAA-MM-JJ
validation: NN
---

# Checklist recommandée — à relire vous-même

Six questions que je ne peux pas trancher à votre place. Elles sont
facultatives : rien dans la suite de la méthode n'en dépend, et vous pouvez
les dérouler quand vous voulez.

Elles ne cherchent pas des erreurs dans les specs. Elles cherchent le seul
défaut qu'aucune relecture automatique ne verra jamais : des spécifications
cohérentes, complètes, et qui décrivent le mauvais produit.

- [ ] **Quel écran avez-vous validé un peu vite, sans vraiment le lire ?**
      Relisez celui-là en premier. C'est presque toujours le bon candidat.

- [ ] **Vous ouvrez l'application pour la première fois.** Le premier écran
      vous donne-t-il envie de faire l'action principale, ou faut-il d'abord
      comprendre quelque chose ?

- [ ] **Les 11 écrans, c'est une V1 ?** Si vous deviez en couper trois pour
      livrer un mois plus tôt, lesquels — et est-ce que le produit tient
      encore sans eux ?

- [ ] **Faites lire `spec-produit.md` à quelqu'un qui n'a pas participé.**
      Est-ce qu'il vous repose une question sur du vocabulaire ?

- [ ] **{Une case dérivée du métier.}** Les frais, la devise et les arrondis :
      est-ce que vous avez déroulé un cas réel à vous, avec vos vrais chiffres,
      jusqu'au montant affiché ?

- [ ] **Ce que vous avez laissé « pour plus tard ».** Est-ce que vous
      accepteriez de livrer sans, ou est-ce que vous le rajouterez en cours de
      route ? Si c'est la deuxième réponse, il vaut mieux le spécifier
      maintenant.

Si vous trouvez quelque chose, relancez `/presta-valide-specs` et donnez-le
moi : on le traite comme un point de plus.
```
