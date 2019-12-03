1.	Liste des agences avec le nombre de véhicules présents.
select age_id, age_nom, count(ve_id) from agence,vehicule where ve_agence=age_id group by age_id
2.	Liste des véhicules par agence.
select ve_id, ve_immatriculation, age_id, age_nom from vehicule,agence where ve_agence=age_id order by age_id
3.	Liste des locations par statut pour une agence donnée.
select loc_statut, loc_id, age_nom from locations, agence where loc_agence_depart=age_id and  loc_agence_depart=2 order by loc_statut

4.	Liste des locations entre 2 dates données pour une agence donnée.

select * from locations where (loc_date_heure_debut<'2019-08-15' and loc_date_heure_fin>'2019-07-15') group by loc_agence_depart=2


5.	Nombre de locations par agence et par statut.
*select count(loc_id) nb, loc_agence, age_nom, loc_statut  from locations, agence where loc_agence_depart=age_id group by loc_statut, age_nom

6.	Liste des agences par département.
select age_id,age_nom, dep_code, dep_nom from departement, agence where dep_id=age_departement order by dep_code

7.	Chiffre d’affaire d’une agence donnée.
**select age_id, age_nom from locations, agence where loc_agence_depart=age_id and  loc_statut="terminee"
8.	Requête donnant la durée (en nombre d’heures) d’une location.
*select loc_id, timediff(loc_date_heure_fin, loc_date_heure_debut) dure  from locations	where loc_id=2
9.	Liste les véhicules libres dans une agence donnée et entre deux dates données. 

10.	Requête donnant le prix d’une location (hors options sur le véhicule).

11.	Requête donnant le montant total des options attachées à chaque véhicule.

