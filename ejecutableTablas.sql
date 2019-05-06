CREATE USER adBiblio IDENTIFIED BY proyecto DEFAULT TABLESPACE USERS01;

GRANT CONNECT, RESOURCE, CREATE VIEW, CREATE ANY INDEX TO adBiblio;

CREATE TABLE autor(
idAutor CHAR(4),
nacionalidad VARCHAR2(20) NOT NULL,
nombreAutor VARCHAR2(20) NOT NULL,
apPatAutor VARCHAR2(20) NOT NULL,
apMatAutor VARCHAR2(20) NULL,
CONSTRAINT PkAutor PRIMARY KEY(idAutor)
);

CREATE TABLE material(
idMaterial CHAR(4),
ubicacion CHAR(18) NOT NULL,
clasificacion CHAR(18) NOT NULL,
titulo VARCHAR2(30) NOT NULL,
tipoMaterial CHAR(5) NOT NULL,
CONSTRAINT PkMaterial PRIMARY KEY (idMaterial),
CONSTRAINT CKTipoMaterial CHECK (tipoMaterial IN ('LIBRO','TESIS'))
);

CREATE TABLE autorMat(
idAutor CHAR(4),
idMaterial CHAR(4),
CONSTRAINT PkAutorMat PRIMARY KEY (idAutor,idMaterial),
CONSTRAINT FKAutorMatAut FOREIGN KEY (idAutor)
REFERENCES autor ON DELETE CASCADE,
CONSTRAINT FkAutorMatMat FOREIGN KEY (idMaterial)
REFERENCES material ON DELETE CASCADE
);

CREATE TABLE libro(
idMaterial CHAR(4),
isbn CHAR(13) NOT NULL,
edicion VARCHAR2(20) NOT NULL,
tema VARCHAR2(20) NOT NULL,
adquisicion CHAR(4) NOT NULL,
CONSTRAINT PkLibro PRIMARY KEY (idMaterial),
CONSTRAINT FklibroMat FOREIGN KEY (idMaterial)
REFERENCES material ON DELETE CASCADE,
CONSTRAINT UqLibroAdq UNIQUE (adquisicion),
CONSTRAINT UqLibroIsbn UNIQUE (isbn)
);

CREATE TABLE director(
idDir CHAR(4),
gradoEst VARCHAR2(30) NOT NULL,
nombreDir VARCHAR2(20) NOT NULL,
apPatDir VARCHAR2(20) NOT NULL,
apMatDir VARCHAR2(20),
CONSTRAINT PkDirector PRIMARY KEY (idDir)
);

CREATE TABLE tesis(
idMaterial CHAR(4),
idTesis CHAR(4) NOT NULL,
carrera VARCHAR2(30) NOT NULL,
anioPubliCacion DATE NOT NULL,
idDir CHAR(4),
CONSTRAINT PkTesis PRIMARY KEY (idMaterial),
CONSTRAINT FKtesisMat FOREIGN KEY (idMaterial)
REFERENCES material ON DELETE CASCADE,
CONSTRAINT FktesisDir FOREIGN KEY (idDir)
REFERENCES director ON DELETE SET NULL,
CONSTRAINT UqTesis UNIQUE (idTesis)
);

CREATE TABLE ejemplar(
idMaterial CHAR(4),
idEjem CHAR(4),
status CHAR(13) NOT NULL,
CONSTRAINT PkEjemplar PRIMARY KEY (idMaterial,idEjem),
CONSTRAINT FkEjemplarMat FOREIGN KEY (idMaterial)
REFERENCES material ON DELETE CASCADE,
CONSTRAINT CkEjemplarStat CHECK 
(status IN('DISPONIBLE','PRESTAMO','MANTENIMIENTO','NO SALE'))
);

CREATE TABLE tipoLector(
idTipo CHAR(4),
refrendos NUMBER(1) NOT NULL,
diasPrest NUMBER(1) NOT NULL,
limiteMat NUMBER(1) NOT NULL,
descLector VARCHAR2(12) NOT NULL,
CONSTRAINT PkTipoLector PRIMARY KEY(idTipo)
);

CREATE TABLE lector(
idLector CHAR(4),
vigente CHAR(1) NOT NULL,
fechaAlta DATE DEFAULT SYSDATE,
telefono CHAR(10) NOT NULL,
nombreLect VARCHAR(20) NOT NULL,
apPatLect VARCHAR(20) NOT NULL,
apMatLect VARCHAR(20),
calleLect VARCHAR(30) NOT NULL,
coloniaLect VARCHAR(50) NOT NULL,
delLect VARCHAR(20) NOT NULL,
adeudo NUMBER(5) DEFAULT 0,
fechaVig DATE DEFAULT SYSDATE+365,
idTipo CHAR(4) NOT NULL,
CONSTRAINT PkLector PRIMARY KEY (idLector),
CONSTRAINT FkLectorTipo FOREIGN KEY (idTipo)
REFERENCES tipoLector ON DELETE CASCADE,
CONSTRAINT CkVig CHECK (vigente IN('Y','N'))
);

CREATE TABLE prestamo(
idPrestamo CHAR(4),
fechaDevl DATE NOT NULL,
fechaPres DATE DEFAULT SYSDATE,
idMaterial CHAR(4) NOT NULL,
idLector CHAR(4) NOT NULL,
idEjem CHAR(4) NOT NULL,
fechaVen DATE NOT NULL,
CONSTRAINT PkPrestamo PRIMARY KEY (idPrestamo),
CONSTRAINT FkPrestamoEjem FOREIGN KEY (idMaterial,idEjem)
REFERENCES ejemplar ON DELETE CASCADE,
CONSTRAINT FkPrestamoLect FOREIGN KEY (idLector)
REFERENCES lector ON DELETE CASCADE
);

CREATE TABLE multa(
idPrestamo CHAR(4),
fechaMulta DATE DEFAULT SYSDATE,
monto NUMBER(6) NOT NULL,
diasRestraso NUMBER(3) NOT NULL,
CONSTRAINT PkMulta PRIMARY KEY (idPrestamo,fechaMulta),
CONSTRAINT FkMultaPrest FOREIGN KEY(idPrestamo)
REFERENCES prestamo ON DELETE CASCADE
);