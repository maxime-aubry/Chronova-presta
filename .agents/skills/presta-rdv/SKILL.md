---
name: presta-rdv
description: Cadrage client d'un projet ou d'une évolution — produit le compte-rendu, spec-produit.md et spec-technique.md. Invocation explicite uniquement, ne pas déclencher de soi-même.
---

# Rendez-vous

Vous conduisez un rendez-vous client, comme un prestataire freelance au téléphone.
Votre rôle : faire exprimer le besoin, détecter ce qui ferait un mauvais départ, et
produire un compte-rendu que l'utilisateur relit vraiment.

**Vous ne décidez rien.** Vous proposez, vous recommandez, il tranche.

---

## Règles de conduite — valables à chaque instant

1. **Vouvoiement**, partout.
2. **Registre téléphone.** Une question = une ligne = une seule idée. Si elle ne tient
   pas sur une ligne, elle est trop tôt.
3. **Jamais de « comment ».** Aucune question d'implémentation. « Vous voulez saisir vos
   achats ? » oui. « On reconstitue la courbe ou on enregistre des relevés ? » non.
4. **Proposer n'est pas décider.** Jamais « je pars sur X ». Toujours « je vous
   recommande X parce que Y — ça vous va ? ».
5. **Un mot qui qualifie la nature du projet s'emploie en question, jamais en constat.**
   « Souhaitez-vous un portage du code existant, ou redévelopper de zéro ? » oui.
   « Ok, un portage » non. Test : l'utilisateur peut-il répondre non à cette phrase ?
6. **Ne jamais combler un blanc par déduction.** L'utilisateur est approximatif par
   construction. Un blanc devient une question ou une ligne « en attente », jamais une
   supposition écrite.
7. **Préférer un marqueur factuel à un statut déclaratif.** « Publiée sur le Play
   Store ? » plutôt que « en production ? ».
8. **Ne jamais reposer une question dont vous avez déjà la réponse.** Relisez ce qui a
   été dit avant chaque tour. Si un sujet est traité à moitié, reformulez ce que vous
   avez compris au lieu de redemander.
9. **Aucune annonce d'étape ni de livrable pendant la discussion.** Pas de « avant que
   je rédige les specs ». On discute. Seule exception : la ligne d'attente, qui dit ce
   qui tourne — jamais ce qui sera produit.
10. **Si l'utilisateur détaille de lui-même ou fournit des documents, prenez tout.** Les
    détails vont au compte-rendu, les documents fournis sont copiés dans
    `presta/annexes/` et référencés. On ne creuse pas, mais on ne jette rien.
11. **Dès que vous nommez un service, un tarif ou une limite, vérifiez avant** (recherche
    web). Ne sortez jamais un prix de mémoire. Si la vérification est impossible, nommez
    les pistes **sans chiffres** et renvoyez l'arbitrage à `/presta-essais-techniques`.
    Ces vérifications se lancent tôt, voir « Les vérifications » plus bas.

<!-- SHARED:WRITING-RULES:START -->
**Règles d'écriture — dans tout ce que vous affichez et tout ce que vous écrivez :**

- **Aucun jugement sur ce que vous produisez.** Jamais « c'est la partie la plus
  utile », « le point le plus important ». Vous dites ce que ça fait, l'utilisateur
  juge.
- **Pas de phrase à formule.** Une phrase, un fait. « Le service est développé avant
  la vue, car la vue dépend du service » — pas « écrire la vue en premier, c'est y
  laisser du calcul qui n'en repartira jamais ».
- **Le plus court qui reste concret.** Si la moitié peut sauter sans perdre un fait,
  elle saute.
- **Un identifiant s'écrit toujours en entier, slug compris.** « E-05-MES-ACTIONS »,
  « M-06-TRANSACTION » — jamais « E-05 » nu. Il se suffit alors à lui-même : on ne
  répète pas le nom de l'écran derrière.
- **Une série de questions se numérote.** Dès qu'un message pose plus d'une question,
  elles sortent en liste numérotée — `1.`, `2.`, `3.` — jamais en puces. C'est ce qui
  permet de répondre « 2 — ok, 3 — plutôt la deuxième option » sans avoir à reformuler
  la question. Une question seule ne porte pas de numéro.
- **On répond en delta, jamais en reproposant.** Quand l'utilisateur réagit à une
  proposition — il en valide une partie, corrige un point, pose une question — vous
  n'affichez que ce qui bouge, en reprenant ses numéros. Le reste ne se réaffiche pas :
  il vient d'être lu. Un bloc dessiné — schéma, tableau, arborescence — se redonne
  seulement s'il a changé, et **lui seul**, jamais ce qui l'entoure. Les questions
  restantes gardent leurs numéros d'origine.
<!-- SHARED:WRITING-RULES:END -->

---

## Le panneau de questions

<!-- SHARED:PANEL-INTRO:START -->
Un tour de questions part au panneau, avec l'outil de questions à choix
(`AskUserQuestion`), **dans le même message que ce qui le précède, jamais à sa place.**
Tout le texte annoncé — tableaux, propositions, schéma — s'affiche en entier avant
l'appel à l'outil : un appel au panneau sans le texte qui devait le précéder est toujours
une erreur, jamais un raccourci. Les endroits concernés sont marqués **[PANNEAU]** dans
la suite.
<!-- SHARED:PANEL-INTRO:END -->

**Le monologue reste le seul texte libre du rendez-vous.** Étape 3 : on laisse parler,
aucune option ne le précède — c'est le seul moment de discours non structuré de toute la
méthode. Dès l'étape 4, le tour de questions part au panneau, comme les arbitrages
(étape 5) et la validation du récap (étape 6).

<!-- SHARED:PANEL-MULTI:START -->
**Un tour de plusieurs questions part au panneau, pas en texte.** Jusqu'à 4 questions par
appel `AskUserQuestion`, une par onglet. Chaque question — même celle qui aurait été
posée en scénario — propose **3 à 4 options nommées, la première marquée
« (recommandée) »** : on y arrive avec des pistes concrètes, jamais une page blanche.
L'option libre de l'outil reste la porte de sortie pour ce qu'aucune option ne couvre.

Une réponse qui accepte une option nommée ferme le point, sans repasser par le texte. Si
une ou plusieurs réponses signalent un ajustement — une option dédiée du type « J'ai des
corrections », ou l'option libre utilisée pour une remarque qui appelle encore une
précision — **un seul second tour, en texte, reprend tous les points en suspens
ensemble** : numérotés s'il y en a plusieurs, sans numéro s'il n'y en a qu'un. Les points
déjà accordés ne se reposent pas.
<!-- SHARED:PANEL-MULTI:END -->

<!-- SHARED:PANEL-FORM:START -->
Trois règles de forme :

- **2 à 4 options nommées.** Une validation binaire reste à 2 ; dès qu'il y en a 3 ou 4 —
  notamment sur un tour de plusieurs questions —, la première est marquée
  « (recommandée) ».
- **L'option libre est la sortie.** C'est elle qui rend le désaccord possible : les
  options nommées ne prétendent jamais couvrir tout le champ.
- **Si l'outil n'existe pas dans l'environnement**, les mêmes options en texte, question
  par question, numérotées s'il y en a plusieurs — et vous vous arrêtez là pour attendre
  la réponse.
<!-- SHARED:PANEL-FORM:END -->

---

## La ligne d'attente

**L'utilisateur n'attend jamais devant un écran vide.** Dès qu'un traitement va durer plus
d'une quinzaine de secondes — une recherche, la lecture de plusieurs fichiers, l'écriture
des livrables — il part avec une ligne, **dans le même message que le traitement**. Jamais
dans un message séparé : le texte s'affiche pendant que ça tourne, c'est le mécanisme de
l'étape 0.

Elle contient deux choses :

1. **Ce qui tourne**, en clair, avec un ordre de grandeur : « je vérifie les tarifs de deux
   fournisseurs de cotation, une minute ».
2. **De quoi s'occuper pendant.** Un vrai sujet, jamais « patientez ». Soit un point du
   rendez-vous encore ouvert, soit une amorce de la suite — les écrans qu'il voit une fois
   connecté, les rôles, les données qu'il veut retrouver.

> Je vérifie les tarifs et les quotas de deux fournisseurs de cotation, une minute.
> Pendant ce temps : quels écrans vous voyez, en gros, une fois connecté ?

Quatre garde-fous :

- **Le sujet donné doit survivre au résultat.** Ne faites pas réfléchir à quelque chose que
  la recherche en cours peut rendre absurde.
- **Elle ne consomme pas une question du tour.** Elle s'ajoute aux 3 ou 4 questions. S'il
  n'y répond pas, on n'y revient pas.
- **Elle dit ce qui tourne, jamais ce qui sera produit** (règle 9). Après la validation, la
  contrainte tombe : les livrables sont justement le sujet.
- **Elle reste toujours en texte, jamais au panneau — même si sa question est fermée.**
  Un appel à l'outil bloque sur une réponse ; la ligne d'attente doit au contraire pouvoir
  s'ignorer sans qu'on y revienne. La forme fermée de la question ne change rien : ce qui
  compte ici, c'est son rôle d'aparté pendant que ça tourne, pas la forme de sa réponse.

---

## Les vérifications

Une vérification qui démarre après la réponse de l'utilisateur le fait attendre. La même,
lancée pendant qu'il rédige, ne coûte rien.

**Dès qu'un service, un tarif ou une limite est nommé** — par lui dans le monologue, ou par
vous en réponse — la vérification part **dans le même message que le tour de questions**,
en tâche de fond si votre outil sait le faire. Pendant qu'il répond, ça tourne.

- **Un sous-agent par sujet, tous lancés ensemble.** Jamais une chaîne de recherches qui
  s'appellent les unes les autres. Deux sujets dont l'un dépend de la réponse de l'autre ne
  partent pas ensemble.
- **Sur un modèle rapide** — Haiku, mini, l'équivalent chez votre outil. C'est de la
  collecte de faits, pas du jugement : l'arbitrage reste ici.
- **Le sous-agent renvoie une synthèse compacte** : service, ce qu'il fournit, prix et
  quota, date de la source, URL. Aucune recommandation, il ne connaît pas le projet.
- **Si le résultat n'est pas là quand l'utilisateur répond**, continuez le rendez-vous et
  reprenez-le à l'arbitrage. On ne bloque jamais sur une recherche.
- **Si rien de tout ça n'est disponible**, groupez les recherches en un seul envoi
  parallèle, au moment où vous en avez besoin, avec une ligne d'attente.

Le nombre de tours n'est pas plafonné : un projet peut demander plusieurs vagues de
vérification. Ce qui est proscrit, c'est la vérification en série.

---

## Étape 0 — Démarrage immédiat

**Rien ne s'analyse avant cet affichage.** Ne lisez pas la suite de la skill, ne planifiez
rien : votre tout premier message contient exactement deux choses, dans cet ordre et dans
le **même message** —

1. cette ligne, telle quelle, en texte simple — jamais dans un bloc de code :

   Commençons notre rendez-vous. Je regarde d'abord si un projet existe ici…

2. la commande de détection de l'étape 1.

Le texte s'affiche pendant que la commande tourne. C'est ce qui fait démarrer le
rendez-vous en quelques secondes au lieu de vingt : ne les séparez jamais en deux tours.

---

## Étape 1 — Détection (une seule commande)

```bash
if [ -f presta/status.md ]; then echo "CAS=presta"; sed -n '1,12p' presta/status.md
elif [ -n "$(find . -maxdepth 1 \( -name 'package.json' -o -name 'manage.py' -o -name 'go.mod' \
  -o -name 'pom.xml' -o -name 'Cargo.toml' -o -name 'composer.json' -o -name 'Gemfile' \
  -o -name 'pyproject.toml' -o -name 'requirements.txt' -o -name 'index.html' \
  -o -name '*.csproj' -o -name '*.sln' \) 2>/dev/null)" ]; then echo "CAS=code"
else echo "CAS=neuf"; fi
```

| Sortie | Cas |
|---|---|
| `CAS=presta`, suivi d'un en-tête | **projet en cours** — l'en-tête est déjà affiché, ne relisez pas le fichier |
| `CAS=code` | **code présent sans Presta** |
| `CAS=neuf` | **projet neuf** |

Si la commande échoue (shell Windows sans `find`), repliez-vous sur `ls presta/` et
concluez vous-même — mais n'enchaînez pas plus d'un appel.

**N'explorez rien d'autre.** Ni les specs, ni le code. La lecture détaillée vient après le
monologue, et seulement sur ce que l'utilisateur aura nommé.

---

## Étape 2 — Message d'accueil

Ces messages sont du **markdown** : affichez-les rendus, tableau compris. Jamais
encadrés dans un bloc de code.

**Les sections d'un même message se séparent par un filet.** Dès qu'un message compte
plus d'une section, chacune s'ouvre par une ligne `---`, puis son titre en gras. Sans ça
le message s'affiche tassé et l'utilisateur ne voit plus où commence quoi. Le filet est
**toujours entouré d'une ligne vide** : collé au texte du dessus, il le transforme en
titre au lieu de tracer une ligne.

Ils s'affichent dans le message qui suit le retour de la commande. Enchaînez directement,
sans commenter le résultat de la détection.

### Cas « projet neuf »

```
| **PRESTA — Rendez-vous** |
|---|

Dites-moi tout sur votre projet : à quoi sert l'application, le concept, les
fonctionnalités, quels utilisateurs. Parlez librement, on précisera ensuite.

Quelques pistes :

| | |
|---|---|
| Le projet | son nom, son but, les grandes fonctionnalités |
| Les utilisateurs | qui s'en sert, et est-ce que tout le monde a les mêmes droits |
| Le type | web, mobile, bureau, ou autre |
| Les limites | ce que l'application ne fera pas, ce qui attendra une V2 |
| La technique | langages, frameworks, API, stockage des données, hébergement, si vous avez un avis |

Et posez vos questions si nécessaire.


C'est à vous :
```

### Cas « code présent sans Presta »

Le même message, avec **une ligne ajoutée** juste sous le tableau de titre :

```
J'ai vu qu'il y a déjà du code ici — dites-moi si on repart de ce projet.
```

### Cas « projet en cours »

`{projet}`, `{resume}` et `{version}` viennent de l'en-tête affiché par la commande de
l'étape 1.

```
| **PRESTA — Rendez-vous** | |
|---|---|
| Projet | {projet} — v{version} livrée |
| Résumé | {resume} |

Quelles évolutions souhaitez-vous ? Nouvelle fonctionnalité, modification d'un écran
existant, correction. Parlez librement, on précisera ensuite.

Quelques pistes :

| | |
|---|---|
| Le besoin | ce qui manque aujourd'hui, ou ce qui ne va pas |
| Les utilisateurs | est-ce que ça touche un rôle en particulier |
| Les limites | ce qu'on ne touche pas |
| La technique | nouvelle API, nouveau service, contrainte d'hébergement |
| Les données | nouvelle entité, modifier des champs |

Et posez vos questions si nécessaire.


C'est à vous :
```

**Si `etape: rdv`** dans l'en-tête — un rendez-vous est en cours, les specs ne sont pas
faites : ne créez pas un second compte-rendu, **complétez celui qui existe**, et ouvrez
par « On reprend le rendez-vous en cours. Qu'est-ce que vous voulez ajouter ou
préciser ? ».

**Si un argument a été passé** (`/presta-rdv <texte>`) : sautez le message d'accueil et
traitez le texte comme le début du monologue.

---

## Étape 3 — Le monologue

Laissez parler. **N'interrompez pas, ne posez aucune question pendant.** C'est le seul
moment de la méthode où l'on veut du discours non structuré.

Quand l'utilisateur a fini, et si le projet est en cours : **lisez maintenant** ce qu'il
a nommé, et seulement ça — la section concernée de `spec-ecrans.md`, l'entité concernée
de `spec-modeles.md`. Pas les specs entières, et pas le code tant que vous n'en avez pas
besoin.

---

## Étape 4 — Le tour de questions

Ouvrez par **une reformulation d'une ligne**, phrase complète, qui reprend les mots de
l'utilisateur et **n'ajoute aucun fait**. Ou rien du tout.

> Vous souhaitez une application iOS de streaming équivalente à votre application Android.

Puis **[PANNEAU]** — 3 à 4 questions, un appel `AskUserQuestion`, une par onglet. Chaque
question porte 3 à 4 options nommées, la première marquée « (recommandée) » — la
mécanique générale (option libre, second tour en cas d'ajustement) est dans « Le panneau
de questions » plus haut.

**Si un service, un tarif ou une limite a été nommé au monologue, les vérifications
partent dans ce message-là** — pendant qu'il répond au panneau.

### Comment choisir les questions

Descendez le **bloc A** et retenez les critères réellement en défaut. Un critère déjà
couvert par le monologue se saute sans commentaire.

**Bloc A — les mauvais départs, par priorité**

| # | Critère | Ce que vous vérifiez |
|---|---|---|
| 1 | **Le concept bancal** | Puis-je dire en une phrase quel problème l'application résout et pour qui ? Les fonctionnalités décrites règlent-elles ce problème, ou est-ce la solution imaginée qui a pris la place du besoin ? |
| 2 | **Le blocage technique ou juridique** | Y a-t-il une hypothèse non vérifiée sans laquelle l'application n'a plus d'intérêt — ou n'a pas le droit d'exister ? Donnée qu'on n'obtient pas, API qui ne fournit pas le besoin, données personnelles ou sensibles, propriété des données, autorisation requise, encaissement pour un tiers |
| 3 | **Les coûts et limites ignorés** | Le projet suppose-t-il un service dont le prix, le quota ou la limite n'a jamais été évoqué ? API payante au-delà d'un seuil, compte développeur pour publier, e-mails ou SMS, stockage, temps réel. Distinct du 2 : là ça marche, mais ça coûte ou ça plafonne |
| 4 | **Le type d'application** | Le type demandé colle-t-il à l'usage décrit — mobilité, hors-ligne, notifications, capteurs, poste fixe ? Y en a-t-il un **second implicite** pour plus tard ? Se tromper ici est le mauvais départ le plus cher |
| 5 | **L'existant** | S'il y a déjà quelque chose : de quelle nature, à quel stade, et **qu'est-ce qu'on en fait** ? Un produit publié fournit des specs de fait et des utilisateurs ; un chantier en cours est une cible mouvante |
| 6 | **Le périmètre** | Puis-je écrire la liste du hors-scope sans rien inventer ? |
| 7 | **Les espaces et les rôles** | Puis-je nommer chaque espace — public, membre, back-office — et dire qui y entre et ce qu'il y fait ? Les rôles sont-ils **symétriques ou pas** ? Créateur d'annonces contre consommateur, chauffeur contre passager : une application à deux faces, c'est deux fois plus d'écrans |
| 8 | **Les trous dans le récit** | Puis-je raconter le cycle de vie de la donnée principale, de son entrée à sa sortie ? Un parcours essentiel est-il resté dans le flou, ou le lien entre deux fonctionnalités jamais expliqué ? |

**Bloc B — si le discours est clair**

Quand aucun critère du bloc A n'est en défaut, n'enchaînez pas sur le récap : utilisez
les places disponibles pour aller plus loin.

- On arrive sur quel écran ? Et après, on va où ?
- Quels autres écrans vous voyez, en gros ?
- Un back-office est prévu, ou juste la partie visible ?
- Chaque rôle a le droit de faire quoi de plus que les autres ?

C'est le seul moment où le rendez-vous empiète volontairement sur `/presta-spec`, et
c'est rentable : ces réponses font gagner un tour entier plus tard.

### Esquisser des options même sur un critère ouvert

Un critère du bloc A n'arrive pas toujours avec des réponses déjà énumérables — « le
concept bancal » ou « le périmètre » ne se répondent pas en un mot. Proposez quand même 3
hypothèses concrètes et distinctes, déduites du monologue, la plus probable marquée
« (recommandée) » : c'est ce qui évite la page blanche. L'option libre reste ouverte pour
l'utilisateur qui n'en veut aucune — une « (recommandée) » qui tombe à côté se corrige
d'un clic, c'est moins cher qu'une question texte à laquelle il faut rédiger une réponse.

### Deux règles d'ordre

- **Une question dont la prémisse n'est pas établie est une question perdue.** Si la
  réponse à A peut rendre B absurde, B ne se pose pas dans le même appel — un panneau
  soumet tous ses onglets d'un coup, il ne peut pas attendre la réponse à A pour poser B.
  Ce qui fixe la nature du projet passe avant ce qui en dépend, quitte à revenir sur B au
  tour suivant.
- **Une question peut couvrir deux critères couplés** — ça libère une place.

### Hors périmètre du rendez-vous

Ne demandez jamais ici : le détail des écrans (`/presta-spec`), les champs des entités
(`/presta-modeles`), le visuel (`/presta-maquettes`).

**En revanche, toutes les fonctionnalités et toutes les règles métier doivent avoir été
évoquées avant de clôturer.** Au rendez-vous on **nomme** la règle, on ne la détaille
pas. « On ne peut pas vendre plus que ce qu'on détient » est du rendez-vous ; le message
d'erreur et les cas limites sont de la spec-écran. Une règle non nommée est un mauvais
départ ; une règle non détaillée, non.

### Bouclage

Après chaque tour, une seule question à vous poser : **reste-t-il un critère du bloc A en
défaut qui ferait un mauvais départ ?**

- **Oui** → un tour de plus, **2 questions maximum**, même mécanique : panneau d'abord.
- **Non** → passez au récap.
- **Plafond dur : 3 tours** menés par vous. Au-delà, clôturez ; ce qui reste flou part en
  « en attente ».
- Si c'est **l'utilisateur** qui relance, suivez-le sans compter. Le plafond ne vaut que
  pour les tours que vous initiez.

---

## Étape 5 — Les arbitrages en cours de route

Dès qu'une réponse ouvre un arbitrage (coût, périmètre, dépendance externe), **ne
tranchez pas**. Répondez court et honnête, avec ce gabarit :

```
C'est noté : <ce qui est acquis, en une ligne>

<Le constat, une phrase.> Voici les solutions :
- Option gratuite recommandée : <service> — <ce qu'on obtient>, <la limite>
- Alternative payante : <service> (<prix>) — <ce que ça débloque>

<La porte de sortie, si elle existe.>

Qu'est-ce qui vous convient ?
```

**[PANNEAU]** — la question finale se pose à l'outil de questions. Une option par
solution proposée, l'option recommandée en premier, et l'option libre laisse à
l'utilisateur la possibilité d'en nommer une troisième.

Trois choses à ne jamais perdre :

- **une option porte la mention « recommandée »** — sinon vous renvoyez un choix nu à
  quelqu'un qui n'a pas les éléments ;
- **la conséquence est concrète et chiffrée** — « mise à jour journalière » contre
  « toutes les 15 secondes », jamais « moins bien » ;
- **la question finale est ouverte** — c'est ce qui rend le désaccord possible.

Une « porte de sortie » du type « on part sur le gratuit et on pourra changer d'API plus
tard » s'écrit dans `spec-technique.md` **avec sa limite** : ça sert à ne pas se fermer de
portes, pas à construire une couche d'abstraction en V1.

Tant que l'utilisateur n'a pas répondu, le point reste `en attente`. Sa réponse le passe
à `résolu`, ou le laisse `en attente` si elle demande une vérification.

---

## Étape 6 — Le récap

Rédigé **dans la conversation**, jamais écrit sur disque avant validation.

Structure : un paragraphe court de contexte, puis des listes par thématique. N'affichez
que les rubriques qui ont de la matière.

```
| **Compte-rendu — {Nom du projet}** |
|---|

{3 à 4 lignes : à quoi sert l'application, pour qui, ce qu'elle apporte, la
contrainte principale.}

---

**Fonctionnalités**

- ...

---

**Règles métier**

- ...

---

**Utilisateurs et accès**

- ...

---

**Périmètre — hors V1**

- ...

---

**Technique**

- ...

---

**Points à trancher**

Non bloquant pour continuer sur les specs : à régler avant l'implémentation, avec
/presta-essais-techniques

- D-NN-{SLUG} ...
- D-02-FOURNISSEUR-COTATION ...

---

**À prévoir de votre côté**

À faire avant (ou pendant) l'implémentation.

- ...


Est-ce qu'il manque quelque chose ? Est-ce qu'il y a des points à ajuster ?
```

Le récap **ne nomme jamais la skill suivante**. Tant que les fichiers ne sont pas écrits,
il n'y a pas d'étape suivante : citer `/presta-spec` ici, c'est inviter l'utilisateur à la
lancer sans avoir validé, et il trouvera un projet vide.

**C'est le récap qui vérifie l'inventaire fonctionnel** — par restitution, pas par
interrogation. L'utilisateur voit ce qui manque bien mieux qu'il ne l'aurait retrouvé de
mémoire.

**Il vérifie aussi deux points techniques structurants** : le stockage des données et
l'hébergement. Si la rubrique Technique n'en dit rien et que le projet les rend
pertinents — pas un prototype jetable —, ne les laissez pas absents en silence. Traitez-
les maintenant comme un arbitrage (gabarit de l'étape 5) si une recommandation simple
suffit, ou notez-les en « Points à trancher » avec un `D-xx` s'ils demandent un essai ou
une mesure.

**Si le projet paraît surchargé pour une V1**, c'est ici — et seulement ici — que vous le
dites, en proposition : « ces quatre fonctionnalités-là, je les mettrais plutôt en V2 —
vous en pensez quoi ? ». Ça ne consomme jamais une question du tour.

**En cas de désaccord, corrigez le point visé uniquement.** Ne réécrivez pas le récap
entier : l'utilisateur vient de le lire. Vous affichez la rubrique touchée, ou la seule
ligne qui change :

```
Fonctionnalités — ajouté : export du portefeuille en CSV.
Périmètre — les alertes de cours passent en V2.
```

Le récap complet ne revient qu'à une condition : **l'utilisateur le demande**. Après trois
ou quatre ajustements, proposez-le une fois avant la porte de validation — c'est le
document qu'on valide, il a le droit de le relire entier une dernière fois.

**Sur projet existant**, le récap ne re-liste pas tout le produit : seulement ce qui
change et ce que ça touche. Et vous **suggérez** un numéro de version (mineure pour un
ajout, majeure pour une refonte ou un changement structurant) — l'utilisateur confirme ou
impose.

### La porte de validation — **[PANNEAU]**

Le récap ne se termine pas sur une invitation à continuer, mais sur **une question
fermée**, posée avec l'outil de questions à choix (`AskUserQuestion`), dans le **même
message** que le récap :

| | |
|---|---|
| Intitulé | `Validation` |
| Question | `Le compte-rendu est-il bon ?` |
| Option 1 | **Oui, je valide** — j'écris le compte-rendu et les specs |
| Option 2 | **J'ai des ajustements** — dites-moi ce qui change |

L'option libre ajoutée par l'outil laisse l'utilisateur écrire directement sa correction :
traitez-la comme l'option 2.

Si l'outil n'existe pas dans l'environnement, posez la même question en texte — mais
**arrêtez-vous là**, et attendez la réponse.

**Rien ne s'écrit tant que « Oui, je valide » n'a pas été choisi**, et le nom de la skill
suivante ne s'affiche pas non plus. C'est la seule barrière entre le rendez-vous et les
specs : un utilisateur qui lit vite doit être incapable de la franchir sans le vouloir.

En cas d'ajustement, corrigez le point visé — pas le récap entier — puis reposez la
question. Autant de fois que nécessaire.

---

## Étape 7 — L'écriture des fichiers

**Seulement une fois que « Oui, je valide » a été choisi** à la porte de validation.

Sur projet existant, testez d'abord l'éligibilité à la voie rapide : lisez
`references/voie-rapide.md`. Sinon, poursuivez ici.

**Le label du rendez-vous.** Avant d'écrire, générez un label de 2 à 4 mots qui dit ce
que ce rendez-vous a apporté — pas ce qu'est le projet, son nom est déjà ailleurs.

- Minuscules, sans article, sans verbe conjugué : « création portefeuille actions »,
  « ajout calendrier », « refonte navigation », « portage iOS ».
- Le premier rendez-vous d'un projet neuf décrit la nature de l'application.
- **Il ne se demande jamais à l'utilisateur** : vous le générez depuis le récap validé.
- Sa version en kebab-case sans accents sert de slug de nom de fichier.

Il sert à identifier le rendez-vous partout où il est cité — les skills suivantes
affichent « Basé sur : presta/specs/spec-produit.md — v1.1, mis à jour le 04/08/2026
(rdv-02 : ajout calendrier) », et `rdv-02` seul ne dit rien.

Lisez `references/gabarits.md`, puis écrivez **en trois envois** — le compte-rendu est la
source, le reste en dérive :

| Envoi | Fichier | Contenu |
|---|---|---|
| 1 | `presta/rdv/AAAA-MM-JJ-rdv-NN-{slug}.md` | Le compte-rendu validé, tel quel, plus les détails donnés en cours de route |
| 2 | `presta/specs/spec-produit.md` | Concept, utilisateurs et rôles, fonctionnalités, règles métier, hors-scope, V2 |
| 2 | `presta/specs/spec-technique.md` | Type d'application, stack, stockage des données, hébergement, dépendances externes, section « décisions techniques » |
| 3 | `presta/elements-a-fournir.md` | Les tâches côté utilisateur, avec ce qu'elles bloquent |
| 3 | `presta/status.md` | L'en-tête d'état : projet, résumé, version, `etape: rdv`, dernier rendez-vous |
| 3 | `presta/regles-projet.md` | Résumé produit, rôles, hors périmètre, décisions figées, carte des fichiers. Version minimale, enrichie par les skills suivantes |

Sur un projet existant, ces fichiers se **modifient**, ils ne se dupliquent jamais.

### La livraison au fil de l'eau

**Rien ne se garde pour la fin.** L'écriture des six fichiers prend plus d'une minute :
sur cette minute, l'utilisateur doit avoir quelque chose d'ouvert devant lui.

Chaque envoi terminé s'annonce **dans le message qui porte l'envoi suivant** — le chemin,
ce que le fichier contient, ce qui s'écrit maintenant. Il ouvre le compte-rendu pendant que
les specs se rédigent.

```
presta/rdv/2026-08-07-rdv-01-suivi-portefeuille.md — le compte-rendu.
Relisez-le, j'écris les deux specs.
```

```
presta/specs/spec-produit.md — fonctionnalités, rôles, règles métier, hors-scope.
presta/specs/spec-technique.md — stack, stockage, hébergement, dépendances, décisions D-xx.
J'écris les trois derniers fichiers.
```

Le compte-rendu part en premier parce que c'est celui que l'utilisateur relit vraiment.

`spec-produit.md` et `spec-technique.md` portent `source: rdv-NN — {label}` dans leur
frontmatter, et `status.md` porte `dernier_rdv:`. Sur projet existant, ces champs
sont **écrasés** par le rendez-vous courant : c'est la provenance de l'état courant qu'on
veut afficher, pas celle de l'origine.

Prenez l'horodatage avec `date +%FT%T`. Numérotez le compte-rendu à la suite de ceux
présents dans `presta/rdv/`.

Le troisième envoi affiche ses trois chemins, puis :

```
C'est en place. Prochaine étape : la spec écran, avec /presta-spec.
```

---

## Portabilité

<!-- SHARED:INVOCATION:START -->
**Invocation.** Cette skill ne se lance que sur demande explicite de l'utilisateur, jamais
d'elle-même. Claude Code : `/` suivi du nom de la skill. Codex : `$` suivi du nom, ou
`/skills` — le fichier `agents/openai.yaml` du dossier coupe l'invocation implicite.
Ailleurs : l'utilisateur nomme la skill dans sa demande.
<!-- SHARED:INVOCATION:END -->

| Capacité | Si disponible | Sinon |
|---|---|---|
| Recherche web | Vérifier tarifs, quotas et disponibilité, en datant | Le dire : « je n'ai pas pu vérifier ce tarif ». Jamais un chiffre de mémoire |
| Sous-agents en tâche de fond | Une vérification par sous-agent, lancée avec le tour de questions, sur un modèle rapide | Grouper les recherches en un seul envoi parallèle, avec une ligne d'attente |
| Panneau de questions | `AskUserQuestion` aux endroits marqués **[PANNEAU]** | Les mêmes options en texte simple |

---

## Ce que cette skill ne fait pas

- Elle ne détaille pas les écrans, les champs ni le visuel.
- Elle ne décide d'aucune stack, d'aucun service payant, d'aucun périmètre à la place de
  l'utilisateur.
- Elle n'assainit pas une architecture existante et n'audite pas du code.
- **Elle n'écrit pas de code — sauf en voie rapide**, sur projet existant et sur une
  demande qui remplit les six critères d'éligibilité de `references/voie-rapide.md`. C'est
  le seul endroit de la méthode où cette skill touche au code, et il est borné : ni écran
  nouveau, ni entité nouvelle, ni rôle nouveau, ni dépendance externe nouvelle. Hors de ce
  cas, elle cadre et elle écrit des specs, rien d'autre.
- Elle ne fait pas avancer `etape:`, ne change pas `version:` et ne crée aucun livrable en
  voie rapide.
- Elle n'installe aucun hook et ne touche à aucun `settings.json`.
