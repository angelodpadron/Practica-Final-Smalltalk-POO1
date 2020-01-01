!classDefinition: #ProovedorDeEstadosDeRegistro category: #'Biblioteca-Estados'!
Object subclass: #ProovedorDeEstadosDeRegistro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Biblioteca-Estados'!

!ProovedorDeEstadosDeRegistro methodsFor: 'as yet unclassified' stamp: 'zg 11/21/2018 16:49:13'!
handle: unSocio with: unaBiblioteca 
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ProovedorDeEstadosDeRegistro class' category: #'Biblioteca-Estados'!
ProovedorDeEstadosDeRegistro class
	instanceVariableNames: ''!

!ProovedorDeEstadosDeRegistro class methodsFor: 'as yet unclassified' stamp: 'zg 11/21/2018 16:45:23'!
toHandle: unSocio with: unaBiblioteca  
	^ (self allSubclasses detect: [:unEstadoDeRegistro | unEstadoDeRegistro canHandle: unSocio with: unaBiblioteca]) new! !


!classDefinition: #NoPuedeRegistrar category: #'Biblioteca-Estados'!
ProovedorDeEstadosDeRegistro subclass: #NoPuedeRegistrar
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Biblioteca-Estados'!

!NoPuedeRegistrar methodsFor: 'as yet unclassified' stamp: 'zg 11/21/2018 16:56:13'!
handle: aSocio with: aBiblioteca 
	
	^ Error signal: 'Legajo esta en uso'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NoPuedeRegistrar class' category: #'Biblioteca-Estados'!
NoPuedeRegistrar class
	instanceVariableNames: ''!

!NoPuedeRegistrar class methodsFor: 'as yet unclassified' stamp: 'zg 11/21/2018 16:52:30'!
canHandle: unSocio with: unaBiblioteca 
	
	^ unaBiblioteca socios anySatisfy: [:unSocioRegistrado | unSocioRegistrado legajo == unSocio legajo]! !


!classDefinition: #PuedeRegistrar category: #'Biblioteca-Estados'!
ProovedorDeEstadosDeRegistro subclass: #PuedeRegistrar
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Biblioteca-Estados'!

!PuedeRegistrar methodsFor: 'as yet unclassified' stamp: 'zg 11/21/2018 16:50:20'!
handle: unSocio with: unaBiblioteca

	unaBiblioteca socios add: unSocio 

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PuedeRegistrar class' category: #'Biblioteca-Estados'!
PuedeRegistrar class
	instanceVariableNames: ''!

!PuedeRegistrar class methodsFor: 'as yet unclassified' stamp: 'zg 11/21/2018 16:47:58'!
canHandle: unSocio with: unaBiblioteca

	^ (unaBiblioteca socios anySatisfy: [:unSocioRegistrado | unSocioRegistrado legajo == unSocio legajo]) not
	
	! !


!classDefinition: #ProveedorDeEstadosDeListaDeLibrosPrestados category: #'Biblioteca-Estados'!
Object subclass: #ProveedorDeEstadosDeListaDeLibrosPrestados
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Biblioteca-Estados'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ProveedorDeEstadosDeListaDeLibrosPrestados class' category: #'Biblioteca-Estados'!
ProveedorDeEstadosDeListaDeLibrosPrestados class
	instanceVariableNames: ''!

!ProveedorDeEstadosDeListaDeLibrosPrestados class methodsFor: 'as yet unclassified' stamp: 'ZG 12/7/2018 19:28:29'!
toHandle: aSet 
	self shouldBeImplemented.! !

!ProveedorDeEstadosDeListaDeLibrosPrestados class methodsFor: 'as yet unclassified' stamp: 'ZG 12/7/2018 19:31:41'!
toHandle: unSet with: unLibro 
	
	^ (self allSubclasses detect: [:unEstado | unEstado canHandle: unSet with: unLibro]) new! !


!classDefinition: #EstaPresenteEnLaLista category: #'Biblioteca-Estados'!
ProveedorDeEstadosDeListaDeLibrosPrestados subclass: #EstaPresenteEnLaLista
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Biblioteca-Estados'!

!EstaPresenteEnLaLista methodsFor: 'as yet unclassified' stamp: 'ADP 12/8/2018 14:58:38'!
handle: unSet with: unLibro 

	"cuando el libro existe en el set, se le suman las horas del ejemplar que no puede ser agregado"
	
	(unSet detect: [:each | each titulo = unLibro titulo & each autor = unLibro autor]) sumarTiempoAlquilado: (unLibro tiempoAlquilado)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EstaPresenteEnLaLista class' category: #'Biblioteca-Estados'!
EstaPresenteEnLaLista class
	instanceVariableNames: ''!

!EstaPresenteEnLaLista class methodsFor: 'as yet unclassified' stamp: 'ZG 12/7/2018 19:39:28'!
canHandle: unSet with: unLibro 
	
	^ unSet anySatisfy: [:libro | libro titulo = unLibro titulo & (libro autor = unLibro autor)].! !


!classDefinition: #NoEstaPresenteEnLaLista category: #'Biblioteca-Estados'!
ProveedorDeEstadosDeListaDeLibrosPrestados subclass: #NoEstaPresenteEnLaLista
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Biblioteca-Estados'!

!NoEstaPresenteEnLaLista methodsFor: 'as yet unclassified' stamp: 'ZG 12/7/2018 19:38:55'!
handle: unSet with: unLibro 
	
	unSet add: unLibro.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NoEstaPresenteEnLaLista class' category: #'Biblioteca-Estados'!
NoEstaPresenteEnLaLista class
	instanceVariableNames: ''!

!NoEstaPresenteEnLaLista class methodsFor: 'as yet unclassified' stamp: 'ZG 12/7/2018 19:36:37'!
canHandle: unSet with: unLibro 
	
	^ unSet noneSatisfy: [:libro | libro titulo = unLibro titulo & (libro autor = unLibro autor)]! !


!classDefinition: #ProveedorDeEstadosDePrestamo category: #'Biblioteca-Estados'!
Object subclass: #ProveedorDeEstadosDePrestamo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Biblioteca-Estados'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ProveedorDeEstadosDePrestamo class' category: #'Biblioteca-Estados'!
ProveedorDeEstadosDePrestamo class
	instanceVariableNames: ''!

!ProveedorDeEstadosDePrestamo class methodsFor: 'as yet unclassified' stamp: 'zg 11/30/2018 15:22:10'!
canHandle: unSocio

	^ self subclassResponsibility ! !

!ProveedorDeEstadosDePrestamo class methodsFor: 'as yet unclassified' stamp: 'zg 11/30/2018 15:18:55'!
toHandle: unSocio
 
	^ (self allSubclasses detect: [:unEstado | unEstado canHandle: unSocio]) new.! !


!classDefinition: #NoPuedePrestar category: #'Biblioteca-Estados'!
ProveedorDeEstadosDePrestamo subclass: #NoPuedePrestar
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Biblioteca-Estados'!

!NoPuedePrestar methodsFor: 'as yet unclassified' stamp: 'zg 12/1/2018 09:04:36'!
handle: unSocio with: unLibro 
	
	(ProveedorDeExcepciones toHandle: unSocio) handle.! !

!NoPuedePrestar methodsFor: 'as yet unclassified' stamp: 'ZG 12/7/2018 17:59:08'!
handle: unSocio with: aLibro extendidoHasta: aFixedGregorianDate biblioteca: unaBiblioteca  
	
	(ProveedorDeExcepciones toHandle: unSocio) handle.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NoPuedePrestar class' category: #'Biblioteca-Estados'!
NoPuedePrestar class
	instanceVariableNames: ''!

!NoPuedePrestar class methodsFor: 'as yet unclassified' stamp: 'zg 12/1/2018 09:37:04'!
canHandle: unSocio

	^ unSocio registracionEstaVigente not or: [unSocio tieneCincoLibrosAlquilados]
	
	! !


!classDefinition: #PuedePrestar category: #'Biblioteca-Estados'!
ProveedorDeEstadosDePrestamo subclass: #PuedePrestar
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Biblioteca-Estados'!

!PuedePrestar methodsFor: 'associating' stamp: 'zg 12/1/2018 09:12:24'!
handle: unSocio with: unLibro

	"unSocio alquilar: unLibro por: 7 * day."
	
	(ProveedorDeTiposDePrestamo toHandle: unLibro) handle: unLibro with: unSocio.
	
	! !

!PuedePrestar methodsFor: 'associating' stamp: 'zg 12/7/2018 21:48:47'!
handle: unSocio with: unLibro extendidoHasta: unaFecha biblioteca: unaBiblioteca 

	| prestamoNuevo |
	prestamoNuevo _ Prestamo libro: unLibro fechaDeInicio: FixedGregorianDate today fechaDeFin: (unaFecha next: 1 * day).
	prestamoNuevo extendido: true.
	unSocio prestamosVigentes add: prestamoNuevo.
	unaBiblioteca registrarLibroPrestado: unLibro! !


!PuedePrestar methodsFor: 'as yet unclassified' stamp: 'zg 12/7/2018 21:47:27'!
handle: unSocio with: unLibro biblioteca: unaBiblioteca 

	(ProveedorDeTiposDePrestamo toHandle: unLibro) handle: unLibro with: unSocio biblioteca: unaBiblioteca.
	unaBiblioteca registrarLibroPrestado: unLibro! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PuedePrestar class' category: #'Biblioteca-Estados'!
PuedePrestar class
	instanceVariableNames: ''!

!PuedePrestar class methodsFor: 'as yet unclassified' stamp: 'zg 11/30/2018 15:59:21'!
canHandle: unSocio

	^ unSocio registracionEstaVigente & unSocio tieneCincoLibrosAlquilados not! !


!classDefinition: #ProveedorDeEstadosDeRenovacion category: #'Biblioteca-Estados'!
Object subclass: #ProveedorDeEstadosDeRenovacion
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Biblioteca-Estados'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ProveedorDeEstadosDeRenovacion class' category: #'Biblioteca-Estados'!
ProveedorDeEstadosDeRenovacion class
	instanceVariableNames: ''!

!ProveedorDeEstadosDeRenovacion class methodsFor: 'as yet unclassified' stamp: 'zg 12/1/2018 10:10:32'!
toHandle: unSocio with: unLibro 
	
	^ (self allSubclasses detect: [:each | each canHandle: unSocio with: unLibro]) new! !


!classDefinition: #NoPuedeRenovarPrestamoPorqueEspecial category: #'Biblioteca-Estados'!
ProveedorDeEstadosDeRenovacion subclass: #NoPuedeRenovarPrestamoPorqueEspecial
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Biblioteca-Estados'!

!NoPuedeRenovarPrestamoPorqueEspecial methodsFor: 'as yet unclassified' stamp: 'zg 12/1/2018 11:04:59'!
handle: unSocio with: unLibro 
	
	Error signal: 'No se puede renovar prestamos especiales'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NoPuedeRenovarPrestamoPorqueEspecial class' category: #'Biblioteca-Estados'!
NoPuedeRenovarPrestamoPorqueEspecial class
	instanceVariableNames: ''!

!NoPuedeRenovarPrestamoPorqueEspecial class methodsFor: 'as yet unclassified' stamp: 'zg 12/1/2018 11:01:37'!
canHandle: aSocio with: unLibro 
	
	^ unLibro esEspecial! !


!classDefinition: #NoPuedeRenovarPrestamoPorqueExpirado category: #'Biblioteca-Estados'!
ProveedorDeEstadosDeRenovacion subclass: #NoPuedeRenovarPrestamoPorqueExpirado
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Biblioteca-Estados'!

!NoPuedeRenovarPrestamoPorqueExpirado methodsFor: 'as yet unclassified' stamp: 'zg 12/1/2018 11:04:01'!
handle: unSocio with: unLibro 
	
	Error signal: 'El prestamo esta expirado'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NoPuedeRenovarPrestamoPorqueExpirado class' category: #'Biblioteca-Estados'!
NoPuedeRenovarPrestamoPorqueExpirado class
	instanceVariableNames: ''!

!NoPuedeRenovarPrestamoPorqueExpirado class methodsFor: 'as yet unclassified' stamp: 'ZG 12/10/2018 10:11:07'!
canHandle: unSocio with: unLibro 
	
	^ (unSocio prestamoDeLibroConTitulo: unLibro titulo deAutor: unLibro autor) estaVigente not! !


!classDefinition: #NoPuedeRenovarPrestamoPorqueExtendido category: #'Biblioteca-Estados'!
ProveedorDeEstadosDeRenovacion subclass: #NoPuedeRenovarPrestamoPorqueExtendido
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Biblioteca-Estados'!

!NoPuedeRenovarPrestamoPorqueExtendido methodsFor: 'as yet unclassified' stamp: 'zg 12/1/2018 14:56:11'!
handle: aSocio with: aLibro 
	
	Error signal: 'No se puede renovar un prestamo extendido'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NoPuedeRenovarPrestamoPorqueExtendido class' category: #'Biblioteca-Estados'!
NoPuedeRenovarPrestamoPorqueExtendido class
	instanceVariableNames: ''!

!NoPuedeRenovarPrestamoPorqueExtendido class methodsFor: 'as yet unclassified' stamp: 'ZG 12/10/2018 10:11:07'!
canHandle: unSocio with: unLibro

	^ (unSocio prestamoDeLibroConTitulo: unLibro titulo deAutor: unLibro autor) esExtendido! !


!classDefinition: #PuedeRenovarPrestamo category: #'Biblioteca-Estados'!
ProveedorDeEstadosDeRenovacion subclass: #PuedeRenovarPrestamo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Biblioteca-Estados'!

!PuedeRenovarPrestamo methodsFor: 'as yet unclassified' stamp: 'ZG 12/10/2018 10:11:07'!
handle: unSocio with: unLibro 
	
	(unSocio prestamoDeLibroConTitulo: unLibro titulo deAutor: unLibro autor) fechaDeFin: (FixedGregorianDate today next: 1 * week).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PuedeRenovarPrestamo class' category: #'Biblioteca-Estados'!
PuedeRenovarPrestamo class
	instanceVariableNames: ''!

!PuedeRenovarPrestamo class methodsFor: 'as yet unclassified' stamp: 'ZG 12/10/2018 10:11:07'!
canHandle: unSocio with: unLibro 
	
	^ (unSocio prestamoDeLibroConTitulo: unLibro titulo deAutor: unLibro autor) estaVigente and: [unLibro esEspecial not] and: [(unSocio prestamoDeLibroConTitulo: unLibro titulo deAutor: unLibro autor) esExtendido not]! !


!classDefinition: #ProveedorDeExcepciones category: #'Biblioteca-Estados'!
Object subclass: #ProveedorDeExcepciones
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Biblioteca-Estados'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ProveedorDeExcepciones class' category: #'Biblioteca-Estados'!
ProveedorDeExcepciones class
	instanceVariableNames: ''!

!ProveedorDeExcepciones class methodsFor: 'as yet unclassified' stamp: 'zg 12/1/2018 09:06:50'!
toHandle: aSocio 
	
	^ (self allSubclasses detect: [:unEstado | unEstado canHandle: aSocio]) new! !

!ProveedorDeExcepciones class methodsFor: 'as yet unclassified' stamp: 'zg 12/1/2018 10:54:11'!
toHandle: aSocio with: aLibro 
	self shouldBeImplemented.! !


!classDefinition: #ErrorDeCantidadDePrestamos category: #'Biblioteca-Estados'!
ProveedorDeExcepciones subclass: #ErrorDeCantidadDePrestamos
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Biblioteca-Estados'!

!ErrorDeCantidadDePrestamos methodsFor: 'as yet unclassified' stamp: 'zg 12/1/2018 09:09:02'!
handle
	
	Error signal: 'Limite de prestamos alcanzado'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ErrorDeCantidadDePrestamos class' category: #'Biblioteca-Estados'!
ErrorDeCantidadDePrestamos class
	instanceVariableNames: ''!

!ErrorDeCantidadDePrestamos class methodsFor: 'as yet unclassified' stamp: 'zg 12/1/2018 09:08:42'!
canHandle: aSocio 
	
	^ aSocio tieneCincoLibrosAlquilados ! !


!classDefinition: #ErrorDeMembresia category: #'Biblioteca-Estados'!
ProveedorDeExcepciones subclass: #ErrorDeMembresia
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Biblioteca-Estados'!

!ErrorDeMembresia methodsFor: 'as yet unclassified' stamp: 'zg 12/1/2018 09:07:58'!
handle
	
	Error signal: 'Registracion expirada'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ErrorDeMembresia class' category: #'Biblioteca-Estados'!
ErrorDeMembresia class
	instanceVariableNames: ''!

!ErrorDeMembresia class methodsFor: 'as yet unclassified' stamp: 'zg 12/1/2018 09:07:39'!
canHandle: aSocio 
	
	^ aSocio registracionEstaVigente not! !


!classDefinition: #ProveedorDeTiposDePrestamo category: #'Biblioteca-Estados'!
Object subclass: #ProveedorDeTiposDePrestamo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Biblioteca-Estados'!

!ProveedorDeTiposDePrestamo methodsFor: 'as yet unclassified' stamp: 'ADP 11/30/2018 17:05:35'!
handle: unLibro with: unSocio

	self subclassResponsibility 
	! !

!ProveedorDeTiposDePrestamo methodsFor: 'as yet unclassified' stamp: 'MD 12/5/2018 18:13:49'!
handle: aLibro with: aSocio biblioteca: aBiblioteca 
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ProveedorDeTiposDePrestamo class' category: #'Biblioteca-Estados'!
ProveedorDeTiposDePrestamo class
	instanceVariableNames: ''!

!ProveedorDeTiposDePrestamo class methodsFor: 'as yet unclassified' stamp: 'ADP 11/30/2018 17:04:29'!
canHandle: unLibro 
	self subclassResponsibility .! !

!ProveedorDeTiposDePrestamo class methodsFor: 'as yet unclassified' stamp: 'ADP 11/30/2018 17:04:08'!
toHandle: unLibro
	
	^ (self allSubclasses detect: [:unPrestamo | unPrestamo canHandle: unLibro.]) new.! !


!classDefinition: #PrestamoEspecial category: #'Biblioteca-Estados'!
ProveedorDeTiposDePrestamo subclass: #PrestamoEspecial
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Biblioteca-Estados'!

!PrestamoEspecial methodsFor: 'as yet unclassified' stamp: 'ADP 12/6/2018 15:01:18'!
handle: unLibro with: unSocio 
	
	unSocio prestamosVigentes add: (Prestamo libro: unLibro fechaDeInicio: FixedGregorianDate today fechaDeFin: FixedGregorianDate tomorrow)! !

!PrestamoEspecial methodsFor: 'as yet unclassified' stamp: 'MD 12/5/2018 18:15:20'!
handle: aLibro with: aSocio biblioteca: aBiblioteca 
	
	self handle: aLibro with: aSocio.
	aBiblioteca librosDisponibles remove: aLibro.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PrestamoEspecial class' category: #'Biblioteca-Estados'!
PrestamoEspecial class
	instanceVariableNames: ''!

!PrestamoEspecial class methodsFor: 'as yet unclassified' stamp: 'zg 12/1/2018 09:29:33'!
canHandle: unLibro

	^ unLibro esEspecial! !


!classDefinition: #TipoDePrestamoEstandar category: #'Biblioteca-Estados'!
ProveedorDeTiposDePrestamo subclass: #TipoDePrestamoEstandar
	instanceVariableNames: 'libro duracionDePrestamo fechaDeInicio fechaDeFin'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Biblioteca-Estados'!

!TipoDePrestamoEstandar methodsFor: 'as yet unclassified' stamp: 'ADP 12/6/2018 14:58:45'!
handle: unLibro with: unSocio 

	| prestamoNuevo |
	prestamoNuevo _ Prestamo libro: unLibro fechaDeInicio: FixedGregorianDate today fechaDeFin: (FixedGregorianDate today next: 7 * day).
	unSocio prestamosVigentes add: prestamoNuevo.
	! !

!TipoDePrestamoEstandar methodsFor: 'as yet unclassified' stamp: 'MD 12/5/2018 18:10:09'!
handle: unLibro with: unSocio biblioteca: unaBiblioteca 
	
	self handle: unLibro with: unSocio.
	unaBiblioteca librosDisponibles remove: unLibro.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TipoDePrestamoEstandar class' category: #'Biblioteca-Estados'!
TipoDePrestamoEstandar class
	instanceVariableNames: ''!

!TipoDePrestamoEstandar class methodsFor: 'as yet unclassified' stamp: 'zg 12/1/2018 09:19:51'!
canHandle: unLibro

	^ unLibro esEspecial not! !
