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

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'MdC 5/13/2022 17:26:54'!
test01PrefixWintReturnsStackOfSize1

	| stack sentenceFinderByPrefix stackWithPrefix |
	
	sentenceFinderByPrefix := SentenceFinderByPrefix new.
	stack := self prepararStack .
	
	stackWithPrefix := sentenceFinderByPrefix find: 'Wint' inAStack: stack.
		
	self assert: stackWithPrefix size equals: 1.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'MdC 5/13/2022 17:27:05'!
test02StackIsEmptyReturnsEmptyStack

	| stack sentenceFinderByPrefix stackWithPrefix |
	
	sentenceFinderByPrefix := SentenceFinderByPrefix new.
	stack := OOStack new.
	
	stackWithPrefix := sentenceFinderByPrefix find: 'Wint' inAStack: stack.
		
	self assert: stackWithPrefix isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'MdC 5/13/2022 17:27:15'!
test03PrefixNotInStackReturnsEmptyStack

	| stack sentenceFinderByPrefix stackWithPrefix |
	
	sentenceFinderByPrefix := SentenceFinderByPrefix new.
	stack := self prepararStack.
	
	stackWithPrefix := sentenceFinderByPrefix find: 'zzz' inAStack: stack.
		
	self assert: stackWithPrefix isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'MdC 5/13/2022 17:27:23'!
test04StackStaysWithSameSize

	| stack sentenceFinderByPrefix stackWithPrefix |
	
	sentenceFinderByPrefix := SentenceFinderByPrefix new.
	stack := self prepararStack.
	
	stackWithPrefix := sentenceFinderByPrefix find: 'Wint' inAStack: stack.
		
	self assert: stack size equals: 4.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'MdC 5/13/2022 17:27:32'!
test05TopOfTheStackStaysInOrder

	| stack sentenceFinderByPrefix stackWithPrefix |
	
	sentenceFinderByPrefix := SentenceFinderByPrefix new.
	stack := self prepararStack.
	
	stackWithPrefix := sentenceFinderByPrefix find: 'Win' inAStack: stack.
		
	self assert: stack top equals: 'Winter is here'.! !


!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'MdC 5/13/2022 16:19:16'!
prepararStack

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

!Estado methodsFor: 'accessing' stamp: 'MdC 5/12/2022 19:51:29'!
top: stack

	self subclassResponsibility ! !


!Estado methodsFor: 'adding' stamp: 'MdC 5/13/2022 17:16:07'!
push: anObject in: aStack

	self subclassResponsibility ! !


!Estado methodsFor: 'removing' stamp: 'MdC 5/12/2022 19:51:24'!
pop: stack

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

!Lleno methodsFor: 'accessing' stamp: 'MdC 5/13/2022 16:35:28'!
top: stack

	^stack last.! !


!Lleno methodsFor: 'adding' stamp: 'MdC 5/13/2022 16:39:50'!
push: anObject in: aStack

	^self error: OOStack stackFullErrorDescription.! !


!Lleno methodsFor: 'removing' stamp: 'MdC 5/13/2022 16:35:12'!
pop: stack

	^stack removeLast.! !

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

!NoVacio methodsFor: 'accessing' stamp: 'MdC 5/12/2022 19:46:13'!
top: stack

	^stack last.! !


!NoVacio methodsFor: 'adding' stamp: 'MdC 5/13/2022 16:37:32'!
push: anObject in: aStack

	aStack add: anObject.! !


!NoVacio methodsFor: 'removing' stamp: 'MdC 5/12/2022 19:45:26'!
pop: stack

	^stack removeLast.! !

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

!Vacio methodsFor: 'accessing' stamp: 'MdC 5/12/2022 20:02:36'!
top: stack
	
	^self error: OOStack stackEmptyErrorDescription! !


!Vacio methodsFor: 'adding' stamp: 'MdC 5/13/2022 16:37:58'!
push: anObject in: aStack

	aStack add: anObject.! !


!Vacio methodsFor: 'removing' stamp: 'MdC 5/12/2022 20:02:29'!
pop: stack
	
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
	instanceVariableNames: 'stack estado tamanioLimite'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'MdC 5/13/2022 16:51:30'!
initialize

	stack := OrderedCollection new.
	
	estado := Vacio new.
	
	self tamanioLimite: infinity.! !


!OOStack methodsFor: 'private' stamp: 'MdC 5/13/2022 16:51:46'!
tamanioLimite: aSizeLimit

	tamanioLimite := aSizeLimit.! !

!OOStack methodsFor: 'private' stamp: 'MdC 5/13/2022 16:46:21'!
verificarEstado

	estado  := (Estado subclasses detect: [:aSubclass | aSubclass esteTamanioSirve: (self size) conLimite: tamanioLimite ]) new.! !


!OOStack methodsFor: 'testing' stamp: 'MdC 5/12/2022 19:49:55'!
isEmpty

	^stack size = 0.! !


!OOStack methodsFor: 'accessing' stamp: 'MdC 5/11/2022 21:47:24'!
size

	^stack size.! !

!OOStack methodsFor: 'accessing' stamp: 'MdC 5/12/2022 20:03:51'!
top

	^estado top: stack.! !


!OOStack methodsFor: 'adding' stamp: 'MdC 5/13/2022 16:56:04'!
push: AnObject
	
	estado push: AnObject in: stack.
	
	self verificarEstado.! !


!OOStack methodsFor: 'removing' stamp: 'MdC 5/12/2022 20:03:58'!
pop

	self verificarEstado.
	
	^estado pop: stack.! !

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


!OOStack class methodsFor: 'class initialization' stamp: 'MdC 5/13/2022 16:51:13'!
initializeWithSize: aNumber
	
	|stack|
	
	stack := OOStack new.
	
	stack tamanioLimite: aNumber.
	
	^stack.! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'serching' stamp: 'MdC 5/13/2022 17:39:31'!
find: aPrefix inAStack: aStack

| stackWithPrefixes stackInverso aString |

stackInverso := OOStack new.
stackWithPrefixes := OOStack new.

(1 to: aStack size) do: [:i |
	aString := aStack pop.
	stackInverso push: aString.
	(aString beginsWith: aPrefix) ifTrue: [ stackWithPrefixes push: aString. ].
	].

(1 to: stackInverso size) do: [:i | aStack push: stackInverso pop.].

^stackWithPrefixes.
! !
