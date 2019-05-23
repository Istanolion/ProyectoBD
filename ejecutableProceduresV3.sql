--@AUTORES:									GARCIAREBOLLO
--													JUAREZ
--													SALAZAR
--@DESCRIPCION:							SCRIPT ENCARGADO DE LA CREACION DE PROCEDIMIENTOS DEL PROYECTO BIBLIOTECA
--@FECHA:										

CREATE OR REPLACE PROCEDURE spInsertAutor(
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
		vapMat director.apMatDir%TYPE:=NULL
	)
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
		vIdDir Tesis.IdDir%TYPE
	)
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
		vtipoMaterial material.tipoMaterial%TYPE,
		vIdAutor autor.IdAutor%TYPE,
		vISBN libro.isbn%TYPE,
		vEdicion libro.edicion%TYPE,
		vTema libro.tema%TYPE,
		vAdquisicion libro.adquisicion%TYPE
	)
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
		vStatus ejemplar.status%TYPE
	)
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
CREATE OR REPLACE PROCEDURE spPrestamo(
	vIdPrestamo prestamo.idPrestamo%TYPE,
	vIdMaterial ejemplar.idMaterial%TYPE,
	vIdEjem ejemplar.idEjem%TYPE,
	vIdLector lector.idLector%TYPE
	)
	AS
		vTipoLector lector.idTipo%TYPE;
		vDiasTipoLector tipoLector.diasPrest%TYPE;
	BEGIN
		--LOS TRIGGERS SE ENCARGARAN DE VERIFICAR:
		--QUE NO HAYA MULTA PARA EL idLector
		--QUE EL EJEMPLAR TENGA EL STATUS DE DISPONIBLE status
		--QUE EL CONTEO DE LIBROS SEA CORRECTO PARA EL idLEctor
		--SELECCION DEL TIPO DE LECTOR
		SELECT idTipo INTO vTipoLector
		FROM lector
		WHERE idLector = vIdLector;
		--SELECCION DEL NUMERO DE DIAS
		SELECT diasPrest INTO vDiasTipoLector
		FROM tipoLector
		WHERE idTipo = vTipoLector;
		--INSERCION DE DATOS
		INSERT INTO prestamo
		(idPrestamo,fechaDevl,idMaterial,idLector,idEjem,fechaVen)
		VALUES(vIdPrestamo,SYSDATE+vIdLector,vIdMaterial,vIdLector,
			vIdEjem,SYSDATE+vIdLector);
		--ACTUALIZACION DE STATUS DEL MATERIAL
		UPDATE ejemplar
		SET status = 'PRESTAMO'
		WHERE idMaterial = vIdMaterial
		AND IdEjem = vIdEjem;
END spPrestamo;
/
----------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE spDevol(
	vIdMaterial ejemplar.idMaterial%TYPE,
	vIdEjem ejemplar.idEjem%TYPE,
	vIdLector lector.idLector%TYPE
	)
	AS
		CURSOR curDev IS 
			SELECT idPrestamo
			FROM prestamo p
			WHERE p.idLector =vIdLector
			AND p.idEjem = vIdEjem
			AND p.idMaterial = vIdMaterial;

			vIdPrestamo prestamo.idPrestamo%TYPE;
	BEGIN
		--EL TRIGGER tgPrestamo SECCION DELETING SE ENCARGARA DE VERIFICAR:
		--QUE NO HAYA MULTA PARA EL idLector Y DE SER
		--NECESARIO LA CREARA	
			begin
				OPEN curDev;
				FETCH curDev INTO vIdPrestamo;
				CLOSE curDev;
				EXCEPTION WHEN NO_DATA_FOUND THEN
					RAISE_APPLICATION_ERROR(-20020,'EL PRESTAMO SOLICITADO NO EXISTE');
			END;
		--BORRADO DEL PRESTAMO
		DELETE FROM prestamo
		WHERE idPrestamo = vIdPrestamo;
		--ACTUALIZACION DEL STATUS DEL MATERIAL
		UPDATE ejemplar
		SET status = 'DISPONIBLE'
		WHERE idMaterial = vIdMaterial
		AND IdEjem = vIdEjem;

END spDevol;
/
----------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE spResello(
	vIdMaterial ejemplar.idMaterial%TYPE,
	vIdEjem ejemplar.idEjem%TYPE,
	vIdLector lector.idLector%TYPE
	)
	AS
		CURSOR curDev IS 
			SELECT idPrestamo
			FROM prestamo p
			WHERE p.idLector =vIdLector
			AND p.idEjem = vIdEjem
			AND p.idMaterial = vIdMaterial;

			vIdPrestamo prestamo.idPrestamo%TYPE;
			vTipoLector lector.idTipo%TYPE;
			vDiasTipoLector tipoLector.diasPrest%TYPE;
	BEGIN
		--EL TRIGGER tgPrestamo SECCION UPDATING SE ENCARGARA DE VERIFICAR:
		--QUE EL DIA DE RESELLO SEA VALIDO
		--SI SE EXCEDE SOLICITA QUE SE HAGA LA DEVOLUCION
		--SI ESTA CON TIEMPO DE SOBRA SOLO RECHAZA EL RESELLO
		--TAMBIEN VERIFICA QUE NO SE TENGA EL LIMITE DE REFRENDOS
			BEGIN
				OPEN curDev;
				FETCH curDev INTO vIdPrestamo;
				CLOSE curDev;
				EXCEPTION WHEN NO_DATA_FOUND THEN
					RAISE_APPLICATION_ERROR(-20020,'EL PRESTAMO SOLICITADO NO EXISTE');
			END;
			--SELECCION DEL TIPO DE LECTOR
			SELECT idTipo INTO vTipoLector
			FROM lector
			WHERE idLector = vIdLector;
			--SELECCION DEL NUMERO DE DIAS DE PRESTAMOS PARA 
			--REALIZAR LA ACTUALIZACION DE FECHAS
			SELECT diasPrest INTO vDiasTipoLector
			FROM tipoLector
			WHERE idTipo = vTipoLector;
			--ACTUALIZACION DEL PRESTAMO
			UPDATE prestamo
			SET fechaPres =SYSDATE,
			fechaDevl = SYSDATE + vDiasTipoLector,
			numRese = numRese+1
			WHERE idPrestamo = vIdPrestamo;

END spResello;
/
----------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE spPagMulta(
	vIdLector lector.idLector%TYPE,
	vIdPrestamo prestamo.idPrestamo%TYPE,
	vMonto multa.monto%TYPE
	)
	AS
	BEGIN
	--SE LIQUIDA LA MULTA ENTONCES EN FUNCION DEL ADEUDO SE PERMITIRA 
	--O NO EL BORRADO
		UPDATE lector
		SET adeudo = adeudo - vMonto
		WHERE idLector = vIdLector;
	--SE ELIMINA EL REGISTRO DE MULTA
		DELETE FROM multa
		WHERE idPrestamo = vIdPrestamo;
		DBMS_OUTPUT.PUT_LINE('SE HA LIQUIDADO LA MULTA ASOCIADA AL PRESTAMO '||vIdPrestamo);
		DELETE FROM prestamo
		WHERE idPrestamo = vIdPrestamo;
END spPagMulta;
/
----------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE spMulta(
	vIdPrestamo prestamo.idPrestamo%TYPE,
	vMonto NUMBER,
	vDiasRet NUMBER)
	AS
	BEGIN

	INSERT INTO multa
	(idPrestamo,monto,diasRetraso)	
	VALUES(vIdPrestamo,vMonto,vDiasRet);

END spMulta;
/
----------------------------------------------------------------------------------
CONNECT system/oracle
SELECT object_name
FROM dba_objects 
WHERE object_type = 'PROCEDURE' AND OWNER='ADBIBLIO';
CONNECT adbiblio/proyecto


