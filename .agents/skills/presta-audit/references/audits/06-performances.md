# Audit 6 — Performances

Vous cherchez ce qui marchera très bien sur le poste du développeur et se dégradera à
l'usage réel.

**Le calibrage vient de la destination du projet, pas d'un seuil du marché.** C'est ce qui
distingue cet audit d'un outil générique : un chargement complet de table est une faute sur
une application publiable, et un non-sujet sur un outil personnel à deux cents lignes de
données.

C'est le seul des six audits qu'un outil générique saurait à peu près faire — à condition
justement d'ignorer la destination, donc de se tromper une fois sur deux.

---

## Vos fichiers

| | |
|---|---|
| `presta/specs/spec-produit.md` | Qui utilise l'application, combien de personnes, dans quel cadre |
| `presta/specs/spec-technique.md` | Section « Hébergement et publication », et les dépendances externes avec leurs quotas |
| `presta/specs/spec-ecrans.md` | Les écrans de liste, les tableaux, les graphiques, les tableaux de bord — c'est là que ça se paie |
| `presta/specs/spec-modeles.md` | Ce qui grossit sans borne : cotations, transactions, journaux, historiques |
| Le code | Les services et les vues des écrans de liste, les tâches de fond, les clients d'API |

---

## Le calibrage

La ligne `DESTINATION DU PROJET` de votre prompt commande tout ce qui suit.

| Destination | Ce que vous signalez | Sévérité plafond |
|---|---|---|
| `personnel` | Ce qui casse déjà, et ce qui grossit sans borne dans le temps — une table qui ne se purge jamais, un historique rechargé en entier | `mineur`, au conditionnel |
| `interne` | Ce qui ne tient pas à quelques dizaines d'utilisateurs simultanés, ou à quelques années de données | `majeur` |
| `publiable` | Tout ce qui est linéaire en nombre d'utilisateurs ou en volume de données | `majeur` |
| `non dit` | L'hypothèse la plus large, **et vous l'écrivez dans le point** | `majeur` |

Sur `personnel` et `non dit`, la conséquence s'écrit **au conditionnel** :

> Rien dans les specs ne dit si cette application sera publiée. Si elle l'est, cet écran
> fera une requête par titre détenu et par visiteur.

Jamais « c'est cassé » quand ça ne l'est pas encore. Le point doit rester contestable en
une phrase.

---

## Ce que vous cherchez

| # | Critère | Ce qui se constate |
|---|---|---|
| 1 | ⭐ **La requête en boucle** : une requête par ligne affichée | Un écran de liste qui interroge la base pour chaque élément de la boucle du gabarit |
| 2 | **Le chargement complet d'une table qui grossit** | `all()` sur les cotations pour n'en afficher que trente |
| 3 | **Les appels réseau en cascade** : N appels séquentiels là où un suffit, ou là où ils pourraient partir ensemble | Un appel de cotation par symbole, l'un après l'autre |
| 4 | **Une liste sans pagination ni limite** sur une donnée qui grossit sans borne | L'historique complet des transactions rendu en une page |
| 5 | **Un calcul refait à chaque affichage** alors qu'il porte sur tout l'historique | La valeur du portefeuille recalculée depuis la première transaction, à chaque chargement |
| 6 | **Une tâche de fond qui traite tout** au lieu du delta | La synchronisation quotidienne qui réimporte l'historique entier |
| 7 | **Un quota externe dépassable** : le volume que le code peut demander, rapporté au quota écrit dans `spec-technique.md` | 25 appels par jour autorisés, un appel par symbole et par visite |
| 8 | **Un index absent** sur une colonne systématiquement filtrée ou triée — seulement si ça se voit depuis le modèle et la requête |  |
| 9 | **Un fichier ou une réponse chargés entièrement en mémoire** | Un export qui construit tout avant d'envoyer |

**Le critère 1 est le plus fréquent et le plus rentable.** C'est le défaut classique du code
généré : la vue passe une collection au gabarit, et le gabarit va chercher une relation
pour chaque élément. Ça ne se voit sur aucun écran de développement, et ça multiplie les
requêtes par le nombre de lignes.

**Le critère 7 est celui que seul cet audit peut faire.** Le quota est écrit dans les specs
du projet ; aucun outil générique ne sait le rapporter au volume d'appels du code.

---

## Comment chercher

1. Partez des **écrans de liste et des tableaux de bord** nommés dans `spec-ecrans.md`.
   C'est là que le volume se manifeste.
2. Pour chacun, lisez le service, la vue et le gabarit **ensemble**. La requête en boucle
   ne se voit qu'en croisant les trois : la vue paraît saine, le gabarit paraît sain.
3. Puis les **tâches de fond** et les **clients d'API**.
4. **Mesurez si vous pouvez le faire sans rien modifier** — un journal de requêtes déjà
   actif, un compteur exposé par le framework en mode développement. Sinon, comptez à la
   lecture, et dites que c'est une lecture.

---

## Le partage avec les autres audits

| Ce que vous voyez | À qui c'est |
|---|---|
| La même requête écrite à trois endroits | **Audit 4** |
| Une requête dans une vue, contraire à l'architecture | **Audit 1** — vous, vous ne signalez que son coût |
| Une donnée calculée stockée en base | **Audit 5** |
| Une pagination spécifiée mais absente | **Audit 2** — c'est un manque de conformité avant d'être une performance |

---

## Faux positifs à ne pas produire

- **Signaler une optimisation sur un volume que rien ne laisse prévoir.** C'est le faux
  positif dominant : appliquez le calibrage, toujours.
- Réclamer un cache, une file d'attente, un index de recherche ou une base secondaire. Ce
  sont des choix d'architecture, ils ne se prennent pas dans un audit.
- Signaler la performance d'un script d'essai (`presta/essais/`), d'un seed, ou d'une
  migration : ils tournent une fois.
- Signaler un chargement complet d'une table **de référence bornée** — les catégories, les
  rôles, les devises. Elles ne grossissent pas.
- Signaler la performance des tests.
- Donner un chiffre inventé. Si vous n'avez pas mesuré, dites ce que vous comptez : « une
  requête par ligne, soit une par titre détenu ».
