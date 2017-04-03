  k<?php


use PHPUnit\Framework\TestCase;
use PHPUnit\DbUnit\TestCaseTrait;

class DbTest extends TestCase{

      private $connection;

      protected function getConnection()
      {
        try {
            $this->connection = new PDO('mysql:host=localhost;dbname=eval_ecommerce','root','simplon974');
            $this->connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch (PDOException $e) {
            print "Erreur !: " . $e->getMessage() . "<br/>";
            die();
        }
        return $this->connection;
      }

      public function testAllUsersFromSaintPierre()
      {

          $database = $this->getConnection();
          $queryTable = $database->prepare(
              'SELECT lastname,firstname FROM customers WHERE city = "Saint-Pierre"'
          );
          $result = $queryTable->execute();
          $result= $queryTable->fetchAll(PDO::FETCH_ASSOC);
          $expectedTable = [
            [
              "firstname" => "Fusce",
              "lastname" => "Semper",
            ],
            [
              "firstname" => "Nulla",
              "lastname" => "Enim",
            ],
          ];

          $this->assertEquals($expectedTable, $result);
    }


      public function testShowLastNameFirstNameEmailOfAllWomenCustomers()
      {

          $database = $this->getConnection();
          $queryTable = $database->prepare(
              'SELECT lastname,firstname,email FROM customers WHERE gender = "Mme"'
          );
          $result = $queryTable->execute();
          $result= $queryTable->fetchAll(PDO::FETCH_ASSOC);
          $expectedTable = [
            [
              "firstname" => "Nulla",
              "lastname" => "Enim",
              "email" => "nulla.enim@mail.com"
            ],
            [
              "firstname" => "Elementum",
              "lastname" => "Leo",
              "email" => "elementum.leo@mail.com"
            ],
            [
              "firstname" => "Mattis",
              "lastname" => "Amet",
              "email" => "mattis.amet@mail.com"
            ],
            [
              "firstname" => "Eget",
              "lastname" => "Viverra",
              "email" => "eget.vivera@mail.com"
            ],
          ];

          $this->assertEquals($expectedTable, $result);
    }


      public function testAllUsersPhoneWhoStartBy0262()
      {

          $database = $this->getConnection();
          $queryTable = $database->prepare(
              'SELECT lastname,firstname,phone FROM customers WHERE phone LIKE "0262%"'
          );
          $result = $queryTable->execute();
          $result= $queryTable->fetchAll(PDO::FETCH_ASSOC);
          $expectedTable = [
            [
              "firstname" => "Fusce",
              "lastname" => "Semper",
              "phone" => "0262112233"
            ],
            [
              "firstname" => "Nulla",
              "lastname" => "Enim",
              "phone" => "0262223344"
            ],
            [
              "firstname" => "Mattis",
              "lastname" => "Amet",
              "phone" => "0262147896"
            ],
            [
              "firstname" => "Maecena",
              "lastname" => "Neque",
              "phone" => "0262357159"
            ],
          ];

          $this->assertEquals($expectedTable, $result);
    }


      public function testMaxPriceAndMinPrice()
      {

          $database = $this->getConnection();
          $queryTable = $database->prepare(
              'SELECT MAX(price) AS "HIGHEST PRICE" , MIN(PRICE) AS "LOWEST PRICE" FROM products;'
          );
          $result = $queryTable->execute();
          $result= $queryTable->fetchAll(PDO::FETCH_ASSOC);
          $expectedTable = [
            [
              "HIGHEST PRICE" => "9999.99",
              "LOWEST PRICE" => "10.00",
            ],
          ];

          $this->assertEquals($expectedTable, $result);
    }



      public function testAllOrdersFrom2016()
      {

          $database = $this->getConnection();
          $queryTable = $database->prepare(
              'SELECT customers.firstname,customers.lastname,customers.email,orderedAt,orders.id AS "Order Id"
               FROM `orders`
               NATURAL JOIN customers
               WHERE orderedAt
               LIKE "2016%"'
          );
          $result = $queryTable->execute();
          $result= $queryTable->fetchAll(PDO::FETCH_ASSOC);
          $expectedTable = [
            [
              "firstname" => "Fusce",
              "lastname" => "Semper",
              "email" => "fusce.semper@mail.com",
              "orderedAt" => "2016-11-23 08:00:00",
              "Order Id" => 1,
            ],
            [
              "firstname" => "Nulla",
              "lastname" => "Enim",
              "email" => "nulla.enim@mail.com",
              "orderedAt" => "2016-12-06 18:30:00",
              "Order Id" => 2,
            ],
            [
              "firstname" => "Maximus",
              "lastname" => "Urna",
              "email" => "maximus.urna@mail.com",
              "orderedAt" => "2016-12-23 23:15:00",
              "Order Id" => 3,
            ]
          ];

          $this->assertEquals($expectedTable, $result);
    }



      public function testOrdersBetween6And12AM()
      {

          $database = $this->getConnection();
          $queryTable = $database->prepare(
            'SELECT customers.firstname,customers.lastname,customers.email,orderedAt,orders.id AS "Order Id"
            FROM `orders`
            NATURAL JOIN customers
            WHERE HOUR(orderedAt)
            BETWEEN "06" AND "12";'
          );
          $result = $queryTable->execute();
          $result= $queryTable->fetchAll(PDO::FETCH_ASSOC);
          $expectedTable = [
            [
              "firstname" => "Fusce",
              "lastname" => "Semper",
              "email" => "fusce.semper@mail.com",
              "orderedAt" => "2016-11-23 08:00:00",
              "Order Id" => 1,
            ],
            [
              "firstname" => "Elementum",
              "lastname" => "Leo",
              "email" => "elementum.leo@mail.com",
              "orderedAt" => "2017-01-02 06:48:00",
              "Order Id" => 4,
            ],
            [
              "firstname" => "Ipsum",
              "lastname" => "Sagittis",
              "email" => "ipsum.sagittis@mail.com",
              "orderedAt" => "2017-01-08 09:15:00",
              "Order Id" => 5,
            ]
          ];

          $this->assertEquals($expectedTable, $result);
    }


      public function testOrdersBetween18And23h59AM()
      {

          $database = $this->getConnection();
          $queryTable = $database->prepare(
            'SELECT customers.firstname,customers.lastname,customers.email,orderedAt,orders.id AS "Order Id"
            FROM `orders`
            NATURAL JOIN customers
            WHERE TIME(orderedAt)
            BETWEEN "18:00:00"
            AND "23:59:00";'
          );
          $result = $queryTable->execute();
          $result= $queryTable->fetchAll(PDO::FETCH_ASSOC);
          $expectedTable = [
            [
              "firstname" => "Nulla",
              "lastname" => "Enim",
              "email" => "nulla.enim@mail.com",
              "orderedAt" => "2016-12-06 18:30:00",
              "Order Id" => 2,
            ],
            [
              "firstname" => "Maximus",
              "lastname" => "Urna",
              "email" => "maximus.urna@mail.com",
              "orderedAt" => "2016-12-23 23:15:00",
              "Order Id" => 3,
            ],
            [
              "firstname" => "Maecena",
              "lastname" => "Neque",
              "email" => "maecena.neque@mail.com",
              "orderedAt" => "2017-01-08 19:15:00",
              "Order Id" => 7,
            ],
          ];

          $this->assertEquals($expectedTable, $result);
    }









}
 ?>
