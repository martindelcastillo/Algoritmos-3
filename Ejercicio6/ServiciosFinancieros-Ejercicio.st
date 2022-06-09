!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'MdC 6/7/2022 16:39:21'!
test01test01BalanceOfPortfolioIsTheSameAsItAccount

	| account portfolio |
	
	account := ReceptiveAccount new.
	
	Deposit register: 50 * peso on: account.
	
	portfolio := Portfolio new.
	portfolio add: account.
	
	self assert: portfolio balance equals: 50 * peso! !

!PortfolioTest methodsFor: 'tests' stamp: 'MdC 6/7/2022 16:39:35'!
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

!PortfolioTest methodsFor: 'tests' stamp: 'MdC 6/7/2022 16:39:41'!
test03PortfolioTransactionsIsTheSameAsAccountTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
	
	portfolio := Portfolio new.
	portfolio add: account.
	
	
	self assert: 1 equals: (portfolio transactions) size.
	self assert: (account transactions includes: deposit).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'MdC 6/7/2022 16:39:46'!
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

!PortfolioTest methodsFor: 'tests' stamp: 'MdC 6/7/2022 16:39:55'!
test05PortfolioRegistersAccountTransactions

	| account portfolio deposit  |
	
	account := ReceptiveAccount new.

	deposit := Deposit register: 50 * peso on: account.
	
	portfolio := Portfolio new.
	portfolio add: account.
	
	self assert: (portfolio hasRegistered: deposit ).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'MdC 6/7/2022 16:40:02'!
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

!PortfolioTest methodsFor: 'tests' stamp: 'JM 6/9/2022 13:32:58'!
test07PortfolioCantAddAnAlreadyAddedAccount

	| account portfolio |
	
	account := ReceptiveAccount new.
	
	Deposit register: 50 * peso on: account.
	
	portfolio := Portfolio new.
	portfolio add: account.
	
	self 
	should: [portfolio add: account]
	raise: Error
	withExceptionDo: [ :anError | self assert: Portfolio case1ErrorDescription equals: anError messageText .
		self assert: portfolio balance equals: 50 * peso.
		].! !

!PortfolioTest methodsFor: 'tests' stamp: 'JM 6/9/2022 13:33:05'!
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
	withExceptionDo: [ :anError | self assert: Portfolio case2ErrorDescription equals: anError messageText .
		self assert: portfolio balance equals: 50 * peso.
		].! !

!PortfolioTest methodsFor: 'tests' stamp: 'JM 6/9/2022 13:33:11'!
test09PortfolioCantAddItself

    | account portfolio |

    account := ReceptiveAccount new.

    Deposit register: 50 * peso on: account.

    portfolio := Portfolio new.
    portfolio add: account.

    self 
    should: [portfolio add: portfolio]
    raise: Error
    withExceptionDo: [ :anError | self assert: Portfolio case3ErrorDescription equals: anError messageText .
        self assert: portfolio balance equals: 50 * peso.
        ].! !

!PortfolioTest methodsFor: 'tests' stamp: 'JM 6/9/2022 13:33:18'!
test10PortfolioChildCantAddAccountThatExistInFatherPortfolio

	| account portfolio1 portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 50 * peso on: account.
	
	portfolio1 := Portfolio new.
	
	portfolio := Portfolio new.
	portfolio add: account.
	portfolio add: portfolio1.
	
	self 
	should: [portfolio1 add: account]
	raise: Error
	withExceptionDo: [ :anError | self assert: Portfolio case4ErrorDescription equals: anError messageText .
		self assert: portfolio1 balance equals: 0 * peso.
		].
! !

!PortfolioTest methodsFor: 'tests' stamp: 'JM 6/9/2022 13:33:23'!
test11PortfolioCantAddChildPortfolioIfItIncludesSameAccount

	| account portfolio1 portfolio2 |
	
	account := ReceptiveAccount new.
	
	Deposit register: 50 * peso on: account.
	
	portfolio2 := Portfolio new.
	portfolio2 add: account.
	
	portfolio1 := Portfolio new.
	portfolio1 add: account.
		
	self 
	should: [portfolio1 add: portfolio2]
	raise: Error
	withExceptionDo: [ :anError | self assert: Portfolio case5ErrorDescription equals: anError messageText .
		self assert: portfolio1 balance equals: 50 * peso.
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

!TransferTest methodsFor: 'tests' stamp: 'MdC 6/7/2022 16:31:49'!
test01TransferAffectsBalanceOnTransactionValue

	| accountExtractionLeg accountDepositLeg |
	
	accountExtractionLeg := ReceptiveAccount new.
	accountDepositLeg := ReceptiveAccount new.
	
	Deposit register: 50 * peso on: accountExtractionLeg.
	
	Transfer register: 20 * peso from: accountExtractionLeg to: accountDepositLeg.
	
	self assert: 30 * peso equals: accountExtractionLeg balance.
	self assert: 20 * peso equals: accountDepositLeg balance.
! !

!TransferTest methodsFor: 'tests' stamp: 'JM 6/9/2022 13:37:22'!
test02TransferKnowsTransferedValue

	| accountExtractionLeg accountDepositLeg transfer |
	
	accountExtractionLeg := ReceptiveAccount new.
	accountDepositLeg := ReceptiveAccount new.
	
	Deposit register: 50 * peso on: accountExtractionLeg.
	
	transfer := Transfer register: 20 * peso from: accountExtractionLeg to: accountDepositLeg.
	
	self assert: (20 * peso) equals: transfer value.
	! !

!TransferTest methodsFor: 'tests' stamp: 'MdC 6/7/2022 16:33:06'!
test03AccountsKnowsItsCorrespondingTransaction

	| accountExtractionLeg accountDepositLeg transfer |
	
	accountExtractionLeg := ReceptiveAccount new.
	accountDepositLeg := ReceptiveAccount new.
	
	Deposit register: 50 * peso on: accountExtractionLeg.
	
	transfer := Transfer register: 20 * peso from: accountExtractionLeg to: accountDepositLeg.
	
	self assert: (accountExtractionLeg hasRegistered: (transfer extractionLeg)).
	self assert: (accountDepositLeg hasRegistered: (transfer depositLeg)).! !

!TransferTest methodsFor: 'tests' stamp: 'MdC 6/7/2022 16:32:21'!
test04AccountsOnlyKnowRegisteredTransactions

	| accountExtractionLeg accountDepositLeg |
	
	accountExtractionLeg := ReceptiveAccount new.
	accountDepositLeg := ReceptiveAccount new.
	
	Deposit register: 60 * peso on: accountExtractionLeg.
	
	Transfer register: 30 * peso from: accountExtractionLeg to: accountDepositLeg.
	
	self assert: (accountExtractionLeg transactions size) equals: 2.
	self assert: (accountDepositLeg transactions size) equals: 1.
	! !

!TransferTest methodsFor: 'tests' stamp: 'JM 6/9/2022 13:31:49'!
test05TransaccionLegsKnowsItsCounterpart

	| accountExtractionLeg accountDepositLeg transfer |
	
	accountExtractionLeg := ReceptiveAccount new.
	accountDepositLeg := ReceptiveAccount new.
	
	Deposit register: 50 * peso on: accountExtractionLeg.
	
	transfer := Transfer register: 20 * peso from: accountExtractionLeg to: accountDepositLeg.
	
	self assert: ((transfer extractionLeg counterpart) = transfer depositLeg).
	self assert: ((transfer depositLeg counterpart) = transfer extractionLeg).
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

!TransferDeposit methodsFor: 'initialization' stamp: 'MdC 6/6/2022 20:00:19'!
initializeFrom: aTransfer

	transfer := aTransfer.! !


!TransferDeposit methodsFor: 'value' stamp: 'MdC 6/6/2022 19:58:49'!
value

	^ transfer value! !

!TransferDeposit methodsFor: 'value' stamp: 'MdC 6/6/2022 20:00:40'!
valueInBalance

	^ self value! !


!TransferDeposit methodsFor: 'getter' stamp: 'JM 6/9/2022 13:31:49'!
counterpart
	^ transfer extractionLeg ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: 'ServiciosFinancieros-Ejercicio'!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'instance creation' stamp: 'MdC 6/6/2022 20:00:20'!
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

!TransferWithdraw methodsFor: 'initialization' stamp: 'MdC 6/6/2022 20:00:20'!
initializeFrom: aTransfer

	transfer := aTransfer.! !


!TransferWithdraw methodsFor: 'value' stamp: 'MdC 6/6/2022 19:58:52'!
value

	^ transfer value! !

!TransferWithdraw methodsFor: 'value' stamp: 'MdC 6/6/2022 20:00:36'!
valueInBalance

	^ self value negated! !


!TransferWithdraw methodsFor: 'getter' stamp: 'JM 6/9/2022 13:31:49'!
counterpart
	^ transfer depositLeg ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: 'ServiciosFinancieros-Ejercicio'!
TransferWithdraw class
	instanceVariableNames: ''!

!TransferWithdraw class methodsFor: 'instance creation' stamp: 'MdC 6/6/2022 20:00:20'!
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
	instanceVariableNames: 'accounts fatherAccounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'comparing' stamp: 'JM 6/9/2022 13:33:05'!
fatherIncludes: anAccount

	(1 to: fatherAccounts size) do: [ :index |
		((fatherAccounts at: index) fatherIncludes: anAccount)  ifTrue: [self error: self class case2ErrorDescription ]
		].
	
	^self includes: anAccount.! !


!Portfolio methodsFor: 'initialization' stamp: 'MdC 6/7/2022 15:34:46'!
initialize

	accounts := OrderedCollection new.
	fatherAccounts := OrderedCollection new.! !


!Portfolio methodsFor: 'accessing' stamp: 'MdC 6/7/2022 15:20:50'!
at: anIndex
	^accounts at: anIndex.! !

!Portfolio methodsFor: 'accessing' stamp: 'MdC 6/7/2022 15:24:02'!
size
	^accounts size! !


!Portfolio methodsFor: 'main protocol' stamp: 'MdC 6/7/2022 15:54:37'!
add: anAccount
	
	self canAddAccount: anAccount.
	
	accounts add: anAccount.
	anAccount addFather: self.! !

!Portfolio methodsFor: 'main protocol' stamp: 'MdC 6/6/2022 20:27:43'!
balance 

	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'MdC 6/6/2022 20:59:29'!
hasRegistered: aTransaction

	^self transactions includes: aTransaction.! !

!Portfolio methodsFor: 'main protocol' stamp: 'JM 6/9/2022 13:33:05'!
includes: anAccount
		
	(1 to: accounts size) do: [ :index | 
		((accounts at: index) includes: anAccount) ifTrue: [self error: self class case2ErrorDescription ]].
	
	(accounts includes: anAccount) ifTrue: [^true].
	
	^false! !

!Portfolio methodsFor: 'main protocol' stamp: 'MdC 6/7/2022 15:13:38'!
transactions

	|transactions|
	transactions := OrderedCollection new.
	
	(1 to: accounts size) do: [ :index | transactions addAllLast: ((accounts at: index) transactions)].
	
	^transactions.! !


!Portfolio methodsFor: 'private add messages' stamp: 'MdC 6/7/2022 16:48:18'!
accountAlreadyInChildPortfolio: anAccount
	
	(1 to: accounts size) do: [ :index | 
		((accounts at: index) includes: anAccount) ifTrue: [^true ]].
	
	^false
! !

!Portfolio methodsFor: 'private add messages' stamp: 'MdC 6/7/2022 16:55:48'!
accountAlreadyInFatherPortfolio: anAccount
		
	(1 to: fatherAccounts size) do: [:index |
		((fatherAccounts at: index) fatherIncludes: anAccount) ifTrue: [^true ]].
		
	^false
! !

!Portfolio methodsFor: 'private add messages' stamp: 'MdC 6/7/2022 16:47:39'!
accountAlreadyInPortfolio: anAccount
	
	
	^accounts includes: anAccount.! !

!Portfolio methodsFor: 'private add messages' stamp: 'MdC 6/7/2022 16:58:23'!
accountHasAccountAlreadyInSelf: anAccount

	(1 to: accounts size) do: [:index |
		(1 to: anAccount size) do: [ :index2 | 
			((accounts at: index) = (anAccount at: index2)) ifTrue: [^true]
			]
		].
	
	^false! !

!Portfolio methodsFor: 'private add messages' stamp: 'MdC 6/7/2022 15:36:04'!
addFather: aPortfolio
	fatherAccounts add: aPortfolio.! !

!Portfolio methodsFor: 'private add messages' stamp: 'JM 6/9/2022 13:33:23'!
canAddAccount: anAccount.

	(self accountAlreadyInPortfolio: anAccount) ifTrue: [self error: self class case1ErrorDescription ].
	
	(self accountAlreadyInChildPortfolio: anAccount) ifTrue: [self error: self class case2ErrorDescription ].
	
	(self portfolioIsSelf: anAccount) ifTrue: [self error: self class case3ErrorDescription ].
	
	(self accountAlreadyInFatherPortfolio: anAccount) ifTrue: [self error: self class case4ErrorDescription ].
		
	(self accountHasAccountAlreadyInSelf: anAccount) ifTrue: [self error: self class case5ErrorDescription ].
! !

!Portfolio methodsFor: 'private add messages' stamp: 'MdC 6/7/2022 16:51:46'!
portfolioIsSelf: anAccount

	^self = anAccount
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error handling' stamp: 'JM 6/9/2022 13:32:58'!
case1ErrorDescription

	^'account already in portfolio'! !

!Portfolio class methodsFor: 'error handling' stamp: 'JM 6/9/2022 13:33:05'!
case2ErrorDescription

	^'portfolio cant add account already included in an included porfolio'! !

!Portfolio class methodsFor: 'error handling' stamp: 'JM 6/9/2022 13:33:11'!
case3ErrorDescription

	^'porfolio cant add itself'! !

!Portfolio class methodsFor: 'error handling' stamp: 'JM 6/9/2022 13:33:17'!
case4ErrorDescription

	^'portfolio cant add account when it is already in a fathers portfolio'
	! !

!Portfolio class methodsFor: 'error handling' stamp: 'JM 6/9/2022 13:33:23'!
case5ErrorDescription

	^'portfolio cant add portfolio with account already included in first porfolio'! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


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

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'MdC 6/7/2022 15:19:12'!
size
	^1! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'private portfolio protocol' stamp: 'MdC 6/7/2022 15:49:43'!
addFather: aPortfolio
! !

!ReceptiveAccount methodsFor: 'private portfolio protocol' stamp: 'MdC 6/7/2022 15:27:55'!
at: anIndex
	^self! !

!ReceptiveAccount methodsFor: 'private portfolio protocol' stamp: 'MdC 6/7/2022 15:47:45'!
fatherIncludes: anAccount
	^false! !

!ReceptiveAccount methodsFor: 'private portfolio protocol' stamp: 'MdC 6/6/2022 21:21:14'!
includes: anAccount
	^false! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'value extractionLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transfer methodsFor: 'initialization' stamp: 'MdC 6/7/2022 16:41:50'!
initializeFor: aValue from: accountExtraccion to: accountDeposito

	value := aValue.
	extractionLeg := TransferWithdraw register: aValue on: accountExtraccion from: self.
	depositLeg := TransferDeposit register: aValue on: accountDeposito from: self.
! !


!Transfer methodsFor: 'getter' stamp: 'MdC 6/7/2022 16:41:43'!
depositLeg

	^depositLeg ! !

!Transfer methodsFor: 'getter' stamp: 'MdC 6/7/2022 16:41:50'!
extractionLeg

	^extractionLeg! !


!Transfer methodsFor: 'value' stamp: 'MdC 6/5/2022 16:54:24'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'MdC 6/5/2022 16:51:59'!
register: aValue from: accountExtraccion to: accountDeposito 

	| transaction |
	
	transaction := self new initializeFor: aValue from: accountExtraccion to: accountDeposito.
	^transaction.! !
