
create database if not exists locacar default character set utf8 collate utf8_general_ci;
use locacar;

set foreign_key_checks =0;

-- table departement
drop table if exists departement;
create table departement (
	dep_id int not null auto_increment primary key,
	dep_code varchar(5) not null,
	dep_nom varchar(50) not null 
)engine=innodb;

-- table agence
drop table if exists agence;
create table agence (
	age_id int not null auto_increment primary key,
	age_nom varchar(50) not null, 
	age_departement int not null
)engine=innodb;

-- table vehicule
drop table if exists vehicule;
create table vehicule (
	ve_id int not null auto_increment primary key,
	ve_immatriculation varchar(10) not null,
    ve_model varchar(20) not null,
	ve_site int not null,
	ve_agence int not null,
    ve_categorie int not null
)engine=innodb;

-- table client
drop table if exists client;
create table client (
	cl_id int auto_increment primary key,
	cl_nom varchar(50) not null,
	cl_prenom varchar(50) not null,
	cl_mail varchar(50) not null,
	cl_adresse varchar(255) not null,
	cl_username varchar(50) not null,
	cl_passw varchar(255) not null
)engine=innodb;

-- table categorie
drop table if exists categorie;
create table categorie (
	cat_id int not null auto_increment primary key,
	cat_nom varchar(20) not null 
)engine=innodb;

-- table options
drop table if exists options;
create table options (
	opt_id int not null auto_increment primary key,
	opt_nom varchar(20) not null, 
    opt_tarif float not null
)engine=innodb;


-- table gestionaire
drop table if exists gestionnaire;
create table gestionnaire (
	ges_id int not null auto_increment primary key,
	ges_nom varchar(20) not null,
	ges_profil varchar(20) not null,
	ges_username varchar(20) not null,
	ges_passw varchar(255) not null,
	ges_agence int 
)engine=innodb;

-- table locations
drop table if exists locations;
create table locations (
	loc_id int not null auto_increment primary key,
   	loc_type varchar(20) not null,
	loc_date_demande datetime,
	loc_date_maj datetime,
	loc_statut varchar(30) not null,
	loc_date_heure_debut datetime,
	loc_date_heure_fin datetime,
	loc_gestionnaire int not null,
    loc_agence_depart int not null,
	loc_agence_arrivee int not null,
	loc_client int not null,
	loc_vehicule int not null
  )engine=innodb;

-- table equiper
drop table if exists equiper;
create table equiper (
	equ_id int not null auto_increment primary key,
	equ_location int not null, 
    equ_option int 
)engine=innodb;



-- table plage horaire
drop table if exists plage_horaire;
create table plage_horaire (
	plg_id int not null auto_increment primary key,
	plg_hmin int not null, 
    plg_hmax int not null
)engine=innodb;

-- table definir
drop table if exists definir;
create table definir (
	def_id int not null auto_increment primary key,
	def_tarif float not null, 
    def_plage_horaire int not null,
	def_categorie int not null
)engine=innodb;


-- contraintes
alter table agence add constraint cs1 foreign key (age_departement) references departement(dep_id);
alter table vehicule add constraint cs2 foreign key (ve_agence) references agence(age_id);
alter table vehicule add constraint cs3 foreign key (ve_site) references agence(age_id);
alter table vehicule add constraint cs4 foreign key (ve_categorie) references categorie(cat_id);
alter table locations add constraint cs5 foreign key (loc_agence_depart) references agence(age_id);
alter table locations add constraint cs6 foreign key (loc_agence_arrivee) references agence(age_id);
alter table locations add constraint cs7 foreign key (loc_client) references client(cl_id);
alter table locations add constraint cs8 foreign key (loc_gestionnaire) references gestionnaire(ges_id);
alter table locations add constraint cs9 foreign key (loc_vehicule) references vehicule(ve_id);
alter table gestionnaire add constraint cs11 foreign key (ges_agence) references agence(age_id);
alter table definir add constraint cs12 foreign key (def_plage_horaire) references plage_horaire(plg_id);
alter table definir add constraint cs13 foreign key (def_categorie) references categorie(cat_id);
alter table equiper add constraint cs14 foreign key (equ_location) references locations(loc_id);
alter table equiper add constraint cs15 foreign key (equ_option) references options(opt_id);
set foreign_key_checks =1;

insert into categorie values(1,"petit");
insert into categorie values(2,"moyen");
insert into categorie values(3,"grand");
insert into categorie values(4,"utilitaire");
insert into categorie values(5,"prestige");
insert into categorie values(6,"campig car");


insert into plage_horaire values(1,1,12) ;
insert into plage_horaire values(2,13,24) ;
insert into plage_horaire values(3,24,720) ;

insert into definir values(1,8,1,1);
insert into definir values(2,7,2,1);
insert into definir values(3,6,3,1);
insert into definir values(4,10,1,2);
insert into definir values(5,9,2,2);
insert into definir values(6,8,3,2);
insert into definir values(7,14,1,3);
insert into definir values(8,12,2,3);
insert into definir values(9,10,3,3);
insert into definir values(10,6,1,4);
insert into definir values(11,5,2,4);
insert into definir values(12,4,3,4);
insert into definir values(13,27,1,5);
insert into definir values(14,24,2,5);
insert into definir values(15,20,3,5);
insert into definir values(16,35,1,6);
insert into definir values(17,34,2,6);
insert into definir values(18,30,3,6);

insert into departement values(null,'01','Ain' );
insert into departement values(null,'02','Aisne' );
insert into departement values(null,'03','Allier' );
insert into departement values(null,'04','Alpes-de-Haute-Provence' );
insert into departement values(null,'05','Hautes-alpes' );
insert into departement values(null,'06','Alpes-maritimes' );
insert into departement values(null,'07','Ardèche' );
INSERT INTO departement VALUES (null,'08', 'Ardennes');
INSERT INTO departement VALUES (null,'09', 'Ariège');
INSERT INTO departement VALUES (null,'10', 'Aube');
INSERT INTO departement VALUES (null,'11', 'Aude');
INSERT INTO departement VALUES (null,'12', 'Aveyron');
INSERT INTO departement VALUES (null,'13', 'Bouches-du-Rhône');
INSERT INTO departement VALUES (null,'14', 'Calvados');
INSERT INTO departement VALUES (null,'15', 'Cantal');
INSERT INTO departement VALUES (null,'16', 'Charente');
INSERT INTO departement VALUES (null,'17', 'Charente-Maritime');
INSERT INTO departement VALUES (null,'18', 'Cher');
INSERT INTO departement VALUES (null,'19', 'Corrèze');
INSERT INTO departement VALUES (null,'2A', 'Corse-du-Sud');
INSERT INTO departement VALUES (null,'2B', 'Haute-Corse');
INSERT INTO departement VALUES (null,'21', 'Côte-dOr');
INSERT INTO departement VALUES (null,'22', 'Côtes-dArmor');
INSERT INTO departement VALUES (null,'23', 'Creuse');
INSERT INTO departement VALUES (null,'24', 'Dordogne');
INSERT INTO departement VALUES (null,'25', 'Doubs');
INSERT INTO departement VALUES (null,'26', 'Drôme');
INSERT INTO departement VALUES (null,'27', 'Eure');
INSERT INTO departement VALUES (null,'28', 'Eure-et-Loir');
INSERT INTO departement VALUES (null,'29', 'Finistère');
INSERT INTO departement VALUES (null,'30', 'Gard');
INSERT INTO departement VALUES (null,'31', 'Haute-Garonne');
INSERT INTO departement VALUES (null,'32', 'Gers');
INSERT INTO departement VALUES (null,'33', 'Gironde');
INSERT INTO departement VALUES (null,'34', 'Hérault');
INSERT INTO departement VALUES (null,'35', 'Ille-et-Vilaine');
INSERT INTO departement VALUES (null,'36', 'Indre');
INSERT INTO departement VALUES (null,'37', 'Indre-et-Loire');
INSERT INTO departement VALUES (null,'38', 'Isère');
INSERT INTO departement VALUES (null,'39', 'Jura');
INSERT INTO departement VALUES (null,'40', 'Landes');
INSERT INTO departement VALUES (null,'41', 'Loir-et-Cher');
INSERT INTO departement VALUES (null,'42', 'Loire');
INSERT INTO departement VALUES (null,'43', 'Haute-Loire');
INSERT INTO departement VALUES (null,'44', 'Loire-Atlantique');
INSERT INTO departement VALUES (null,'45', 'Loiret');
INSERT INTO departement VALUES (null,'46', 'Lot');
INSERT INTO departement VALUES (null,'47', 'Lot-et-Garonne');
INSERT INTO departement VALUES (null,'48', 'Lozère');
INSERT INTO departement VALUES (null,'49', 'Maine-et-Loire');
INSERT INTO departement VALUES (null,'50', 'Manche');
INSERT INTO departement VALUES (null,'51', 'Marne');
INSERT INTO departement VALUES (null,'52', 'Haute-Marne');
INSERT INTO departement VALUES (null,'53', 'Mayenne');
INSERT INTO departement VALUES (null,'54', 'Meurthe-et-Moselle');
INSERT INTO departement VALUES (null,'55', 'Meuse');
INSERT INTO departement VALUES (null,'56', 'Morbihan');
INSERT INTO departement VALUES (null,'57', 'Moselle');
INSERT INTO departement VALUES (null,'58', 'Nièvre');
INSERT INTO departement VALUES (null,'59', 'Nord');
INSERT INTO departement VALUES (null,'60', 'Oise');
INSERT INTO departement VALUES (null,'61', 'Orne');
INSERT INTO departement VALUES (null,'62', 'Pas-de-Calais');
INSERT INTO departement VALUES (null,'63', 'Puy-de-Dôme');
INSERT INTO departement VALUES (null,'64', 'Pyrénées-Atlantiques');
INSERT INTO departement VALUES (null,'65', 'Hautes-Pyrénées');
INSERT INTO departement VALUES (null,'66', 'Pyrénées-Orientales');
INSERT INTO departement VALUES (null,'67', 'Bas-Rhin');
INSERT INTO departement VALUES (null,'68', 'Haut-Rhin');
INSERT INTO departement VALUES (null,'69', 'Rhône');
INSERT INTO departement VALUES (null,'70', 'Haute-Saône');
INSERT INTO departement VALUES (null,'71', 'Saône-et-Loire');
INSERT INTO departement VALUES (null,'72', 'Sarthe');
INSERT INTO departement VALUES (null,'73', 'Savoie');
INSERT INTO departement VALUES (null,'74', 'Haute-Savoie');
INSERT INTO departement VALUES (null, '75','Paris');
INSERT INTO departement VALUES (null,'76', 'Seine-Maritime');
INSERT INTO departement VALUES (null,'77', 'Seine-et-Marne');
INSERT INTO departement VALUES (null,'78', 'Yvelines');
INSERT INTO departement VALUES (null,'79', 'Deux-Sèvres');
INSERT INTO departement VALUES (null,'80', 'Somme');
INSERT INTO departement VALUES (null,'81', 'Tarn');
INSERT INTO departement VALUES (null,'82', 'Tarn-et-Garonne');
INSERT INTO departement VALUES (null,'83', 'Var');
INSERT INTO departement VALUES (null,'84', 'Vaucluse');
INSERT INTO departement VALUES (null,'85', 'Vendée');
INSERT INTO departement VALUES (null,'86', 'Vienne');
INSERT INTO departement VALUES (null,'87', 'Haute-Vienne');
INSERT INTO departement VALUES (null,'88', 'Vosges');
INSERT INTO departement VALUES (null,'89', 'Yonne');
INSERT INTO departement VALUES (null,'90', 'Territoire de Belfort');
INSERT INTO departement VALUES (null,'91', 'Essonne');
INSERT INTO departement VALUES (null,'92', 'Hauts-de-Seine');
INSERT INTO departement VALUES (null,'93', 'Seine-Saint-Denis');
INSERT INTO departement VALUES (null,'94', 'Val-de-Marne');
INSERT INTO departement VALUES (null,'95', 'Val-dOise');



