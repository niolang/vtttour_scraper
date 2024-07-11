#!/bin/bash

# Chemin vers le fichier CSV (converti depuis l'Excel)
csv_file="/home/nikmu/Documents/vtttour_scraper/vtttour_sentiers.csv"

# Chemin vers le dossier contenant les fichiers à organiser
source_directory="/home/nikmu/Documents/vtttour_scraper/gpx_files"

# Chemin vers le dossier de destination où les fichiers seront classés
destination_directory="/home/nikmu/Documents/vtttour_scraper/gpx_tri"


# Vérifiez si le fichier CSV existe
if [[ ! -f "$csv_file" ]]; then
    echo "Le fichier CSV n'existe pas."
    exit 1
fi

# Lire le fichier CSV ligne par ligne
while IFS=, read -r fichier departement massif
do
    # Ignore la première ligne si c'est l'entête
    if [[ "$fichier" == "fichier" ]]; then
        continue
    fi
    
    # Nom du fichier avec extension .gpx
    fichier_gpx="${fichier}.gpx"

    # Crée les dossiers si nécessaires
    mkdir -p "$destination_directory/$departement/$massif"

    # Déplace le fichier vers le bon dossier
    if [[ -f "$source_directory/$fichier_gpx" ]]; then
        mv "$source_directory/$fichier_gpx" "$destination_directory/$departement/$massif/"
        echo "Déplacé: $fichier_gpx -> $departement/$massif/"
    else
        echo "Le fichier $fichier_gpx n'existe pas dans le dossier source."
    fi
done < "$csv_file"

echo "Organisation terminée."