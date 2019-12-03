<?php
//composer require fzaninotto/faker
require "../_include/inc_config.php";
require_once '../vendor/autoload.php';
// use the factory to create a Faker\Generator instance
$faker = Faker\Factory::create("fr_FR");

//les variables pour les dates actuelles
$timestamp = time();
$datetime = date("Y-m-d H:i:s");
$date = date("Y-m-d");
$dateAnnee = date("Y");
$dateMois = date("m");

$nbagence = "21";
$nbvehicule = "200";
$nbgestionnaire = "51";
$nbclient = "20";
$nblocation = "100";
$nbplage = "3";

//passw
$caract = "abcdefghijklmnopqrstuvwyxz0123456789";
$nb_caract = 4;
?>
<!DOCTYPE html>
<html>

<head>
    <?php require "../_include/inc_head.php" ?>
</head>

<body>
    <header>
        <?php require "../_include/inc_entete.php" ?>
    </header>
    <nav>
        <?php require "../_include/inc_menu.php"; ?>
    </nav>
    <div id="contenu">
        <h1>Génération du jeu de données</h1>
        <?php

        //création des clients
        echo "<h1>Création des clients</h1>";
        $sql = "insert into client values ";
        $data = [];
        for ($i = 1; $i <= $nbclient; $i++) {
            $cl_nom = $faker->lastname;
            $cl_prenom = $faker->firstname;
            $cl_adresse = $faker->address(100);
            $cl_mail = $faker->email;
            $cl_username = $cl_nom . "." . $dateMois;
            $passw = [];
            for ($j = 1; $j <= $nb_caract; ++$j) {
                $nbr = strlen($caract);
                $nbr = mt_rand(0, ($nbr - 1));
                $passw[$j] = $nbr;
            }
            $cl_passw = password_hash(implode($passw), PASSWORD_DEFAULT);
            $data[] = "(null,'$cl_nom','$cl_prenom','$cl_mail','$cl_adresse','$cl_username','$cl_passw')";
        }

        $link->query($sql . implode(",", $data));


        //création des categories        
        echo "<h1>Création des categories</h1>";
        $chaine = "petit, moyen, grand, utilitaire, prestige, camping car";
        $categorie = explode(",", $chaine);
        $sql = "insert into categorie values ";
        $data = [];
        foreach ($categorie as $nom) {
            $data[] = "(null,'$nom')";
        }
        $link->query($sql . implode(",", $data));


        //création des options        
        $option["nom"] =    ["Climatisation", "GPS", "pneus neige", "lecteur viedeo", "minibar"];
        $option["tarif"] = ["10", "7", "23", "5", "15"];
        echo "<h1>Création des option</h1>";
        $sql = "insert into options values ";
        $data = [];
        for ($i = 0; $i < count($option["nom"]); ++$i) {
            $nom = $option["nom"][$i];
            $tarif = $option["tarif"][$i];
            $data[] = "(null,'$nom','$tarif')";
        }

        $link->query($sql . implode(",", $data));

        //création des agences
        echo "<h1>Création des agences</h1>";
        $sql = "insert into agence values ";
        $data = [];
        for ($i = 1; $i <= $nbagence; ++$i) {
            if ($i == 1) {
                $nom = "Service de Réservation Centrale";
                $dep = rand(1, 95);
            } else {
                $nom = "Locacar $i";
                $dep = rand(1, 95);
            }

            $data[] = "(null,'$nom','$dep')";
        }

        $link->query($sql . implode(",", $data));

        //création des gestionnaire
        echo "<h1>Création des gestionnaire</h1>";
        $sql = "insert into gestionnaire values ";
        $ag = 1;
        $data = [];
        for ($i = 1; $i <= $nbgestionnaire; $i++) {
            $ges_nom = $faker->firstname;
            if ($i == 1) {
                $ges_profil = "admin";
            } else if ($i > 1 && $i <= 11) {
                $ges_profil = "SRC";
            } else {
                $ges_profil = "gestAgence";
            }

            if ($ges_profil == "gestAgence") {
                $ges_agence = $ag;
                ++$ag;
                if ($ag > 20) {
                    $ag = 1;
                }
            } else {
                $ges_agence = 1;
            }

            $ges_username = $ges_nom . "." . $dateMois;
            $passw = [];
            for ($j = 1; $j <= $nb_caract; ++$j) {
                $nbr = strlen($caract);
                $nbr = mt_rand(0, ($nbr - 1));
                $passw[$j] = $nbr;
            }
            $ges_passw = password_hash(implode($passw), PASSWORD_DEFAULT);
            $data[] = "(null,'$ges_nom','$ges_profil','$ges_username','$ges_passw',$ges_agence)";
        }

        $link->query($sql . implode(",", $data));

        //création des vehicules
        $chaine = "Renault, Peugeot, Citroën, volkswagen, Mercedes, Audi, Škoda, SEAT, BMW, Mazda, Kia";
        $modele = explode(",", $chaine);
        echo "<h1>Création des véhicules</h1>";
        $sql = "insert into vehicule values ";

        $data = [];
        for ($i = 2; $i <= $nbagence; $i++) {
            $ve_site = $i;
            for ($j = 1; $j <= 10; $j++) {
                $ve_categorie = rand(1, 6);
                $ve_agence = rand(2, 21);
                $ve_immatriculation = strtoupper($faker->bothify('???##') . $i);
                $mod = shuffle($modele);
                $ve_modele = $mod[0];
               
            }
            $data[] = "(null,'$ve_immatriculation','$ve_modele','$ve_site', '$ve_agence', '$ve_categorie')";
        }
        $link->query($sql . implode(",", $data));

        //création des locations
        echo "<h1>Création des locations</h1>";
        $sql = "insert into locations values";
        $chaine = "telephone, internet,en agence";
        $type = explode(",", $chaine);
        for ($i = 1; $i <= $nblocation; $i++) {
            shuffle($type);
            $loc_id = $i;
            $loc_type = $type[1];
            $loc_date_maj = $datetime;
            $ts_debut = mktime(rand(8, 20), 0, 0, rand(1, 12), rand(1, 30), $dateAnnee);   //date-heure debut (timestamp)
            $demande = rand(1, 336) * 3600;       //calcue: date-heur demande -> max 2 semain avant depart
            $duree_loc = rand(1, 720) * 3600;     //calcule: date-heure duree (ts)
            $ts_fin = $timestamp + $duree_loc;        //date-heur arrivee (ts)
            $ts_dem = $timestamp - $demande;       //date-heure demande
            $loc_date_heure_debut = date("Y-m-d H:i:s", $ts_debut);
            $loc_date_heure_fin = date("Y-m-d H:i:s", $ts_fin);
            $loc_date_demande = date("Y-m-d H:i:s", $ts_dem);
            $loc_client = rand(1, $nbclient);
            $loc_agence_depart = rand(2, $nbagence);
            $loc_agence_arrivee = rand(2, $nbagence);
            if ($loc_type == "en agence") {
                $sql = "select * from gestionnaire where ges_agence='$loc_agence_depart' ";
                $gestion = $link->query($sql)->fetchAll();
                extract($gestion);
                
                $loc_gestionnaire = $gestion[]['ges_id'];
            }else {
                $loc_gestionaire=rand(2,11);
            }
            if ($ts_fin < $timestamp) {
                $loc_statut = "terminee";
            } else if ($ts_debut < $timestamp && $ts_fin > $timestamp) {
                $loc_statut = "validee";
            } else {
                $loc_statut = "initialisee";
            }
            $sql = "select * from vehicule where ve_agence=$loc_agence_depart ";
            $veh_disponible = $link->query($sql)->fetchAll();
            extract($veh_disponible);

            //$loc_vehicule= ;


            //$data[] = "(null,'$loc_type','$loc_date_demande','$loc_date_maj','$loc_statut','$loc_date_heure_debut','$loc_date_heure_fin','$loc_gestionnaire','$loc_agence_depart','$loc_agence_arrivee','$loc_client','$loc_vehicule')";
        }
        var_dump($gestion);
        //$link->query($sql . implode(",",$data));        

        //création des equiper
        echo "<h1>Création des equiper</h1>";
        $sql = "insert into equiper values ";
        $nboption = count($option["nom"]);
        $tab = range(1, $nboption);
        $data = [];
        for ($i = 1; $i <= $nblocation; ++$i) {
            $equ_location = $i;

            shuffle($tab);
            for ($j = 1; $j <= count($tab); $j++) {
                $equ_option = $tab[$j];
                $data[] = "(null,'$equ_location','$equ_option')";
            }
        }
        $link->query($sql . implode(",", $data));

        //creation plage horaire
        echo "<h1>creation de la plage horaire</h1>";
        $nb_pl = 3;
        $sql = "insert into plage_horaire values";
        $data = [];

        for ($i = 1; $i <= $nb_pl; $i++) {
            if ($i == 1) {
                $plg_hmin = 1;
                $plg_hmax = 12;
            } else if ($i == 2) {
                $plg_hmin = 13;
                $plg_hmax = 24;
            } else if ($i == 3) {
                $plg_hmin = 25;
                $plg_hmax = 720;
            }

            $data[] = "(null,'$plg_hmin','$plg_hmax')";
        }

        $link->query($sql . implode(",", $data));

        /*********************Jaoiad***************** */
        
 
        // creation de la table definir
        echo "<h1>creation de la table definir</h1>";
        $sql = "insert into definir values";
        $data = [];

        $tarifs["plage1"] = ["8", "10", "14", "6", "27", "35"];
        $tarifs["plage2"] = ["7", "9", "12", "5", "24", "34"];
        $tarifs["plage3"] = ["6", "8", "10", "4", "20", "30"];
/************************************ */
        for($i=1; $i<=18; ++$i){
            for($j=0; $j<3; ++$j){
               for($k)
            }
        
            $data[] = "(null,'$def_tarif','$def_plage_horaire','$cle')";
        }

/*************************************** */
        foreach ($categorie as $cle => $nom) {
           

            for ($i = 1; $i <= 6; $i++) {

                $def_plage_horaire = 1;
                $def_tarif = $tarifs["plage1"][$i];
                $data[] = "(null,'$def_tarif','$def_plage_horaire','$cle')";
            }
        }
        foreach ($categorie as $cle => $nom) {
            $cle = $def_categorie;
            for ($i = 0; $i <= 5; $i++) {
                $def_plage_horaire = 2;
                $def_tarif = $tarifs["plage2"][$i];
                $data[] = "(null,'$def_tarif','$def_plage_horaire','$cle')";
            }
        }
        foreach ($categorie as $cle => $nom) {
            $cle = $def_categorie;
            for ($i = 0; $i <= 5; $i++) {
                $def_plage_horaire = 3;
                $def_tarif = $tarifs["plage3"][$i];
                $data[] = "(null,'$def_tarif','$def_plage_horaire','$cle')";
            }
        }

        $link->query($sql . implode(",", $data));
 
        ?>
    </div>
    <hr>
    <footer>
        <?php require "../_include/inc_pied.php"; ?>
    </footer>
</body>

</html>