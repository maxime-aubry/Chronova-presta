# La voie rapide

À lire **uniquement** sur un projet existant, au moment du récap.

Ce n'est pas un second mode de fonctionnement : c'est le rendez-vous qui produit soit une
proposition complète, soit **un devis d'une ligne**. Même skill, même conversation, taille
de sortie différente. En prestation, un client qui demande une petite modification
n'obtient ni specs ni proposition commerciale — il obtient un devis d'une ligne, et on le
fait.

---

## Les six critères d'éligibilité

**Tous obligatoires.** Un seul qui saute → processus normal.

1. Projet existant, avec specs et code en place — **jamais sur greenfield**
2. **Aucun écran nouveau** (un écran *modifié*, oui ; un écran *de plus*, non)
3. **Aucune entité nouvelle** (un champ de plus sur une entité existante, oui)
4. **Aucun rôle nouveau, aucune modification de permissions**
5. **Aucune dépendance externe nouvelle** — pas de nouvelle API, pas de nouvelle clé
6. **Ne touche aucun point encore `en attente`** dans `spec-technique.md`

**En cas de doute, c'est la voie longue.** L'erreur n'est pas symétrique : traiter à tort
une petite demande par le processus complet coûte vingt minutes d'agacement ; traiter à
tort une grosse demande en une fois coûte une application cassée et des specs fausses.

---

## La proposition

Affichez les critères. C'est ce qui rend le désaccord possible : sans eux, l'utilisateur
ne peut que faire confiance ou refuser en aveugle, il n'a aucune prise pour dire « attends,
ça touche aussi l'écran de facturation ».

```
Cette demande est petite et peut être traitée directement, sans dérouler toute la
méthode : elle ne crée aucun écran, aucune nouvelle entité et aucune dépendance
externe.

Si vous êtes d'accord, je procède ainsi : je mets d'abord à jour spec-modeles.md et
spec-ecrans.md, je vous montre ce qui change, puis j'implémente — et je vous laisse
deux ou trois points à vérifier vous-même à la fin.

Confirmez-moi que je pars comme ça, ou dites-le si vous préférez que je déroule la
méthode complète.
```

Adaptez les fichiers cités à ce que la demande touche réellement. Les trois éléments à ne
jamais perdre : **le pourquoi c'est petit**, **les noms de fichiers**, **les points à
vérifier**.

---

## Le déroulé

**L'ordre est non négociable.**

1. **Mettre à jour les spécifications concernées**, frontmatter compris : `maj:` à
   l'horodatage du moment (`date +%FT%T`) et `source: rdv-NN — {label}`. Sans ça, la spec
   dit qu'elle vient du rendez-vous précédent alors que le code vient de celui-ci.
   **Si `spec-ecrans.md` est touchée**, la règle de propagation s'applique — voir les
   gabarits de `/presta-spec` : `acces-par-role.md` à régénérer, aperçus périmés à
   signaler.
2. **Montrer ce que ça change** — le diff, ou les lignes touchées.
3. **Implémenter**, puis vérifier que ça compile et que ça se lance.
4. **Écrire la mini-recette** et la donner à dérouler.
5. **Commit.**

Jamais « j'implémente et j'aligne après » : on obtiendrait des specs qui décrivent une
intention et un code qui fait autre chose, ce qui est pire que pas de specs du tout.

---

## La mini-recette — obligatoire

2 à 3 étapes concrètes que l'utilisateur déroule lui-même, avec les vrais libellés et les
vraies URL.

C'est le point le plus important de toute la voie rapide : c'est le seul endroit de la
méthode sans phase, sans vérificateur et sans cahier de recettes — donc le seul où l'IA
validerait son propre travail sans témoin. **Sans elle, la voie rapide devient la porte
dérobée par laquelle le vibe coding rentre dans la méthode.**

---

## Si l'implémentation révèle des dépendances imprévues

**On ne s'arrête pas.** Ce qui a été convenu est convenu, on le livre — un prestataire ne
laisse pas un chantier à moitié. On note les points découverts et on les remonte à la fin :

> J'ai implémenté ce qui était convenu ; je me suis aperçu au passage qu'il y avait aussi
> ceci, cela. Voulez-vous qu'on fasse un rendez-vous sur ces points ?

**Exception unique :** si terminer ce qui était convenu **casse quelque chose qui
marchait** — une migration qui fait tomber un écran existant, par exemple — on interrompt
et on prévient. Le projet doit rester compilable et lançable, c'est non négociable. La
distinction est entre *incomplet* (on livre et on signale) et *cassé* (on s'arrête et on
appelle).

Les points découverts vont dans le compte-rendu daté de `presta/rdv/` ; les inconnues
techniques vont dans `spec-technique.md` avec le statut `en attente`.

---

## Trace

- Un fichier daté dans `presta/rdv/`, **trois lignes suffisent** — un rendez-vous reste un
  rendez-vous.
- **`presta/status.md` : deux champs et une ligne.** `dernier_rdv:` prend le rendez-vous
  qu'on vient de faire, `maj:` la date du jour, et la ligne de corps dit ce qui vient
  d'être livré. **`etape:`, `version:` et `livrable_courant:` ne bougent pas** — il n'y a
  ni phase, ni découpage, ni nouveau livrable, et c'est exactement le principe de la voie
  rapide.
- **Pas de dossier de livrable** pour une modification d'une ligne : le diff des specs est
  dans git.
- **Un commit à la fin**, pour la même raison que les phases en font un.
