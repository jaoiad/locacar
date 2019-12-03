1.	Liste des agences avec le nombre de véhicules présents.
select age_id, age_nom, count(ve_id)
from agence,vehicule
where ve_agence=age_id
group by age_id;

2.	Liste des véhicules par agence.
select ve_id, ve_immatriculation, age_id, age_nom
from vehicule,agence
where ve_agence=age_id
order by age_id;

3.	Liste des locations par statut pour une agence donnée.
select loc_statut, loc_id, age_nom
from locations, agence
where loc_agence_depart=age_id and  loc_agence_depart=2
order by loc_statut;

4.	Liste des locations entre 2 dates données pour une agence donnée.

select *
from locations
where loc_agence_depart=8 and (loc_date_heure_debut<'2019-08-15' and loc_date_heure_fin>'2019-07-15')


5.	Nombre de locations par agence et par statut.
select count(loc_id) nb, loc_agence_depart, age_nom, loc_statut 
from locations, agence
where loc_agence_depart=age_id
group by loc_statut, age_nom;

6.	Liste des agences par département.
select age_id,age_nom, dep_code, dep_nom
from departement, agence
where dep_id=age_departement
order by dep_code;

7.	Chiffre d’affaire d’une agence donnée.
--vue loc_duree dans exo 10
-- création de la vue des prix par location 
create or replace view loc_tarif as 
select loc_id, def_tarif*duree prixsansoptions 
from loc_duree, plage_horaire, definir 
where cat_id=def_categorie  and plg_id=def_plage_horaire and duree between plg_hmin and plg_hmax

-- creation de la vue 
create or replace view loc_option as 
select  equ_location, loc_agence_depart, sum(opt_tarif) prixopt 
from options, equiper, locations, vehicule 
where equ_option=opt_id and equ_location=loc_id and ve_id=loc_vehicule
group by loc_id

-- total
select age_id, age_nom, count(loc_id) nb, sum(prixsansoptions + prixopt) total
from loc_option, loc_tarif, agence 
where equ_location=loc_id and age_id=loc_agence_depart and age_id=15

8.	Requête donnant la durée (en nombre d’heures) d’une location.
select loc_id, timestampdiff(hour, loc_date_heure_debut, loc_date_heure_fin) dure  from locations	where loc_id=2

9.	Liste les véhicules libres dans une agence donnée et entre deux dates données. 
select age_id, age_nom, ve_id, ve_immatriculation, ve_model 
from vehicule, agence 
where ve_agence=age_id and ve_agence=2 and ve_id not in 
(select loc_vehicule 
from locations 
where (loc_date_heure_debut<'2019-11-01' 
and loc_date_heure_fin>'2019-12-30'))

10.	Requête donnant le prix d’une location (hors options sur le véhicule).
create or replace view loc_duree as 
select loc_id, cat_id, cat_nom, timestampdiff(hour, loc_date_heure_debut, loc_date_heure_fin) duree 
 from locations, vehicule, categorie 
where loc_vehicule=ve_id 
and ve_categorie=cat_id


-- requette
select loc_id, def_tarif*duree prix 
from loc_duree, plage_horaire, definir 
where cat_id=def_categorie  and plg_id=def_plage_horaire and duree between plg_hmin and plg_hmax

11.	Requête donnant le montant total des options attachées à chaque véhicule.
select  equ_location, ve_immatriculation, ve_model, sum(opt_tarif) prixopt 
from options, equiper, locations, vehicule 
where equ_option=opt_id and equ_location=loc_id and ve_id=loc_vehicule
group by ve_id

----------------------------------------------
Nombre des vehicules disponible par agence
select count(ve_id) nb, age_id from vehicule, agence where ve_agence=age_id group by age_id


--prix options par location
-- requette
select  equ_location, sum(opt_tarif) prixopt 
from options, equiper, locations, vehicule 
where equ_option=opt_id and equ_location=loc_id and ve_id=loc_vehicule
group by loc_id

--------------------------------------------------------
-- création de la vue des prix par location 
create or replace view loc_tarif as 
select loc_id, def_tarif*duree prixsansoptions 
from loc_duree, plage_horaire, definir 
where cat_id=def_categorie  and plg_id=def_plage_horaire and duree between plg_hmin and plg_hmax

-- creation de la vue 
create or replace view loc_option as 
select  equ_location, loc_agence_depart, sum(opt_tarif) prixopt 
from options, equiper, locations, vehicule 
where equ_option=opt_id and equ_location=loc_id and ve_id=loc_vehicule
group by loc_id

-- total
select age_id, age_nom, count(loc_id) nb, sum(prixsansoptions + prixopt) total
from loc_option, loc_tarif, agence 
where equ_location=loc_id and age_id=loc_agence_depart and age_id=15

-- daba
select sum(prixopt,prix)
from loc_option, loc_tarif,  
where age_id=2