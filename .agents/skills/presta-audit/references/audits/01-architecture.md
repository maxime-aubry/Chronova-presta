# Audit 1 — Architecture

Vous vérifiez que le code est rangé comme `spec-architecture.md` le dit, et que les
interdits qu'elle pose sont tenus.

**Pourquoi ça passe en premier :** sans ce contrôle, `spec-architecture.md` est décoratif.
On l'écrit, personne ne vérifie qu'il est suivi, et il devient un document mort en trois
phases — après quoi chaque sous-agent d'implémentation invente sa propre structure.

---

## Vos fichiers

| | |
|---|---|
| `presta/specs/spec-architecture.md` | Les couches, les interdits `A-xx`, les règles de code, les parcours en étapes |
| `presta/specs/spec-architecture-complement-{stack}.md` | L'arborescence réelle, le contenu type d'une unité, les parcours en fichiers, les conventions `S-xx`. **En cas de contradiction, le complément l'emporte** |
| `AGENTS.md` | Les commandes et conventions réelles du projet |
| `presta/livrables/{livrable}/rapports/*.md` | Les dérogations déclarées phase par phase |
| Le code | Par où entrer : l'arborescence du complément, puis les fichiers qu'elle nomme |

Ne lisez pas les specs d'écrans ni de modèles : ce n'est pas votre angle.

**Si `spec-architecture.md` n'existe pas, rendez une liste vide.** Il n'y a rien à
contrôler le code contre, et inventer une architecture de référence produirait huit points
inutiles.

---

## Ce que vous cherchez

| # | Critère | Ce qui se constate |
|---|---|---|
| 1 | **Chaque interdit `A-xx` est-il tenu ?** Descendez-les un par un | Une vue qui requête, un service qui connaît HTTP, une couche données qui appelle le réseau |
| 2 | **Les fichiers sont-ils là où le complément dit ?** | Un fichier au mauvais niveau, une unité qui n'existe pas, un dossier inventé |
| 3 | **Les dépendances entre unités** respectent-elles les interdits déclarés ? | Une application qui importe une autre alors que le complément l'interdit |
| 4 | **Le parcours d'ajout d'une fonctionnalité a-t-il été suivi ?** | Un écran dont le calcul vit dans la vue au lieu du service, une étape sautée |
| 5 | **Une seule façon de faire** (`A-10-UNE-SEULE-FACON` ou son équivalent) | Deux mécanismes concurrents pour la même chose : deux façons de charger des données, deux façons de rendre une réponse d'erreur |
| 6 | **YAGNI** (`A-12-YAGNI`) | Une interface à une seule implémentation, une option de configuration que rien ne lit, une abstraction sans second usage |
| 7 | **Un seul endroit par sujet** (`A-13-UN-SEUL-ENDROIT`) | Autorisation, validation, journalisation ou gestion d'erreur écrites ailleurs que dans le fichier prévu |
| 8 | **Échouer bruyamment** (`A-14-ECHOUER-BRUYAMMENT`) | Un `catch` qui renvoie une valeur par défaut, une erreur avalée en silence, un `except` nu |
| 9 | **Une responsabilité par fichier** (`A-15-UNE-RESPONSABILITE`) | Un fichier au-delà du seuil chiffré par la spec, ou qui porte deux sujets sans rapport |
| 10 | **Les dérogations sont-elles déclarées ?** `regles-projet.md` impose que toute dérogation soit écrite dans le rapport de la phase concernée | Un écart réel qu'aucun rapport ne mentionne |

**Les numéros `A-xx` de ce tableau sont indicatifs.** Prenez ceux du projet : c'est
`spec-architecture.md` qui fait foi, y compris s'il en a moins, plus, ou d'autres.
Citez-les tels quels dans le champ `CONCERNE`.

**Le critère 10 est le plus révélateur.** Un projet peut s'écarter de son architecture pour
une bonne raison ; ce qui est un défaut, c'est que personne ne le sache. Un écart déclaré
dans un rapport de phase n'est pas un point — mentionnez-le, en `mineur`, uniquement si la
dérogation s'est propagée ailleurs que là où elle a été déclarée.

---

## Le partage avec les autres audits

| Ce que vous voyez | À qui c'est |
|---|---|
| Du code dupliqué, une logique écrite deux fois | **Audit 4.** Même si `A-11-DRY-SEUIL-3` existe, la duplication ne se signale qu'une fois, et c'est là-bas |
| Un contrôle d'autorisation absent | **Audit 3**, même s'il est aussi hors de l'endroit prévu |
| Un écran manquant, une action non branchée | **Audit 2** |
| Une requête en boucle | **Audit 6** |
| Un `// TODO` ou une hypothèse non déclarée | **Audit 5** |

Vous ne signalez que la **structure** : où vit le code, ce qu'il a le droit d'appeler,
combien de façons de faire coexistent.

---

## Faux positifs à ne pas produire

- Réclamer une couche, un dossier ou un patron que `spec-architecture.md` n'a pas prévus.
  **Une architecture plus simple que ce que vous auriez fait n'est pas un défaut.**
- Signaler l'absence d'un patron de conception. La méthode en interdit explicitement la
  prescription à l'avance.
- Signaler un écart au complément d'une **autre** stack que celle du projet.
- Traiter comme un écart ce que le complément autorise explicitement en dérogation.
- Signaler la structure d'un fichier généré par le framework, ou d'une migration.
- Juger le nommage, la longueur des lignes, l'ordre des imports.
