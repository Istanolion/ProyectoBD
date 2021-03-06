CREATE OR REPLACE TRIGGER tgPrestamo
	BEFORE INSERT OR DELETE OR UPDATE OF fechaPres
	ON prestamo
	FOR EACH ROW
	DECLARE
		-- VARIABLES PARA INSERTING
		vMonto multa.monto%TYPE;
		vNumLibros NUMBER;
		vLimite tipoLector.limiteMat%TYPE;
		vStatus ejemplar.status%TYPE;
		vTipoLector lector.idTipo%TYPE;
		vDiasTipoLector tipoLector.diasPrest%TYPE;
		-- VARIABLES PARA UPDATING
		vDifFecha NUMBER;
		vResLimit NUMBER;
		-- VARIABLES PARA DELETING
		vMultaMonto NUMBER;
		vAdeudo NUMBER;

		CURSOR curMul IS 
			SELECT SUM(m.monto)
			FROM prestamo p
			JOIN multa m
			ON (p.idPrestamo=m.idPrestamo)
			WHERE p.idLector=:NEW.idLector
			GROUP BY p.idLector;

		CURSOR curPres IS 
			SELECT COUNT(*)
			FROM prestamo p
			WHERE p.idLector=:NEW.idLector;

	BEGIN

		CASE
			--SI SE INSERTA UN NUEVO PRESTAMO HABRA QUE VERIFICAR EL STATUS
			--DEL MATERIAL, QUE NO HAYA MULTA, QUE EL NUMERO DE PRESTAMOS
			--SEA CORRECTO Y NO SE EXCEDA
			WHEN INSERTING THEN
				--VERIFICAMOS QUE EL MATERIAL ESTE DISPONIBLE
					SELECT status INTO vStatus
					FROM ejemplar
					WHERE idMaterial = :NEW.idMaterial
					AND idEjem = :NEW.idEjem;

					IF vStatus != 'DISPONIBLE' THEN
						RAISE_APPLICATION_ERROR(-20007,'EL MATERIAL '||:NEW.idEjem||' NO ESTA DISPONIBLE
							 PARA PRESTAMO');
					END IF;

				--VERIFICAMOS SI EL USUARIO TIENE UNA MULTA
				--ESTO SE HACE CON AYUDA DEL CURSOR, QUE 
				--GUARDARA EL MONTO TOTAL DE MULTAS

					BEGIN
						OPEN curMul;
						FETCH curMul INTO vMonto;
						CLOSE curMul;
						EXCEPTION WHEN NO_DATA_FOUND THEN
							vMonto := 0;
					END;

					IF vMonto > 0 THEN
						RAISE_APPLICATION_ERROR(-20008,'NO SE PUEDE REALIZAR EL PRESTAMO, EL LECTOR '||:NEW.idLector||' 
							TIENE UNA MULTA DE '||vMonto);
					END IF;

				--VERIFICAMOS QUE EL NUMERO DE PRESTAMOS NO SE 
				--EXCEDA
				--SELECCION DEL TIPO DE LECTOR
					SELECT idTipo INTO vTipoLector
					FROM lector
					WHERE idLector = :NEW.idLector; 
				--SELECCION DEL NUMERO MAXIMO DE LIBROS QUE PUEDE PEDIR
					SELECT limiteMat INTO vLimite
					FROM tipoLector
					WHERE idTipo = vTipoLector;
					BEGIN
						OPEN curPres;
						FETCH curPres INTO vNumLibros;
						CLOSE curPres;
						EXCEPTION WHEN NO_DATA_FOUND THEN
							vNumLibros := 0;
					END;

					IF vNumLibros >= vLimite THEN
						RAISE_APPLICATION_ERROR(-20009,'NO SE PUEDE REALIZAR EL PRESTAMO, EL LECTOR '||:NEW.idLector||' 
							NO PUEDE SOLICITAR MAS MATERIAL QUE '||vLimite);
					END IF;

			--CUANDO SE HACE UN UPDATE DENTRO DE PRESTAMO SIGNIFICA QUE SE HARA UN RESELLO
			--DEBE VERIFICARSE QUE LA FECHA DEL RESELLO SEA EL DIA LIMITE DEL ANTIGUO PRESTAMO
			--TAMBIEN QUE EL NUMERO MAXIMO DE RESELLOS AUN NO SE TENGA
			WHEN UPDATING THEN
				--VERIFICAMOS QUE LA FECHA ACTUAL SEA LA FECHA DE VENCIMIENTO
				vDifFecha := TRUNC(TO_NUMBER(SYSDATE-:OLD.fechaDevl));

					IF vDifFecha < 0 THEN
						RAISE_APPLICATION_ERROR(-20010,'NO SE PUEDE REALIZAR EL RESELLO,NO ES EL DIA DE ENTREGA
							DE ESTE MATERIAL');
					ELSIF vDifFecha > 0 THEN
						RAISE_APPLICATION_ERROR(-20011,'NO SE PUEDE REALIZAR EL RESELLO,SE HA EXCEDIDO EL DIA DE ENTREGA
							DE ESTE MATERIAL POR FAVOR REGISTRE LA DEVOLUCION');
					END IF;

				--VERIFICAMOS QUE NO SE TENGA YA EL LIMITE DE RESELLOS

				SELECT idTipo INTO vTipoLector
				FROM lector
				WHERE idLector = :NEW.idLector; 

				SELECT refrendos INTO vResLimit
				FROM tipoLector
				WHERE idTipo = vTipoLector;

				IF :OLD.numRese >= vResLimit THEN
					RAISE_APPLICATION_ERROR(-20012,'NO SE PUEDE REALIZAR EL RESELLO, SE HA ALCANZADO
						EL LIMITE');
				END IF;

			--CUANDO SE HACE UN DELETE DENTRO DE PRESTAMO SIGNIFICA QUE SE HA HECHO UNA DEVOLUCION
			--DEBE DE REGISTRARSE UNA NUEVA MULTA EN CASO DE SER NECESARIO 

			WHEN DELETING THEN
				--ESTE CASO CUBRE LA PRIMERA INSERCION DE LA MULTA PARA ESTE PRESTAMO
				vDifFecha := TRUNC(TO_NUMBER(SYSDATE-:OLD.fechaDevl));

				SELECT adeudo INTO vAdeudo
				FROM lector
				WHERE idLector = :OLD.idLector;

				IF vDifFecha > 0 AND 
				:OLD.hMulta = 'N' THEN
					DBMS_OUTPUT.PUT_LINE('EL MATERIAL SE HA DEVUELTO CON ATRASO
					SE REGISTRARA UNA MULTA PARA EL USUARIO SOBRE EL PRESTAMO '||
					:OLD.idPrestamo);

					vMultaMonto := ftMulta(:OLD.fechaDevl);

					INSERT INTO multa
						(idPrestamo,monto,diasRetraso)	
					VALUES(:OLD.idPrestamo,vMultaMonto,vDifFecha);
					--UNA BANDERA QUE NOS DICE QUE EL PRESTAMO YA TIENE UNA MULTA
					UPDATE prestamo
					SET hMulta = 'Y'
					WHERE (idPrestamo = :OLD.idPrestamo);

					RAISE_APPLICATION_ERROR(-20013,'SOLO SE PODRA BORRAR DE PRESTAMO SI
						SE LIQUIDA LA MULTA DE '||vMultaMonto||' PESOS');

				--ESTE CASO NO PERMITIRA EL BORRADO POR QUE YA SE TIENE REGISTRADA LA MULTA
				--Y ESTA NO SE HA LIQUIDADO, SI EL ADEUDO ES 0 NO SE ENTRA AQUI,
				--SE PERMITE EL BORRADO

				ELSIF :OLD.hMulta = 'Y' AND vAdeudo > 0 THEN
					RAISE_APPLICATION_ERROR(-20013,'SOLO SE PODRA BORRAR DE PRESTAMO SI
						SE LIQUIDA LA MULTA DE '||vMultaMonto||' PESOS');
				END IF;

	END CASE;
END tgPrestamo;
/