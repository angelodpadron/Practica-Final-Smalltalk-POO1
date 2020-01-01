!classDefinition: #Biblioteca category: #'Biblioteca-Main'!
Object subclass: #Biblioteca
	instanceVariableNames: 'listaLibrosDisponibles identificadorLibros socios numeroLegajo librosQueFueronPrestadosAlgunaVez'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Biblioteca-Main'!

!Biblioteca methodsFor: 'accesos' stamp: 'ADP 11/24/2018 09:38:39'!
asignarLegajo
	"responde con un numero de legajo para asignar a socio, este se incrementa en uno al invocar"
	
	numeroLegajo _ numeroLegajo + 1.
	^ numeroLegajo.! !

!Biblioteca methodsFor: 'accesos' stamp: 'ZG 12/10/2018 10:01:32'!
buscarLibroTitulo: unTitulo de: unAutor
	"retorna el libro buscado, si no existe levanta una excepcion"
	
	^ self librosDisponibles detect: [:libro | (libro titulo = unTitulo) & (libro autor = unAutor)] ifNone: [Error signal: 'libro no disponible'] ! !

!Biblioteca methodsFor: 'accesos' stamp: 'ADP 11/21/2018 17:54:21'!
cantidadDeLibrosDisponibles
	"responde la cantidad de libros disponibles en biblioteca"
	^ listaLibrosDisponibles size! !

!Biblioteca methodsFor: 'accesos' stamp: 'ADP 11/21/2018 18:03:47'!
librosDisponibles
	"responde con los libros disponibles de biblioteca"
	 ^ listaLibrosDisponibles ! !

!Biblioteca methodsFor: 'accesos' stamp: 'ADP 12/11/2018 18:22:08'!
librosMasPedidos
	"retorna una lista ordenada por dias de alquiler de cada libro"
	^ self librosQueFueronPrestadosAlgunaVez asSortedCollection: [:libro1 :libro2 | libro1 tiempoAlquilado > libro2 tiempoAlquilado]! !

!Biblioteca methodsFor: 'accesos' stamp: 'zg 12/11/2018 22:05:35'!
librosQueFueronPrestadosAlgunaVez
	"Retorna una lista con todos los libros(un ejemplar por libro) que fueron prestados por lo menos una vez"
	^ librosQueFueronPrestadosAlgunaVez.! !

!Biblioteca methodsFor: 'accesos' stamp: 'ADP 11/24/2018 09:50:36'!
socioConLegajoNro: numeroEntero
	"responde con el socio cuyo numero de registro sea el invocado"
	
	^ self socios detect: [:socio | socio legajo == numeroEntero] ifNone: [Error signal: 'no existe socio con numero de legajo ', (numeroEntero asString)] ! !

!Biblioteca methodsFor: 'accesos' stamp: 'zg 11/21/2018 16:19:48'!
socios
	
	^socios! !

!Biblioteca methodsFor: 'accesos' stamp: 'ADP 12/8/2018 15:48:16'!
sociosSancionados
	"responde con un listado de socios sancionados hasta la fecha"
	
	^ self sociosActivos select: [:socio | socio estaSancionado] ! !

!Biblioteca methodsFor: 'accesos' stamp: 'ADP 12/11/2018 18:23:19'!
sociosSolidarios
	"retorna una coleccion de socios que tengan marca de solidaridad (retornaron un prestamo estandar antes de que pasen 3 dias)"
	^ self sociosActivos select: [:socio | socio esSolidario] ! !


!Biblioteca methodsFor: 'setup' stamp: 'zg 12/11/2018 21:55:57'!
initialize

	"colecciones"
	listaLibrosDisponibles _ Set new.
	socios _ OrderedCollection new.
	librosQueFueronPrestadosAlgunaVez _ Set new.
	
	"contadores"
	identificadorLibros _ 0.	
	numeroLegajo _ 0.
	! !

!Biblioteca methodsFor: 'setup' stamp: 'zg 12/4/2018 00:24:11'!
registrarLibro: libro 
 	"agrega un libro al inventario de la biblioteca y le asigna un numero"
	
	libro identificador: identificadorLibros + 1.
	identificadorLibros _ libro identificador.
	listaLibrosDisponibles add:  libro.! !


!Biblioteca methodsFor: 'consultas' stamp: 'ADP 12/11/2018 18:19:43'!
existeLibroSobre: tema
	"verifica si existe algun libro en biblioteca que hable sobre el tema"

	(self librosDisponibles anySatisfy: [:libro | libro tags includes: tema])
	ifFalse:[
		Error signal: 'no hay libros disponibles acerca de ' , tema
	].! !

!Biblioteca methodsFor: 'consultas' stamp: 'ADP 12/11/2018 18:19:49'!
librosSobre: genero
	"responde con una lista de libros de temas relacionados"
	self existeLibroSobre: genero.
	^ (self librosDisponibles select: [:libro | libro tags includes: genero]) asSet! !

!Biblioteca methodsFor: 'consultas' stamp: 'ADP 12/11/2018 18:20:07'!
membresiaDeSocioEstaActiva: numeroEntero
	"verifica si el socio con numero de legajo invocado tiene su membresia activa"
	|socio|
	socio _ self socioConLegajoNro: numeroEntero.
	^ ((socio fechaDeRegistro) distanceTo: (FixedGregorianDate today)) < (365  *day) "el tiempo transcurrido entre la fecha de registro y hoy es menor a 1 año"! !

!Biblioteca methodsFor: 'consultas' stamp: 'ADP 11/24/2018 11:47:27'!
periodoPrestamoGeneral
	"responde con la cantidad de dias de prestemos generales (una semana)"
	
	^ 7 * day! !

!Biblioteca methodsFor: 'consultas' stamp: 'ADP 11/24/2018 10:12:36'!
sociosActivos
	"responde con una lista de socios cuya membresia se encuentra activa"
	^ self socios select: [ :socio | self membresiaDeSocioEstaActiva: (socio legajo) ]! !

!Biblioteca methodsFor: 'consultas' stamp: 'ADP 12/11/2018 18:20:56'!
sociosSancionables
	"retorna una coleccion de socios que presentan prestamos vencidos (y deben ser sancionados)"
	
	^ self sociosActivos select: [:unSocio | unSocio tienePrestamosVencidos]! !


!Biblioteca methodsFor: 'prestamos' stamp: 'zg 12/11/2018 22:06:19'!
otorgarPrestamoDeLibroTitulo: tituloDeLibro deAutor: nombreDeAutor aSocio: unSocio
	"Genera un prestamo estandar o especial (Segun el caso) de un libro dado a unSocio"
	(ProveedorDeEstadosDePrestamo toHandle: unSocio) handle: unSocio with: (self buscarLibroTitulo: tituloDeLibro de: nombreDeAutor) biblioteca: self.
	! !

!Biblioteca methodsFor: 'prestamos' stamp: 'zg 12/11/2018 22:06:58'!
otorgarPrestamoExtendidoDe: unLibro a: unSocio hasta: aFixedGregorianDate 
	
	"Genera un prestamo extendido de un libro unLibro a unSocio hasta la fecha dada, pensado para testing, implementacion inicial"
	(ProveedorDeEstadosDePrestamo toHandle: unSocio) handle: unSocio with: unLibro extendidoHasta: aFixedGregorianDate biblioteca: self.! !

!Biblioteca methodsFor: 'prestamos' stamp: 'zg 12/11/2018 22:07:21'!
otorgarPrestamoExtendidoDeLibroTitulo: tituloDeLibro Autor: nombreDeAutor aSocio: unSocio Hasta: aFixedGregorianDate 
	
	"Genera un prestamo extendido de un libro dado por un titulo y un autor a unSocio hasta una fecha dada"
	(ProveedorDeEstadosDePrestamo toHandle: unSocio) handle: unSocio with: (self buscarLibroTitulo: tituloDeLibro de: nombreDeAutor) extendidoHasta: aFixedGregorianDate biblioteca: self.! !

!Biblioteca methodsFor: 'prestamos' stamp: 'zg 12/11/2018 22:07:50'!
prestarLibro: unLibro a: unSocio 
	"Implementacion inicial de generacion de prestamo"
	(ProveedorDeEstadosDePrestamo toHandle: unSocio) handle: unSocio with: unLibro.
	! !

!Biblioteca methodsFor: 'prestamos' stamp: 'zg 12/11/2018 22:08:41'!
recibirDevolucion: unPrestamo deParteDe: unSocio 
	
	"Remueve un prestamo de los prestamos vigentes de unSocio y vuelve a agregar el libro correspondiente a los libros disponibles para alquiler"
	
	|libro|
	
	libro _ unPrestamo libro.
	libro registrarDiasDeAlquilerDesde: (unPrestamo fechaDeInicio).
	self registrarLibro: libro.
	
	(((unPrestamo duracionDePrestamo) > (1 * day)) & (unPrestamo fechaDeInicio distanceTo: (FixedGregorianDate today)) < (3 * day))
		ifTrue: [unSocio recibirSolidario]. "el if nooo"
	
	unSocio prestamosVigentes remove: unPrestamo. 
	
	"faltaria verificar si lo despues o antes de tiempo, y de aca saldria el socio solidario y socio garca"! !

!Biblioteca methodsFor: 'prestamos' stamp: 'zg 12/11/2018 22:11:30'!
renovarPrestamoDe: unLibro a: unSocio 
	"Renueva el prestamo vigente (Solo al ser un prestamo estandar) correspondiente a un libro dado a unSocio por el periodo de una semana contando desde el dia en que se solicito la renovacion"
	(ProveedorDeEstadosDeRenovacion toHandle: unSocio with: unLibro) handle: unSocio with: unLibro! !

!Biblioteca methodsFor: 'prestamos' stamp: 'zg 12/11/2018 22:12:37'!
renovarPrestamoDeLibroConTitulo: tituloDeLibro deAutor: nombreDeAutor aSocio: unSocio 
	
	"Renueva el prestamo vigente (Solo de un prestamo estandar) correspondiente a un libro de titulo tituloDeLibro y autor nombreDeAutor de un socio por una semana contando desde el dia en que se solicito la renovacion"
	(ProveedorDeEstadosDeRenovacion toHandle: unSocio with: (self buscarLibroTitulo: tituloDeLibro de: nombreDeAutor)) handle: unSocio with: (self buscarLibroTitulo: tituloDeLibro de: nombreDeAutor) ! !


!Biblioteca methodsFor: 'sanciones' stamp: 'zg 12/11/2018 22:13:09'!
sancionarSociosElegibles
	
	"Marca como 'sancionados' a todos los socios elegibles para sancion registrados en la plataforma"
	self sociosSancionables do: [:unSocio | unSocio recibirSancion]! !


!Biblioteca methodsFor: 'registros' stamp: 'zg 12/11/2018 22:04:48'!
agregarSocio: unSocio
	
	"Agrega un socio a la lista de 'socios' de la Biblioteca si no existe ningun socio con el mismo numero de legajo asignado"
	(ProovedorDeEstadosDeRegistro toHandle: unSocio with: self) handle: unSocio with: self.! !

!Biblioteca methodsFor: 'registros' stamp: 'zg 12/11/2018 22:09:09'!
registrarLibroEspecial: unLibro 
	
	"Agrega un libro a la lista de libros disponibles para alquiler y lo marca como libro especial"
	self registrarLibro: unLibro.
	unLibro marcarLibroEspecial.! !

!Biblioteca methodsFor: 'registros' stamp: 'ADP 12/11/2018 18:15:14'!
registrarLibroPrestado: unLibro
	"almacena en una coleccion de libros prestados el libro argumentado, su creacion fue pensada para acceder a los libros de inventario sin que estos se repitan al tener mas de un ejemplar"
	
	(ProveedorDeEstadosDeListaDeLibrosPrestados toHandle: self librosQueFueronPrestadosAlgunaVez with: unLibro) handle: self librosQueFueronPrestadosAlgunaVez with: unLibro.! !

!Biblioteca methodsFor: 'registros' stamp: 'ADP 12/11/2018 18:16:57'!
registrarSocioNombre: unNombre Apellido: unApellido
	"crea un nuevo socio con los parametros dados, se le asigna un legajo unico y luego se lo almacena en la coleccion"
	
	socios add: (Socio registrarNombre: unNombre apellido: unApellido legajo: self asignarLegajo)
	! !


!Biblioteca methodsFor: 'streams' stamp: 'ADP 12/11/2018 18:08:18'!
generarArchivoListaDeLibrosMasPedidos

"genera un archivo de texto en el directorio raiz del ambiente cuis con una lista ordenada de los libros alquilados por mas tiempo"

	'listaDeLibrosMasPedidos.txt' asFileEntry writeStreamDo: 
		[:stream |
			stream nextPutAll: 'Titulo'.
			stream tab.
			stream nextPutAll: 'Autor'.
			stream tab.
			stream nextPutAll: 'Dias acumulados de prestamo'. "un nombre mas lindo?"
			stream newLine.
			stream newLine.
			self librosMasPedidos do: [:each | 
												stream nextPutAll: each titulo.
												stream tab.
												stream nextPutAll: each autor asString.
												stream tab.
												stream nextPutAll: each tiempoAlquilado.
												stream newLine
										].
			stream newLine.
			stream nextPutAll: 'Promedio de horas de lectura: ', (((((self librosMasPedidos sum: [:each | each tiempoAlquilado]) amount) div: (self librosMasPedidos size)) * 24) * hour) asString. "a modo prueba"
		]
	! !

!Biblioteca methodsFor: 'streams' stamp: 'ADP 12/11/2018 18:09:03'!
generarArchivoListaDeLibrosSobre: unTema
	
"genera un archivo con la lista de libros sobre unTema"

	'listaDeLibrosSobre.txt' asFileEntry writeStreamDo: 
		[:stream |
			stream nextPutAll: 'Libros sobre ', unTema.
			stream newLine.
			stream newLine.
			stream nextPutAll: 'Titulo'.
			stream tab.
			stream nextPutAll: 'Autor'.
			stream newLine.
			stream newLine.
			(self librosSobre: unTema) do: [:each | 
												stream nextPutAll: each titulo.
												stream tab.
												stream nextPutAll: each autor.
												stream newLine
											   ].
			stream newLine.
			stream nextPutAll: 'Cantidad de libros sobre ', unTema, ': ', (self librosSobre: unTema) size asString.
		]
	! !

!Biblioteca methodsFor: 'streams' stamp: 'ADP 12/11/2018 18:09:40'!
generarArchivoListaDeSociosActivos

"genera un archivo de texto con la lista de socios activos y su legajo"

	'listaDeSociosActivos.txt' asFileEntry writeStreamDo: 
		[:stream |
			stream nextPutAll: 'Nombre y Apellido'.
			stream tab.
			stream nextPutAll: 'Numero de legajo'.
			stream newLine.
			stream newLine.
			self sociosActivos do: [:each | 
										stream nextPutAll: each nombreYApellido.
										stream tab.
										stream nextPutAll: each legajo asString.
										stream newLine
										].
			stream newLine.
			stream nextPutAll: 'Cantidad de socios registrados: ', self sociosActivos size asString. 
		]
	! !

!Biblioteca methodsFor: 'streams' stamp: 'ADP 12/11/2018 18:10:56'!
generarArchivoListaDeSociosSancionados

"genera un archivo de texto en el directorio raiz de cuis con la lista de socios sancionados y sus datos (nombre, apellido, legajo)"

	'listaDeSociosSancionados.txt' asFileEntry writeStreamDo: 
		[:stream |
			stream nextPutAll: 'Nombre y Apellido'.
			stream tab.
			stream nextPutAll: 'Numero de legajo'.
			stream newLine.
			stream newLine.
			self sociosSancionados do: [:each | 
												stream nextPutAll: each nombreYApellido.
												stream tab.
												stream nextPutAll: each legajo asString.
												stream newLine
											].
			stream newLine.
			stream nextPutAll: 'Cantidad de socios sancionados ', self sociosSancionados size asString.
		]
	! !

!Biblioteca methodsFor: 'streams' stamp: 'ADP 12/11/2018 18:11:57'!
generarArchivoListaDeSociosSolidarios

"genera un archivo de texto en el directorio raiz de cuis con la lista de socios solidarios y sus datos (nombre, apellido, legajo)"

	'listaDeSociosSolidarios.txt' asFileEntry writeStreamDo: 
		[:stream |
			stream nextPutAll: 'Nombre y Apellido'.
			stream tab.
			stream nextPutAll: 'Numero de legajo'.
			stream newLine.
			stream newLine.
			self sociosSolidarios do: [:each | 
											stream nextPutAll: each nombreYApellido.
											stream tab.
											stream nextPutAll: each legajo asString.
											stream newLine
										].
			stream newLine.
			stream nextPutAll: 'Cantidad de socios solidarios ', self sociosSolidarios size asString.
		]
	! !


!classDefinition: #Libro category: #'Biblioteca-Main'!
Object subclass: #Libro
	instanceVariableNames: 'identificador autor genero titulo tags especial tiempoAlquilado'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Biblioteca-Main'!

!Libro methodsFor: 'setup' stamp: 'ADP 11/21/2018 17:58:19'!
autor: string
 	"asigna el nombre del autor al libro, este debe de ser argumentado como un string"
	
	autor _ string! !

!Libro methodsFor: 'setup' stamp: 'ADP 11/21/2018 17:58:28'!
genero: string
	"asigna un genero al libro, el parametro debe ser de tipo string"
	
	genero _ string.
	
	"asignar genero a coleccion de temas relacionados"
	
	tags add: string.! !

!Libro methodsFor: 'setup' stamp: 'ADP 11/21/2018 17:58:51'!
identificador: numeroEntero
	"asigna un numero entero positivo como nuevo identificador de la copia"
	
	identificador _ numeroEntero! !

!Libro methodsFor: 'setup' stamp: 'zg 12/7/2018 22:29:39'!
initialize
	
	tags _ Set new. "no admite temas repetidos"
	especial _ false.
	tiempoAlquilado _ 0 * day.
! !

!Libro methodsFor: 'setup' stamp: 'zg 12/4/2018 00:24:50'!
marcarLibroEspecial
	
	especial _ true! !

!Libro methodsFor: 'setup' stamp: 'zg 12/7/2018 22:29:21'!
registrarDiasDeAlquilerDesde: unaFecha

"unaFecha debe ser FixedGregorianDate"

	self sumarTiempoAlquilado: (unaFecha distanceTo: (FixedGregorianDate today))! !

!Libro methodsFor: 'setup' stamp: 'ADP 11/21/2018 17:58:57'!
titulo: string 
	"agrega un titulo al libro, parametro debe ser de tipo string"
	
	titulo _ string.! !


!Libro methodsFor: 'consultas' stamp: 'ADP 11/16/2018 18:25:48'!
autor
	"responde el nombre del autor"
	^autor! !

!Libro methodsFor: 'consultas' stamp: 'ADP 11/30/2018 16:26:01'!
esEspecial
	
	^ especial.! !

!Libro methodsFor: 'consultas' stamp: 'ADP 11/16/2018 18:38:22'!
genero
	"responde el genero del libro"
	^genero! !

!Libro methodsFor: 'consultas' stamp: 'ADP 11/16/2018 18:58:16'!
identificador
	"resopende que identificador tiene el libro, si este no es del tipo entero positivo, se interpreta como libro sin identificador"
	
	(identificador > 0)
	ifFalse: [
		Error signal: 'identificador no asignado o erroneo'
	].
	^ identificador! !

!Libro methodsFor: 'consultas' stamp: 'ADP 11/19/2018 11:26:01'!
tags
	"responde los tags (coleccion de temas relacionados) del libro"
	^ tags! !

!Libro methodsFor: 'consultas' stamp: 'MD 12/5/2018 18:27:37'!
tiempoAlquilado
	
	^ tiempoAlquilado! !

!Libro methodsFor: 'consultas' stamp: 'ADP 11/16/2018 18:52:00'!
titulo
	"responde el titulo del libro"
	^titulo! !


!Libro methodsFor: 'modificar' stamp: 'ADP 12/11/2018 18:25:21'!
sumarTiempoAlquilado: unTiempo
	"suma unTiempo al acumulador de dias de prestamo"
	tiempoAlquilado _ tiempoAlquilado + unTiempo! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Libro class' category: #'Biblioteca-Main'!
Libro class
	instanceVariableNames: ''!

!Libro class methodsFor: 'creacion' stamp: 'ADP 11/16/2018 19:01:20'!
titulo: string1 autor: string2 genero: string3 identificador: int
	"crea un libro con los atributos de titulo, autor, genero e identificador. Los Primeros 3 datos deben  de ser de tipo string, y el ultimo de tipo entero"
	|libro|
	libro _ self new titulo: string1.
	libro autor: string2.
	libro genero: string3.
	libro identificador: int.
	
	^ libro! !


!Libro class methodsFor: 'as yet unclassified' stamp: 'ADP 11/21/2018 16:26:19'!
titulo: titulo autor: autor genero: genero 
	|libro|
	libro _ self new titulo: titulo.
	libro autor: autor.
	libro genero: genero.
	^ libro.! !


!classDefinition: #Prestamo category: #'Biblioteca-Main'!
Object subclass: #Prestamo
	instanceVariableNames: 'libro fechaDeInicio fechaDeFin extendido'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Biblioteca-Main'!

!Prestamo methodsFor: 'setup' stamp: 'ADP 12/11/2018 18:26:21'!
extendido: unBooleano
	
	extendido _ unBooleano! !

!Prestamo methodsFor: 'setup' stamp: 'ADP 12/11/2018 18:26:33'!
fechaDeFin: aFixedGregorianDate 
	
	fechaDeFin _ aFixedGregorianDate! !

!Prestamo methodsFor: 'setup' stamp: 'ADP 12/11/2018 18:26:38'!
fechaDeInicio: aFixedGregorianDate 
	
	fechaDeInicio _ aFixedGregorianDate! !

!Prestamo methodsFor: 'setup' stamp: 'zg 12/1/2018 11:44:34'!
initialize 

	extendido _ false! !

!Prestamo methodsFor: 'setup' stamp: 'ADP 12/11/2018 18:26:51'!
libro: unLibro 

	libro _ unLibro! !


!Prestamo methodsFor: 'consultas' stamp: 'zg 12/11/2018 22:15:00'!
duracionDePrestamo
	"Retorna la duracion del prestamo"
	
	^ (self fechaDeInicio) distanceTo: (self fechaDeFin) ! !

!Prestamo methodsFor: 'consultas' stamp: 'zg 12/11/2018 22:15:10'!
esExtendido
	"Retorna true si el prestamo es extendido"
	^ extendido! !

!Prestamo methodsFor: 'consultas' stamp: 'zg 12/11/2018 22:15:25'!
estaVigente
	"Retorna true si el prestamo esta vigente a la fecha de hoy"
	^ FixedGregorianDate today < self fechaDeFin.! !

!Prestamo methodsFor: 'consultas' stamp: 'zg 12/1/2018 10:33:09'!
fechaDeFin
	
	^fechaDeFin! !

!Prestamo methodsFor: 'consultas' stamp: 'zg 12/1/2018 08:38:51'!
fechaDeInicio
	
	^fechaDeInicio! !

!Prestamo methodsFor: 'consultas' stamp: 'zg 12/11/2018 22:15:39'!
libro
	"Retorna el libro al que corresponde este prestamo"
	^libro! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Prestamo class' category: #'Biblioteca-Main'!
Prestamo class
	instanceVariableNames: ''!

!Prestamo class methodsFor: 'as yet unclassified' stamp: 'ADP 12/6/2018 14:58:03'!
libro: unLibro fechaDeInicio: unaFechaDeInicio fechaDeFin: unaFechaDeFin

	^ ((self new libro: unLibro) fechaDeInicio: unaFechaDeInicio) fechaDeFin: unaFechaDeFin 
	
	! !


!classDefinition: #Socio category: #'Biblioteca-Main'!
Object subclass: #Socio
	instanceVariableNames: 'nombre apellido legajo fechaDeRegistro librosPrestados estaSancionado prestamosVigentes esSolidario'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Biblioteca-Main'!

!Socio methodsFor: 'setup' stamp: 'zg 12/11/2018 22:16:03'!
apellido: unApellido 
	"Asigna un apellido unApellido dado por un string al socio"
	apellido _ unApellido! !

!Socio methodsFor: 'setup' stamp: 'ADP 12/11/2018 18:27:28'!
fechaDeRegistro: unaFecha
	"preferiblemente en FixedGregorianDate"
	
	fechaDeRegistro _ unaFecha! !

!Socio methodsFor: 'setup' stamp: 'ADP 12/11/2018 18:41:32'!
initialize

	librosPrestados _ Set new.
	prestamosVigentes _ Set new.
	estaSancionado _ false.
	esSolidario _ false.! !

!Socio methodsFor: 'setup' stamp: 'ADP 11/24/2018 09:30:26'!
legajo: unNumero

	legajo _ unNumero! !

!Socio methodsFor: 'setup' stamp: 'ADP 12/11/2018 18:27:46'!
nombre: unNombre 

	nombre _ unNombre

! !


!Socio methodsFor: 'consultas' stamp: 'zg 11/21/2018 11:23:30'!
apellido
	
	^apellido! !

!Socio methodsFor: 'consultas' stamp: 'ADP 12/6/2018 15:17:58'!
esSolidario
	
	^ esSolidario! !

!Socio methodsFor: 'consultas' stamp: 'ADP 12/11/2018 18:28:31'!
estaSancionado
	
	^ estaSancionado ! !

!Socio methodsFor: 'consultas' stamp: 'zg 11/21/2018 15:54:38'!
fechaDeRegistro
	
	^fechaDeRegistro! !

!Socio methodsFor: 'consultas' stamp: 'zg 11/21/2018 15:50:22'!
legajo
	
	^legajo! !

!Socio methodsFor: 'consultas' stamp: 'zg 11/21/2018 11:22:10'!
nombre
	
	^nombre! !

!Socio methodsFor: 'consultas' stamp: 'zg 11/21/2018 15:48:24'!
nombreYApellido
	^ nombre, ' ', apellido! !

!Socio methodsFor: 'consultas' stamp: 'ADP 12/11/2018 18:29:23'!
registracionEstaVigente
	
	^ (fechaDeRegistro distanceTo: FixedGregorianDate today) amount < 365. "el tiempo transcurrido desde el dia del registro al actual es menor a 1 año"! !

!Socio methodsFor: 'consultas' stamp: 'ADP 12/11/2018 18:29:47'!
tieneCincoLibrosAlquilados
	"responde la cantidad de prestamos maximos que puede tener un socio"
	^ prestamosVigentes size == 5.! !

!Socio methodsFor: 'consultas' stamp: 'ADP 12/11/2018 18:30:29'!
tienePrestamosVencidos
	"verifica si el socio presenta algun prestamo cuya vigencia se encuentre expirada"
	^ prestamosVigentes anySatisfy: [:unPrestamo | unPrestamo estaVigente not]! !


!Socio methodsFor: 'accesos' stamp: 'ADP 12/4/2018 18:38:21'!
librosAlquilados
	"responde con los libros alquilados"
	^ self prestamosVigentes collect: [:each | each libro]! !

!Socio methodsFor: 'accesos' stamp: 'ADP 12/11/2018 18:31:11'!
prestamoDe: unLibro
	"dado un libro argumentado, verifica si este fue alquilado por el socio"
	
	^ self prestamosVigentes detect: [:prestamos | prestamos libro = unLibro] ifNone: [ Error signal: unLibro titulo , ' no prestado.' ]! !

!Socio methodsFor: 'accesos' stamp: 'ADP 12/11/2018 18:32:23'!
prestamoDeLibroConTitulo: tituloDeLibro deAutor: nombreDeAutor
	"misma funcion de 'prestamoDe:' pero con parametros de titulo y nombre de autor para evitar buscar con objetos"
	

	^ self prestamosVigentes detect: [:prestamos | (prestamos libro titulo = tituloDeLibro) & (prestamos libro autor = nombreDeAutor)] ifNone: [ Error signal: tituloDeLibro, ' no prestado.' ]! !

!Socio methodsFor: 'accesos' stamp: 'zg 12/4/2018 00:27:37'!
prestamosVigentes
	
	^ prestamosVigentes! !


!Socio methodsFor: 'modificar' stamp: 'ADP 12/11/2018 18:32:34'!
recibirSancion
	
	estaSancionado _ true! !

!Socio methodsFor: 'modificar' stamp: 'ADP 12/6/2018 15:35:47'!
recibirSolidario
	
	esSolidario _ true.! !

!Socio methodsFor: 'modificar' stamp: 'ADP 12/11/2018 18:32:49'!
renovarRegistro
	"actualiza la fecha de registro al dia actual"
	fechaDeRegistro _ Date today.! !


!Socio methodsFor: 'prestamos' stamp: 'ADP 12/11/2018 18:33:48'!
devolverLibro: unLibro a: unaBiblioteca 
	"version vieja"
		
	self prestamosVigentes remove: (self prestamoDe: unLibro)! !

!Socio methodsFor: 'prestamos' stamp: 'ADP 12/11/2018 18:37:02'!
devolverLibroConTitulo: tituloDeLibro deAutor: nombreDeAutor aBiblioteca: unaBiblioteca 
	"retorna a la biblioteca argumentada el libro con atributos argumentados"
	
	unaBiblioteca recibirDevolucion: (self prestamoDeLibroConTitulo: tituloDeLibro deAutor: nombreDeAutor) deParteDe: self.! !

!Socio methodsFor: 'prestamos' stamp: 'ADP 12/11/2018 18:36:11'!
solicitarPrestamoEstandarDeLibro: unLibro a: unaBiblioteca 
	"version vieja"
	
	unaBiblioteca prestarLibro: unLibro a: self.
	! !

!Socio methodsFor: 'prestamos' stamp: 'ADP 12/11/2018 18:37:42'!
solicitarPrestamoEstandarDeLibroConTitulo: tituloDeLibro deAutor: nombreDeAutor aBiblioteca: unaBiblioteca 
	"solicita a la biblioteca argumentada un prestamo de 7 dias del libro con atributos argumentados"
	
	unaBiblioteca otorgarPrestamoDeLibroTitulo: tituloDeLibro deAutor: nombreDeAutor  aSocio: self.! !

!Socio methodsFor: 'prestamos' stamp: 'ADP 12/11/2018 18:37:56'!
solicitarPrestamoExtendidoDeLibro: unLibro a: unaBiblioteca hasta: unaFecha 
	"version vieja"
	
	unaBiblioteca otorgarPrestamoExtendidoDe: unLibro a: self hasta: unaFecha.! !

!Socio methodsFor: 'prestamos' stamp: 'ADP 12/11/2018 18:38:48'!
solicitarPrestamoExtendidoDeLibroConTitulo: tituloDeLibro deAutor: nombreDeAutor aSocio: unaBiblioteca hastaFecha: unaFecha
	"solicita a la biblioteca argumentada un prestamo extendido con cierre en la fecha argumentada del libro con atributos argumentados" 
	
	unaBiblioteca otorgarPrestamoExtendidoDeLibroTitulo: tituloDeLibro Autor: nombreDeAutor aSocio: self Hasta: unaFecha.! !

!Socio methodsFor: 'prestamos' stamp: 'ADP 12/11/2018 18:39:00'!
solicitarRenovacionDe: unLibro a: unaBiblioteca 
	"version vieja"
	unaBiblioteca renovarPrestamoDe: unLibro a: self.
	! !

!Socio methodsFor: 'prestamos' stamp: 'ADP 12/11/2018 18:40:16'!
solicitarRenovacionDePrestamoDeLibroConTitulo: tituloDeLibro deAutor: nombreDeAutor aBiblioteca: unaBiblioteca 
	"solicita a la biblioteca argumentada una extension de 7 dias al prestamo del libro argumentado"
	
	unaBiblioteca renovarPrestamoDeLibroConTitulo: tituloDeLibro deAutor: nombreDeAutor aSocio: self.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Socio class' category: #'Biblioteca-Main'!
Socio class
	instanceVariableNames: ''!

!Socio class methodsFor: 'as yet unclassified' stamp: 'zg 11/21/2018 18:26:17'!
registrarNombre: nombre apellido: apellido legajo: legajo   

	^ (((self new nombre: nombre) apellido: apellido) legajo: legajo) fechaDeRegistro: FixedGregorianDate today! !

!Socio class methodsFor: 'as yet unclassified' stamp: 'zg 11/30/2018 14:52:22'!
registrarNombre: unNombre apellido: unApellido legajo: unNumeroDeLegajo fecha: unaFecha 
	
	^ (Socio registrarNombre: unNombre apellido: unApellido legajo: unNumeroDeLegajo) fechaDeRegistro: unaFecha ! !
