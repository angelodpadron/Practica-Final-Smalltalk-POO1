!classDefinition: #BloqueDeTest category: #'Biblioteca-Tests'!
TestCase subclass: #BloqueDeTest
	instanceVariableNames: 'benShapiro unaBiblioteca metro2033 warcraftCronicas bladeRunner libro4 estoNoEsUnLibro libro5'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Biblioteca-Tests'!

!BloqueDeTest methodsFor: 'as yet unclassified' stamp: 'zg 12/4/2018 00:24:12'!
setUp

	benShapiro _ Socio registrarNombre: 'Ben' apellido: 'Shapiro' legajo: 2.
	unaBiblioteca _ Biblioteca new.
	metro2033 _ Libro titulo: 'Metro 2033' autor: 'some russian dude' genero: 'sci-fi'.
	warcraftCronicas _ Libro titulo: 'World of Warcraft - Cronicas vol. 1' autor: 'christie algo' genero: 'fantasia'.
	bladeRunner _ Libro titulo: 'Suenan los androides con ovejas electricas?' autor: 'Me Olvide' genero: 'sci-fi'.
	libro4 _ Libro titulo: 'Libro 4' autor: 'Me quede sin imaginacion' genero: 'comedia'.
	estoNoEsUnLibro _ Libro titulo: 'Esto no es un libro' autor: 'Totalmente no un escritor' genero: 'misterio'.
	libro5 _ Libro titulo: 'E' autor: 'George Soros' genero: 'Filosofia'.
	unaBiblioteca registrarLibro: metro2033.
	unaBiblioteca registrarLibro: warcraftCronicas .
	unaBiblioteca registrarLibro: bladeRunner .
	unaBiblioteca registrarLibro: libro4 .
	unaBiblioteca registrarLibro: estoNoEsUnLibro .
	unaBiblioteca registrarLibro: libro5.
	! !


!classDefinition: #BibliotecaTest category: #'Biblioteca-Tests'!
BloqueDeTest subclass: #BibliotecaTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Biblioteca-Tests'!

!BibliotecaTest methodsFor: 'as yet unclassified' stamp: 'ADP 11/21/2018 18:03:34'!
test01BibliotecaSinLibros

	|biblioteca|
	biblioteca _ Biblioteca new.
	
	Assert that: biblioteca cantidadDeLibrosDisponibles isEqualTo: 0! !

!BibliotecaTest methodsFor: 'as yet unclassified' stamp: 'zg 12/4/2018 00:24:12'!
test02RegistrarLibroEnInventario

	|biblioteca libro|
	biblioteca _ Biblioteca new.
	libro _ Libro titulo: 'turbo pascal' autor: 'some dude'  genero: 'si'.
	biblioteca registrarLibro: libro.
	
	Assert isTrue: (biblioteca librosDisponibles includes: libro)! !

!BibliotecaTest methodsFor: 'as yet unclassified' stamp: 'zg 12/4/2018 00:24:12'!
test03BibliotecaRetornaListaDeLibrosConTemaRelacionado
	
	|biblioteca libro libro2|
	biblioteca _ Biblioteca new.
	
	libro _ Libro titulo: 'turbo pascal' autor: 'some dude'  genero: 'programacion'.
	libro2 _ Libro titulo: 'c++' autor: 'another dude'  genero: 'programacion'.
	
	biblioteca registrarLibro: libro .
	biblioteca registrarLibro: libro2 .
	
	
	Assert isTrue: ((biblioteca librosSobre: 'programacion') includes: libro).
	Assert isTrue: ((biblioteca librosSobre: 'programacion') includes: libro2).
! !

!BibliotecaTest methodsFor: 'as yet unclassified' stamp: 'zg 12/4/2018 00:24:12'!
test04Excepcion_BibliotecaRetornaListaDeLibrosConTemaRelacionado
	
	"error buscado: no existen libros con el tema buscado"
	
	|biblioteca libro|
	biblioteca _ Biblioteca new.
	
	libro _ Libro titulo: 'turbo pascal' autor: 'some dude'  genero: 'programacion'.
		
	biblioteca registrarLibro: libro .
		
	Assert should: [biblioteca librosSobre: 'humanidades'] signal: Error withDescription: 'no hay libros disponibles acerca de humanidades'! !

!BibliotecaTest methodsFor: 'as yet unclassified' stamp: 'ADP 11/24/2018 09:48:59'!
test05BibliotecaRegistraSocioEnSuBaseDeDatos

	|biblioteca|
	biblioteca _ Biblioteca new.
		
	biblioteca registrarSocioNombre: 'angelo' Apellido: 'padron'. 
	
	Assert that: ((biblioteca socioConLegajoNro: 1) nombre) isEqualTo: 'angelo'! !

!BibliotecaTest methodsFor: 'as yet unclassified' stamp: 'ADP 11/24/2018 09:51:08'!
test06Excepcion_BibliotecaRegistraSocioEnSuBaseDeDatos

	|biblioteca|
	biblioteca _ Biblioteca new.
		
	Assert should: [biblioteca socioConLegajoNro: 10] signal: Error withDescription: 'no existe socio con numero de legajo 10'! !

!BibliotecaTest methodsFor: 'as yet unclassified' stamp: 'ADP 11/24/2018 10:15:11'!
test07BibliotecaVerificaQueMembresiaDeSocioEsteVigente

	|biblioteca|
	biblioteca _ Biblioteca new.
	biblioteca registrarSocioNombre: 'ezequiel' Apellido: 'gasanol' "es italiano".
		
	Assert isTrue: (biblioteca membresiaDeSocioEstaActiva: 1) ! !

!BibliotecaTest methodsFor: 'as yet unclassified' stamp: 'ADP 11/24/2018 10:17:00'!
test08ListaDeSociosConMembresiaActiva

	|biblioteca|
	biblioteca _ Biblioteca new.
	biblioteca registrarSocioNombre: 'ezequiel' Apellido: 'gasanol' "es italiano".
	
	Assert isTrue: (biblioteca sociosActivos anySatisfy: [:socio | socio nombre == 'ezequiel']) ! !

!BibliotecaTest methodsFor: 'as yet unclassified' stamp: 'ZG 12/10/2018 10:01:32'!
test09BibliotecaVerificaSiExisteLibro

	|biblioteca|
	biblioteca _ Biblioteca new.
	
	biblioteca registrarLibro: (Libro titulo: 'master and commander' autor: 'some british dude' genero: 'novela').
	
	Assert isTrue: ((biblioteca buscarLibroTitulo: 'master and commander' de: 'some british dude') identificador == 1)! !

!BibliotecaTest methodsFor: 'as yet unclassified' stamp: 'ZG 12/10/2018 10:06:06'!
test10BibliotecaGeneraPrestamoASocio

	|biblioteca|
	biblioteca _ Biblioteca new.
	
	biblioteca registrarSocioNombre: 'ezequiel' Apellido: 'gasanol' "al ser el primer socio su legajo es 1".
	
	biblioteca registrarLibro: (Libro titulo: 'metro 2033' autor: 'some russian dude' genero: 'sci fi' ).
	
	biblioteca otorgarPrestamoDeLibroTitulo: 'metro 2033' deAutor: 'some russian dude' aSocio: (biblioteca socioConLegajoNro: 1).
	
	Assert isTrue: (((biblioteca socioConLegajoNro: 1) librosAlquilados) anySatisfy: [:libro | libro titulo = 'metro 2033']).! !

!BibliotecaTest methodsFor: 'as yet unclassified' stamp: 'ADP 12/4/2018 19:07:46'!
test11BibliotecaNoGeneraPrestamoASocioConMembresiaExpirada

	|biblioteca metro2033 unSocio |
	biblioteca _ Biblioteca new.
	metro2033 _ Libro titulo: 'metro 2033' autor: 'some russian dude' genero: 'sci fi'.
	unSocio _ Socio registrarNombre: 'Ezequiel' apellido: 'Gasañol' legajo: 10 fecha: (FixedGregorianDate yearNumber: 2017 monthNumber: 11 dayNumber: 25).

	biblioteca registrarLibro: metro2033.
	biblioteca 	agregarSocio: unSocio.
	
	Assert should: [unSocio solicitarPrestamoEstandarDeLibro: metro2033 a: biblioteca.] signal: Error withDescription: 'Registracion expirada'.
	
	Assert isFalse: ((biblioteca socioConLegajoNro: 10) prestamosVigentes anySatisfy: [:each | each libro = metro2033 ])! !

!BibliotecaTest methodsFor: 'as yet unclassified' stamp: 'ADP 12/6/2018 15:07:09'!
test12PuedoSaberSiUnSocioEsElegibleParaSancion

	| unPrestamo |
	unPrestamo _ Prestamo libro: metro2033 fechaDeInicio: (FixedGregorianDate today previous: 1 * week) fechaDeFin: FixedGregorianDate yesterday.
	unaBiblioteca agregarSocio: benShapiro.
	benShapiro prestamosVigentes add: unPrestamo.
	
	Assert isTrue: (unaBiblioteca sociosSancionables includes: benShapiro)! !

!BibliotecaTest methodsFor: 'as yet unclassified' stamp: 'ADP 12/6/2018 14:59:27'!
test13PuedoSancionarALosSociosElegiblesParaSancion

	| unPrestamo |
	unPrestamo _ Prestamo libro: metro2033 fechaDeInicio: (FixedGregorianDate today previous: 1 * week) fechaDeFin: FixedGregorianDate today.
	unaBiblioteca agregarSocio: benShapiro.
	benShapiro prestamosVigentes add: unPrestamo.
	
	unaBiblioteca sancionarSociosElegibles.
	Assert isTrue: benShapiro estaSancionado.! !

!BibliotecaTest methodsFor: 'as yet unclassified' stamp: 'ZG 12/10/2018 10:12:00'!
test14CuandoSeHaceUnPrestamoElLibroDejaDeEstarDisponible

	benShapiro solicitarPrestamoEstandarDeLibroConTitulo: 'Metro 2033' deAutor: 'some russian dude' aBiblioteca: unaBiblioteca .
	
	Assert isFalse: (unaBiblioteca librosDisponibles includes: metro2033)! !

!BibliotecaTest methodsFor: 'as yet unclassified' stamp: 'ZG 12/10/2018 10:12:01'!
test15AlRecibirLibroEsteVuelveAEstarDisponibleParaPrestamo

	benShapiro solicitarPrestamoEstandarDeLibroConTitulo: 'Metro 2033' deAutor: 'some russian dude' aBiblioteca: unaBiblioteca.
	
	
	benShapiro devolverLibroConTitulo: 'Metro 2033' deAutor: 'some russian dude' aBiblioteca: unaBiblioteca.
	
	Assert isTrue: (unaBiblioteca librosDisponibles includes: metro2033)
	! !

!BibliotecaTest methodsFor: 'as yet unclassified' stamp: 'ZG 12/10/2018 10:12:01'!
test16BibliotecaConcedeSolidaridadASocioQueDevuelveLibroAntesDeLos3Dias

	"valido solo con prestamo estandar"
	
	|biblioteca libro|
	biblioteca _ Biblioteca new.
	
	libro _ Libro titulo: 'turbo pascal' autor: 'some dude'  genero: 'programacion'.
	
	biblioteca registrarSocioNombre: 'angelo' Apellido: 'padron'. "legajo nro 1"
	biblioteca registrarLibro: libro.
	
	(biblioteca socioConLegajoNro: 1) solicitarPrestamoEstandarDeLibroConTitulo: 'turbo pascal' deAutor: 'some dude' aBiblioteca: biblioteca.
	(biblioteca socioConLegajoNro: 1) devolverLibroConTitulo: 'turbo pascal' deAutor: 'some dude' aBiblioteca: biblioteca.
	
	Assert isTrue: ((biblioteca socioConLegajoNro: 1) esSolidario) ! !

!BibliotecaTest methodsFor: 'as yet unclassified' stamp: 'ZG 12/10/2018 10:12:01'!
test17BibliotecaRetornaUnaListaConLosSociosSolidarios

	"valido solo con prestamo estandar"
	
	|biblioteca libro|
	biblioteca _ Biblioteca new.
	
	libro _ Libro titulo: 'turbo pascal' autor: 'some dude'  genero: 'programacion'.
	
	biblioteca registrarSocioNombre: 'angelo' Apellido: 'padron'. "legajo nro 1"
	biblioteca registrarSocioNombre: 'ezequiel' Apellido: 'gasanol'. "legajo nro 2"
	
	biblioteca registrarLibro: libro. "id 1"
	biblioteca registrarLibro: libro. "id 2"
	
	(biblioteca socioConLegajoNro: 1) solicitarPrestamoEstandarDeLibroConTitulo: 'turbo pascal' deAutor: 'some dude' aBiblioteca: biblioteca.
	(biblioteca socioConLegajoNro: 1) devolverLibroConTitulo: 'turbo pascal' deAutor: 'some dude' aBiblioteca: biblioteca.
	
	(biblioteca socioConLegajoNro: 2) solicitarPrestamoEstandarDeLibroConTitulo: 'turbo pascal' deAutor: 'some dude' aBiblioteca: biblioteca.
	(biblioteca socioConLegajoNro: 2) devolverLibroConTitulo: 'turbo pascal' deAutor: 'some dude' aBiblioteca: biblioteca.
	
	Assert isTrue: (biblioteca sociosSolidarios includes: (biblioteca socioConLegajoNro: 1)).
	Assert isTrue: (biblioteca sociosSolidarios includes: (biblioteca socioConLegajoNro: 2)).! !

!BibliotecaTest methodsFor: 'as yet unclassified' stamp: 'zg 12/7/2018 22:17:22'!
test18PuedoAgregarUnLibroQueFuePrestadoAlgunaVezALaLista

	
	unaBiblioteca registrarLibroPrestado: metro2033.
	
	Assert isTrue: (unaBiblioteca librosQueFueronPrestadosAlgunaVez includes: metro2033)! !

!BibliotecaTest methodsFor: 'as yet unclassified' stamp: 'zg 12/7/2018 22:17:37'!
test19OtroEjemplarDeUnMismoLibroYaPresenteEnLaListaDeLibrosPrestadosNoEsAgregado

	|otroLibro|
	otroLibro _ Libro titulo: 'Metro 2033' autor: 'some russian dude' genero: 'sci-fi'.
	
	unaBiblioteca registrarLibroPrestado: metro2033.
	unaBiblioteca registrarLibroPrestado: otroLibro.
	
	Assert isFalse: (unaBiblioteca librosQueFueronPrestadosAlgunaVez includes: otroLibro)! !

!BibliotecaTest methodsFor: 'as yet unclassified' stamp: 'ZG 12/10/2018 10:12:01'!
test20AlEfectuarseUnPrestamoElLibroEsRegistradoEnLaListaDeLibrosPrestados

	benShapiro solicitarPrestamoEstandarDeLibroConTitulo: 'Metro 2033' deAutor: 'some russian dude' aBiblioteca: unaBiblioteca.
	
	Assert isTrue: (unaBiblioteca librosQueFueronPrestadosAlgunaVez includes: metro2033)! !

!BibliotecaTest methodsFor: 'as yet unclassified' stamp: 'ADP 12/8/2018 15:07:13'!
test21SumarTiempoDeAlquilerAListDeLibrosAlquilados

	| libro1 libro2 |
	libro1 _ (Libro titulo: 'c' autor: 'some dude' genero: 'programacion') registrarDiasDeAlquilerDesde: (FixedGregorianDate today previous: 1 * week).
	libro2 _ (Libro titulo: 'c' autor: 'some dude' genero: 'programacion') registrarDiasDeAlquilerDesde: (FixedGregorianDate today previous: 1 *week).
	
	unaBiblioteca registrarLibro: libro1.
	unaBiblioteca registrarLibro: libro2.
	unaBiblioteca registrarLibroPrestado: libro1.
	unaBiblioteca registrarLibroPrestado: libro2. "no deberia guardarlo aca".
	
	
	Assert isTrue: (unaBiblioteca librosMasPedidos includes: libro1).
	Assert isFalse: (unaBiblioteca librosMasPedidos includes: libro2).
	Assert that: (unaBiblioteca librosMasPedidos first) tiempoAlquilado isEqualTo: (2 * week)! !

!BibliotecaTest methodsFor: 'as yet unclassified' stamp: 'ZG 12/10/2018 10:12:01'!
test22BibliotecaRetornaListaDeLibrosMasPedidos

	| unLibroRandom |
	unLibroRandom _ (Libro titulo: 'hola' autor: 'todo biennmmmn?' genero: 'e') registrarDiasDeAlquilerDesde: (FixedGregorianDate yearNumber: 2018 monthNumber: 11 dayNumber: 23).
	
	unaBiblioteca registrarLibro: unLibroRandom.
	unaBiblioteca registrarLibroPrestado: unLibroRandom.
	
	benShapiro solicitarPrestamoEstandarDeLibroConTitulo: 'Metro 2033' deAutor: 'some russian dude' aBiblioteca: unaBiblioteca.
	
	benShapiro devolverLibroConTitulo: 'Metro 2033' deAutor: 'some russian dude' aBiblioteca: unaBiblioteca.
	
	Assert isTrue: (unaBiblioteca librosMasPedidos includes: metro2033).
	Assert that: unaBiblioteca librosMasPedidos first isEqualTo: unLibroRandom.
	Assert that: unaBiblioteca librosMasPedidos last isEqualTo: metro2033! !

!BibliotecaTest methodsFor: 'as yet unclassified' stamp: 'ADP 12/11/2018 18:43:00'!
test23PuntoExtra_BibliotecaRetornaListaDeLibrosSobreUnTemaSinRepetir

	
	|libro1 libro2 libro3 biblioteca|
	
	biblioteca _ Biblioteca new.
	
	libro1 _ Libro titulo: 'master and commander' autor: 'Patric OBrien' genero: 'a'.
	libro2 _ Libro titulo: 'Fundacion e Imperio' autor: 'Isaac Asimov' genero: 'a'.
	libro3 _ Libro titulo: 'Manualidades Caseras' autor: 'Utilisima' genero: 'b'.
	
	biblioteca registrarLibro: libro1.
	biblioteca registrarLibro: libro1.
	
	biblioteca registrarLibro: libro2.
	biblioteca registrarLibro: libro2.
	biblioteca registrarLibro: libro2.
	biblioteca registrarLibro: libro2.
	
	biblioteca registrarLibro: libro3.
	biblioteca registrarLibro: libro3.
	
	Assert that: (biblioteca librosSobre: 'a') size isEqualTo: 2 		"siendo 6 ejemplares que hablan sobre el tema, solo 2 los representan".

! !

!BibliotecaTest methodsFor: 'as yet unclassified' stamp: 'ADP 12/11/2018 18:43:19'!
test24PuntoExtra_BibliotecaRetornaListaDeSociosSancionadosALaFecha

	
	| biblioteca|
	
	biblioteca _ Biblioteca new.
	
	biblioteca registrarSocioNombre: 'Angelo' Apellido: 'Padron'. "socio legajo nro 1".
	biblioteca registrarSocioNombre: 'Ezequiel' Apellido: 'Gasañol' "socio legajo nro 2".
	biblioteca registrarSocioNombre: 'Juan' Apellido: 'Topo' "socio legajo nro 3".
	biblioteca registrarSocioNombre: 'Jessica' Apellido: 'Jones' "socio legajo nro 4".
	biblioteca registrarSocioNombre: 'Matthew' Apellido: 'Murdook' "socio ciego legajo nro 5".

	(biblioteca socioConLegajoNro: 1) recibirSancion.
	(biblioteca socioConLegajoNro: 2) recibirSancion.
	(biblioteca socioConLegajoNro: 5) recibirSancion.
	
	Assert that: biblioteca sociosSancionados size isEqualTo: 3.
	Assert isTrue: (biblioteca sociosSancionados includes: (biblioteca socioConLegajoNro: 1)).
	Assert isTrue: (biblioteca sociosSancionados includes: (biblioteca socioConLegajoNro: 2)).
	Assert isTrue: (biblioteca sociosSancionados includes: (biblioteca socioConLegajoNro: 5)).
! !


!classDefinition: #LibroTest category: #'Biblioteca-Tests'!
BloqueDeTest subclass: #LibroTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Biblioteca-Tests'!

!LibroTest methodsFor: 'as yet unclassified' stamp: 'ADP 11/16/2018 18:58:16'!
test01LibroPoseeID

	|fundacion|
	fundacion _ Libro new.
	fundacion identificador: 1.
	
	Assert isTrue: (fundacion identificador = 1)! !

!LibroTest methodsFor: 'as yet unclassified' stamp: 'ADP 11/21/2018 17:59:37'!
test02LibroPoseeAutor

	|fundacion|
	fundacion _ Libro new.
	fundacion autor: 'Isaac Asimov'.
	
	Assert that: fundacion autor isEqualTo: 'Isaac Asimov'! !

!LibroTest methodsFor: 'as yet unclassified' stamp: 'ADP 11/21/2018 17:59:48'!
test03LibroPoseeGenero

	|fundacion|
	fundacion _ Libro new.
	fundacion genero: 'ciencia ficcion'.
	
	Assert that: fundacion genero isEqualTo: 'ciencia ficcion'! !

!LibroTest methodsFor: 'as yet unclassified' stamp: 'ADP 11/21/2018 17:59:58'!
test04LibroPoseeTitulo
	
	|libro|
	libro _ Libro new.
	libro titulo: 'La Sombra Sobre Insmouth'.
	
	Assert that: libro titulo isEqualTo: 'La Sombra Sobre Insmouth'! !

!LibroTest methodsFor: 'as yet unclassified' stamp: 'ADP 11/21/2018 18:00:08'!
test05CreacionDeLibroDesdeClase

	|libro|
	libro _ Libro titulo: 'Bautismo de Fuego' autor: 'Andrzej Sapkowski' genero: 'Fantastico'.
	
	Assert that: libro titulo isEqualTo: 'Bautismo de Fuego'.
	Assert that: libro autor isEqualTo: 'Andrzej Sapkowski'.
	Assert that: libro genero isEqualTo: 'Fantastico'.
	! !

!LibroTest methodsFor: 'as yet unclassified' stamp: 'ADP 11/21/2018 18:00:38'!
test06LibroPoseeTemasRelacionados

	|libro|
	libro _ Libro titulo: 'Bautismo de Fuego' autor: 'Andrzej Sapkowski' genero: 'Fantastico' identificador: 1.
	
	Assert isTrue: (libro tags includes: 'Fantastico') ! !

!LibroTest methodsFor: 'as yet unclassified' stamp: 'ADP 11/30/2018 16:22:58'!
test07LibroEsEspecial

	|libro unaBiblioteca|
	libro _ Libro titulo: 'Bautismo de Fuego' autor: 'Andrzej Sapkowski' genero: 'Fantastico'.
	unaBiblioteca _ Biblioteca new.
	unaBiblioteca registrarLibroEspecial: libro.
	
	Assert isTrue: libro esEspecial.! !

!LibroTest methodsFor: 'as yet unclassified' stamp: 'zg 12/4/2018 00:24:12'!
test08LibroNoEsEspecial

	|libro unaBiblioteca|
	libro _ Libro titulo: 'Bautismo de Fuego' autor: 'Andrzej Sapkowski' genero: 'Fantastico'.
	unaBiblioteca _ Biblioteca new.
	unaBiblioteca registrarLibro: libro.
	
	Assert isFalse: libro esEspecial.! !

!LibroTest methodsFor: 'as yet unclassified' stamp: 'ZG 12/10/2018 10:10:04'!
test09PuedoSaberElTiempoTotalPorElQueFuePedidoUnEjemplar
	
	|biblioteca libro|
	
	biblioteca _ Biblioteca new.
	libro _ Libro titulo: 'asados' autor: 'francis mallmann' genero: 'cocnica' "identificador libro 1". 
	
	biblioteca  registrarSocioNombre: 'angelo' Apellido: 'padron' "legajo nro 1".
	
	biblioteca registrarLibro: libro.
	
	"modo manual de prestamo para agregar fechas custom"
	
	(biblioteca socioConLegajoNro: 1) prestamosVigentes add: (Prestamo libro: libro 
	fechaDeInicio: (FixedGregorianDate yearNumber: 2018 monthNumber: 11 dayNumber: 30) 
	fechaDeFin: (FixedGregorianDate yearNumber: 2018 monthNumber: 12 dayNumber: 10)).
	
	biblioteca librosDisponibles remove: libro. "paso innecesario para el test"
	
	(biblioteca socioConLegajoNro: 1) devolverLibroConTitulo: 'asados' deAutor: 'francis mallmann' aBiblioteca: biblioteca.
	
	Assert that: libro tiempoAlquilado isEqualTo: ((FixedGregorianDate yearNumber: 2018 monthNumber: 11 dayNumber: 30) distanceTo: FixedGregorianDate today)
	
	! !


!classDefinition: #PrestamoTest category: #'Biblioteca-Tests'!
BloqueDeTest subclass: #PrestamoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Biblioteca-Tests'!

!PrestamoTest methodsFor: 'as yet unclassified' stamp: 'ADP 12/6/2018 15:00:27'!
test01PuedoRenovarUnPrestamo

	|unPrestamo|
	unPrestamo _ Prestamo libro: metro2033 fechaDeInicio: FixedGregorianDate yesterday fechaDeFin: (FixedGregorianDate yesterday next: 7 * day).
	
	benShapiro prestamosVigentes add: unPrestamo.
	benShapiro solicitarRenovacionDe: metro2033 a: unaBiblioteca .
	
	Assert that: (benShapiro prestamosVigentes detect:[:each |each libro = metro2033]) fechaDeFin isEqualTo: (FixedGregorianDate today next: 1 * week)! !

!PrestamoTest methodsFor: 'as yet unclassified' stamp: 'ADP 12/6/2018 15:00:38'!
test02NoPuedoRenovarUnPrestamoExpirado

	|unPrestamo|
	unPrestamo _ Prestamo libro: metro2033 fechaDeInicio: FixedGregorianDate yesterday fechaDeFin: FixedGregorianDate today.
	
	benShapiro prestamosVigentes add: unPrestamo.

	Assert should: [benShapiro solicitarRenovacionDe: metro2033 a: unaBiblioteca] signal: Error withDescription: 'El prestamo esta expirado' .
	
	Assert that: (benShapiro prestamosVigentes detect:[:each |each libro = metro2033]) fechaDeFin isEqualTo: FixedGregorianDate today.! !

!PrestamoTest methodsFor: 'as yet unclassified' stamp: 'ADP 12/6/2018 15:00:49'!
test03NoPuedoRenovarUnPrestamoEspecial

	|unPrestamo|
	metro2033 marcarLibroEspecial.
	unPrestamo _ Prestamo libro: metro2033 fechaDeInicio: FixedGregorianDate today fechaDeFin: FixedGregorianDate tomorrow.
	
	benShapiro prestamosVigentes add: unPrestamo.

	Assert should: [benShapiro solicitarRenovacionDe: metro2033 a: unaBiblioteca.] signal: Error withDescription: 'No se puede renovar prestamos especiales'.
	
	Assert that: (benShapiro prestamosVigentes detect:[:each |each libro = metro2033]) fechaDeFin isEqualTo: FixedGregorianDate tomorrow.! !

!PrestamoTest methodsFor: 'as yet unclassified' stamp: 'ADP 12/6/2018 15:01:02'!
test04PuedoSaberSiUnPrestamoEsExtendido
	|unPrestamo|
	
	unPrestamo _ Prestamo libro: metro2033 fechaDeInicio: FixedGregorianDate today fechaDeFin: FixedGregorianDate tomorrow.
	
	unPrestamo extendido: true.
	
	Assert isTrue: unPrestamo esExtendido.! !


!classDefinition: #SocioTest category: #'Biblioteca-Tests'!
BloqueDeTest subclass: #SocioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Biblioteca-Tests'!

!SocioTest methodsFor: 'as yet unclassified' stamp: 'zg 11/21/2018 15:55:02'!
test01PuedoSaberElNombreDeUnSocio

	| unsocio |
	unsocio _ Socio new.
	unsocio nombre: 'Ricardo'.
	
	Assert that: unsocio nombre isEqualTo: 'Ricardo'! !

!SocioTest methodsFor: 'as yet unclassified' stamp: 'zg 11/21/2018 15:55:20'!
test02PuedoSaberElApellidoDeUnSocio

	| unsocio |
	unsocio _ Socio new.
	unsocio apellido: 'Gomez'.
	
	Assert that: unsocio apellido isEqualTo: 'Gomez'! !

!SocioTest methodsFor: 'as yet unclassified' stamp: 'zg 11/21/2018 15:55:37'!
test03PuedoSaberElNombreYApellidoDeUnSocio

	| unsocio |
	unsocio _ Socio new.
	unsocio nombre: 'Ricardo'.
	unsocio apellido: 'Gomez'.
	
	Assert that: unsocio nombreYApellido isEqualTo: 'Ricardo Gomez'! !

!SocioTest methodsFor: 'as yet unclassified' stamp: 'zg 11/21/2018 15:55:53'!
test04PuedoElNumeroDeLegajoDeUnSocio

	| unsocio |
	unsocio _ Socio new.
	unsocio nombre: 'Ricardo'.
	unsocio apellido: 'Gomez'.
	unsocio legajo: 22331.
	
	Assert that: unsocio legajo isEqualTo: 22331! !

!SocioTest methodsFor: 'as yet unclassified' stamp: 'zg 11/21/2018 18:26:41'!
test05PuedoLaFechaDeRegistracionDeUnSocio

	| unsocio |
	unsocio _ Socio new.
	unsocio nombre: 'Ricardo'.
	unsocio apellido: 'Gomez'.
	unsocio fechaDeRegistro: FixedGregorianDate today.
	
	Assert that: unsocio fechaDeRegistro isEqualTo: FixedGregorianDate today! !

!SocioTest methodsFor: 'as yet unclassified' stamp: 'ADP 11/24/2018 09:31:35'!
test06unSocioPuedeRenovarSuRegistro

	| unsocio |
	unsocio _ Socio new.
	unsocio nombre: 'Ricardo'.
	unsocio apellido: 'Gomez'.
		
	unsocio renovarRegistro.
	Assert that: unsocio fechaDeRegistro isEqualTo: Date today! !

!SocioTest methodsFor: 'as yet unclassified' stamp: 'zg 11/21/2018 18:33:05'!
test07PuedoSaberSiLaRegistracionDeUnSocioExpiro

	| unsocio |
	unsocio _ Socio new.
	unsocio nombre: 'Ricardo'.
	unsocio apellido: 'Gomez'.
	unsocio fechaDeRegistro: (FixedGregorianDate yearNumber: 2017 monthNumber: 11 dayNumber: 21).
	
	Assert isFalse: unsocio registracionEstaVigente.! !

!SocioTest methodsFor: 'as yet unclassified' stamp: 'ADP 12/4/2018 18:39:58'!
test08PuedoSaberSiUnSocioTieneMasDe5LibrosAlquilados
	
	benShapiro solicitarPrestamoEstandarDeLibro: metro2033 a: unaBiblioteca.
	benShapiro solicitarPrestamoEstandarDeLibro: bladeRunner a: unaBiblioteca .
	benShapiro solicitarPrestamoEstandarDeLibro: warcraftCronicas a: unaBiblioteca .
	benShapiro solicitarPrestamoEstandarDeLibro: libro4 a: unaBiblioteca .
	benShapiro solicitarPrestamoEstandarDeLibro: estoNoEsUnLibro a: unaBiblioteca .
	
	Assert isTrue: benShapiro tieneCincoLibrosAlquilados.! !

!SocioTest methodsFor: 'as yet unclassified' stamp: 'ADP 12/4/2018 18:39:58'!
test09UnSocioNoPuedeAlquilarMasDe5Libros
	
	benShapiro solicitarPrestamoEstandarDeLibro: metro2033 a: unaBiblioteca.
	benShapiro solicitarPrestamoEstandarDeLibro: bladeRunner a: unaBiblioteca .
	benShapiro solicitarPrestamoEstandarDeLibro: warcraftCronicas a: unaBiblioteca .
	benShapiro solicitarPrestamoEstandarDeLibro: libro4 a: unaBiblioteca .
	benShapiro solicitarPrestamoEstandarDeLibro: estoNoEsUnLibro a: unaBiblioteca .
	Assert should: [benShapiro solicitarPrestamoEstandarDeLibro: libro5 a: unaBiblioteca .] signal: Error withDescription: 'Limite de prestamos alcanzado'.
	
	Assert isFalse: (benShapiro librosAlquilados includes: libro5).! !

!SocioTest methodsFor: 'as yet unclassified' stamp: 'ADP 12/4/2018 18:39:58'!
test10PuedoSaberLosPrestamosVigentesDeUnSocio
	
	benShapiro solicitarPrestamoEstandarDeLibro: metro2033 a: unaBiblioteca.
	
	 Assert 
		isTrue: (benShapiro prestamosVigentes anySatisfy: [:each | each libro == metro2033])
	! !

!SocioTest methodsFor: 'as yet unclassified' stamp: 'ZG 12/10/2018 10:12:01'!
test11PuedoPedirUnLibroEspecial
	
	
	|biblioteca|
	biblioteca _ Biblioteca new.
	biblioteca registrarSocioNombre: 'some' Apellido: 'dude'.
	biblioteca registrarLibroEspecial: (Libro titulo: 'soberano de tormentas' autor: 'el ponja' genero: 'fantasia').
	biblioteca registrarSocioNombre: 'another' Apellido: 'dude'.
	
	(biblioteca socioConLegajoNro: 1) solicitarPrestamoEstandarDeLibroConTitulo: 'soberano de tormentas' deAutor: 'el ponja' aBiblioteca: biblioteca.
	
	Assert isTrue: ((biblioteca socioConLegajoNro: 1) prestamosVigentes anySatisfy: [:unPrestamo | (unPrestamo duracionDePrestamo = (1 * day)) & (unPrestamo libro titulo = 'soberano de tormentas')])
	! !

!SocioTest methodsFor: 'as yet unclassified' stamp: 'ZG 12/10/2018 10:12:01'!
test12PuedoSolicitarUnPrestamoExtendido
	
	|biblioteca soberanoDeTormentas|
	biblioteca _ Biblioteca new.
	soberanoDeTormentas _ Libro titulo: 'soberano de tormentas' autor: 'el ponja' genero: 'fantasia'.
	biblioteca registrarLibro: soberanoDeTormentas.
	biblioteca registrarSocioNombre: 'some' Apellido: 'dude'.
	(biblioteca socioConLegajoNro: 1) solicitarPrestamoEstandarDeLibroConTitulo: 'soberano de tormentas' deAutor: 'el ponja' aBiblioteca: biblioteca.
	
	
	"Assert isTrue: ((biblioteca socioConLegajoNro: 1) prestamoDe: soberanoDeTormentas) esExtendido.
	Assert that: (benShapiro prestamoDe: metro2033) fechaDeFin isEqualTo: (FixedGregorianDate yearNumber: 2018 monthNumber: 12 dayNumber: 13)"
	! !

!SocioTest methodsFor: 'as yet unclassified' stamp: 'ZG 12/10/2018 10:12:31'!
test12REFACTOR_PuedoSolicitarUnPrestamoExtendido
	
	|biblioteca|
	biblioteca _ Biblioteca new.
	biblioteca registrarLibro: (Libro titulo: 'soberano de tormentas' autor: 'el ponja' genero: 'fantasia').
	biblioteca registrarSocioNombre: 'some' Apellido: 'dude'.
	(biblioteca socioConLegajoNro: 1) solicitarPrestamoExtendidoDeLibroConTitulo: 'soberano de tormentas' deAutor: 'el ponja' aSocio: biblioteca hastaFecha: (FixedGregorianDate yearNumber: 2018 monthNumber: 12 dayNumber: 30).
	
	
	Assert isTrue: ((biblioteca socioConLegajoNro: 1) prestamoDeLibroConTitulo: 'soberano de tormentas' deAutor: 'el ponja') esExtendido.
	Assert that: ((biblioteca socioConLegajoNro: 1) prestamoDeLibroConTitulo: 'soberano de tormentas' deAutor: 'el ponja') fechaDeFin isEqualTo: (FixedGregorianDate yearNumber: 2018 monthNumber: 12 dayNumber: 31) "revisar esto!!"
	! !

!SocioTest methodsFor: 'as yet unclassified' stamp: 'ADP 12/4/2018 18:40:37'!
test13NoPuedoSolicitarUnPrestamoExtendidoConMembresiaExpirada
	
	benShapiro fechaDeRegistro: (FixedGregorianDate yearNumber: 2017 monthNumber: 11 dayNumber: 30).
	Assert should: [benShapiro solicitarPrestamoExtendidoDeLibro: metro2033 a: unaBiblioteca hasta: (FixedGregorianDate yearNumber: 2018 monthNumber: 12 dayNumber: 12).] signal: Error withDescription: 'Registracion expirada'.
	
	Assert isTrue: benShapiro prestamosVigentes isEmpty! !

!SocioTest methodsFor: 'as yet unclassified' stamp: 'ADP 12/4/2018 18:40:37'!
test14NoPuedoRenovarUnPrestamoExtendido
	
	benShapiro solicitarPrestamoExtendidoDeLibro: metro2033 a: unaBiblioteca hasta: (FixedGregorianDate yearNumber: 2018 monthNumber: 12 dayNumber: 12).
	
	Assert should: [benShapiro solicitarRenovacionDe: metro2033 a: unaBiblioteca.] signal: Error withDescription: 'No se puede renovar un prestamo extendido'.
	
	Assert that: (benShapiro prestamoDe: metro2033) fechaDeFin isEqualTo: (FixedGregorianDate yearNumber: 2018 monthNumber: 12 dayNumber: 13)! !

!SocioTest methodsFor: 'as yet unclassified' stamp: 'ZG 12/10/2018 10:12:59'!
test14REFACTOR_NoPuedoRenovarUnPrestamoExtendido
	
	
	|biblioteca|
	biblioteca _ Biblioteca new.
	biblioteca registrarSocioNombre: 'pepe' Apellido: 'argento'.
	biblioteca registrarLibro: (Libro titulo: 'manual' autor: 'de tv' genero: 'ni idea').
	(biblioteca socioConLegajoNro: 1) solicitarPrestamoExtendidoDeLibroConTitulo: 'manual' deAutor: 'de tv' aSocio: biblioteca hastaFecha: (FixedGregorianDate yearNumber: 2018 monthNumber: 12 dayNumber: 30).
	
	Assert should: [(biblioteca socioConLegajoNro: 1) solicitarRenovacionDePrestamoDeLibroConTitulo: 'manual' deAutor: 'de tv' aBiblioteca: biblioteca] signal: Error withDescription: 'No se puede renovar un prestamo extendido'.
	
	Assert that: ((biblioteca socioConLegajoNro: 1) prestamoDeLibroConTitulo: 'manual' deAutor: 'de tv') fechaDeFin isEqualTo: (FixedGregorianDate yearNumber: 2018 monthNumber: 12 dayNumber: 31) "revisar esto!!"! !

!SocioTest methodsFor: 'as yet unclassified' stamp: 'ZG 12/10/2018 10:12:01'!
test15REFACTOR_SocioPuedeDevolverLibro
	
	|biblioteca|
	biblioteca _ Biblioteca new.
	biblioteca registrarLibro: (Libro titulo: 'abc' autor: 'pepe' genero: 'infantil').
	biblioteca registrarSocioNombre: 'pocho' Apellido: 'the panther'.
	(biblioteca socioConLegajoNro: 1) solicitarPrestamoEstandarDeLibroConTitulo: 'abc' deAutor: 'pepe' aBiblioteca: biblioteca.
	
	(biblioteca socioConLegajoNro: 1) devolverLibroConTitulo: 'abc' deAutor: 'pepe' aBiblioteca: biblioteca.
	
	Assert isTrue: (biblioteca socioConLegajoNro: 1) prestamosVigentes isEmpty! !

!SocioTest methodsFor: 'as yet unclassified' stamp: 'ADP 12/4/2018 18:39:58'!
test15SocioPuedeDevolverLibro
	
	benShapiro solicitarPrestamoEstandarDeLibro: metro2033 a: unaBiblioteca.
	
	benShapiro devolverLibro: metro2033 a: unaBiblioteca.
	
	Assert isTrue: benShapiro prestamosVigentes isEmpty! !

!SocioTest methodsFor: 'as yet unclassified' stamp: 'zg 12/4/2018 00:26:28'!
test16PuedoSaberSiUnSocioEstaSancionado
	
	benShapiro recibirSancion.
	
	Assert isTrue: benShapiro estaSancionado.! !

!SocioTest methodsFor: 'as yet unclassified' stamp: 'zg 12/1/2018 18:00:33'!
test17PuedoSaberSiUnSocioNoEstaSancionado
	
	Assert isFalse: benShapiro estaSancionado.! !

!SocioTest methodsFor: 'as yet unclassified' stamp: 'ADP 12/6/2018 15:17:16'!
test18PuedoSaberSiUnSocioEsSolidario
	
	Assert isFalse: benShapiro esSolidario! !


!classDefinition: #StreamsTest category: #'Biblioteca-Tests'!
TestCase subclass: #StreamsTest
	instanceVariableNames: 'benShapiro unaBiblioteca metro2033 warcraftCronicas bladeRunner libro4 estoNoEsUnLibro libro5'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Biblioteca-Tests'!
!StreamsTest commentStamp: '<historical>' prior: 0!
ACLARACION IMPORTANTE: LOS TESTS NO FUNCIONAN CORRECTAMENTE DEBIDO A LA FALTA
DE CONOCIMIENTOS ACERCA DE COMO TESTEAR LOS MISMOS, SIN EMBARGO, SU FUNCION DE TDD
FUE CORRECTA, LOS ARCHIVOS ESPERADOS SE GENERAN CORRECTAMENTE EN EL DIRECTORIO RAIZ
DEL AMBIENTE DE CUIS.!


!StreamsTest methodsFor: 'as yet unclassified' stamp: 'ADP 12/11/2018 10:47:43'!
test01BibliotecaGeneraDocumentoDeLibrosSobreUnTema

	|biblioteca libro1 libro2|
	biblioteca _ Biblioteca new.
	libro1 _ Libro titulo: 'Shader programming for starters' autor: 'Unreal' genero: 'programacion'.
	libro2 _ Libro titulo: 'TDD en Smalltalk' autor: 'MP' genero: 'programacion'.
	
	biblioteca registrarLibro: libro1.
	biblioteca registrarLibro: libro2.
	
	biblioteca generarArchivoListaDeLibrosSobre: 'programacion'.
	
	Assert isTrue: ('./listaDeLibrosSobre.txt' asFileEntry exists) ! !

!StreamsTest methodsFor: 'as yet unclassified' stamp: 'ADP 12/11/2018 22:05:53'!
test02BibliotecaGeneraDocumentoDeLibrosMasPedidos

	|biblioteca|
	biblioteca _ Biblioteca new.
	biblioteca registrarLibro: ((Libro titulo: 'Shader programming for starters' autor: 'Unreal' genero: 'programacion') registrarDiasDeAlquilerDesde: (FixedGregorianDate yearNumber: 2018 monthNumber: 11 dayNumber: 23)).
	biblioteca registrarLibro: (Libro titulo: 'TDD en Smalltalk' autor: 'MP' genero: 'programacion'). "sin alquilar, no deberia incluirse en el listado"

	
	biblioteca registrarSocioNombre: 'Angelo' Apellido: 'Padron'. "primer socio, legajo nro1"
	
	(biblioteca socioConLegajoNro: 1) solicitarPrestamoEstandarDeLibroConTitulo: 'Shader programming for starters' deAutor: 'Unreal' aBiblioteca: biblioteca.
	(biblioteca socioConLegajoNro: 1) devolverLibroConTitulo: 'Shader programming for starters' deAutor: 'Unreal' aBiblioteca: biblioteca.
	
	biblioteca generarArchivoListaDeLibrosMasPedidos.
	
	Assert isTrue: ('./listaLibrosMasPedidos' asFileEntry exists) 
	! !

!StreamsTest methodsFor: 'as yet unclassified' stamp: 'ADP 12/11/2018 22:10:11'!
test03BibliotecaGeneraDocumentoDeSociosSolidarios

	|biblioteca|
	biblioteca _ Biblioteca new.
	
	biblioteca registrarSocioNombre: 'Angelo' Apellido: 'Padron'. "primer socio, legajo nro1"
	biblioteca registrarSocioNombre: 'Ezequiel' Apellido: 'Gasañol'. "segundo socio, legajo nro2"
	biblioteca registrarSocioNombre: 'Juan' Apellido: 'Gomez'. "tercer socio, legajo nro3"
	
	(biblioteca socioConLegajoNro: 1) recibirSolidario.
	(biblioteca socioConLegajoNro: 2) recibirSolidario.
	(biblioteca socioConLegajoNro: 3) recibirSancion. "este no deberia aparecer en el listado"
	
	
	biblioteca generarArchivoListaDeSociosSolidarios.
	
	Assert isTrue: ('./listaDeSociosSolidarios.txt' asFileEntry exists) 
	! !

!StreamsTest methodsFor: 'as yet unclassified' stamp: 'ADP 12/11/2018 22:09:58'!
test04BibliotecaGeneraDocumentoDeSociosSancionados

	|biblioteca|
	biblioteca _ Biblioteca new.
	
	biblioteca registrarSocioNombre: 'Angelo' Apellido: 'Padron'. "primer socio, legajo nro1"
	biblioteca registrarSocioNombre: 'Ezequiel' Apellido: 'Gasañol'. "segundo socio, legajo nro2"
	biblioteca registrarSocioNombre: 'Juan' Apellido: 'Gomez'. "tercer socio, legajo nro3"
	
	(biblioteca socioConLegajoNro: 1) recibirSolidario.
	(biblioteca socioConLegajoNro: 2) recibirSolidario.
	(biblioteca socioConLegajoNro: 3) recibirSancion. "este no deberia aparecer en el listado"
	
	
	biblioteca generarArchivoListaDeSociosSancionados.
	
	Assert isTrue: ('./listaDeSociosSancionados.txt' asFileEntry exists) 
	! !
