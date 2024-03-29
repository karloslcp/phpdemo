-- -----------------------------------------------------
-- Schema dogtorvet
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dogtorvet` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `dogtorvet` ;

-- -----------------------------------------------------
-- Table `dogtorvet`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dogtorvet`.`usuario` (
  `username` VARCHAR(16) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(100) NOT NULL,
  `telefono` VARCHAR(45) NULL,
  PRIMARY KEY (`username`),
  UNIQUE INDEX `IDX_EMAIL_UQ` (`email` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dogtorvet`.`tipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dogtorvet`.`tipo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dogtorvet`.`mascota`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dogtorvet`.`mascota` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `propietario` VARCHAR(16) NOT NULL,
  `fechaNac` DATE NOT NULL,
  `raza` VARCHAR(45) NOT NULL,
  `color` VARCHAR(45) NOT NULL,
  `genero` ENUM('Macho', 'Hembra') NOT NULL,
  `tipo` INT NOT NULL,
  `fotoUrl` VARCHAR(255),
  PRIMARY KEY (`id`),
  INDEX `propietario_idx` (`propietario` ASC),
  INDEX `fk_tipo_idx` (`tipo` ASC),
  CONSTRAINT `fk_propietario`
    FOREIGN KEY (`propietario`)
    REFERENCES `dogtorvet`.`usuario` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_tipo`
    FOREIGN KEY (`tipo`)
    REFERENCES `dogtorvet`.`tipo` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dogtorvet`.`vacuna`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dogtorvet`.`vacuna` (
  `id` VARCHAR(36) NOT NULL DEFAULT (UUID()),
  `fecha` DATETIME NOT NULL,
  `mascota` INT NOT NULL,
  `descripcion` VARCHAR(255) NOT NULL,
  INDEX `FK_MASCOTA_VACUNA_idx` (`mascota` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_MASCOTA_VACUNA`
    FOREIGN KEY (`mascota`)
    REFERENCES `dogtorvet`.`mascota` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dogtorvet`.`revision`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dogtorvet`.`revision` (
  `id` VARCHAR(36) NOT NULL DEFAULT (UUID()),
  `fecha` DATETIME NOT NULL,
  `mascota` INT NOT NULL,
  `peso` FLOAT NOT NULL,
  `comentarios` VARCHAR(255) NOT NULL,
  INDEX `FK_REVISION_MASCOTA_idx` (`mascota` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_REVISION_MASCOTA`
    FOREIGN KEY (`mascota`)
    REFERENCES `dogtorvet`.`mascota` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Insert data `dogtorvet`.`usuario`
-- -----------------------------------------------------
INSERT INTO `dogtorvet`.`usuario`(`username`, `password`, `email`, `nombre`, `apellidos`, `telefono`) VALUES
  ('jromo', SHA2('12345',256), 'jromo@correo.net', 'José', 'Romo', '55-5555-5555' ),
  ('atellez', SHA2('12345',256), 'atellez@correo.net', 'Alejandro', 'Téllez', '55-5555-5555' ),
  ('cgiron', SHA2('12345',256), 'cgiron@correo.net', 'Carlos', 'Girón', '55-5555-5555' ),
  ('snieto', SHA2('12345',256), 'snieto@correo.net', 'Susana', 'Nieto', '55-5555-5555' ),
  ('jvera', SHA2('12345',256), 'jvera@correo.net', 'Jaime', 'Vera', '55-5555-5555' );

-- -----------------------------------------------------
-- Insert data `dogtorvet`.`tipo`
-- -----------------------------------------------------
INSERT INTO `dogtorvet`.`tipo` (`descripcion`) VALUES ('Perro'),('Gato');

-- -----------------------------------------------------
-- Insert data `dogtorvet`.`mascota`
-- -----------------------------------------------------
INSERT INTO `dogtorvet`.`mascota` (`nombre`,`propietario`,`fechaNac`,`raza`,`color`,`genero`,`tipo`,`fotoUrl`) VALUES
  ('Denver', 'atellez', '2014-11-18', 'Metizo/Labrador', 'Miel', 'Macho', 1, 'https://raw.githubusercontent.com/atellezf/atellezf.github.io/master/perros/denver.jpg'),
  ('Camy', 'atellez', '2014-11-18', 'Mestizo/Labrador', 'Miel/Blanco', 'Hembra', 1, 'https://raw.githubusercontent.com/atellezf/atellezf.github.io/master/perros/camy.jpg'),
  ('Kia', 'atellez', '2016-01-28', 'Mestizo/Galgo', 'Atigrado', 'Hembra', 1, 'https://raw.githubusercontent.com/atellezf/atellezf.github.io/master/perros/kia.jpg'),
  ('Hamilton', 'atellez', '2018-04-05', 'Corgi', 'Miel', 'Macho', 1, 'https://raw.githubusercontent.com/atellezf/atellezf.github.io/master/perros/hamilton.jpg'),
  ('Olivia', 'atellez', '2026-08-25', 'Corgi', 'Miel/Blanco', 'Hembra', 1, 'https://raw.githubusercontent.com/atellezf/atellezf.github.io/master/perros/olivia.jpg'),
  ('Wera', 'jromo', '2012-09-16', 'Cocker Spagniel', 'Miel', 'Hembra', 1, 'https://misanimales.com/wp-content/uploads/2018/11/cocker-spaniel.jpg'),
  ('Maya', 'jromo', '2016-10-02', 'Border Collie', 'Negro/Blanco', 'Hembra', 1, 'https://t2.uc.ltmcdn.com/es/posts/8/3/6/como_saber_si_un_border_collie_es_puro_44638_600_square.jpg'),
  ('Chicharito', 'snieto', '2018-12-19', 'Mestizo', 'Negro/Blanco', 'Macho', 1, 'https://i.pinimg.com/474x/26/4e/ca/264eca5cd5a8fae9ff8f6d77b42d4a68.jpg'),
  ('Aquiles', 'snieto', '2016-03-30', 'Pit Bull', 'Blanco/Beige', 'Macho', 1, 'https://i.pinimg.com/originals/0e/f6/7a/0ef67a2ae564032c7eb80ba870e7ba73.jpg'),
  ('Roco', 'cgiron', '2012-03-30', 'Barbet', 'Blanco/Beige', 'Macho', 1, 'http://3.bp.blogspot.com/-FPdBxjVjE3U/Uae3pg2Qh3I/AAAAAAAALVU/dUCWJRqh5fk/s1600/67.jpg'),
  ('Lucky', 'cgiron', '2010-03-30', 'Cocker Spagniel', 'Blanco/Beige', 'Macho', 1, 'https://images.pexels.com/photos/11161177/pexels-photo-11161177.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
  ('Molly', 'jvera', '2021-11-30', 'Pomerania', 'Beige', 'Hembra', 1, 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ed/Pomeranian_Thank_You.jpg/250px-Pomeranian_Thank_You.jpg');
