!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MdC 5/31/2022 18:45:12'!
test01
	|marsRover|
	marsRover _ MarsRover new.
	self assert: (marsRover position = (0@0)).
	self assert: (marsRover orientation class = East).
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MdC 5/31/2022 16:33:44'!
test02
	|marsRover|
	marsRover _ MarsRover new.
	marsRover recieveCommands: 'f'.
	self deny: (marsRover position = (0@0)).
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MdC 5/31/2022 18:11:56'!
test03
	|marsRover|
	marsRover _ MarsRover new.
	marsRover recieveCommands: 'f'.
	marsRover recieveCommands: 'f'.
	self assert: (marsRover position = (2@0)).
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MdC 5/31/2022 16:33:44'!
test04
	|marsRover|
	marsRover _ MarsRover new.
	marsRover recieveCommands: 'b'.
	self assert: (marsRover position = (-1@0)).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MdC 5/31/2022 16:33:44'!
test05
	|marsRover|
	marsRover _ MarsRover new.
	marsRover recieveCommands: 'l'.
	marsRover recieveCommands: 'f'.
	self assert: (marsRover position = (0@1)).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MdC 5/31/2022 16:33:44'!
test06
	|marsRover|
	marsRover _ MarsRover new.
	marsRover recieveCommands: 'l'.
	marsRover recieveCommands: 'l'.
	marsRover recieveCommands: 'f'.
	self assert: (marsRover position = (-1@0)).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MdC 5/31/2022 16:33:44'!
test07
	|marsRover|
	marsRover _ MarsRover new.
	marsRover recieveCommands: 'r'.
	marsRover recieveCommands: 'f'.
	self assert: (marsRover position = (0@-1)).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MdC 5/31/2022 16:33:44'!
test08
	|marsRover|
	marsRover _ MarsRover new.
	marsRover recieveCommands: 'l'.
	marsRover recieveCommands: 'r'.
	marsRover recieveCommands: 'f'.
	self assert: (marsRover position = (1@0)).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MdC 5/31/2022 16:33:44'!
test09
	|marsRover|
	marsRover _ MarsRover new.
	marsRover recieveCommands: 'fff'.
	self assert: (marsRover position = (3@0)).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MdC 5/31/2022 17:55:12'!
test10
	|marsRover|
	marsRover _ MarsRover new.
	
	self 
	should: [marsRover recieveCommands: 'fxf']
	raise: Error
	withExceptionDo: [ :anError | self assert: MarsRover invalidCommandErrorDescription equals: anError messageText .
		self assert: (marsRover position = (1@0)).
		].! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MdC 5/31/2022 18:43:16'!
test11
	|marsRover|
	marsRover _ MarsRover new.
	marsRover recieveCommands: 'l'.
	self assert: (marsRover orientation class = North).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MdC 5/31/2022 18:43:20'!
test12
	|marsRover|
	marsRover _ MarsRover new.
	marsRover recieveCommands: 'll'.
	self assert: (marsRover orientation class = West).! !


!classDefinition: #CardinalPoint category: 'MarsRover'!
Object subclass: #CardinalPoint
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CardinalPoint methodsFor: 'as yet unclassified' stamp: 'MdC 5/31/2022 18:40:16'!
puntoCardinalALaDerecha
	
	self subclassResponsibility ! !

!CardinalPoint methodsFor: 'as yet unclassified' stamp: 'MdC 5/31/2022 18:40:20'!
puntoCardinalALaIzquierda
	
	self subclassResponsibility ! !


!classDefinition: #East category: 'MarsRover'!
CardinalPoint subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'as yet unclassified' stamp: 'MdC 5/31/2022 18:33:50'!
puntoCardinalALaDerecha
	
	^South new.! !

!East methodsFor: 'as yet unclassified' stamp: 'MdC 5/31/2022 18:42:16'!
puntoCardinalALaIzquierda
	
	^North new.! !


!classDefinition: #North category: 'MarsRover'!
CardinalPoint subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'as yet unclassified' stamp: 'MdC 5/31/2022 18:34:12'!
puntoCardinalALaDerecha
	
	^East new! !

!North methodsFor: 'as yet unclassified' stamp: 'MdC 5/31/2022 18:42:16'!
puntoCardinalALaIzquierda
	
	^West new! !


!classDefinition: #South category: 'MarsRover'!
CardinalPoint subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'as yet unclassified' stamp: 'MdC 5/31/2022 18:36:48'!
puntoCardinalALaDerecha
	
	^West new! !

!South methodsFor: 'as yet unclassified' stamp: 'MdC 5/31/2022 18:42:16'!
puntoCardinalALaIzquierda
	
	^East new! !


!classDefinition: #West category: 'MarsRover'!
CardinalPoint subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'as yet unclassified' stamp: 'MdC 5/31/2022 18:37:10'!
puntoCardinalALaDerecha
	
	^North new! !

!West methodsFor: 'as yet unclassified' stamp: 'MdC 5/31/2022 18:42:16'!
puntoCardinalALaIzquierda
	
	^South new! !


!classDefinition: #Command category: 'MarsRover'!
Object subclass: #Command
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Command methodsFor: 'as yet unclassified' stamp: 'MdC 5/31/2022 17:52:53'!
ejecutarComando: aMarsRover

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Command class' category: 'MarsRover'!
Command class
	instanceVariableNames: ''!

!Command class methodsFor: 'as yet unclassified' stamp: 'MdC 5/31/2022 17:47:25'!
estaLetraTeSirve: aCharacter

	self subclassResponsibility! !


!classDefinition: #CommandB category: 'MarsRover'!
Command subclass: #CommandB
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CommandB methodsFor: 'as yet unclassified' stamp: 'MdC 5/31/2022 17:38:10'!
ejecutarComando: aMarsRover
	aMarsRover morverHaciaAtras.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CommandB class' category: 'MarsRover'!
CommandB class
	instanceVariableNames: ''!

!CommandB class methodsFor: 'as yet unclassified' stamp: 'MdC 5/31/2022 17:45:12'!
estaLetraTeSirve: aCharacter
	^aCharacter = $b.! !


!classDefinition: #CommandF category: 'MarsRover'!
Command subclass: #CommandF
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CommandF methodsFor: 'as yet unclassified' stamp: 'MdC 5/31/2022 17:38:04'!
ejecutarComando: aMarsRover
	aMarsRover morverHaciaAdelante.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CommandF class' category: 'MarsRover'!
CommandF class
	instanceVariableNames: ''!

!CommandF class methodsFor: 'as yet unclassified' stamp: 'MdC 5/31/2022 17:45:19'!
estaLetraTeSirve: aCharacter
	^aCharacter = $f.! !


!classDefinition: #CommandL category: 'MarsRover'!
Command subclass: #CommandL
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CommandL methodsFor: 'as yet unclassified' stamp: 'MdC 5/31/2022 17:38:16'!
ejecutarComando: aMarsRover
	aMarsRover rotarOrientacionHaciaLaIzquerda.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CommandL class' category: 'MarsRover'!
CommandL class
	instanceVariableNames: ''!

!CommandL class methodsFor: 'as yet unclassified' stamp: 'MdC 5/31/2022 17:45:16'!
estaLetraTeSirve: aCharacter
	^aCharacter = $l.! !


!classDefinition: #CommandR category: 'MarsRover'!
Command subclass: #CommandR
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CommandR methodsFor: 'as yet unclassified' stamp: 'MdC 5/31/2022 17:38:21'!
ejecutarComando: aMarsRover
	aMarsRover rotarOrientacionHaciaLaDerecha.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CommandR class' category: 'MarsRover'!
CommandR class
	instanceVariableNames: ''!

!CommandR class methodsFor: 'as yet unclassified' stamp: 'MdC 5/31/2022 17:45:08'!
estaLetraTeSirve: aCharacter
	^aCharacter = $r.! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position advance knownCommands orientation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'as yet unclassified' stamp: 'MdC 5/31/2022 17:55:41'!
recieveCommands: aListOfCommands

	| comando |

	(1 to: aListOfCommands size) do: [ :i | 
		((knownCommands includes: (aListOfCommands at: i)) ifFalse: [self error: (self class invalidCommandErrorDescription)]).	
		
		comando  := (Command subclasses detect: [:aSubclass | aSubclass estaLetraTeSirve: (aListOfCommands at: i)]) new.
		comando ejecutarComando: self.
	].! !


!MarsRover methodsFor: 'private' stamp: 'MdC 5/31/2022 17:39:27'!
morverHaciaAdelante
	position _ position + advance.! !

!MarsRover methodsFor: 'private' stamp: 'MdC 5/31/2022 17:39:47'!
morverHaciaAtras
	position _ position - advance! !

!MarsRover methodsFor: 'private' stamp: 'MdC 5/31/2022 18:44:01'!
rotarOrientacionHaciaLaDerecha
	
	| pi |
	pi _ (Float pi).
	advance _ (advance rotatedBy: pi*3/2) rounded.
	
	orientation _ orientation puntoCardinalALaDerecha.
	
	"(orientation = #East) ifTrue: [^orientation _ #South].
	(orientation = #North) ifTrue: [^orientation _ #East].
	(orientation = #West) ifTrue: [^orientation _ #North].
	(orientation = #South) ifTrue: [^orientation _ #West]."! !

!MarsRover methodsFor: 'private' stamp: 'MdC 5/31/2022 18:44:04'!
rotarOrientacionHaciaLaIzquerda
	
	| pi |
	pi _ (Float pi).
	advance _ (advance rotatedBy: pi/2) rounded.
	
	orientation _ orientation puntoCardinalALaIzquierda.
	
	"(orientation = #East) ifTrue: [^orientation _ #North].
	(orientation = #North) ifTrue: [^orientation _ #West].
	(orientation = #West) ifTrue: [^orientation _ #South].
	(orientation = #South) ifTrue: [^orientation _ #East]."! !


!MarsRover methodsFor: 'initialization' stamp: 'MdC 5/31/2022 18:37:55'!
initialize
	position _ 0@0.
	advance _ 1@0.
	knownCommands _ {$f. $b. $l. $r}.
	orientation _ East new.! !


!MarsRover methodsFor: 'getter' stamp: 'MdC 5/31/2022 18:13:02'!
orientation
	^orientation! !

!MarsRover methodsFor: 'getter' stamp: 'MdC 5/31/2022 15:48:16'!
position
	^position.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'MdC 5/31/2022 17:11:20'!
invalidCommandErrorDescription
	^'invalid command'.! !
