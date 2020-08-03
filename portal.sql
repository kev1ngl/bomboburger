-- --------------------------------------------------------
-- Host:                         localhost
-- Versión del servidor:         5.7.24 - MySQL Community Server (GPL)
-- SO del servidor:              Win64
-- HeidiSQL Versión:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Volcando estructura para tabla tramite.area
CREATE TABLE IF NOT EXISTS `area` (
  `area_cod` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Codigo auto-incrementado del movimiento del area',
  `area_nombre` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT 'nombre del area',
  `area_fecha_registro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'fecha del registro del movimiento',
  `area_estado` enum('ACTIVO','INACTIVO') COLLATE utf8_unicode_ci NOT NULL COMMENT 'estado del area',
  PRIMARY KEY (`area_cod`),
  UNIQUE KEY `unico` (`area_nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Entidad Area';

-- Volcando datos para la tabla tramite.area: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `area` DISABLE KEYS */;
INSERT INTO `area` (`area_cod`, `area_nombre`, `area_fecha_registro`, `area_estado`) VALUES
	(1, 'SECRETARIADO', '2018-11-21 04:54:25', 'ACTIVO'),
	(2, 'DIRECCION', '2018-11-21 05:41:19', 'ACTIVO');
/*!40000 ALTER TABLE `area` ENABLE KEYS */;

-- Volcando estructura para tabla tramite.ciudadano
CREATE TABLE IF NOT EXISTS `ciudadano` (
  `ciudadano_cod` int(11) NOT NULL AUTO_INCREMENT,
  `ciud_nombres` varchar(100) NOT NULL,
  `ciud_apellidoPate` varchar(50) NOT NULL,
  `ciud_apellidoMate` varchar(50) NOT NULL,
  `ciud_dni` char(8) NOT NULL,
  `ciud_sexo` char(1) NOT NULL,
  `ciud_fechaNacimiento` date NOT NULL,
  `ciud_direccion` varchar(250) NOT NULL,
  `ciud_telefono` char(9) NOT NULL,
  `ciud_movil` char(9) NOT NULL,
  `ciud_email` varchar(80) NOT NULL,
  `ciud_fecharegistro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ciud_estado` enum('ACTIVO','INACTIVO') NOT NULL,
  `ciud_tipo` enum('NATURAL','JURIDICA') NOT NULL,
  PRIMARY KEY (`ciudadano_cod`),
  KEY `cod_ciudona` (`ciud_nombres`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla tramite.ciudadano: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `ciudadano` DISABLE KEYS */;
INSERT INTO `ciudadano` (`ciudadano_cod`, `ciud_nombres`, `ciud_apellidoPate`, `ciud_apellidoMate`, `ciud_dni`, `ciud_sexo`, `ciud_fechaNacimiento`, `ciud_direccion`, `ciud_telefono`, `ciud_movil`, `ciud_email`, `ciud_fecharegistro`, `ciud_estado`, `ciud_tipo`) VALUES
	(9, 'YASMIN', 'YASMIN', 'YASMIN', '222', 'F', '2017-10-21', 'YASMIN', '23', '23', 'sdds', '2018-11-21 04:41:23', 'ACTIVO', 'NATURAL');
/*!40000 ALTER TABLE `ciudadano` ENABLE KEYS */;

-- Volcando estructura para tabla tramite.detalle_ciudadano
CREATE TABLE IF NOT EXISTS `detalle_ciudadano` (
  `detalleciudadano_cod` int(11) NOT NULL AUTO_INCREMENT,
  `ciudadano_cod` int(11) NOT NULL,
  `documento_cod` char(13) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`detalleciudadano_cod`),
  KEY `ciudadano_cod` (`ciudadano_cod`),
  KEY `fd` (`documento_cod`),
  CONSTRAINT `detalle_ciudadano_ibfk_1` FOREIGN KEY (`ciudadano_cod`) REFERENCES `ciudadano` (`ciudadano_cod`),
  CONSTRAINT `detalle_ciudadano_ibfk_2` FOREIGN KEY (`documento_cod`) REFERENCES `documento` (`documento_cod`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla tramite.detalle_ciudadano: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `detalle_ciudadano` DISABLE KEYS */;
INSERT INTO `detalle_ciudadano` (`detalleciudadano_cod`, `ciudadano_cod`, `documento_cod`) VALUES
	(15, 9, 'DOC-000001'),
	(16, 9, 'DOC-000002'),
	(17, 9, 'DOC-000003'),
	(18, 9, 'DOC-000004');
/*!40000 ALTER TABLE `detalle_ciudadano` ENABLE KEYS */;

-- Volcando estructura para tabla tramite.detalle_institucion
CREATE TABLE IF NOT EXISTS `detalle_institucion` (
  `detalleinstitucion_cod` int(11) NOT NULL AUTO_INCREMENT,
  `institucion_cod` int(11) NOT NULL,
  `documento_cod` char(13) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`detalleinstitucion_cod`),
  KEY `institucion_cod` (`institucion_cod`),
  KEY `sd` (`documento_cod`),
  CONSTRAINT `detalle_institucion_ibfk_1` FOREIGN KEY (`institucion_cod`) REFERENCES `institucion` (`institucion_cod`),
  CONSTRAINT `detalle_institucion_ibfk_2` FOREIGN KEY (`documento_cod`) REFERENCES `documento` (`documento_cod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla tramite.detalle_institucion: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `detalle_institucion` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalle_institucion` ENABLE KEYS */;

-- Volcando estructura para tabla tramite.documento
CREATE TABLE IF NOT EXISTS `documento` (
  `documento_cod` char(13) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Codigo auto-incrementado del documento',
  `doc_asunto` varchar(150) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Asunto del documento',
  `doc_fecha_recepcion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'fecha del registro del documento',
  `tipoDocumento_cod` int(11) NOT NULL COMMENT 'codigo del tipo de documentos',
  `area_cod` int(11) NOT NULL COMMENT 'Destino del documento',
  `usu_cod` int(11) NOT NULL COMMENT 'Codigo de Usuario',
  `doc_estado` enum('PENDIENTE','ACEPTADO','RECHAZADO') COLLATE utf8_unicode_ci NOT NULL COMMENT 'estado del documento',
  `doc_tipo` enum('I','C') COLLATE utf8_unicode_ci NOT NULL,
  `doc_documento` varchar(350) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`documento_cod`),
  KEY `area_cod` (`area_cod`),
  KEY `tipoDocumento_cod` (`tipoDocumento_cod`),
  KEY `usu_cod` (`usu_cod`),
  CONSTRAINT `documento_ibfk_1` FOREIGN KEY (`area_cod`) REFERENCES `area` (`area_cod`),
  CONSTRAINT `documento_ibfk_2` FOREIGN KEY (`tipoDocumento_cod`) REFERENCES `tipo_documento` (`tipodocumento_cod`),
  CONSTRAINT `documento_ibfk_3` FOREIGN KEY (`usu_cod`) REFERENCES `usuario` (`cod_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Entidad Documento';

-- Volcando datos para la tabla tramite.documento: ~7 rows (aproximadamente)
/*!40000 ALTER TABLE `documento` DISABLE KEYS */;
INSERT INTO `documento` (`documento_cod`, `doc_asunto`, `doc_fecha_recepcion`, `tipoDocumento_cod`, `area_cod`, `usu_cod`, `doc_estado`, `doc_tipo`, `doc_documento`) VALUES
	('DOC-000001', 'CCC', '2018-11-25 05:58:48', 3, 2, 1, 'ACEPTADO', 'C', 'Archivo/5bfa64483dd0d-modelado.pdf'),
	('DOC-000002', 'PROFORMAS', '2018-11-26 21:45:11', 3, 1, 1, 'ACEPTADO', 'C', 'Archivo/5bfc93978495c-modelado.pdf'),
	('DOC-000003', 'FHFHF', '2020-08-02 20:06:55', 2, 2, 1, 'RECHAZADO', 'C', NULL),
	('DOC-000004', '', '2020-08-02 20:09:55', 3, 2, 1, 'RECHAZADO', 'C', NULL),
	('DOC-000005', 'FDSFS', '2020-08-02 21:37:50', 3, 2, 1, 'RECHAZADO', '', NULL),
	('DOC-000006', 'RYRYRY', '2020-08-02 21:40:39', 2, 2, 1, 'ACEPTADO', '', NULL),
	('DOC-000007', 'JHJHJHJK', '2020-08-02 22:21:35', 2, 2, 1, 'ACEPTADO', '', 'Archivo/5f2774af04090-Correo.txt');
/*!40000 ALTER TABLE `documento` ENABLE KEYS */;

-- Volcando estructura para tabla tramite.institucion
CREATE TABLE IF NOT EXISTS `institucion` (
  `institucion_cod` int(11) NOT NULL AUTO_INCREMENT,
  `inst_nombre` varchar(150) NOT NULL,
  `inst_tipoinstitucion` varchar(50) NOT NULL,
  `inst_estado` enum('ACTIVO','INACTIVO') NOT NULL,
  PRIMARY KEY (`institucion_cod`),
  UNIQUE KEY `unico` (`inst_nombre`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla tramite.institucion: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `institucion` DISABLE KEYS */;
INSERT INTO `institucion` (`institucion_cod`, `inst_nombre`, `inst_tipoinstitucion`, `inst_estado`) VALUES
	(1, 'BITEC', 'INSTITUTO', 'ACTIVO'),
	(2, 'SAN PEDRO', 'UNIVERSIDAD', 'INACTIVO'),
	(3, 'CESAR VALLEJO', 'UNIVERSIDAD', 'ACTIVO');
/*!40000 ALTER TABLE `institucion` ENABLE KEYS */;

-- Volcando estructura para procedimiento tramite.PA_BUSCARADMINISTRADOR
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_BUSCARADMINISTRADOR`(IN `codigo` INT)
BEGIN
SELECT
personal.pers_nombres,
personal.pers_apellidoPate,
personal.pers_apellidoMate,
usuario.usu_foto,
usuario.cod_usuario,
personal.pers_email,
personal.pers_telefono,
personal.pers_movil,
usuario.usu_clave,
personal.pers_direccion,
personal.pers_fechaNacimiento,
personal.pers_dni,
personal.pers_sexo
FROM
usuario
INNER JOIN personal ON personal.usuario_cod = usuario.cod_usuario
where personal.personal_cod = codigo;
END//
DELIMITER ;

-- Volcando estructura para procedimiento tramite.PA_EDITARAREA
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_EDITARAREA`(IN `CODIGO` INT, IN `AREA` VARCHAR(80), IN `ESTADO` VARCHAR(30))
BEGIN
UPDATE area SET
area_nombre = AREA,
area_estado = ESTADO
WHERE area_cod = CODIGO;
END//
DELIMITER ;

-- Volcando estructura para procedimiento tramite.PA_EDITARCIUDADANOTODOS
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_EDITARCIUDADANOTODOS`(IN `codigo` INT, IN `nombre` VARCHAR(100), IN `apePat` VARCHAR(50), IN `apeMat` VARCHAR(50), IN `tipopersona` VARCHAR(20), IN `telefo` VARCHAR(9), IN `movil` VARCHAR(9), IN `direc` VARCHAR(300), IN `fecha` DATE, IN `nrodocume` CHAR(8), IN `email` VARCHAR(100))
BEGIN
UPDATE ciudadano SET
ciud_nombres = nombre,
ciud_apellidoPate = apePat,
ciud_apellidoMate = apeMat,
ciud_email = email,
ciud_telefono = telefo,
ciud_movil = movil,
ciud_direccion = direc,
ciud_fechaNacimiento = fecha,
ciud_dni = nrodocume,
ciud_tipo=tipopersona
WHERE ciudadano_cod = codigo;
END//
DELIMITER ;

-- Volcando estructura para procedimiento tramite.PA_EDITARINSTITUCION
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_EDITARINSTITUCION`(IN `codigo` INT, IN `institucion` VARCHAR(150), IN `tipo` VARCHAR(50), IN `estado` VARCHAR(20))
BEGIN
UPDATE institucion SET
inst_nombre = institucion,
inst_tipoinstitucion=tipo,
inst_estado=estado
WHERE institucion_cod = codigo;
END//
DELIMITER ;

-- Volcando estructura para procedimiento tramite.PA_EDITARPERSONAL
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_EDITARPERSONAL`(IN `codigo` CHAR(10), IN `nombre` VARCHAR(100), IN `apePat` VARCHAR(50), IN `apeMat` VARCHAR(50), IN `email` VARCHAR(100), IN `telefo` CHAR(13), IN `movil` CHAR(13), IN `direc` VARCHAR(200), IN `fecha` VARCHAR(20), IN `dni` VARCHAR(13))
BEGIN
UPDATE personal SET
pers_nombres = nombre,
pers_apellidoPate = apePat,
pers_apellidoMate = apeMat,
pers_email = email,
pers_telefono = telefo,
pers_movil = movil,
pers_direccion = direc,
pers_fechaNacimiento = fecha,
pers_dni = dni
WHERE personal_cod = codigo;
END//
DELIMITER ;

-- Volcando estructura para procedimiento tramite.PA_EDITARPERSONALTODOS
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_EDITARPERSONALTODOS`(IN `codigo` INT, IN `nombre` VARCHAR(100), IN `apePat` VARCHAR(50), IN `apeMat` VARCHAR(50), IN `telefo` VARCHAR(9), IN `movil` VARCHAR(9), IN `direc` VARCHAR(300), IN `fecha` DATE, IN `nrodocume` CHAR(8), IN `email` VARCHAR(100), IN `estado` VARCHAR(20))
BEGIN
UPDATE personal SET
pers_nombres = nombre,
pers_apellidoPate = apePat,
pers_apellidoMate = apeMat,
pers_email = email,
pers_telefono = telefo,
pers_movil = movil,
pers_direccion = direc,
pers_fechaNacimiento = fecha,
pers_dni = nrodocume,
pers_estado = estado 
WHERE personal_cod = codigo;
END//
DELIMITER ;

-- Volcando estructura para procedimiento tramite.PA_EDITARTIPODOCUMENTO
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_EDITARTIPODOCUMENTO`(IN `CODIGO` INT, IN `NOMBRE` VARCHAR(250), IN `ESTADO` VARCHAR(20))
BEGIN
UPDATE tipo_documento 
SET
tipodo_descripcion = NOMBRE,
tipodo_estado = ESTADO
WHERE tipodocumento_cod = CODIGO;
END//
DELIMITER ;

-- Volcando estructura para procedimiento tramite.PA_EDITARUSUARIO
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_EDITARUSUARIO`(IN `usuario` VARCHAR(30), IN `actual` VARCHAR(30), IN `nueva` VARCHAR(30))
BEGIN
UPDATE usuario u
SET
u.usu_clave = nueva
WHERE u.usu_nombre = usuario AND u.usu_clave = actual;
END//
DELIMITER ;

-- Volcando estructura para procedimiento tramite.PA_REGISTRARAREA
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_REGISTRARAREA`(IN `NOMBRE` VARCHAR(50))
BEGIN
INSERT INTO area (area_nombre,area_estado) VALUES(NOMBRE,'ACTIVO');
END//
DELIMITER ;

-- Volcando estructura para procedimiento tramite.PA_REGISTRARCIUDADANO
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_REGISTRARCIUDADANO`(IN `nombre` VARCHAR(100), IN `apePat` VARCHAR(50), IN `apeMat` VARCHAR(50), IN `tipope` VARCHAR(50), IN `telefo` CHAR(9), IN `movil` CHAR(9), IN `direcc` VARCHAR(250), IN `fecnac` DATE, IN `dni` CHAR(8), IN `email` VARCHAR(30), IN `genero` CHAR(1))
BEGIN
INSERT INTO ciudadano(ciud_nombres,ciud_apellidoPate,ciud_apellidoMate,ciud_dni,ciud_sexo,ciud_fechaNacimiento,ciud_direccion,ciud_telefono,ciud_movil,ciud_email,ciud_estado,ciud_tipo) VALUES
(nombre,apePat,apeMat,dni,genero,fecnac,direcc,telefo,movil,email,'ACTIVO',tipope);
END//
DELIMITER ;

-- Volcando estructura para procedimiento tramite.PA_REGISTRARDOCUMENTO
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_REGISTRARDOCUMENTO`(IN `iddocumento` CHAR(13), IN `asunto` VARCHAR(150), IN `idtipodocu` INT, IN `idarea` INT, IN `idremitente` INT, IN `idusuario` INT, IN `opcion` VARCHAR(10))
BEGIN
INSERT INTO documento (documento_cod,doc_asunto,tipoDocumento_cod,area_cod,usu_cod,doc_estado,doc_tipo) VALUES
(iddocumento,asunto,idtipodocu,idarea,idusuario,'PENDIENTE',opcion);
IF opcion = 'C' THEN
INSERT INTO detalle_ciudadano (ciudadano_cod,documento_cod) VALUES (idremitente,iddocumento);
END IF;
IF opcion = 'I' THEN
INSERT INTO detalle_institucion(institucion_cod,documento_cod) VALUES (idremitente,iddocumento);
END IF;
END//
DELIMITER ;

-- Volcando estructura para procedimiento tramite.PA_REGISTRARDOCUMENTOARCHIVO
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_REGISTRARDOCUMENTOARCHIVO`(
	IN `iddocumento` CHAR(13),
	IN `idtipodocu` INT,
	IN `idusuario` INT,
	IN `archivo` VARCHAR(50),
	IN `cont` INT

)
BEGIN
IF cont = 0 THEN
	INSERT INTO documento (documento_cod,tipoDocumento_cod,usu_cod) VALUES
(iddocumento,idtipodocu,idusuario);
END IF;
IF cont = 1 THEN
	INSERT INTO documento (documento_cod,tipoDocumento_cod,usu_cod,doc_documento) VALUES
(iddocumento,idtipodocu,idusuario,archivo);
END IF;
END//
DELIMITER ;

-- Volcando estructura para procedimiento tramite.PA_REGISTRARINSTITUCION
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_REGISTRARINSTITUCION`(IN `institucion` VARCHAR(150), IN `tipo` VARCHAR(50))
BEGIN
INSERT INTO institucion(inst_nombre,inst_tipoinstitucion,inst_estado) VALUES(institucion,tipo,'ACTIVO');
END//
DELIMITER ;

-- Volcando estructura para procedimiento tramite.PA_REGISTRARPERSONAL
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_REGISTRARPERSONAL`(IN `nombre` VARCHAR(100), IN `apePat` VARCHAR(50), IN `apeMat` VARCHAR(50), IN `telefo` CHAR(9), IN `movil` CHAR(9), IN `direcc` VARCHAR(250), IN `fecnac` DATE, IN `dni` CHAR(8), IN `email` VARCHAR(30), IN `genero` CHAR(1), IN `usuario` VARCHAR(50), IN `clave` VARCHAR(50), IN `tipousario` INT, IN `puesto` VARCHAR(30))
BEGIN
INSERT INTO usuario (usu_nombre,usu_clave,usu_estado,cod_tipousuario,usu_foto) VALUES(usuario,clave,'ACTIVO',tipousario,'Fotos/admin.png');
INSERT INTO personal(pers_nombres,pers_apellidoPate,pers_apellidoMate,pers_dni,pers_sexo,pers_fechaNacimiento,pers_direccion,pers_telefono,pers_movil,pers_email,pers_estado,usuario_cod,pers_puesto) VALUES
(nombre,apePat,apeMat,dni,genero,fecnac,direcc,telefo,movil,email,'ACTIVO',(SELECT MAX(cod_usuario) from usuario),puesto);
END//
DELIMITER ;

-- Volcando estructura para procedimiento tramite.PA_REGISTRARTIPODOCUMENTO
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_REGISTRARTIPODOCUMENTO`(IN `NOMBRE` VARCHAR(250))
BEGIN
INSERT INTO tipo_documento (tipodo_descripcion,tipodo_estado) VALUES (NOMBRE,"ACTIVO");
END//
DELIMITER ;

-- Volcando estructura para procedimiento tramite.PA_VERIFICARUSUARIO
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_VERIFICARUSUARIO`(IN `_usu` VARCHAR(30), IN `_pass` VARCHAR(30))
SELECT
usuario.usu_nombre,
usuario.usu_clave,
CONCAT_WS(' ',personal.pers_nombres,personal.pers_apellidoPate,personal.pers_apellidoMate),
tipo_usuario.cod_tipousuario,
usuario.usu_foto,
personal.personal_cod,
tipo_usuario.tipusu_descripcion,
usuario.cod_usuario
FROM
personal
INNER JOIN usuario ON personal.usuario_cod = usuario.cod_usuario
INNER JOIN tipo_usuario ON usuario.cod_tipousuario = tipo_usuario.cod_tipousuario
WHERE usuario.usu_nombre = _usu AND usuario.usu_clave = _pass//
DELIMITER ;

-- Volcando estructura para tabla tramite.personal
CREATE TABLE IF NOT EXISTS `personal` (
  `personal_cod` int(11) NOT NULL AUTO_INCREMENT,
  `pers_nombres` varchar(100) NOT NULL,
  `pers_apellidoPate` varchar(50) NOT NULL,
  `pers_apellidoMate` varchar(50) NOT NULL,
  `pers_dni` char(8) NOT NULL,
  `pers_sexo` char(1) NOT NULL,
  `pers_fechaNacimiento` date NOT NULL,
  `pers_direccion` varchar(250) NOT NULL,
  `pers_telefono` char(9) NOT NULL,
  `pers_movil` char(9) NOT NULL,
  `pers_email` varchar(80) NOT NULL,
  `pers_fecharegistro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `pers_estado` enum('ACTIVO','INACTIVO') NOT NULL,
  `usuario_cod` int(11) NOT NULL,
  `pers_puesto` enum('ADMINISTRATIVO','AYUDANTE DE COCINA','GARZÓN') NOT NULL,
  PRIMARY KEY (`personal_cod`),
  KEY `cod_persona` (`pers_nombres`),
  KEY `personal_ibfk_1` (`usuario_cod`),
  CONSTRAINT `personal_ibfk_1` FOREIGN KEY (`usuario_cod`) REFERENCES `usuario` (`cod_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla tramite.personal: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `personal` DISABLE KEYS */;
INSERT INTO `personal` (`personal_cod`, `pers_nombres`, `pers_apellidoPate`, `pers_apellidoMate`, `pers_dni`, `pers_sexo`, `pers_fechaNacimiento`, `pers_direccion`, `pers_telefono`, `pers_movil`, `pers_email`, `pers_fecharegistro`, `pers_estado`, `usuario_cod`, `pers_puesto`) VALUES
	(9, 'JOSE', 'MENDOZA', 'MARAMBIO', '16308134', 'M', '2020-08-19', 'SANTANDER 458', '223454666', '399566558', 'sistemas.ssi@redsalud.gob.cl', '2020-08-02 18:31:06', 'ACTIVO', 11, 'GARZÓN'),
	(10, 'KEVIN ', 'GALLEGUILLOS', 'LOPEZ', '19771479', 'M', '2020-08-07', 'FREIRE 702', '223454666', '85365353', 'bvg.lopez@gmail.com', '2020-08-02 21:05:42', 'ACTIVO', 12, 'ADMINISTRATIVO');
/*!40000 ALTER TABLE `personal` ENABLE KEYS */;

-- Volcando estructura para tabla tramite.tipo_documento
CREATE TABLE IF NOT EXISTS `tipo_documento` (
  `tipodocumento_cod` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Codigo auto-incrementado del tipo documento',
  `tipodo_descripcion` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'Descripcion del  tipo documento',
  `tipodo_estado` enum('ACTIVO','INACTIVO') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'estado del tipo de documento',
  PRIMARY KEY (`tipodocumento_cod`),
  UNIQUE KEY `IU_COD_TIPDOCUMENTO` (`tipodocumento_cod`) USING BTREE COMMENT 'EL CODIGO SERA UNICO',
  KEY `IX_NOMBRE` (`tipodo_descripcion`) USING BTREE COMMENT 'SE ORDENARA LOS DATOS POR LA DESCRIPCION'
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Entidad Documento';

-- Volcando datos para la tabla tramite.tipo_documento: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `tipo_documento` DISABLE KEYS */;
INSERT INTO `tipo_documento` (`tipodocumento_cod`, `tipodo_descripcion`, `tipodo_estado`) VALUES
	(1, 'VACACIONES', 'ACTIVO'),
	(2, 'PERMISO MEDICO', 'ACTIVO'),
	(3, 'PERMISO', 'ACTIVO');
/*!40000 ALTER TABLE `tipo_documento` ENABLE KEYS */;

-- Volcando estructura para tabla tramite.tipo_usuario
CREATE TABLE IF NOT EXISTS `tipo_usuario` (
  `cod_tipousuario` int(11) NOT NULL AUTO_INCREMENT,
  `tipusu_descripcion` varchar(40) NOT NULL,
  `tipusu_estado` enum('ACTIVO','INACTIVO') NOT NULL,
  PRIMARY KEY (`cod_tipousuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla tramite.tipo_usuario: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `tipo_usuario` DISABLE KEYS */;
INSERT INTO `tipo_usuario` (`cod_tipousuario`, `tipusu_descripcion`, `tipusu_estado`) VALUES
	(1, 'ADMINISTRADOR', 'ACTIVO'),
	(2, 'ASISTENTE', 'ACTIVO');
/*!40000 ALTER TABLE `tipo_usuario` ENABLE KEYS */;

-- Volcando estructura para tabla tramite.usuario
CREATE TABLE IF NOT EXISTS `usuario` (
  `cod_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `usu_nombre` varchar(30) NOT NULL,
  `usu_clave` varchar(30) NOT NULL,
  `usu_estado` enum('ACTIVO','INACTIVO') DEFAULT NULL,
  `cod_tipousuario` int(11) NOT NULL,
  `usu_foto` varchar(350) NOT NULL,
  PRIMARY KEY (`cod_usuario`),
  KEY `cod_tipousuario` (`cod_tipousuario`),
  CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`cod_tipousuario`) REFERENCES `tipo_usuario` (`cod_tipousuario`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla tramite.usuario: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` (`cod_usuario`, `usu_nombre`, `usu_clave`, `usu_estado`, `cod_tipousuario`, `usu_foto`) VALUES
	(1, 'admin', 'admin123', 'ACTIVO', 1, 'Fotos/admin.png'),
	(10, 'asistente', '1234567', 'ACTIVO', 2, 'Fotos/admin.png'),
	(11, 'bryan.galleguillos', '16308134', 'ACTIVO', 2, 'Fotos/admin.png'),
	(12, 'kevin.galleguillos', 'admin123', 'ACTIVO', 1, 'Fotos/admin.png');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
