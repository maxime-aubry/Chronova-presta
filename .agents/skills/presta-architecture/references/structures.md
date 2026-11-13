# Structures, conventions natives et décisions de structure

Lu avant la première proposition de la **porte 1**. Sert aussi en porte 2 et 3, pour dire
ce qui se traduit dans la stack cible et ce qui ne se traduit pas.

---

## Les structures qu'on sait nommer

Une structure se **nomme**, et elle s'accompagne d'une ligne qui dit ce qu'elle sépare.
Une architecture non nommée ne se conteste pas.

| Structure | Quand elle s'impose | Stacks typiques |
|---|---|---|
| **MVC / MVT + couche métier** | Web rendu serveur, écrans CRUD | Django, Rails, Laravel, ASP.NET MVC |
| **Par composants** | UI riche, état local, écrans composés | Blazor, React, Next, Vue, Nuxt |
| **Vertical slice** — tout ce qui concerne une fonctionnalité au même endroit : vue, service, modèle | Projet qui va grossir, implémentation par sous-agents successifs | .NET, Next, applications Django |
| **Monolithe modulaire** — modules à frontières explicites, un seul déploiement | Plusieurs parties distinctes : espace membre, back-office, données de marché | Toutes |
| **Client / serveur découplé** — API d'un côté, front de l'autre | Un second client est prévu : mobile, application tierce | Django REST + Next, ASP.NET API + Blazor WASM |
| **Ports et adaptateurs** (hexagonal) | Beaucoup d'intégrations externes, ou domaine à tester sans base | Toutes — coût réel, à ne proposer que motivé |

**Elles se combinent.** « MVT avec une couche métier, organisé en vertical slice » est une
réponse plus juste que l'étiquette unique qui n'existe pas.

**Deux propositions au maximum** : le défaut de la stack, et une alternative si elle se
défend. Trois options sur un sujet que l'utilisateur ne maîtrise pas, c'est un choix qu'il
ne peut pas faire.

### Ce qu'on ne propose jamais

Microservices, CQRS, event sourcing, clean architecture complète, DDD tactique. Coût
certain, problème hypothétique. Même règle que pour les patrons de conception : ça
s'ajoute le jour où un problème le demande.

---

## Les conventions natives, par framework

Le point de départ d'une proposition. **Vérifiez-les contre la version du projet** : ce
tableau donne le niveau stable, pas les changements de version majeure.

| Framework | Découpage natif | Unité |
|---|---|---|
| **Django** | Une application par partie du produit, contenant `models.py`, `views.py`, `urls.py`, `forms.py`, `templates/` | l'application |
| **Rails** | Par type au niveau du projet — `app/models`, `app/controllers`, `app/views` | le dossier de type |
| **Laravel** | Par type — `app/Models`, `app/Http/Controllers`, `resources/views` | le dossier de type |
| **ASP.NET MVC** | Par type — `Controllers/`, `Models/`, `Views/` | le dossier de type |
| **Blazor** | Par type — `Pages/`, `Components/`, `Services/`, `Models/`, un `.razor.css` par composant | le composant |
| **React / Next** | Par route dans le dossier de routage, composants et fonctions à côté | le composant, la route |
| **Vue / Nuxt** | Par type — `pages/`, `components/`, `composables/`, `stores/` | le composant |
| **FastAPI / Flask** | Peu conventionné : c'est justement là que la décision compte le plus | à décider |

**Une proposition s'énonce en trois temps** : ce que le framework conventionne, ce qu'on
ajoute par-dessus, ce dont on s'écarte et pourquoi. Le troisième temps est ce qui rend le
document contestable.

### Ce qui change avec les versions

Ce qui bouge, ce ne sont pas les principes, ce sont les ruptures de structure. Quelques
exemples de ce qu'une recherche doit viser quand la version est plus récente que ce que
vous savez décrire :

- un nouveau système de routage qui déplace les fichiers,
- des modes de rendu qui changent le découpage du projet,
- un mécanisme intégré qui remplace une brique tierce — tâches de fond, journalisation,
  authentification.

La recherche est **ciblée sur la structure de projet et les conventions**, jamais sur la
liste des nouveautés de la version.

---

## Les trois décisions de structure

Elles se prennent une fois, ici. Le reste s'en déduit.

| Décision | Ce qui se joue |
|---|---|
| **Le découpage en couches**, et ce que chacune n'a **pas** le droit de faire | Le squelette, et le premier point contrôlé par `/presta-audit` |
| **Le regroupement des fichiers** : par fonctionnalité, ou par type technique | Par fonctionnalité vieillit mieux sur un gros projet, par type est plus simple à démarrer. Le défaut du framework tranche le plus souvent |
| **L'accès aux données** : ORM appelé directement, ou passage obligé par un repository | C'est ici qu'on décide si l'ORM fuite dans toute l'application. Structurant et difficile à défaire |

---

## La pièce qu'on oublie : les tâches de fond

Aucune de ces structures ne la couvre, et elle apparaît dès qu'il y a une synchronisation
planifiée, un envoi différé ou un traitement long. Trois questions, au point 1 :

- qui la déclenche — planificateur intégré, file d'attente, service externe ;
- où vit le code, et ce qu'il a le droit d'appeler ;
- ce qui se passe si elle échoue, et où ça se voit.

Beaucoup de frameworks ont désormais un mécanisme intégré. Vérifiez avant de proposer une
brique tierce.

---

## Le tri, en porte 2 et en porte 3

Le même test que celui du prompt d'extraction, appliqué dans l'autre sens : **on garde ce
qui s'énonce sans nommer une contrainte du projet source.**

- « Un écran = un fichier autonome » → aucune contrainte nommée → se transpose.
- « Séparer la donnée du fournisseur de la donnée saisie » → suppose une intégration
  précise → ne se transpose pas tel quel, ça devient une question.

Ce qui se transpose se réénonce **dans le vocabulaire de la stack cible**, en tableau à
deux colonnes : la règle d'origine, ce qu'elle devient ici.
