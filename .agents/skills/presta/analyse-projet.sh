#!/usr/bin/env bash
# /presta — état d'un projet Presta.
#
# Se lance depuis la racine du projet :  bash {skill}/analyse-projet.sh
#
# Il ne rend pas des données à interpréter : il rend le message à afficher, en entier,
# prêt à recopier — tableau coché compris. Toute la composition se fait ici : les
# marqueurs d'étape, les compteurs, les noms, les accords, l'étape suivante. Le modèle
# ne calcule rien et ne rédige rien.
#
# La taille de ce fichier ne coûte rien : le modèle écrit son chemin, pas son contenu.

# ---------------------------------------------------------------- le vocabulaire

CMD=( "" "/presta-rdv" "/presta-spec" "/presta-modeles" "/presta-maquettes" \
      "/presta-valide-specs" "/presta-architecture" "/presta-phases" "/presta-setup" \
      "/presta-tests" "/presta-implemente" )
LIB=( "" "Rendez-vous" "Spécifications : écran par écran" "Modèles de données" \
      "Maquettes et design system" "Validation des specs" "Architecture du code" \
      "Découpage en phases" "Initialisation du projet" "Mécanismes de test" \
      "Développement" )
NOM=( "" "rendez-vous" "spec écrans" "modèles" "maquettes" "validation des specs" \
      "architecture" "phases" "setup" "mécanismes de test" "implémentation" )
ART=( "" "le rendez-vous" "la spec écrans" "les modèles" "les maquettes" \
      "la validation des specs" "l'architecture" "les phases" "le setup" \
      "les mécanismes de test" "l'implémentation" )

# x = terminée, - = commencée, . = pas commencée
S=( "" . . . . . . . . . . )

bloc() {
  echo "**Étapes :**"
  echo
  echo "| | | | |"
  echo "|---|---|---|---|"
  local i c
  for i in 1 2 3 4 5 6 7 8 9 10; do
    c="${S[$i]}"; [ "$c" = "." ] && c=" "
    echo "| [$c] | **$i** | ${CMD[$i]} | ${LIB[$i]} |"
  done
  echo
  echo "---"
  echo
  echo "**Autres :**"
  echo
  echo "| | |"
  echo "|---|---|"
  echo "| /presta-essais-techniques | Essais techniques, à tout moment |"
  echo "| /presta-audit | Audit du code, après le développement |"
  echo
  echo "---"
  echo
  echo "**Légende :** E : Écran / M : Modèle / F : Fonctionnalité / D : Décision technique /"
  echo "L : Layout (maquettes) / A : Architecture / S : Stack / P : Phase / V : Validation"
  echo "des specs / AU : Audit"
  echo
  echo "---"
  echo
}

# ---------------------------------------------------------------- pas de projet

if [ ! -f presta/status.md ]; then
  bloc
  if find . -maxdepth 1 \( -name 'package.json' -o -name 'manage.py' -o -name 'go.mod' \
    -o -name 'pom.xml' -o -name 'Cargo.toml' -o -name 'composer.json' -o -name 'Gemfile' \
    -o -name 'pyproject.toml' -o -name 'requirements.txt' -o -name 'index.html' \
    -o -name '*.csproj' -o -name '*.sln' \) 2>/dev/null | grep -q .; then
    echo "Aucun projet Presta dans ce dossier, mais il y a déjà du code ici. Le rendez-vous"
    echo "vous demandera si on repart de ce projet."
  else
    echo "Aucun projet Presta dans ce dossier."
  fi
  echo
  echo "Prochaine étape : vous pouvez lancer /presta-rdv"
  exit 0
fi

# ---------------------------------------------------------------- lecture de l'état

val() { sed -n "s/^$1: *//p" presta/status.md | head -1; }

PROJET=$(val projet); VERSION=$(val version); ETAPE=$(val etape)
L=$(val livrable_courant); [ -n "$L" ] || L='*'

R=0
case "$ETAPE" in
  rdv) R=1;; specs) R=2;; modeles) R=3;; maquettes) R=4;;
  architecture) R=6;; phases) R=7;; setup) R=8;; tests) R=9;;
  implementation) R=10;; livre) R=11;;
esac

f() { [ -f "$1" ] && echo 1 || echo 0; }
g() { ls $1 >/dev/null 2>&1 && echo 1 || echo 0; }
mark() { if [ "$1" = 0 ]; then echo "."; elif [ "$R" -ge "$2" ]; then echo "x"; else echo "-"; fi; }

S[1]=$(mark "$(f presta/specs/spec-produit.md)" 1)
S[2]=$(mark "$(f presta/specs/spec-ecrans.md)" 2)
S[3]=$(mark "$(f presta/specs/spec-modeles.md)" 3)
S[4]=$(mark "$(f presta/maquettes/design-system.md)" 4)
# étape 5 : /presta-valide-specs ne fait pas avancer etape:, donc pas de rang
[ "$(g 'presta/validations/*.md')" = 1 ] && S[5]=x || S[5]=.
S[6]=$(mark "$(f presta/specs/spec-architecture.md)" 6)
S[7]=$(mark "$(g "presta/livrables/$L/phases/p-*.md")" 7)
# étape 8 : le setup se fait une fois pour le projet, pas une fois par livrable
SU=$(grep -l '^etat: validée' presta/livrables/*/phases/p-01-setup.md 2>/dev/null | wc -l | tr -d ' ')
if [ "$SU" -gt 0 ]; then S[8]=x; elif [ "$(f AGENTS.md)" = 1 ]; then S[8]=-; else S[8]=.; fi

PT=$(ls presta/livrables/$L/phases/p-*.md 2>/dev/null | wc -l | tr -d ' ')
PV=$(grep -l '^etat: validée' presta/livrables/$L/phases/p-*.md 2>/dev/null | wc -l | tr -d ' ')
PH=$(grep -l '^etat: validée' presta/livrables/$L/phases/p-*.md 2>/dev/null | grep -cv 'p-01-setup')
# étape 9 : les mécanismes de test, une fois pour le projet
S[9]=$(mark "$(f presta/specs/spec-tests.md)" 9)
S[10]=$(mark "$([ "${PH:-0}" -gt 0 ] && echo 1 || echo 0)" 11)

ED=$(grep -c '^## E-' presta/specs/spec-ecrans.md 2>/dev/null); ET=$(grep -c '^| E-' presta/specs/spec-ecrans.md 2>/dev/null)
MD=$(grep -c '^## M-' presta/specs/spec-modeles.md 2>/dev/null); MT=$(grep -c '^| M-' presta/specs/spec-modeles.md 2>/dev/null)
# les décisions en attente : un bloc « ### D-xx-SLUG » suivi de « Statut : en attente ».
# Le tableau des dépendances externes porte aussi « en attente » : il ne compte pas.
ATT=$(awk '/^##/{d=""} /^### D-/{d=$2} /^Statut *: *en attente/{if(d!=""){print d; d=""}}' \
      presta/specs/spec-technique.md 2>/dev/null | tr '\n' ' ')

# ---------------------------------------------------------------- le message

echo "**$PROJET — v$VERSION**"
echo
bloc

if [ "$ETAPE" = "livre" ]; then
  echo "$L est livré : $PV phases validées."
  [ -n "$ATT" ] && echo "En attente : $(echo $ATT | sed 's/ /, /g') — /presta-essais-techniques"
  echo
  echo "Prochaine étape : /presta-audit pour relire le code contre vos specs, ou /presta-rdv"
  echo "pour cadrer la version suivante."
  exit 0
fi

# ce qui est commencé — le tableau dit ce qui est fait, cette ligne dit où on en est
DIT=0
for i in 1 2 3 4 5 6 7 8 9 10; do
  [ "${S[$i]}" = "-" ] || continue
  case $i in
    2) echo "En cours : spec écrans — $ED écrans sur $ET détaillés." ;;
    3) echo "En cours : modèles — $MD entités sur $MT." ;;
    10) echo "En cours : implémentation — $PV phases sur $PT validées." ;;
    *) echo "En cours : ${NOM[$i]}." ;;
  esac
  DIT=1
done

# une étape sautée ne se signale pas ; une étape jamais commencée sous une étape faite, si
SAUTE=""; LAST=0
for i in 1 2 3 4 5 6 7 8 9 10; do [ "${S[$i]}" = x ] && LAST=$i; done
for i in $(seq 1 "$LAST"); do [ "${S[$i]}" = "." ] && SAUTE="$SAUTE, ${ART[$i]}"; done
[ -n "$SAUTE" ] && { echo "Non fait : ${SAUTE#, }."; DIT=1; }

[ -n "$ATT" ] && { echo "En attente : $(echo $ATT | sed 's/ /, /g') — /presta-essais-techniques"; DIT=1; }
[ "$DIT" = 1 ] && echo

# l'étape suivante : la première qui n'est pas terminée
for i in 1 2 3 4 5 6 7 8 9 10; do
  [ "${S[$i]}" = x ] && continue
  if [ "${S[$i]}" = "-" ]; then
    echo "Prochaine étape : vous pouvez reprendre ${CMD[$i]}"
  else
    echo "Prochaine étape : vous pouvez lancer ${CMD[$i]}"
  fi
  exit 0
done

echo "Les 10 étapes sont faites. Le livrable n'est pas encore clôturé : reprenez"
echo "/presta-implemente."
