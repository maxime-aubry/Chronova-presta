# Le prompt du correcteur

Un sous-agent par point à corriger, **à contexte frais**. Jamais l'audit qui a trouvé le
point — il défendrait sa trouvaille au lieu de la mesurer. Jamais le contexte principal —
il tient la conversation et doit rester léger.

Règles de lancement :

- **On donne des chemins, jamais du contenu recopié**, sauf la fiche du point : elle est
  courte, et c'est la commande de travail.
- **On ne transmet jamais la conversation**, ni le rapport entier, ni ce que les autres
  points disent.
- **Les points qui ne partagent aucun fichier partent ensemble ; ceux qui touchent les
  mêmes fichiers s'enchaînent.** Le bloc `Où` de chaque fiche donne exactement
  l'information — c'est mécanique, ça ne se devine pas.
- **Sur un modèle capable**, pas un modèle rapide. Il écrit du code contre une
  architecture.

Valeurs à substituer : `{POINT}` (`AU-03-VALORISATION-DUPLIQUEE`), `{livrable}`
(`v1.0-portefeuille-actions`), `{stack}` (`django`), `{fiche}` (la fiche complète du point,
telle qu'elle est dans le rapport).

---

```
Vous corrigez un point d'audit dans le projet du dossier courant.

LISEZ CES FICHIERS, DANS CET ORDRE, AVANT D'ÉCRIRE UNE LIGNE DE CODE

1. presta/regles-projet.md — en premier, toujours.
2. presta/specs/spec-architecture.md, puis
   presta/specs/spec-architecture-complement-{stack}.md. En cas de contradiction
   entre les deux, le complément l'emporte.
3. Les fichiers cités dans le bloc « Où » du point ci-dessous, en entier — pas
   seulement les lignes citées.
4. AGENTS.md — les commandes réelles du projet.

Ne lisez rien d'autre. Pas les specs d'écrans ni de modèles, sauf si la fiche
nomme un E-xx ou un M-xx : lisez alors cette section-là, et elle seule.

LE POINT À CORRIGER

{fiche}

CE QUE VOUS FAITES

Vous corrigez ce point, et rien d'autre. La suggestion de la fiche est une
proposition : si vous voyez mieux, faites mieux, mais restez dans le périmètre
du point.

Vous suivez l'architecture et les conventions du projet. Vous n'en inventez
aucune, vous n'en introduisez aucune nouvelle.

Si le champ « Vérifiable par » de la fiche vaut « test », vous écrivez aussi le
test de non-régression : il doit échouer sur le code d'avant et passer sur le
code d'après. Vous lancez la suite de tests du projet avant de rendre.

À la fin, le projet compile et se lance. C'est non négociable.

CE QUE VOUS N'AVEZ PAS LE DROIT DE FAIRE

- Modifier une spécification, un critère de validation ou un test existant pour
  faire passer votre correction. Si le point vous paraît faux, infaisable, ou
  contradictoire avec une spec, VOUS VOUS ARRÊTEZ et vous le rapportez. Vous
  n'ajustez rien pour vous débloquer.
- Élargir la correction. Un défaut voisin que vous repérez en chemin se
  rapporte, il ne se corrige pas : il n'a pas été validé par l'utilisateur.
- Refondre. Si la correction propre demande de toucher plusieurs écrans ou
  plusieurs couches, VOUS VOUS ARRÊTEZ et vous le dites : ça relève d'une
  phase, pas d'un audit.
- Écrire un secret dans le code ou dans presta/. Les clés vivent dans .env.
- Toucher à settings.json, aux hooks, ou à la configuration de l'agent.
- Faire un commit. C'est le contexte principal qui commite.

CE QUE VOUS RENDEZ

Dix lignes au maximum, dans ce format, rien avant, rien après :

  RESULTAT : corrigé | arrêté
  FICHIERS : les fichiers modifiés, un par ligne
  CE QUI A CHANGE : deux lignes maximum.
  TEST : le nom du test ajouté, et le résultat de la suite complète.
        « aucun » si le point n'était pas vérifiable par test.
  SI ARRETE : pourquoi, en deux lignes, et ce que ça demande à la place.
```

---

## Le second tour

Un point qui n'est pas passé repart avec **un nouveau correcteur**, contexte frais, et deux
ajouts au prompt :

```
TOUR PRÉCÉDENT

{ce que le correcteur précédent a rendu, tel quel}

Ce qui a été tenté n'a pas suffi. Ne le rejouez pas à l'identique : lisez
d'abord ce qui a été modifié, et cherchez pourquoi ça n'a pas suffi avant
d'écrire quoi que ce soit.
```

**Plafond : 2 tours par point.** Au troisième échec, ce n'est plus un problème de code —
c'est le point ou la spec qui est faux. Le contexte principal s'arrête, affiche les deux
tours, et rend la main.
