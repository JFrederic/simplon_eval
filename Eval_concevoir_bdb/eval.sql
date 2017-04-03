
CREATE DATABASE IF NOT EXISTS `eval_hospital` CHARACTER SET 'utf8';
USE `eval_hospital` ;

CREATE TABLE IF NOT EXISTS `patient` (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `lastname` VARCHAR(45) NOT NULL,
    `firstname` VARCHAR(45) NOT NULL,
    `age` INT NOT NULL,
    `gender` VARCHAR(45) NOT NULL,
    `weight` INT NOT NULL,
    `height` INT NOT NULL,
    PRIMARY KEY (`id`)
)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `staff` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `lastname` VARCHAR(45) NOT NULL,
    `firstname` VARCHAR(45) NOT NULL,
    `job` VARCHAR(255) NOT NULL,
    `phone` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`id`)
)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `room` (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `patient_id` INT UNSIGNED NOT NULL,
    `number` VARCHAR(45) NOT NULL,
    `dateofentry` INT NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_room`
    FOREIGN KEY (`patient_id`)
    REFERENCES `patient` (`id`)
)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `addresses` (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `patient_id` INT UNSIGNED NOT NULL,
    `staff_id` INT UNSIGNED NOT NULL,
    `street` VARCHAR(45) NOT NULL,
    `zipcode` INT NOT NULL,
    `city` VARCHAR(45) NOT NULL,
    `country` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_addresses_patient`
    FOREIGN KEY (`patient_id`)
    REFERENCES `patient` (`id`),
    CONSTRAINT `fk_addresses_staff`
    FOREIGN KEY (`staff_id`)
    REFERENCES `staff` (`id`)
)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `bills` (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `patient_id` INT UNSIGNED NOT NULL,
    `createdAt` DATE,
    `total_price` INT NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_bills_patient`
    FOREIGN KEY (`patient_id`)
    REFERENCES `patient` (`id`)
)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `bills_item` (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `bills_id` INT UNSIGNED NOT NULL,
    `service_name` VARCHAR(255) NOT NULL,
    `service_price` INT NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_bills_item_bills`
    FOREIGN KEY (`bills_id`)
    REFERENCES `bills` (`id`)

)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `patient_records` (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `patient_id` INT UNSIGNED NOT NULL,
    `staff_id` INT UNSIGNED NOT NULL,
    `patient_records_component_id` INT UNSIGNED NOT NULL,
    `desc` TEXT NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_records_patient`
    FOREIGN KEY (`patient_id`)
    REFERENCES `patient` (`id`),
    CONSTRAINT `fk_records_staff`
    FOREIGN KEY (`staff_id`)
    REFERENCES `staff` (`id`),
    CONSTRAINT `fk_records_patient_records_component`
    FOREIGN KEY (`patient_records_component_id`)
    REFERENCES `patient_records_component` (`id`)
)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `patient_records_component` (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `type` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`)
)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `payment_method` (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `patient_id` INT UNSIGNED NOT NULL,
    `regulation` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_payment_patient`
    FOREIGN KEY (`patient_id`)
    REFERENCES `patient` (`id`)
)
ENGINE = InnoDB;
