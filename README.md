# Risk-of-credit
### Introduction

#### Contexte
Le jeu de données original contient 1000 entrées avec 20 attributs catégoriels/symboliques préparés par le Professeur Hofmann. Chaque entrée représente une personne qui demande un crédit auprès d'une banque. Chaque personne est classée comme présentant un risque de crédit bon ou mauvais selon un ensemble d'attributs. Le lien vers le jeu de données original est disponible ci-dessous.

#### Contenu
Il est pratiquement impossible de comprendre le jeu de données original en raison de son système compliqué de catégories et de symboles. Par conséquent, j'ai écrit un petit script Python pour le convertir en un fichier CSV lisible. Plusieurs colonnes sont simplement ignorées, car à mon avis, elles ne sont pas importantes ou leurs descriptions sont obscures. Les attributs sélectionnés sont les suivants :
- Age (numérique)
- Sexe (texte : masculin, féminin)
- Emploi (numérique : 0 - non qualifié et non résident, 1 - non qualifié et résident, 2 - qualifié, 3 - hautement qualifié)
- Logement (texte : propre, location, gratuit)
- Comptes d'épargne (texte : peu, modéré, assez riche, riche)
- Compte courant (numérique, en DM - Mark allemand)
- Montant du crédit (numérique, en DM)
- Durée (numérique, en mois)
- But (texte : voiture, meubles/équipements, radio/TV, appareils ménagers, réparations, éducation, affaires, vacances/autres)
- Risque (valeur cible - Risque bon ou mauvais)


