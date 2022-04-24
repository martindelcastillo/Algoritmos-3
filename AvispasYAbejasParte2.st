!classDefinition: #ElHabitat category: 'AvispasYAbejasParte2'!
DenotativeObject subclass: #ElHabitat
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AvispasYAbejasParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElHabitat class' category: 'AvispasYAbejasParte2'!
ElHabitat class
	instanceVariableNames: 'huevosConFirmaGeneticaDePolly cantidadDeHuevos cantidadDeOrugas cantidadDePolillas huevosConFirmaGeneticaDeOrianaYOrnella huevosConFirmaGeneticaDeLara'!

!ElHabitat class methodsFor: 'as yet unclassified' stamp: 'mdc 4/21/2022 20:30:42'!
agregarHuevoUsandoHuevo
	 cantidadDeHuevos > 0  ifTrue: [
	huevosConFirmaGeneticaDeLara := huevosConFirmaGeneticaDeLara + 1.
	huevosConFirmaGeneticaDeOrianaYOrnella > 0 ifTrue: [
		huevosConFirmaGeneticaDeOrianaYOrnella := huevosConFirmaGeneticaDeOrianaYOrnella - 1. ] ifFalse: [
		huevosConFirmaGeneticaDePolly := huevosConFirmaGeneticaDePolly - 1]
	
	]! !

!ElHabitat class methodsFor: 'as yet unclassified' stamp: 'mdc 4/21/2022 20:16:12'!
agregarHuevoUsandoOruga
	 cantidadDeOrugas > 0  ifTrue: [
	cantidadDeHuevos := cantidadDeHuevos + 1.
	cantidadDeOrugas := cantidadDeOrugas - 1.
	huevosConFirmaGeneticaDeOrianaYOrnella := huevosConFirmaGeneticaDeOrianaYOrnella + 1.
	]! !

!ElHabitat class methodsFor: 'as yet unclassified' stamp: 'mdc 4/21/2022 20:15:41'!
agregarHuevoUsandoPolilla
	 cantidadDePolillas > 0  ifTrue: [
	cantidadDeHuevos := cantidadDeHuevos + 1.
	cantidadDePolillas := cantidadDePolillas - 1.
	huevosConFirmaGeneticaDePolly := huevosConFirmaGeneticaDePolly + 1.
	]! !

!ElHabitat class methodsFor: 'as yet unclassified' stamp: 'mdc 4/21/2022 19:47:32'!
agregarUnaOruga
	cantidadDeOrugas := cantidadDeOrugas + 1.! !

!ElHabitat class methodsFor: 'as yet unclassified' stamp: 'mdc 4/21/2022 20:07:17'!
agregarUnaPolilla
	cantidadDePolillas := cantidadDePolillas + 1.! !

!ElHabitat class methodsFor: 'as yet unclassified' stamp: 'mdc 4/21/2022 20:31:43'!
cantidadDeHuevosConFirmaGeneticaDeLara
	^huevosConFirmaGeneticaDeLara.! !

!ElHabitat class methodsFor: 'as yet unclassified' stamp: 'mdc 4/21/2022 20:17:18'!
cantidadDeHuevosConFirmaGeneticaDeOriana
	^huevosConFirmaGeneticaDeOrianaYOrnella.! !

!ElHabitat class methodsFor: 'as yet unclassified' stamp: 'mdc 4/21/2022 20:17:25'!
cantidadDeHuevosConFirmaGeneticaDeOrnella
	^huevosConFirmaGeneticaDeOrianaYOrnella.! !

!ElHabitat class methodsFor: 'as yet unclassified' stamp: 'mdc 4/21/2022 20:17:34'!
cantidadDeHuevosConFirmaGeneticaDePolly
	^huevosConFirmaGeneticaDePolly.! !

!ElHabitat class methodsFor: 'as yet unclassified' stamp: 'mdc 4/21/2022 19:37:36'!
cantidadDeHuevosDeAvispas
	^cantidadDeHuevos.! !

!ElHabitat class methodsFor: 'as yet unclassified' stamp: 'mdc 4/21/2022 19:46:41'!
cantidadDeOrugas
	^cantidadDeOrugas.! !

!ElHabitat class methodsFor: 'as yet unclassified' stamp: 'mdc 4/21/2022 20:09:09'!
cantidadDePolillas
	^cantidadDePolillas.! !

!ElHabitat class methodsFor: 'as yet unclassified' stamp: 'mdc 4/21/2022 21:45:54'!
llenarRecursos
	10 timesRepeat: [ self agregarUnaOruga ].
	10 timesRepeat: [ self agregarUnaPolilla ].
	"cantidadDeOrugas := 10.
	cantidadDePolillas := 10."
! !

!ElHabitat class methodsFor: 'as yet unclassified' stamp: 'mdc 4/21/2022 20:41:57'!
retrocederAlInicioDeLosTiempos
	cantidadDeHuevos  := 0.
	cantidadDeOrugas := 0.
	cantidadDePolillas  := 0.
	huevosConFirmaGeneticaDeOrianaYOrnella := 0.
	huevosConFirmaGeneticaDePolly := 0.
	huevosConFirmaGeneticaDeLara := 0.! !


!ElHabitat class methodsFor: '--** private fileout/in **--' stamp: 'JM 4/24/2022 17:10:17'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	huevosConFirmaGeneticaDePolly := 0.
	cantidadDeHuevos := 1.
	cantidadDeOrugas := 9.
	cantidadDePolillas := 10.
	huevosConFirmaGeneticaDeOrianaYOrnella := 1.
	huevosConFirmaGeneticaDeLara := 0.! !


!classDefinition: #LaAvispaLara category: 'AvispasYAbejasParte2'!
DenotativeObject subclass: #LaAvispaLara
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AvispasYAbejasParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LaAvispaLara class' category: 'AvispasYAbejasParte2'!
LaAvispaLara class
	instanceVariableNames: ''!

!LaAvispaLara class methodsFor: 'as yet unclassified' stamp: 'mdc 4/21/2022 20:23:43'!
intentarReproducirse
	ElHabitat agregarHuevoUsandoHuevo .! !


!classDefinition: #LaAvispaOriana category: 'AvispasYAbejasParte2'!
DenotativeObject subclass: #LaAvispaOriana
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AvispasYAbejasParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LaAvispaOriana class' category: 'AvispasYAbejasParte2'!
LaAvispaOriana class
	instanceVariableNames: ''!

!LaAvispaOriana class methodsFor: 'as yet unclassified' stamp: 'mdc 4/21/2022 20:04:09'!
intentarReproducirse
	ElHabitat agregarHuevoUsandoOruga .! !


!classDefinition: #LaAvispaOrnella category: 'AvispasYAbejasParte2'!
DenotativeObject subclass: #LaAvispaOrnella
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AvispasYAbejasParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LaAvispaOrnella class' category: 'AvispasYAbejasParte2'!
LaAvispaOrnella class
	instanceVariableNames: ''!

!LaAvispaOrnella class methodsFor: 'as yet unclassified' stamp: 'mdc 4/21/2022 20:03:04'!
intentarReproducirse
	ElHabitat agregarHuevoUsandoOruga .! !


!classDefinition: #LaAvispaPolly category: 'AvispasYAbejasParte2'!
DenotativeObject subclass: #LaAvispaPolly
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AvispasYAbejasParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LaAvispaPolly class' category: 'AvispasYAbejasParte2'!
LaAvispaPolly class
	instanceVariableNames: ''!

!LaAvispaPolly class methodsFor: 'as yet unclassified' stamp: 'mdc 4/21/2022 20:04:50'!
intentarReproducirse
	ElHabitat agregarHuevoUsandoPolilla.! !


!classDefinition: #PruebasReproduccionDeAvispas category: 'AvispasYAbejasParte2'!
DenotativeObject subclass: #PruebasReproduccionDeAvispas
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AvispasYAbejasParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PruebasReproduccionDeAvispas class' category: 'AvispasYAbejasParte2'!
PruebasReproduccionDeAvispas class
	instanceVariableNames: 'cantidadDeOrugas'!

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana' stamp: 'JMB 4/18/2022 18:38:11'!
test01EnElInicioDeLosTiemposNoHayHuevos	
	self retrocederElHabitatAlInicioDeLosTiempos.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 0! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana' stamp: 'JMB 4/21/2022 12:12:44'!
test02CuandoOrianaLaAvispaSeReproducePorPrimeraVezDejaUnHuevo
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana' stamp: 'JMB 4/21/2022 12:12:11'!
test03CadaVezQueOrianaSeReproduceDejaUnHuevoMas
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	self laAvispaOriana intentarReproducirse.
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 2.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana' stamp: 'JMB 4/21/2022 12:12:53'!
test04ParaDejarUnHuevoOrianaLaAvispaReduceLaPoblacionDeUnaOrugaANinguna
	self retrocederElHabitatAlInicioDeLosTiempos.
	self queElHabitatTengaUnaOrugaMas.
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self habitat cantidadDeOrugas isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana' stamp: 'JMB 4/21/2022 12:13:43'!
test05ParaDejarUnHuevoOrianaLaAvispaDecrementaEnUnoLaPoblacionDeOrugasDelHabitat
	self retrocederElHabitatAlInicioDeLosTiempos.
	self queElHabitatTengaDosOrugasMas.
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self habitat cantidadDeOrugas isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana' stamp: 'JMB 4/21/2022 12:13:22'!
test06CuandoNoHayOrugasOrianaLaAvispaNoPuedeDejarHuevos
	self retrocederElHabitatAlInicioDeLosTiempos.
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 0.! !


!PruebasReproduccionDeAvispas class methodsFor: 'tests - Ornella' stamp: 'JMB 4/21/2022 12:14:24'!
test07CuandoOrnellaLaAvispaSeReproduceDejaUnHuevo
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	
	self laAvispaOrnella intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Ornella' stamp: 'JMB 4/21/2022 12:14:18'!
test08ParaDejarUnHuevoOrnellaLaAvispaReduceLaPoblacionDeUnaOrugaANinguna
	self retrocederElHabitatAlInicioDeLosTiempos.
	self queElHabitatTengaUnaOrugaMas.
	
	self laAvispaOrnella intentarReproducirse.
	
	Assert that: self habitat cantidadDeOrugas isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Ornella' stamp: 'JMB 4/21/2022 12:14:11'!
test09CuandoNoHayOrugasOrnellaLaAvispaNoPuedeDejarHuevos
	self retrocederElHabitatAlInicioDeLosTiempos.
	
	self laAvispaOrnella intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 0.! !


!PruebasReproduccionDeAvispas class methodsFor: 'tests - Polly' stamp: 'JMB 4/21/2022 12:14:46'!
test10CuandoPollyLaAvispaSeReproduceDejaUnHuevo
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	
	self laAvispaPolly intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Polly' stamp: 'JMB 4/21/2022 12:14:40'!
test11ParaDejarUnHuevoPollyLaAvispaReduceLaPoblacionDeUnaPolillaANinguna
	self retrocederElHabitatAlInicioDeLosTiempos.
	self queElHabitatTengaUnaPolillaMas.
	
	self laAvispaPolly intentarReproducirse.
	
	Assert that: self habitat cantidadDePolillas isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Polly' stamp: 'JMB 4/21/2022 12:14:36'!
test12ParaDejarUnHuevoPollyLaAvispaDecrementaEnUnoLaPoblacionDePolillasDelHabitat
	self retrocederElHabitatAlInicioDeLosTiempos.
	self queElHabitatTengaDosPolillasMas.
	
	self laAvispaPolly intentarReproducirse.
	
	Assert that: self habitat cantidadDePolillas isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Polly' stamp: 'JMB 4/21/2022 12:14:30'!
test13CuandoNoHayPolillasPollyLaAvispaNoPuedeDejarHuevos
	self retrocederElHabitatAlInicioDeLosTiempos.
	
	self laAvispaPolly intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 0.! !


!PruebasReproduccionDeAvispas class methodsFor: 'tests - firma genetica' stamp: 'mdc 4/21/2022 20:20:40'!
test14CuandoOrianaLaAvispaSeReproduceDejaUnHuevoConSuFirmaGenetica
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeOriana isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - firma genetica' stamp: 'JMB 4/21/2022 12:15:02'!
test15CuandoOrianaLaAvispaAunNoSeReprodujoNoTieneHuevosConSuFirmaGenetica
	self retrocederElHabitatAlInicioDeLosTiempos. 
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeOriana isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - firma genetica' stamp: 'JMB 4/21/2022 12:14:58'!
test16CuandoPollyLaAvispaSeReproduceDejaUnHuevoConSuFirmaGenetica
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	
	self laAvispaPolly intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDePolly isEqualTo: 1.
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeOriana isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - firma genetica' stamp: 'JMB 4/21/2022 12:14:54'!
test17CuandoOrnellaLaAvispaSeReproduceDejaUnHuevoConLaMismaFirmaGeneticaQueOriana
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	
	self laAvispaOrnella intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeOrnella isEqualTo: 1.
	Assert 
		that: self cantidadDeHuevosConLaFirmaGeneticaDeOrnella  
		isEqualTo: self cantidadDeHuevosConLaFirmaGeneticaDeOriana! !


!PruebasReproduccionDeAvispas class methodsFor: 'tests - Lara la ladrona' stamp: 'JMB 4/21/2022 12:15:27'!
test18CuandoLaraLaAvispaSeReproduceDejaUnHuevoConSuFirmaGenetica
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	self laAvispaOrnella intentarReproducirse.
	
	self laAvispaLara intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeLara isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Lara la ladrona' stamp: 'JMB 4/21/2022 12:15:22'!
test19CuandoLaraLaAvispaSeReproduceLeSacaElHuevoAOtraAvispa
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	self laAvispaOriana intentarReproducirse.
	
	self laAvispaLara intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeOriana isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Lara la ladrona' stamp: 'JMB 4/21/2022 12:15:18'!
test20CuandoLaraLaAvispaSeReproduceLeSacaElHuevoAPolly
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	self laAvispaPolly intentarReproducirse.
	
	self laAvispaLara intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDePolly isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Lara la ladrona' stamp: 'JMB 4/21/2022 12:15:12'!
test21CuandoLaraLaAvispaNoTieneRecursosNoDejaUnHuevo
	self retrocederElHabitatAlInicioDeLosTiempos. 
		
	self laAvispaLara intentarReproducirse.
		
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeLara isEqualTo: 0.! !


!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'mdc 4/21/2022 20:29:55'!
cantidadDeHuevosConLaFirmaGeneticaDeLara
	^self habitat cantidadDeHuevosConFirmaGeneticaDeLara.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'mdc 4/21/2022 20:20:55'!
cantidadDeHuevosConLaFirmaGeneticaDeOriana
	^self habitat cantidadDeHuevosConFirmaGeneticaDeOriana.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'mdc 4/21/2022 20:21:07'!
cantidadDeHuevosConLaFirmaGeneticaDeOrnella
	^self habitat cantidadDeHuevosConFirmaGeneticaDeOrnella .! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'mdc 4/21/2022 20:21:13'!
cantidadDeHuevosConLaFirmaGeneticaDePolly
	^self habitat cantidadDeHuevosConFirmaGeneticaDePolly .! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'mdc 4/21/2022 19:22:27'!
habitat
	^ElHabitat! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'mdc 4/21/2022 19:57:06'!
hacerQueElHabitatTengaLosRecursosSuficientes
	self habitat llenarRecursos.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'mdc 4/21/2022 20:29:40'!
laAvispaLara
	^LaAvispaLara.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'mdc 4/21/2022 19:58:37'!
laAvispaOriana
	^LaAvispaOriana.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'mdc 4/21/2022 19:59:35'!
laAvispaOrnella
	^LaAvispaOrnella.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'mdc 4/21/2022 20:05:56'!
laAvispaPolly
	^LaAvispaPolly ! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'mdc 4/21/2022 19:49:50'!
queElHabitatTengaDosOrugasMas
	self habitat agregarUnaOruga.
	self habitat agregarUnaOruga.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'mdc 4/21/2022 20:10:38'!
queElHabitatTengaDosPolillasMas
	self habitat agregarUnaPolilla.
	self habitat agregarUnaPolilla.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'mdc 4/21/2022 19:47:12'!
queElHabitatTengaUnaOrugaMas
	self habitat agregarUnaOruga.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'mdc 4/21/2022 20:06:44'!
queElHabitatTengaUnaPolillaMas
	self habitat agregarUnaPolilla.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'mdc 4/21/2022 20:42:20'!
retrocederElHabitatAlInicioDeLosTiempos
	self habitat retrocederAlInicioDeLosTiempos.! !


!PruebasReproduccionDeAvispas class methodsFor: '--** private fileout/in **--' stamp: 'JM 4/24/2022 17:10:17'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	cantidadDeOrugas := nil.! !

ElHabitat initializeAfterFileIn!
PruebasReproduccionDeAvispas initializeAfterFileIn!