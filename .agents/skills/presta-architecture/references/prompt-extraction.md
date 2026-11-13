# Prompt d'extraction d'architecture

À **exécuter dans l'autre projet**, pas ici. L'utilisateur ouvre son projet source dans
son agent, colle le prompt ci-dessous, relit le `architecture-system.md` produit, le
corrige s'il le souhaite, puis le rapporte dans la session Presta.

Ce document est la **matière** de `spec-architecture.md`, pas le fichier final.

---

```
Analyse le projet en détail à l'aide de sous-agents d'exploration pour comprendre
quelles sont les règles d'architecture, les pratiques et les patterns de code qui
ont été utilisés.

Le but est d'obtenir un document "architecture-system.md" qui va donner des
indications sur :

- Comment l'arborescence des fichiers est structurée
- Comment le code a été organisé et découpé : par fonctionnalité, par couche
  logicielle, par service, par composant, par écran...
- Comment la gestion des dépendances est faite
- Le détail de la stack et les technologies utilisées
- Les services ou fonctionnalités transversales qui pourraient être réutilisés sur
  d'autres projets (exemples : classe Utils statique, service de logging pour le
  debug... ; et non des fonctionnalités spécifiques au projet)
- Comment les données ont été structurées, et comment elles sont accedées.
- Fonctionnalité : Comment, en général, les différentes fonctionnalités sont
  construites et architecturées ?

Je veux un rapport très simple, très concis, qui ne remonte pas les analyses de
code : pas de noms de fichiers, pas de numéros de ligne, pas d'extraits de code,
pas de statistiques. Ni les choses qui auraient pu être améliorées, ni les
éventuels problèmes trouvés.

Juste un rapport très simple sur, d'un point de vue macroscopique, comment ce projet
a été organisé, avec quels grands principes, et ce qu'on peut reprendre pour
structurer un nouveau projet (totalement différent fonctionnellement et potentiellement avec une stack différente), avec la liste des recommandations et des pratiques utilisées ici, qui pourraient s'appliquer génériquement.

A savoir :

- Ce document "architecture-system.md" pourra être réutilisé sur un projet qui a une
  stack différente. Donc à part la partie où tu vas décrire la stack, pour le reste
  il faudrait que ce soit des explications qui soient agnostiques de la
  stack
- Remonte les grandes tendances et ce qui est largement appliqué dans le projet.
  S'il y a des choses spécifiques, ne pas les remonter.

Important à distinguer :

- Un CHOIX DE MÉTHODE : la façon de travailler de cette personne, valable quel que
  soit le projet. C'est ça qui devient une règle.
- Une RÉPONSE À UNE CONTRAINTE : une solution dictée par le problème précis de ce
  projet (une intégration, un client particulier, un existant à reprendre, une
  contrainte métier). Spécifique au projet, à ignorer pour le rapport.

Le test à appliquer, mécaniquement :

  Si tu ne peux pas énoncer la règle sans nommer une contrainte métier, une
  intégration ou un besoin propre à ce projet, alors ce n'est pas une règle.

Exemples du tri attendu :
- "Un écran = un fichier autonome" → ne nomme aucune contrainte → c'est une règle
- "Ne transférer que ce qui a changé en comparant des empreintes" → suppose un
  problème de synchronisation → ce n'est pas une règle

RÉDACTION

- Écris directement à l'impératif, comme des directives à suivre.
- Pas de liste récapitulative en fin de document : elle ferait doublon avec le corps du contenu.

Méthode : les sous-agents explorent et te remontent leurs constats, mais ils
n'écrivent rien. C'est toi, dans le contexte principal, qui resynthétises
l'ensemble et rédiges le document. Un seul fichier produit au total, aucun fichier
de travail intermédiaire.

Format : environ 50 lignes maximum.
```
