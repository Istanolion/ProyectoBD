CREATE SEQUENCE seqAutor
MINVALUE 1
MAXVALUE 9999
START WITH 1
INCREMENT BY 1;
---------------------------------------------------------------------------
CREATE SEQUENCE seqPrestamo
MINVALUE 1
MAXVALUE 9999
START WITH 1
INCREMENT BY 1;
----------------------------------------------------------
CREATE SEQUENCE seqMaterial
MINVALUE 1
MAXVALUE 9999
START WITH 1
INCREMENT BY 1;
----------------------------------------------------------
CREATE SEQUENCE seqAdquisicion
MINVALUE 1
MAXVALUE 9999
START WITH 1
INCREMENT BY 1;
---------------------------------------------------------------------------
CREATE SEQUENCE seqDir
MINVALUE 1
MAXVALUE 9999
START WITH 1
INCREMENT BY 1;
---------------------------------------------------------------------------
CREATE SEQUENCE seqTesis
MINVALUE 1
MAXVALUE 9999
START WITH 1
INCREMENT BY 1;
---------------------------------------------------------------------------
CREATE SEQUENCE seqLector
MINVALUE 1
MAXVALUE 9999
START WITH 1
INCREMENT BY 1;
---10 INSERTS DE AUTORES--------
EXEC spInsertAutor(seqAutor.NEXTVAL,'mexicano','juan','rulfo');
EXEC spInsertAutor(seqAutor.NEXTVAL,'Ingles','J.R.R.','TOLKIEN');
EXEC spInsertAutor(seqAutor.NEXTVAL,'estadounidense','George R.R.','MARTIN');
EXEC spInsertAutor(seqAutor.NEXTVAL,'panameño','Carlos','Fuentes','Maciás');
EXEC spInsertAutor(seqAutor.NEXTVAL,'colombiano','Gabriel','garcia','marquez');
EXEC spInsertAutor(seqAutor.NEXTVAL,'estadounidense','Patrick','Rothfuss');
EXEC spInsertAutor(seqAutor.NEXTVAL,'mexicano','juan','perez','garcia');
EXEC spInsertAutor(seqAutor.NEXTVAL,'hondureño','gabriel','marquez','hernandez');
EXEC spInsertAutor(seqAutor.NEXTVAL,'frances','Albert','Camus');
EXEC spInsertAutor(seqAutor.NEXTVAL,'mexicano','gabriel','robles','sandoval');

---10 INSERTS DE LIBROS-----------------------------------------------------
EXEC spInsertLibro(seqMaterial.NEXTVAL,'Q5784A7890C447C789','NOVELA','Juego de Tronos','3','018457963571x','planeta','fantasia',seqAdquisicion.NEXTVAL);
EXEC spInsertLibro(seqMaterial.NEXTVAL,'c4785e4789f447f877','Infantil','El hobbit','2','784957610382a','minotauro','fantasia',seqAdquisicion.NEXTVAL);
EXEC spInsertLibro(seqMaterial.NEXTVAL,'E7845R1146F145W123','NOVELA','PEDRO PARAMO','1','147854693125C','debolsillo','realista',seqAdquisicion.NEXTVAL);
EXEC spInsertLibro(seqMaterial.NEXTVAL,'E7112E2156F154A122','Poemas','Coleccion de poemas','10','147854698212x','minotauro','literario',seqAdquisicion.NEXTVAL);
EXEC spInsertLibro(seqMaterial.NEXTVAL,'e1455f8441C123R555','TEXTO','COMO PROGRAMAR EN SQL','8','451752178888C','UNIVERSIDAD','consulta',seqAdquisicion.NEXTVAL);
EXEC spInsertLibro(seqMaterial.NEXTVAL,'F7774r4444e111f111','Novela','el extraño','9','147845293748x','editorial mundo','filosofia',seqAdquisicion.NEXTVAL);
EXEC spInsertLibro(seqMaterial.NEXTVAL,'F7774r4444e111f112','novela','La muerte de Artemio cruz','4','147885293748x','minotauro','realista',seqAdquisicion.NEXTVAL);
EXEC spInsertLibro(seqMaterial.NEXTVAL,'E7845R1177F145W123','Novela','amor en los tiempos del colera','5','157945854978x','debolsillo','fantasia',seqAdquisicion.NEXTVAL);
EXEC spInsertLibro(seqMaterial.NEXTVAL,'f7845R1146F145W123','Novela','el nombre del silencio','6','136948585412x','debolsillo','fantasia',seqAdquisicion.NEXTVAL);
EXEC spInsertLibro(seqMaterial.NEXTVAL,'E7895R1146F145W123','novela','los muertos no hablan','7','255567841453x','universal','policiaca',seqAdquisicion.NEXTVAL);


---10 INSERTS DE directores------------------------------------------------
EXEC SPINSERTDIR(seqDir.NEXTVAL,'universidad','juan','garcia','franco');
EXEC SPINSERTDIR(seqDir.NEXTVAL,'doctorado','diego','peres');
EXEC SPINSERTDIR(seqDir.NEXTVAL,'universidad','manuel','rosas','rojas');
EXEC SPINSERTDIR(seqDir.NEXTVAL,'maestria','brandon','gutierrez');
EXEC SPINSERTDIR(seqDir.NEXTVAL,'doctorado','gabriel','diaz');
EXEC SPINSERTDIR(seqDir.NEXTVAL,'posgrado','victor','soto','cabello');
EXEC SPINSERTDIR(seqDir.NEXTVAL,'doctorado','eduardo','villanueva','perez');
EXEC SPINSERTDIR(seqDir.NEXTVAL,'maestria','jose','castilla','sosa');
EXEC SPINSERTDIR(seqDir.NEXTVAL,'universidad','hector','campos');
EXEC SPINSERTDIR(seqDir.NEXTVAL,'maestria','irving','rosas','miranda');

---10 INSERTS DE tesis-----------------------------------------------------
EXEC SPINSERTTESIS(seqMaterial.NEXTVAL,'E7895R2246F145W123','texto','tesis como pasar mario bros 1','9',seqTesis.NEXTVAL,'sistemas','07/05/1998','1');
EXEC SPINSERTTESIS(seqMaterial.NEXTVAL,'a8895R2246F145W123','texto','mov. de una turbina eolica','8',seqTesis.NEXTVAL,'mecanica','01/02/2018','2');
EXEC SPINSERTTESIS(seqMaterial.NEXTVAL,'E7895R2246F445W123','texto','capacitacion de sql en redes','10',seqTesis.NEXTVAL,'sistemas','01/02/2012','2');
EXEC SPINSERTTESIS(seqMaterial.NEXTVAL,'E7895R2246F145c123','texto','teologia en el dia a dia','9',seqTesis.NEXTVAL,'literatura','13/05/2009','5');
EXEC SPINSERTTESIS(seqMaterial.NEXTVAL,'E7895R2246F145p222','texto','software libre y su economia','9',seqTesis.NEXTVAL,'sistemas','31/05/2007','6');
EXEC SPINSERTTESIS(seqMaterial.NEXTVAL,'E7895R2246F145r333','texto','trabajos de recuperacion','8',seqTesis.NEXTVAL,'arte','11/02/1999','8');
EXEC SPINSERTTESIS(seqMaterial.NEXTVAL,'E7895R2246F147v888','texto','economia mundial y mexico','10',seqTesis.NEXTVAL,'economia','30/06/2005','9');
EXEC SPINSERTTESIS(seqMaterial.NEXTVAL,'E7895R2245c555e222','texto','literatura mexicana','8',seqTesis.NEXTVAL,'literatura','28/02/2000','10');
EXEC SPINSERTTESIS(seqMaterial.NEXTVAL,'E7895R2246w774c444','texto','muerte sociocultural en mex','8',seqTesis.NEXTVAL,'literatura','13/05/1985','4');
EXEC SPINSERTTESIS(seqMaterial.NEXTVAL,'E7895c5556F145W123','texto','documentos en linea y su uso','10',seqTesis.NEXTVAL,'sistemas','14/05/2006','5');

---3 INSERTS DE tipolector-------------------------------------------------
EXEC SPINSERTTIPOLEC('1',1,8,3,'estudiante');
EXEC SPINSERTTIPOLEC('2',2,15,5,'profesor');
EXEC SPINSERTTIPOLEC('3',3,30,10,'investigador');

---10 INSERTS DE Lectores--------------------------------------------------
EXEC spInsertLector(seqLector.NEXTVAL,'5587496813','azucenas','tezonco','iztapalapa','1','juan','reyes');
EXEC spInsertLector(seqLector.NEXTVAL,'5214789652','hortencias','roma','alvaro obregon','2','manuel','perez','perez');
EXEC spInsertLector(seqLector.NEXTVAL,'5547813549','alelies','tezonco','iztapalapa','2','federico','rojas','ugalde');
EXEC spInsertLector(seqLector.NEXTVAL,'5531469728','claveles','nopalera','benito juarez','1','jose','hernandez');
EXEC spInsertLector(seqLector.NEXTVAL,'5531487493','rio nilo','coapa','magdalena','3','enrique','prieto');
EXEC spInsertLector(seqLector.NEXTVAL,'5518413541','francia','zapotitian','milpalta','2','claudia','esquivel','ramirez');
EXEC spInsertLector(seqLector.NEXTVAL,'5516841358','el salvador','san cristobal','benito juarez','3','laura','gomez','pardo');
EXEC spInsertLector(seqLector.NEXTVAL,'5567481855','colon','coapa','alvaro obregon','1','diana','romero');
EXEC spInsertLector(seqLector.NEXTVAL,'5541681392','cristobal','polanco','magdalena','1','tamara','villanueva');
EXEC spInsertLector(seqLector.NEXTVAL,'5514813866','nicolas campion','roma','alvaro obregon','3','lupita','perez','hernandez');
---15 INSERTS DE ejemplares------------------------------------------------
EXEC spInsertEjemplar('3','1','disponible');
EXEC spInsertEjemplar('5','1','disponible');
EXEC spInsertEjemplar('12','1','disponible');
EXEC spInsertEjemplar('13','1','disponible');
EXEC spInsertEjemplar('8','1','disponible');
EXEC spInsertEjemplar('1','1','no sale');
EXEC spInsertEjemplar('19','1','disponible');
EXEC spInsertEjemplar('20','1','no sale');
EXEC spInsertEjemplar('4','1','mantenimiento');
EXEC spInsertEjemplar('1','2','disponible');
EXEC spInsertEjemplar('6','1','disponible');
EXEC spInsertEjemplar('7','1','disponible');
EXEC spInsertEjemplar('2','1','disponible');
EXEC spInsertEjemplar('4','2','disponible');
EXEC spInsertEjemplar('4','3','disponible');

---10 INSERTS DE prestamos-----------------------------------------------------
EXEC spPrestamo(seqPrestamo.NEXTVAL,'3','1','2');
EXEC spPrestamo(seqPrestamo.NEXTVAL,'5','1','3');
EXEC spPrestamo(seqPrestamo.NEXTVAL,'4','1','5');
EXEC spPrestamo(seqPrestamo.NEXTVAL,'4','3','4');
EXEC spPrestamo(seqPrestamo.NEXTVAL,'12','1','8');
EXEC spPrestamo(seqPrestamo.NEXTVAL,'13','1','1');
EXEC spPrestamo(seqPrestamo.NEXTVAL,'20','1','1');
EXEC spPrestamo(seqPrestamo.NEXTVAL,'19','1','6');
EXEC spPrestamo(seqPrestamo.NEXTVAL,'7','1','6');
EXEC spPrestamo(seqPrestamo.NEXTVAL,'8','1','8');