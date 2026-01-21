# OSINT Tools

## SpidderFoot

### Description

**SpiderFoot** est un script python permettant de tester des sites web de manière automatisées via un serveur web.
Il propose 4 type de detections : 
- All : Récupere toutes les informations de la cible.
- FootPrint : Comprendre ce que la cible laisse à dispo sur internet.
- Investigate : Un peut plus profond que Passive.
- Passive : Quand tu ne veux pas ^^etre suspecté.

### Installation

Installation du projet python
`git clone https://github.com/smicallef/spiderfoot.git`

Déplacement dans le dossier
`cd spiderfoot`

Installation des dépendances
`python3 -m pip install -r requirements.txt`

Lancement du serveur
`python3 sf.py -l 127.0.0.1:80`

## H8Mail

### Description

**H8Mail** est un puissant analyseur d'OSINT (Open Source Intelligence) conçu pour vérifier si des adresses e-mail apparaissent dans des fuites de données (data breaches).
`python -m h8mail -t cible@exemple.com`
