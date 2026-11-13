#!/usr/bin/env python3
"""Aperçus = gabarit + fichier de variables. Deux gabarits × cinq partis pris."""
import re
from pathlib import Path

# chemins relatifs au script : la skill doit marcher où qu'elle soit installée
REF = Path(__file__).resolve().parent.parent / "references"
CSS = REF / "partis-pris"
OUT = REF / "apercus"

D, F = "/* --- DEBUT VARIABLES --- */", "/* --- FIN VARIABLES --- */"
# noms et phrases : source unique = partis-pris/index.md
partis = {}
for ligne in (CSS / "index.md").read_text(encoding="utf-8").splitlines():
    m = re.match(r"\|\s*`([^`]+)`\s*\|\s*\*\*(.+?)\*\*\s*\|\s*(.+?)\s*\|$", ligne)
    if m:
        partis[m.group(1)] = (m.group(2), m.group(3))

GABARITS = {"landing": "gabarit-apercu.html", "app": "gabarit-apercu-app.html"}

for genre, fichier in GABARITS.items():
    gabarit = (REF / fichier).read_text(encoding="utf-8")
    avant, reste = gabarit.split(D, 1)
    _, apres = reste.split(F, 1)
    dossier = OUT / genre
    dossier.mkdir(parents=True, exist_ok=True)

    for cle, (nom, _) in partis.items():
        variables = (CSS / f"{cle}.css").read_text(encoding="utf-8").strip()
        html = avant + D + "\n" + variables + "\n" + F + apres
        html = html.replace("/* @@POLICES@@ */", "")
        html = html.replace("<title>{NOM}</title>", f"<title>{nom}</title>")
        (dossier / f"{cle}.html").write_text(html, encoding="utf-8")
        etat = "OK" if "{NOM}" not in html and "@@POLICES@@" not in html else "RESIDU"
        print(f"{genre}/{cle}.html  {etat}")

# les anciens fichiers à plat n'ont plus lieu d'être
for vieux in OUT.glob("*.html"):
    vieux.unlink()
    print(f"supprimé : apercus/{vieux.name}")
