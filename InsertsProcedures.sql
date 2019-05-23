CREATE OR REPLACE PROCEDURE spInsertAutor
(
vIdAutor autor.idAutor%TYPE,
vNacionalidad autor.nacionalidad%TYPE,
vNombre autor.nombreAutor%TYPE,
vApPat autor.apPatAutor%TYPE,
vApMat autor.apMatAutor%TYPE:=NULL
)
AS BEGIN
INSERT INTO autor
VALUES (UPPER(vIdAutor),UPPER(vNacionalidad),UPPER(vNombre),
UPPER(vApPat),UPPER(vApMat));
END spInsertAutor;
/
----------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE spInsertDir(
vIdDir director.IdDir%TYPE,
vGradoEst director.gradoEst%TYPE,
vnombre director.nombreDir%TYPE,
vapPat director.apPatDir%TYPE,
vapMat director.apMatDir%TYPE:=NULL)
AS BEGIN
INSERT INTO director
VALUES (UPPER(vIdDir),UPPER(vGradoEst),UPPER(vNombre),
UPPER(vApPat),UPPER(vApMat));
END spInsertDir;
/
----------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE spInsertTesis(
vIdMaterial material.idMaterial%TYPE,
vUbicacion material.ubicacion%TYPE,
vClasificacion material.clasificacion%TYPE,
vTitulo material.titulo%TYPE,
vIdAutor autor.IdAutor%TYPE,
vIdTesis Tesis.IdTesis%TYPE,
vCarrera Tesis.Carrera%TYPE,
vAnio Tesis.AnioPublicacion%TYPE,
vIdDir Tesis.IdDir%TYPE:=NULL)
AS BEGIN
INSERT INTO material
VALUES (UPPER(vIdMaterial),UPPER(vUbicacion),
UPPER(vClasificacion),UPPER(vTitulo),'TESIS');
INSERT INTO tesis
VALUES (UPPER(vIdMaterial),UPPER(vIdTesis),UPPER(vCarrera),
UPPER(vanio),UPPER(vIdDir));
INSERT INTO autorMat 
VALUES (UPPER(vIdAutor),UPPER(vIdMaterial));
END spInsertTesis;
/
----------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE spInsertLibro(
vIdMaterial material.idMaterial%TYPE,
vUbicacion material.ubicacion%TYPE,
vClasificacion material.clasificacion%TYPE,
vTitulo material.titulo%TYPE,
vIdAutor autor.IdAutor%TYPE,
vISBN libro.isbn%TYPE,
vEdicion libro.edicion%TYPE,
vTema libro.tema%TYPE,
vAdquisicion libro.adquisicion%TYPE)
AS BEGIN
INSERT INTO material
VALUES (UPPER(vIdMaterial),UPPER(vUbicacion),
UPPER(vClasificacion),UPPER(vTitulo),'LIBRO');
INSERT INTO libro
VALUES(UPPER(vIdMaterial),UPPER(vIsbn),UPPER(vEdicion),
UPPER(vTema),UPPER(vAdquisicion));
INSERT INTO autorMat 
VALUES (UPPER(vIdAutor),UPPER(vIdMaterial));
END spInsertLibro;
/
----------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE spInsertEjemplar(
vidMaterial ejemplar.idMaterial%TYPE,
vidEjem ejemplar.IdEjem%TYPE,
vStatus ejemplar.status%TYPE)
AS BEGIN
INSERT INTO ejemplar
VALUES (UPPER(vIdMaterial),UPPER(vIdEjem),UPPER(vStatus));
END spInsertEjemplar;
/
----------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE spInsertTipoLec(
vIdTipo TipoLector.IdTipo%TYPE,
vRefrendos TipoLector.Refrendos%TYPE,
vDiasPrest TipoLector.DiasPrest%TYPE,
vLimiteMat TipoLector.LimiteMat%TYPE,
vDescrip TipoLector.DescLector%TYPE
)
AS BEGIN
INSERT INTO TipoLector
VALUES(UPPER(vIdTipo),UPPER(vRefrendos),
UPPER(vDiasPrest),UPPER(vLimiteMat),UPPER(vDescrip));
END spInsertTipoLec;
/
----------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE spInsertLector(
vIdLector Lector.IdLector%TYPE,
vTelefono Lector.Telefono%TYPE,
vCalle Lector.CalleLect%TYPE,
vColonia Lector.ColoniaLect%TYPE,
vDel Lector.DelLect%TYPE,
vIdTipo Lector.IdTipo%TYPE,
vNombre Lector.NombreLect%TYPE,
vApPat Lector.ApPatLect%TYPE,
vApMat Lector.ApMatLect%TYPE:=NULL
)
AS BEGIN
INSERT INTO lector(IdLector,Telefono,NombreLect,ApPatLect,ApMatLect,
CalleLect,ColoniaLect,DelLect,IdTipo)
VALUES(UPPER(vIdLector),vTelefono,UPPER(vNombre),UPPER(vApPat),UPPER(vApMat),
UPPER(vCalle),UPPER(vColonia),UPPER(vDel),UPPER(vIdTipo));
END spInsertLector;
/
----------------------------------------------------------------------------------

----------------------------------------------------------------------------------

CONNECT system/oracle
SELECT object_name
FROM dba_objects 
WHERE object_type = 'PROCEDURE' AND OWNER='ADBIBLIO';
CONNECT adbiblio/proyecto

CONNECT system/oracle
SELECT object_name
FROM dba_objects 
WHERE object_type = 'TRIGGER' AND OWNER='ADBIBLIO';
CONNECT adbiblio/proyecto

CONNECT system/oracle
SELECT object_name
FROM dba_objects 
WHERE object_type = 'FUNCTION' AND OWNER='ADBIBLIO';
CONNECT adbiblio/proyecto

CONNECT system/oracle
SELECT object_name
FROM dba_objects 
WHERE object_type = 'VIEW' AND OWNER='ADBIBLIO';
CONNECT adbiblio/proyecto

ALTER TABLE tipoLector MODIFY diasPrest NUMBER(2);