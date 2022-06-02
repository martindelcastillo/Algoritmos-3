!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'testing' stamp: 'MdC 6/2/2022 14:37:24'!
test01MarsRoverStartsAt00FacingEast

	| marsRover |
	
	marsRover _ MarsRover new.
	
	self assert: (marsRover position = (0@0)).
	self assert: (marsRover orientation class = East).! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MdC 6/2/2022 14:37:31'!
test02FCommandMovesMarsRover

	| marsRover |
	
	marsRover _ MarsRover new.
	
	marsRover receiveCommands: 'f'.
	
	self assert: (marsRover position = (1@0)).! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MdC 6/2/2022 14:37:37'!
test03MultipleFCommandMovesMarsRoverToCorrectPosition

	| marsRover |
	
	marsRover _ MarsRover new.
	
	marsRover receiveCommands: 'f'.
	marsRover receiveCommands: 'f'.
		
	self assert: (marsRover position = (2@0)).! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MdC 6/2/2022 14:37:48'!
test04BCommandMovesMarsRoverBackwards

	| marsRover |
	
	marsRover _ MarsRover new.
	
	marsRover receiveCommands: 'b'.
		
	self assert: (marsRover position = (-1@0)).! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MdC 6/2/2022 14:37:52'!
test05LCommandRotatesMarsRoverToCorrectPosition

	| marsRover |
	
	marsRover _ MarsRover new.
	
	marsRover receiveCommands: 'l'.
	marsRover receiveCommands: 'f'.
		
	self assert: (marsRover position = (0@1)).! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MdC 6/2/2022 14:37:57'!
test06RAndLCommandsWorkTogether

	| marsRover |
	
	marsRover _ MarsRover new.
	
	marsRover receiveCommands: 'l'.
	marsRover receiveCommands: 'r'.
	marsRover receiveCommands: 'f'.
		
	self assert: (marsRover position = (1@0)).! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MdC 6/2/2022 14:38:02'!
test07MultipleCommandsCanBeSendAtTheSameTime

	| marsRover |
	
	marsRover _ MarsRover new.
	
	marsRover receiveCommands: 'fff'.
		
	self assert: (marsRover position = (3@0)).! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MdC 6/2/2022 14:38:08'!
test08ReceivingAnInvalidCommandStopsFurtherCommandsFromExecuting

	| marsRover |
	
	marsRover _ MarsRover new.
	
	self 
	should: [marsRover receiveCommands: 'fxf']
	raise: Error
	withExceptionDo: [ :anError | self assert: MarsRover invalidCommandErrorDescription equals: anError messageText .
		self assert: (marsRover position = (1@0)).
		].! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MdC 6/2/2022 14:38:16'!
test09LCommandMakesMarsRoverFaceCorrectCardinalPoint

	| marsRover |
	
	marsRover _ MarsRover new.
	
	marsRover receiveCommands: 'l'.
		
	self assert: (marsRover orientation class = North).! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MdC 6/2/2022 14:38:21'!
test10MultipleLComandsMakesMarsRoverFaceCorrectCardinalPoint

	| marsRover |
	
	marsRover _ MarsRover new.
	
	marsRover receiveCommands: 'll'.
		
	self assert: (marsRover orientation class = West).! !


!classDefinition: #CardinalPoint category: 'MarsRover'!
Object subclass: #CardinalPoint
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CardinalPoint methodsFor: 'converting' stamp: 'JM 5/31/2022 18:38:45'!
rotateLeft

	self subclassResponsibility ! !

!CardinalPoint methodsFor: 'converting' stamp: 'JM 5/31/2022 18:38:50'!
rotateRight

	self subclassResponsibility ! !


!classDefinition: #East category: 'MarsRover'!
CardinalPoint subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'converting' stamp: 'JM 5/31/2022 18:33:24'!
rotateLeft

	^North new! !

!East methodsFor: 'converting' stamp: 'JM 5/31/2022 18:37:50'!
rotateRight

	^South new
	
	
	
	! !


!classDefinition: #North category: 'MarsRover'!
CardinalPoint subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'converting' stamp: 'JM 5/31/2022 18:36:21'!
rotateLeft

	^West new! !

!North methodsFor: 'converting' stamp: 'JM 5/31/2022 18:38:02'!
rotateRight

	^East new! !


!classDefinition: #South category: 'MarsRover'!
CardinalPoint subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'converting' stamp: 'JM 5/31/2022 18:36:32'!
rotateLeft

	^East new! !

!South methodsFor: 'converting' stamp: 'JM 5/31/2022 18:38:11'!
rotateRight

	^West new! !


!classDefinition: #West category: 'MarsRover'!
CardinalPoint subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'converting' stamp: 'JM 5/31/2022 18:36:39'!
rotateLeft

	^South new! !

!West methodsFor: 'converting' stamp: 'JM 5/31/2022 18:38:24'!
rotateRight

	^North new! !


!classDefinition: #Command category: 'MarsRover'!
Object subclass: #Command
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Command methodsFor: 'public' stamp: 'JM 6/2/2022 11:30:33'!
executeCommandIn: aMarsRover

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Command class' category: 'MarsRover'!
Command class
	instanceVariableNames: ''!

!Command class methodsFor: 'as yet unclassified' stamp: 'JM 5/31/2022 17:43:18'!
verifyCommand: aCommand

	self subclassResponsibility ! !


!classDefinition: #CommandBackwards category: 'MarsRover'!
Command subclass: #CommandBackwards
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CommandBackwards methodsFor: 'public' stamp: 'JM 6/2/2022 11:30:33'!
executeCommandIn: aMarsRover


	aMarsRover moveBackwards.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CommandBackwards class' category: 'MarsRover'!
CommandBackwards class
	instanceVariableNames: ''!

!CommandBackwards class methodsFor: 'verifying' stamp: 'JM 5/31/2022 17:52:39'!
verifyCommand: aCommand

	^aCommand = $b.! !


!classDefinition: #CommandForward category: 'MarsRover'!
Command subclass: #CommandForward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CommandForward methodsFor: 'public' stamp: 'JM 6/2/2022 11:30:33'!
executeCommandIn: aMarsRover


	aMarsRover moveForward.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CommandForward class' category: 'MarsRover'!
CommandForward class
	instanceVariableNames: ''!

!CommandForward class methodsFor: 'verifying' stamp: 'JM 5/31/2022 17:52:43'!
verifyCommand: aCommand

	^aCommand = $f.! !


!classDefinition: #CommandLeft category: 'MarsRover'!
Command subclass: #CommandLeft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CommandLeft methodsFor: 'public' stamp: 'JM 6/2/2022 11:30:33'!
executeCommandIn: aMarsRover


	aMarsRover rotateLeft.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CommandLeft class' category: 'MarsRover'!
CommandLeft class
	instanceVariableNames: ''!

!CommandLeft class methodsFor: 'verifying' stamp: 'JM 5/31/2022 17:52:47'!
verifyCommand: aCommand

	^aCommand = $l.! !


!classDefinition: #CommandRight category: 'MarsRover'!
Command subclass: #CommandRight
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CommandRight methodsFor: 'public' stamp: 'JM 6/2/2022 11:30:33'!
executeCommandIn: aMarsRover


	aMarsRover rotateRight.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CommandRight class' category: 'MarsRover'!
CommandRight class
	instanceVariableNames: ''!

!CommandRight class methodsFor: 'verifying' stamp: 'JM 5/31/2022 17:52:52'!
verifyCommand: aCommand

	^aCommand = $r.! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position advance comando orientation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'public' stamp: 'JM 5/31/2022 18:16:22'!
orientation
	
	^orientation! !

!MarsRover methodsFor: 'public' stamp: 'JM 5/31/2022 15:47:50'!
position

	^position! !


!MarsRover methodsFor: 'input-reading' stamp: 'JM 6/2/2022 11:30:33'!
receiveCommands: aStringOfCommands
	
	(1 to: aStringOfCommands size) collect: [:aLetter |
		
		(({$f . $b. $l. $r} includes: (aStringOfCommands at: aLetter)) ifFalse: [self error: (self class invalidCommandErrorDescription)]).
		
		self createCommand: (aStringOfCommands at: aLetter).
		
		comando executeCommandIn: self.
		
		
		
		
		].
! !


!MarsRover methodsFor: 'private' stamp: 'JM 6/2/2022 11:25:08'!
createCommand: aCommand

	comando  := (Command subclasses detect: [:aSubclass | aSubclass verifyCommand: aCommand]) new.! !


!MarsRover methodsFor: 'private-Command' stamp: 'JM 5/31/2022 17:38:56'!
moveBackwards
		
	position := position - advance.
		! !

!MarsRover methodsFor: 'private-Command' stamp: 'JM 5/31/2022 17:37:46'!
moveForward
		
	position := position + advance.
		! !


!MarsRover methodsFor: 'private-CardinalPoint' stamp: 'JM 5/31/2022 18:34:08'!
rotateLeft

	| pi |
	pi _ Float pi.
	
	advance := (advance rotatedBy: pi/2) rounded.
	
	orientation := orientation rotateLeft.
	
		
	
! !

!MarsRover methodsFor: 'private-CardinalPoint' stamp: 'JM 5/31/2022 18:37:25'!
rotateRight

	| pi |
	pi _ Float pi.
	
	advance := (advance rotatedBy: (pi * 3/2)) rounded.
	
	orientation := orientation rotateRight.
		
	
! !


!MarsRover methodsFor: 'initialization' stamp: 'JM 5/31/2022 18:31:12'!
initialize

	position _ 0@0.
	advance _ 1@0.
	orientation _ East new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'error-handling' stamp: 'JM 6/2/2022 11:29:37'!
invalidCommandErrorDescription

	^'invalid command'.! !
