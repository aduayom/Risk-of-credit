/* Définir le chemin vers le fichier CSV */
%let path = /home/u59501961/sasuser.v94/Credit_Risk/Data;
%let file = Data_with_target.csv;

/* Utiliser PROC IMPORT pour lire le fichier CSV */
proc import datafile="&path./&file."
    out=Data
    dbms=csv
    replace;
    getnames=yes; /* Indique si la première ligne du fichier CSV contient les noms des variables */
run;

/* Afficher les premières observations pour vérifier l'importation */
proc print data=Data (obs=10);
run;

/* Obtenir des informations sur les variables et types de données */
proc contents data=Data;
run;

/* Rechercher les valeurs manquantes */
proc means data=Data n nmiss;
run;


/* Création de datasets séparés pour 'good' et 'bad' credit */
data good_credit bad_credit;
    set Data;
    if Risk = 'good' then output good_credit;
    else if Risk = 'bad' then output bad_credit;
run;

/* Comptage des occurrences de chaque catégorie de risque */
proc sql;
    create table good_credit_counts as
    select Risk, count(*) as Count
    from good_credit
    group by Risk;

    create table bad_credit_counts as
    select Risk, count(*) as Count
    from bad_credit
    group by Risk;
quit;

/* Combinaison des deux tables pour une visualisation côte à côte */
data combined_counts;
    set good_credit_counts bad_credit_counts;
run;

/* Création du graphique à barres groupées */
proc sgplot data=combined_counts;
    vbar Risk / response=Count group=Risk groupdisplay=cluster;
    yaxis label='Count';
    xaxis label='Risk Variable';
    title 'Target Variable Distribution';
run;

/* Création des histogrammes avec les densités normalisées */

proc sgplot data=Data;
    histogram Age;
    yaxis label='Count';
    xaxis label='Age';
    title 'Histogramme de la variable Age General';
run;

/* Création des histogrammes côte à côte avec PROC SGPANEL */
proc sgpanel data=Data;
    panelby Risk / columns=1 spacing=10; /* Crée un panneau par variable Risk, 1 colonne */
    
    histogram Age / binwidth=5; /* Réglage facultatif de la largeur du bin */
    rowaxis label='Count';
    colaxis label='Age';
    title 'Histogramme de la variable Age';
    
    /* Personnalisation des titres des panneaux */
    title1 "Histogramme pour les profils Good Risk";
    title2 "Histogramme pour les profils Bad Risk";
    title3 "Histogramme général";
run;

/* Calcul des fréquences par âge et par risque */
proc freq data=Data;
    tables Age * Risk / out=freq_counts(keep=Age Risk Count);
run;

/* Création d'un graphique à barres empilées avec PROC SGPLOT */
proc sgplot data=freq_counts;
    vbar Age / response=Count group=Risk groupdisplay=stack datalabel;
    yaxis label='Count';
    xaxis label='Age';
    title 'Age Count by Risk';
    keylegend / position=topright title='Risk';
run;

/* Définition des intervalles d'âge avec PROC FORMAT */
proc format;
    value age_cat
    low -< 25 = 'Student'
    25 -< 35 = 'Young'
    35 -< 60 = 'Adult'
    60 - high = 'Senior';
run;

/* Transformation des données avec DATA step */
data Data;
    set Data;

    /* Création de la variable Age_cat en utilisant le format */
    Age_cat = put(Age, age_cat.);

    /* Filtrage des données par Risk */
    if Risk = 'good' or Risk = 'bad';
run;

/* Création des box plots avec PROC SGPLOT */
proc sgplot data=Data;
    vbox 'Credit amount'n / category=Age_cat group=Risk 
                         outlierattrs=(symbol=circlefilled)
                         boxwidth=0.7;
    
    /* Personnalisation des axes et du titre */
    yaxis label='Credit Amount (US Dollar)' grid;
    xaxis label='Age Categorical';
    title 'Credit Amount Distribution by Age Category and Risk';
run;

/* Calcul des fréquences des catégories de logement par risque */
proc freq data=Data;
    tables Housing * Risk / out=freq_counts (keep=Housing Risk Count);
run;

/* Création du graphique à barres avec PROC SGPLOT */
proc sgplot data=freq_counts;
    vbar Housing / response=Count group=Risk groupdisplay=cluster;
    
    /* Personnalisation du titre */
    title 'Housing Distribution by Risk';
    
    /* Réglage des options d'axe */
    yaxis label='Count';
    xaxis discreteorder=data;
run;




