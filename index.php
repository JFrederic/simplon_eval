<?php
$hostname = "localhost";
$dbname = "commerce";
$user = "root";
$pass = "simplon974";


try {
    $db = new PDO('mysql:host='.$hostname.';dbname='.$dbname,$user,$pass);
} catch (PDOException $e) {
    print "Erreur !: " . $e->getMessage() . "<br/>";
    die();
}

$stmt = $db->prepare('SELECT * FROM product WHERE price <= 200000');
$stmt->execute();
$result = $stmt->fetchAll();
// print_r($result);
echo "<br>";
$stmt2 = $db->prepare('SELECT * FROM product WHERE weight >= 2');
$stmt2->execute();
$result2 = $stmt2->fetchAll();
// var_dump($result2);
echo "<br>";
$stmt3 = $db->prepare('SELECT * FROM customers WHERE firstname LIKE "%u%" OR lastname LIKE "%u%"');
$stmt3->execute();
$result3 = $stmt3->fetchAll();
var_dump($result3);



 ?>
