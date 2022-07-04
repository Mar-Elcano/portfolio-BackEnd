-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema portfolio-ap
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema portfolio-ap
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `portfolio-ap` DEFAULT CHARACTER SET utf8 ;
USE `portfolio-ap` ;

-- -----------------------------------------------------
-- Table `portfolio-ap`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio-ap`.`usuario` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `contraseña` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio-ap`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio-ap`.`persona` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `apellido` VARCHAR(45) NULL,
  `apodo` VARCHAR(45) NULL,
  `ciudad` VARCHAR(45) NULL,
  `fecha_Nac` DATE NULL,
  `correo` VARCHAR(45) NULL,
  `sobre_mi` VARCHAR(300) NULL,
  `url_foto` VARCHAR(45) NULL,
  `usuario_id` INT NOT NULL,
  `profesion` VARCHAR(45) NULL,
  PRIMARY KEY (`id`, `usuario_id`),
  CONSTRAINT `fk_persona_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `portfolio-ap`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio-ap`.`experiencia_laboral`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio-ap`.`experiencia_laboral` (
  `id` INT NOT NULL,
  `nombre_empresa` VARCHAR(45) NULL,
  `trabajoactual` TINYINT NULL,
  `fechaInicio` DATE NULL,
  `fechaFin` DATE NULL,
  `tipo_de_empleo` VARCHAR(45) NULL,
  `persona_id` INT NOT NULL,
  PRIMARY KEY (`id`, `persona_id`),
  CONSTRAINT `fk_experiencia_laboral_persona`
    FOREIGN KEY (`persona_id`)
    REFERENCES `portfolio-ap`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio-ap`.`educacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio-ap`.`educacion` (
  `id` INT NOT NULL,
  `nombre_del_estabablecimiento` VARCHAR(45) NULL,
  `titulo_obtenido` VARCHAR(45) NULL,
  `cursa_actualmente` TINYINT NULL,
  `fechaInicio` DATE NULL,
  `fechaFin` DATE NULL,
  `persona_id` INT NOT NULL,
  `persona_usuario_id` INT NOT NULL,
  PRIMARY KEY (`id`, `persona_id`, `persona_usuario_id`),
  CONSTRAINT `fk_educacion_persona1`
    FOREIGN KEY (`persona_id` , `persona_usuario_id`)
    REFERENCES `portfolio-ap`.`persona` (`id` , `usuario_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio-ap`.`formacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio-ap`.`formacion` (
  `id` INT NOT NULL,
  `nombre_establecimiento` VARCHAR(45) NULL,
  `titulo` VARCHAR(45) NULL,
  `cursa-actualmente` TINYINT NULL,
  `fechaInicio` DATE NULL,
  `fechaFin` DATE NULL,
  `persona_id` INT NOT NULL,
  `persona_usuario_id` INT NOT NULL,
  PRIMARY KEY (`id`, `persona_id`, `persona_usuario_id`),
  CONSTRAINT `fk_formacion_persona1`
    FOREIGN KEY (`persona_id` , `persona_usuario_id`)
    REFERENCES `portfolio-ap`.`persona` (`id` , `usuario_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio-ap`.`tipos_de_empleos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio-ap`.`tipos_de_empleos` (
  `id` INT NOT NULL,
  `nombre_tipo` VARCHAR(45) NULL,
  `experiencia_laboral_id` INT NOT NULL,
  `experiencia_laboral_persona_id` INT NOT NULL,
  PRIMARY KEY (`id`, `experiencia_laboral_id`, `experiencia_laboral_persona_id`),
  CONSTRAINT `fk_tipos_de_empleos_experiencia_laboral1`
    FOREIGN KEY (`experiencia_laboral_id` , `experiencia_laboral_persona_id`)
    REFERENCES `portfolio-ap`.`experiencia_laboral` (`id` , `persona_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio-ap`.`puesto_laboral`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio-ap`.`puesto_laboral` (
  `id` INT NOT NULL,
  `nombre-puesto` VARCHAR(45) NULL,
  `experiencia_laboral_id` INT NOT NULL,
  `experiencia_laboral_persona_id` INT NOT NULL,
  PRIMARY KEY (`id`, `experiencia_laboral_id`, `experiencia_laboral_persona_id`),
  CONSTRAINT `fk_puesto_laboral_experiencia_laboral1`
    FOREIGN KEY (`experiencia_laboral_id` , `experiencia_laboral_persona_id`)
    REFERENCES `portfolio-ap`.`experiencia_laboral` (`id` , `persona_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio-ap`.`tipo_educacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio-ap`.`tipo_educacion` (
  `id` INT NOT NULL,
  `nombre_tipo_educacion` VARCHAR(45) NULL,
  `educacion_id` INT NOT NULL,
  PRIMARY KEY (`id`, `educacion_id`),
  CONSTRAINT `fk_tipo_educacion_educacion1`
    FOREIGN KEY (`educacion_id`)
    REFERENCES `portfolio-ap`.`educacion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio-ap`.`skill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio-ap`.`skill` (
  `id` INT NOT NULL,
  `nombre_skill` VARCHAR(45) NULL,
  `persona_id` INT NOT NULL,
  `persona_usuario_id` INT NOT NULL,
  PRIMARY KEY (`id`, `persona_id`, `persona_usuario_id`),
  CONSTRAINT `fk_skill_persona1`
    FOREIGN KEY (`persona_id` , `persona_usuario_id`)
    REFERENCES `portfolio-ap`.`persona` (`id` , `usuario_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio-ap`.`grado_de_aprendizaje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio-ap`.`grado_de_aprendizaje` (
  `id` INT NOT NULL,
  `nombre_de_avance` VARCHAR(45) NULL,
  `cantidad` INT NULL,
  `skill_id` INT NOT NULL,
  PRIMARY KEY (`id`, `skill_id`),
  CONSTRAINT `fk_grado_de_aprendizaje_skill1`
    FOREIGN KEY (`skill_id`)
    REFERENCES `portfolio-ap`.`skill` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
