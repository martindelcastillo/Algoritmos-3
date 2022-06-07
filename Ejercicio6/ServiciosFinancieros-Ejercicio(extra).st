!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'JM 6/7/2022 16:22:18'!
test01BalanceOfPortfolioIsTheSameAsItAccount

	| account portfolio |
	
	account := ReceptiveAccount new.
	
	Deposit register: 50 * peso on: account.
	
	portfolio := Portfolio new.
	portfolio add: account.
	
	self assert: portfolio balance equals: 50 * peso! !

!PortfolioTest methodsFor: 'tests' stamp: 'JM 6/7/2022 16:23:22'!
test02BalanceOfPortfoliosIsTheSumOfAccountsBalances

	| account account2 portfolio |
	
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Deposit register: 50 * peso on: account.
	Withdraw register: 10 * peso on: account2.
	
	portfolio := Portfolio new.
	portfolio add: account.
	portfolio add: account2.
	
	self assert: portfolio balance equals: 40 * peso
! !

!PortfolioTest methodsFor: 'tests' stamp: 'JM 6/7/2022 16:24:25'!
test03PortfolioTransactionsIsTheSameAsAccountTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
	
	portfolio := Portfolio new.
	portfolio add: account.
	
	
	self assert: 1 equals: (portfolio transactions) size.
	self assert: (account transactions includes: deposit).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'JM 6/7/2022 16:25:05'!
test04PortfolioTransactionsIsTheSumOfAccountsTransactions

	| account portfolio deposit account2 withdraw |
	
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	deposit := Deposit register: 50 * peso on: account.
	withdraw := Withdraw register: 40 * peso on: account2.

	
	portfolio := Portfolio new.
	portfolio add: account.
	portfolio add: account2.
	
	
	self assert: 2 equals: (portfolio transactions) size.
	self assert: (portfolio transactions includes: deposit).
	self assert: (portfolio transactions includes: withdraw).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'JM 6/7/2022 16:25:33'!
test05PortfolioRegistersAccountTransactions

	| account portfolio deposit  |
	
	account := ReceptiveAccount new.

	deposit := Deposit register: 50 * peso on: account.
	
	portfolio := Portfolio new.
	portfolio add: account.
	
	self assert: (portfolio hasRegistered: deposit ).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'JM 6/7/2022 16:26:22'!
test06PortfolioCanWorkWithOtherPortfoliosInside

	| account portfolio1 portfolio2 deposit account2 deposit2|
	
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	deposit := Deposit register: 50 * peso on: account.
	deposit2 := Deposit register: 50 * peso on: account2.
	
	portfolio1 := Portfolio new.
	portfolio1 add: account.
	
	portfolio2 := Portfolio new.
	portfolio2 add: portfolio1.
	portfolio2 add: account2 .
	
	self assert: portfolio2 balance equals: 100 * peso .
	self assert: portfolio2 transactions size equals: 2.
	self assert: (portfolio2 hasRegistered: deposit ).
	self assert: (portfolio2 hasRegistered: deposit2 ).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'JM 6/7/2022 16:26:46'!
test07PortfolioCantAddAnAlreadyAddedAccount

	| account portfolio |
	
	account := ReceptiveAccount new.
	
	Deposit register: 50 * peso on: account.
	
	portfolio := Portfolio new.
	portfolio add: account.
	
	self 
	should: [portfolio add: account]
	raise: Error
	withExceptionDo: [ :anError | self assert: Portfolio existingAccountErrorDescription equals: anError messageText .
		self assert: portfolio balance equals: 50 * peso.
		].! !

!PortfolioTest methodsFor: 'tests' stamp: 'JM 6/7/2022 16:27:30'!
test08PortfolioCantAddAccountAlreadyIncludedInOneOfHisChilds

	| account portfolio portfolio1 portfolio2 |
	
	account := ReceptiveAccount new.
	
	Deposit register: 50 * peso on: account.
	
	portfolio2 := Portfolio new.
	portfolio2 add: account.
	
	portfolio1 := Portfolio new.
	portfolio1 add: portfolio2.
	
	portfolio := Portfolio new.
	portfolio add: portfolio1.
	
	self 
	should: [portfolio add: account]
	raise: Error
	withExceptionDo: [ :anError | self assert: Portfolio existingAccountErrorDescription equals: anError messageText .
		self assert: portfolio balance equals: 50 * peso.
		].! !

!PortfolioTest methodsFor: 'tests' stamp: 'JM 6/7/2022 16:27:45'!
test09PortfolioCantAddItself

	| account portfolio |
	
	account := ReceptiveAccount new.
	
	Deposit register: 50 * peso on: account.
	
	portfolio := Portfolio new.
	portfolio add: account.
	
	self 
	should: [portfolio add: portfolio]
	raise: Error
	withExceptionDo: [ :anError | self assert: Portfolio existingAccountErrorDescription equals: anError messageText .
		self assert: portfolio balance equals: 50 * peso.
		].! !

!PortfolioTest methodsFor: 'tests' stamp: 'JM 6/7/2022 16:29:13'!
test10PortfolioChildCantAddAccountThatExistInFatherPortfolio

	| account portfolio portfolio1 |
	
	account := ReceptiveAccount new.
	
	Deposit register: 50 * peso on: account.
	
	portfolio1 := Portfolio new.
	
	portfolio := Portfolio new.
	portfolio add: account.
	portfolio add: portfolio1.
	
	
	self 
	should: [portfolio1 add: account]
	raise: Error
	withExceptionDo: [ :anError | self assert: Portfolio existingAccountErrorDescription equals: anError messageText .
		self assert: portfolio1 balance equals: 0 * peso.
		].! !

!PortfolioTest methodsFor: 'tests' stamp: 'JM 6/7/2022 16:30:09'!
test11PortfolioCantAddChildPortfolioIfItIncludesSameAccount

	| account portfolio portfolio1 |
	
	account := ReceptiveAccount new.
	
	Deposit register: 50 * peso on: account.
	
	portfolio1 := Portfolio new.
	portfolio1 add: account.
	
	portfolio := Portfolio new.
	portfolio add: account.
	
	self 
	should: [portfolio add: portfolio1]
	raise: Error
	withExceptionDo: [ :anError | self assert: Portfolio existingAccountErrorDescription equals: anError messageText .
		self assert: portfolio balance equals: 50 * peso.
		].! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:43'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:20'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:24'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:14'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:22'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:14'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:23'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferTest methodsFor: 'test' stamp: 'JM 6/7/2022 16:22:51'!
test01TransferModifiesAccountsBalances

	| accountPataDeExtraccion accountPataDeDeposito |
	
	accountPataDeExtraccion := ReceptiveAccount new.
	accountPataDeDeposito := ReceptiveAccount new.
	
	Deposit register: 50 * peso on: accountPataDeExtraccion.
	
	Transfer register: 20 * peso from: accountPataDeExtraccion to: accountPataDeDeposito.
	
	self assert: 30 * peso equals: accountPataDeExtraccion balance.
	self assert: 20 * peso equals: accountPataDeDeposito balance.
! !

!TransferTest methodsFor: 'test' stamp: 'MdC 6/7/2022 13:26:04'!
test02

	| accountPataDeExtraccion accountPataDeDeposito transfer |
	
	accountPataDeExtraccion := ReceptiveAccount new.
	accountPataDeDeposito := ReceptiveAccount new.
	
	Deposit register: 50 * peso on: accountPataDeExtraccion.
	
	transfer := Transfer register: 20 * peso from: accountPataDeExtraccion to: accountPataDeDeposito.
	
	self assert: (20 * peso) equals: transfer value.
	! !

!TransferTest methodsFor: 'test' stamp: 'MdC 6/7/2022 13:26:14'!
test03

	| accountPataDeExtraccion accountPataDeDeposito transfer |
	
	accountPataDeExtraccion := ReceptiveAccount new.
	accountPataDeDeposito := ReceptiveAccount new.
	
	Deposit register: 50 * peso on: accountPataDeExtraccion.
	
	transfer := Transfer register: 20 * peso from: accountPataDeExtraccion to: accountPataDeDeposito.
	
	self assert: (accountPataDeExtraccion hasRegistered: (transfer pataDeExtraccion)).
	self assert: (accountPataDeDeposito hasRegistered: (transfer pataDeDeposito)).! !

!TransferTest methodsFor: 'test' stamp: 'MdC 6/7/2022 13:26:19'!
test04

	| accountPataDeExtraccion accountPataDeDeposito |
	
	accountPataDeExtraccion := ReceptiveAccount new.
	accountPataDeDeposito := ReceptiveAccount new.
	
	Deposit register: 60 * peso on: accountPataDeExtraccion.
	
	Transfer register: 30 * peso from: accountPataDeExtraccion to: accountPataDeDeposito.
	
	self assert: (accountPataDeExtraccion transactions size) equals: 2.
	self assert: (accountPataDeDeposito transactions size) equals: 1.
	! !

!TransferTest methodsFor: 'test' stamp: 'MdC 6/7/2022 13:26:26'!
test05

	| accountPataDeExtraccion accountPataDeDeposito transfer |
	
	accountPataDeExtraccion := ReceptiveAccount new.
	accountPataDeDeposito := ReceptiveAccount new.
	
	Deposit register: 50 * peso on: accountPataDeExtraccion.
	
	transfer := Transfer register: 20 * peso from: accountPataDeExtraccion to: accountPataDeDeposito.
	
	self assert: ((transfer pataDeExtraccion contraparte) = transfer pataDeDeposito).
	self assert: ((transfer pataDeDeposito contraparte) = transfer pataDeExtraccion).
	! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'MdC 6/2/2022 21:19:54'!
valueInBalance 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

!Deposit methodsFor: 'value' stamp: 'MdC 6/2/2022 21:19:38'!
valueInBalance

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferDeposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #TransferDeposit
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'MdC 6/5/2022 17:16:12'!
contraparte
	^ transfer pataDeExtraccion ! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'MdC 6/6/2022 20:00:19'!
initializeFrom: aTransfer

	transfer := aTransfer.! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'MdC 6/6/2022 19:58:49'!
value

	^ transfer value! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'MdC 6/6/2022 20:00:40'!
valueInBalance

	^ self value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: 'ServiciosFinancieros-Ejercicio'!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'as yet unclassified' stamp: 'MdC 6/6/2022 20:00:20'!
register: aValue on: account from: aTransfer

	| transaction |
	
	transaction := self new initializeFrom: aTransfer.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferWithdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #TransferWithdraw
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'MdC 6/5/2022 17:16:16'!
contraparte
	^ transfer pataDeDeposito ! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'MdC 6/6/2022 20:00:20'!
initializeFrom: aTransfer

	transfer := aTransfer.! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'MdC 6/6/2022 19:58:52'!
value

	^ transfer value! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'MdC 6/6/2022 20:00:36'!
valueInBalance

	^ self value negated! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: 'ServiciosFinancieros-Ejercicio'!
TransferWithdraw class
	instanceVariableNames: ''!

!TransferWithdraw class methodsFor: 'as yet unclassified' stamp: 'MdC 6/6/2022 20:00:20'!
register: aValue on: account from: aTransfer

	| transaction |
	
	transaction := self new initializeFrom: aTransfer.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

!Withdraw methodsFor: 'value' stamp: 'MdC 6/2/2022 21:19:48'!
valueInBalance

	^ value negated! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts padre'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'comparing' stamp: 'JM 6/7/2022 15:49:22'!
fatherIncludes: anAccount

	(1 to: padre size) do: [:index |
		((padre at: index) fatherIncludes: anAccount) ifTrue: [self error: self class existingAccountErrorDescription]].
		
	^self includes: anAccount.! !


!Portfolio methodsFor: 'adding' stamp: 'JM 6/7/2022 15:53:21'!
addFather: aFather

	padre add: aFather! !


!Portfolio methodsFor: 'initialization' stamp: 'JM 6/7/2022 15:35:10'!
initialize

	accounts := OrderedCollection new.
	
	padre _ OrderedCollection new.! !


!Portfolio methodsFor: 'accessing' stamp: 'JM 6/7/2022 15:16:23'!
accounts

	^accounts copy.! !

!Portfolio methodsFor: 'accessing' stamp: 'JM 6/7/2022 15:27:35'!
at: anIndex

	^accounts at: anIndex! !

!Portfolio methodsFor: 'accessing' stamp: 'JM 6/7/2022 15:38:48'!
padre

	^padre! !

!Portfolio methodsFor: 'accessing' stamp: 'JM 6/7/2022 15:27:11'!
size

	^accounts size! !


!Portfolio methodsFor: 'main protocol' stamp: 'JM 6/7/2022 16:20:34'!
add: anAccount
	
	((self accountAlreadyInPortfolio: anAccount) or: (self addsItself: anAccount)) ifTrue: [self error: self class existingAccountErrorDescription ]. "#1 #3"
	
	(self accountAlreadyInChildPortfolio: anAccount) ifTrue: [self error: self class existingAccountErrorDescription ]. "#2"
	
	(self case4: anAccount) ifTrue: [self error: self class existingAccountErrorDescription ]. "#4"
		
	(self case5: anAccount) ifTrue: [self error: self class existingAccountErrorDescription]. "#5"
	
	anAccount addFather: self.
	accounts add: anAccount.! !

!Portfolio methodsFor: 'main protocol' stamp: 'MdC 6/6/2022 20:27:43'!
balance 

	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'MdC 6/6/2022 20:59:29'!
hasRegistered: aTransaction

	^self transactions includes: aTransaction.! !

!Portfolio methodsFor: 'main protocol' stamp: 'MdC 6/6/2022 21:30:03'!
includes: anAccount
		
	(1 to: accounts size) do: [ :index | 
		((accounts at: index) includes: anAccount) ifTrue: [self error: self class existingAccountErrorDescription ]].
	
	(accounts includes: anAccount) ifTrue: [^true].
	
	^false! !

!Portfolio methodsFor: 'main protocol' stamp: 'MdC 6/6/2022 20:53:36'!
transactions

	|transactions|
	transactions := OrderedCollection new.
	
	"transactions add: (accounts first)."
	
	(1 to: accounts size) do: [ :index | transactions addAllLast: ((accounts at: index) transactions)].
	
	^transactions.! !


!Portfolio methodsFor: 'private add messages' stamp: 'JM 6/7/2022 16:00:01'!
accountAlreadyInChildPortfolio: anAccount
	
	| bool | 
	bool _ false.
	
	(1 to: accounts size) do: [ :index | 
		((accounts at: index) includes: anAccount) ifTrue: [bool _ true ]].
	
	^bool
	! !

!Portfolio methodsFor: 'private add messages' stamp: 'JM 6/7/2022 15:57:25'!
accountAlreadyInPortfolio: anAccount
	
	
	^accounts includes: anAccount.
	! !

!Portfolio methodsFor: 'private add messages' stamp: 'JM 6/7/2022 15:55:44'!
addsItself: anAccount

	^self = anAccount
	! !

!Portfolio methodsFor: 'private add messages' stamp: 'JM 6/7/2022 16:20:46'!
case4: anAccount

	"No puedo agregar una cuenta a un portfolio cuando este último ya es hijo de otro portfolio padre que tenía dicha cuenta."
	
	|bool |
	bool _ false.
	
	(1 to: padre size) do: [:index |
		((padre at: index) fatherIncludes: anAccount) ifTrue: [bool _ true ]].
		
	^bool! !

!Portfolio methodsFor: 'private add messages' stamp: 'JM 6/7/2022 16:20:20'!
case5: anAccount

	"No puedo agregar un portfolio a otro porfolio, si el primero incluye una cuenta que el segundo ya tiene."
	
	| bool |
	bool _ false.

	(1 to: accounts size) do: [:index |
		(1 to: anAccount size) do: [ :index2 | 
			((accounts at: index) = (anAccount at: index2)) ifTrue: [bool _ true]]].
	
	^bool
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error messages' stamp: 'MdC 6/6/2022 21:10:29'!
existingAccountErrorDescription

	^'account already in portfolio'! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'MdC 6/6/2022 21:21:14'!
includes: anAccount
	^false! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'JM 6/7/2022 15:28:00'!
at: anIndex

	^self.! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'MdC 6/2/2022 21:21:47'!
balance

	^transactions sum: [ :aTransaction | aTransaction valueInBalance ] ifEmpty: [ 0 ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'JM 6/7/2022 15:27:17'!
size

	^1! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'private - empty' stamp: 'JM 6/7/2022 15:50:00'!
addFather: aFather

! !

!ReceptiveAccount methodsFor: 'private - empty' stamp: 'JM 6/7/2022 15:50:38'!
fatherIncludes: aFather

	^false! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'value pataDeExtraccion pataDeDeposito'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transfer methodsFor: 'main protocol' stamp: 'MdC 6/5/2022 16:54:24'!
value

	^ value! !


!Transfer methodsFor: 'initialization' stamp: 'MdC 6/5/2022 17:17:25'!
initializeFor: aValue from: accountExtraccion to: accountDeposito

	value := aValue.
	pataDeExtraccion := TransferWithdraw register: aValue on: accountExtraccion from: self.
	pataDeDeposito := TransferDeposit register: aValue on: accountDeposito from: self.
! !


!Transfer methodsFor: 'getter' stamp: 'MdC 6/5/2022 17:17:32'!
pataDeDeposito

	^pataDeDeposito ! !

!Transfer methodsFor: 'getter' stamp: 'MdC 6/5/2022 17:17:30'!
pataDeExtraccion

	^pataDeExtraccion! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'MdC 6/5/2022 16:51:59'!
register: aValue from: accountExtraccion to: accountDeposito 

	| transaction |
	
	transaction := self new initializeFor: aValue from: accountExtraccion to: accountDeposito.
	^transaction.! !
