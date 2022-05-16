!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'MdC 5/12/2022 19:51:06'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'MdC 5/13/2022 16:53:04'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'MdC 5/13/2022 17:09:14'!
test11StackWithLimitWorks

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack initializeWithSize: 3.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'MdC 5/13/2022 17:02:56'!
test12CanNotPushWhenThereTheStackIsFull

	| stack |
	
	stack := OOStack initializeWithSize: 2.
	stack push: 'first'.
	stack push: 'second'.
	
	self
		should: [ stack push: 'third'. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackFullErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'MdC 5/13/2022 17:06:44'!
test13CanPushWhenTheStackWasFull

	| stack |
	
	stack := OOStack initializeWithSize: 2.
	stack push: 'first'.
	stack push: 'second'.
	stack pop.
	stack pop.
	
	stack push: 'third'.
	
	self assert: stack size = 1.
	! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JM 5/16/2022 18:08:15'!
test01PrefixWintReturnsStackOfSize1

	| stack sentenceFinderByPrefix stackWithPrefix |
	
	sentenceFinderByPrefix := SentenceFinderByPrefix new.
	stack := self prepareStack .
	
	stackWithPrefix := sentenceFinderByPrefix find: 'Wint' inAStack: stack.
		
	self assert: stackWithPrefix size equals: 1.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'MdC 5/13/2022 17:27:05'!
test02StackIsEmptyReturnsEmptyStack

	| stack sentenceFinderByPrefix stackWithPrefix |
	
	sentenceFinderByPrefix := SentenceFinderByPrefix new.
	stack := OOStack new.
	
	stackWithPrefix := sentenceFinderByPrefix find: 'Wint' inAStack: stack.
		
	self assert: stackWithPrefix isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JM 5/16/2022 18:08:15'!
test03PrefixNotInStackReturnsEmptyStack

	| stack sentenceFinderByPrefix stackWithPrefix |
	
	sentenceFinderByPrefix := SentenceFinderByPrefix new.
	stack := self prepareStack.
	
	stackWithPrefix := sentenceFinderByPrefix find: 'zzz' inAStack: stack.
		
	self assert: stackWithPrefix isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JM 5/16/2022 18:08:15'!
test04StackStaysWithSameSize

	| stack sentenceFinderByPrefix stackWithPrefix |
	
	sentenceFinderByPrefix := SentenceFinderByPrefix new.
	stack := self prepareStack.
	
	stackWithPrefix := sentenceFinderByPrefix find: 'Wint' inAStack: stack.
		
	self assert: stack size equals: 4.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JM 5/16/2022 18:08:15'!
test05TopOfTheStackStaysInOrder

	| stack sentenceFinderByPrefix stackWithPrefix |
	
	sentenceFinderByPrefix := SentenceFinderByPrefix new.
	stack := self prepareStack.
	
	stackWithPrefix := sentenceFinderByPrefix find: 'Win' inAStack: stack.
		
	self assert: stack top equals: 'Winter is here'.! !


!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'JM 5/16/2022 18:08:15'!
prepareStack

	| stack |
	
	stack := OOStack new.
	stack push: 'winter is coming'.
	stack push: 'winning is everything'.
	stack push: 'The winds of Winter'.
	stack push: 'Winter is here'.
	
	^stack.! !


!classDefinition: #Estado category: 'Stack-Exercise'!
Object subclass: #Estado
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Estado methodsFor: 'accessing' stamp: 'MdC 5/16/2022 13:42:33'!
top: aOOStack

	self subclassResponsibility ! !


!Estado methodsFor: 'adding' stamp: 'MdC 5/16/2022 13:42:40'!
push: anObject in: aOOStack

	self subclassResponsibility ! !


!Estado methodsFor: 'removing' stamp: 'MdC 5/16/2022 13:42:36'!
pop: aOOStack

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Estado class' category: 'Stack-Exercise'!
Estado class
	instanceVariableNames: ''!

!Estado class methodsFor: 'comparing' stamp: 'MdC 5/13/2022 17:18:42'!
esteTamanioSirve: aSize conLimite: aSizeLimit

	self subclassResponsibility ! !


!classDefinition: #Lleno category: 'Stack-Exercise'!
Estado subclass: #Lleno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Lleno methodsFor: 'accessing' stamp: 'MdC 5/16/2022 13:53:43'!
top: aOOStack

	^aOOStack topEnStackNoVacio.! !


!Lleno methodsFor: 'adding' stamp: 'MdC 5/16/2022 13:41:48'!
push: anObject in: aOOStack

	^self error: OOStack stackFullErrorDescription.! !


!Lleno methodsFor: 'removing' stamp: 'MdC 5/16/2022 13:53:48'!
pop: aOOStack

	^aOOStack popEnStackNoVacio.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Lleno class' category: 'Stack-Exercise'!
Lleno class
	instanceVariableNames: ''!

!Lleno class methodsFor: 'comparing' stamp: 'MdC 5/13/2022 16:45:08'!
esteTamanioSirve: aSize conLimite: aSizeLimit

	^aSize = aSizeLimit.! !


!classDefinition: #NoVacio category: 'Stack-Exercise'!
Estado subclass: #NoVacio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NoVacio methodsFor: 'accessing' stamp: 'MdC 5/16/2022 13:53:33'!
top: aOOStack

	^aOOStack topEnStackNoVacio.! !


!NoVacio methodsFor: 'adding' stamp: 'MdC 5/16/2022 13:53:29'!
push: anObject in: aOOStack

	aOOStack pushEnStackNoLleno: anObject.! !


!NoVacio methodsFor: 'removing' stamp: 'MdC 5/16/2022 13:53:36'!
pop: aOOStack

	^aOOStack popEnStackNoVacio.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NoVacio class' category: 'Stack-Exercise'!
NoVacio class
	instanceVariableNames: ''!

!NoVacio class methodsFor: 'comparing' stamp: 'MdC 5/13/2022 16:47:49'!
esteTamanioSirve: aSize conLimite: aSizeLimit

	^(0 < aSize and: aSize < aSizeLimit).! !


!classDefinition: #Vacio category: 'Stack-Exercise'!
Estado subclass: #Vacio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Vacio methodsFor: 'accessing' stamp: 'MdC 5/16/2022 13:42:26'!
top: aOOStack
	
	^self error: OOStack stackEmptyErrorDescription! !


!Vacio methodsFor: 'adding' stamp: 'MdC 5/16/2022 13:53:25'!
push: anObject in: aOOStack

	aOOStack pushEnStackNoLleno: anObject.! !


!Vacio methodsFor: 'removing' stamp: 'MdC 5/16/2022 13:42:16'!
pop: aOOStack
	
	^self error: OOStack stackEmptyErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Vacio class' category: 'Stack-Exercise'!
Vacio class
	instanceVariableNames: ''!

!Vacio class methodsFor: 'comparing' stamp: 'MdC 5/13/2022 16:44:13'!
esteTamanioSirve: aSize conLimite: aSizeLimit

	^aSize = 0.! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'stack estado sizeLimit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'JM 5/16/2022 18:09:25'!
initialize

	stack := OrderedCollection new.
	
	estado := Vacio new.
	
	self sizeLimit: infinity.! !


!OOStack methodsFor: 'accessing' stamp: 'MdC 5/11/2022 21:47:24'!
size

	^stack size.! !

!OOStack methodsFor: 'accessing' stamp: 'MdC 5/16/2022 13:49:22'!
top

	^estado top: self.! !


!OOStack methodsFor: 'adding' stamp: 'JM 5/16/2022 18:12:28'!
push: AnObject
	
	estado push: AnObject in: self.
	
	self verifyEstado.! !


!OOStack methodsFor: 'removing' stamp: 'JM 5/16/2022 18:12:28'!
pop

	self verifyEstado.
	
	^estado pop: self.! !


!OOStack methodsFor: 'testing' stamp: 'MdC 5/12/2022 19:49:55'!
isEmpty

	^stack size = 0.! !


!OOStack methodsFor: 'private' stamp: 'JM 5/16/2022 18:10:34'!
sizeLimit: aSizeLimit

	sizeLimit := aSizeLimit.! !

!OOStack methodsFor: 'private' stamp: 'JM 5/16/2022 18:12:28'!
verifyEstado

	estado  := (Estado subclasses detect: [:aSubclass | aSubclass esteTamanioSirve: (self size) conLimite: sizeLimit ]) new.! !


!OOStack methodsFor: 'private - accessing' stamp: 'MdC 5/16/2022 13:44:24'!
topEnStackNoVacio

	^stack last.! !


!OOStack methodsFor: 'private - adding' stamp: 'MdC 5/16/2022 13:46:55'!
pushEnStackNoLleno: anObject

	^stack add: anObject.! !


!OOStack methodsFor: 'private - removing' stamp: 'MdC 5/16/2022 13:43:58'!
popEnStackNoVacio

	^stack removeLast.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !

!OOStack class methodsFor: 'error descriptions' stamp: 'MdC 5/13/2022 16:39:17'!
stackFullErrorDescription
	
	^ 'Stack is full'! !


!OOStack class methodsFor: 'class initialization' stamp: 'JM 5/16/2022 18:09:25'!
initializeWithSize: aNumber
	
	|stack|
	
	stack := OOStack new.
	
	stack sizeLimit: aNumber.
	
	^stack.! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'searching' stamp: 'JM 5/16/2022 18:07:15'!
find: aPrefix inAStack: aStack

| stackWithPrefixes invertedStack  |

invertedStack := OOStack new.
stackWithPrefixes := OOStack new.

self find: aPrefix in: aStack andSaveStringsIn: stackWithPrefixes withInverseStack: invertedStack.

self restoreOriginalStack: aStack withInverseStack: invertedStack.

^stackWithPrefixes.
! !


!SentenceFinderByPrefix methodsFor: 'private - searching' stamp: 'JM 5/16/2022 18:07:33'!
find: aPrefix in: aStack andSaveStringsIn: stackWithPrefixes withInverseStack: anInvertedStack

	| aString |
	
	(1 to: aStack size) do: [:i |
		aString := aStack pop.
		anInvertedStack push: aString.
		(aString beginsWith: aPrefix) ifTrue: [ stackWithPrefixes push: aString. ].
		].! !

!SentenceFinderByPrefix methodsFor: 'private - searching' stamp: 'JM 5/16/2022 18:07:43'!
restoreOriginalStack: aStack withInverseStack: anInvertedStack

	(1 to: anInvertedStack size) do: [:i | aStack push: anInvertedStack pop.].
! !
