CREATE OR REPLACE VIEW vwlibros
AS
select idMAterial,TITULO,IDEJEM,STATUS
FROM material
NATURAL JOIN ejemplar
where tipoMAterial LIKE 'LIBRO';
------------------------------------------
CREATE OR REPLACE VIEW vwtesis
AS
select idMAterial,TITULO,IDEJEM,STATUS
FROM material
NATURAL JOIN ejemplar
where tipoMAterial LIKE 'TESIS';
---------------------------------------
CREATE OR REPLACE VIEW vwautores
AS
SELECT * FROM AUTOR;
------------------------------------------------------------
CREATE OR REPLACE VIEW VWLECTOR
AS
SELECT IDTIPO,NOMBRELECT,APPATLECT,APMATLECT,ADEUDO,FECHAVIG
FROM LECTOR
ORDER BY IDTIPO;

