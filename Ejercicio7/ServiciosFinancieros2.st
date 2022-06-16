!classDefinition: #AccountSummaryTest category: 'ServiciosFinancieros2'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!AccountSummaryTest methodsFor: 'test' stamp: 'JM 6/14/2022 17:01:41'!
test01emptyAccountHas0BalanceInAccountSummary

	| account collection |

	account _ ReceptiveAccount new.
	
	collection _ OrderedCollection new.
	collection add: 'Balance = 0 * pesos'.
	
	self assert: collection equals: (account makeReport: AccountSummary).! !

!AccountSummaryTest methodsFor: 'test' stamp: 'JM 6/14/2022 17:01:32'!
test02DepositModifiesAccountSummary

	| account collection |

	account _ ReceptiveAccount new.
	
	Deposit register: 100 * peso on: account.
	collection _ OrderedCollection new.
	collection add: 'Depósito por 100 * pesos'.
	collection add: 'Balance = 100 * pesos'.
	
	self assert: collection equals: (account makeReport: AccountSummary).! !

!AccountSummaryTest methodsFor: 'test' stamp: 'JM 6/14/2022 17:01:27'!
test03WithdrawModifiesAccountSummary

	| account collection |

	account _ ReceptiveAccount new.
	
	Withdraw register: 100 * peso on: account.
	collection _ OrderedCollection new.
	collection add: 'Extracción por 100 * pesos'.
	collection add: 'Balance = -100 * pesos'.
	
	self assert: collection equals: (account makeReport: AccountSummary).! !

!AccountSummaryTest methodsFor: 'test' stamp: 'JM 6/14/2022 17:01:16'!
test04TransferWithdrawModifiesAccountSummary

	| account collection otherAccount|

	account _ ReceptiveAccount new.
	otherAccount _ ReceptiveAccount new.
	
	Transfer amount: 20 * peso from: account to: otherAccount.
	
	collection _ OrderedCollection new.
	collection add: 'Salida por transferencia de 20 * pesos'.
	collection add: 'Balance = -20 * pesos'.
	
	self assert: collection equals: (account makeReport: AccountSummary).! !

!AccountSummaryTest methodsFor: 'test' stamp: 'JM 6/14/2022 17:01:58'!
test05TransferDepositModifiesAccountSummary

	| account collection otherAccount|

	account _ ReceptiveAccount new.
	otherAccount _ ReceptiveAccount new.
	
	Transfer amount: 30 * peso from: otherAccount to: account.
	
	collection _ OrderedCollection new.
	collection add: 'Entrada por transferencia de 30 * pesos'.
	collection add: 'Balance = 30 * pesos'.
	
	self assert: collection equals: (account makeReport: AccountSummary).! !

!AccountSummaryTest methodsFor: 'test' stamp: 'JM 6/14/2022 17:02:45'!
test06AccountSummaryWorksWithAnyTransactionOrTransfer

	| account collection otherAccount|

	account _ ReceptiveAccount new.
	otherAccount _ ReceptiveAccount new.
	
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account. 
	Transfer amount: 20 * peso from: account to: otherAccount.
	Transfer amount: 30 * peso from: otherAccount to: account.
	
	collection _ OrderedCollection new.
	collection add: 'Depósito por 100 * pesos'.
	collection add: 'Extracción por 50 * pesos'.
	collection add: 'Salida por transferencia de 20 * pesos'.
	collection add: 'Entrada por transferencia de 30 * pesos'.
	collection add: 'Balance = 60 * pesos'.

	
	self assert: collection equals: (account makeReport: AccountSummary).! !


!classDefinition: #PortfolioTest category: 'ServiciosFinancieros2'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:00'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:06'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:12'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100 * peso))! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:18'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:26'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:08'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 * peso on: account.
	anotherAccountWithdraw := Withdraw register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 11/29/2021 18:55:37'!
test12PortfolioCanNotIncludeItself

	| simplePortfolio |
	
	simplePortfolio := Portfolio new.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 0 equals: simplePortfolio accountsSize. ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros2'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

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


!classDefinition: #SpecialReportsTest category: 'ServiciosFinancieros2'!
TestCase subclass: #SpecialReportsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!SpecialReportsTest methodsFor: 'test' stamp: 'JM 6/14/2022 16:53:12'!
test01EmptyPortfolioReturnItsName

	| familyPortfolio collection|
	
	familyPortfolio _ Portfolio named: 'Portfolio de la familia'.
	
	collection _ OrderedCollection with: 'Portfolio de la familia'.
	
	self assert: collection equals: (familyPortfolio makeReport: PortfolioTreePrinter).
	
	! !

!SpecialReportsTest methodsFor: 'test' stamp: 'JM 6/14/2022 16:53:34'!
test02PortfolioWithAccountReturnsBothNames

	| familyPortfolio collection johnsAccount|
	
	johnsAccount _ ReceptiveAccount named: 'Cuenta de Juan'. 
	familyPortfolio _ Portfolio named: 'Portfolio de la familia' with: johnsAccount.
	
	collection _ OrderedCollection with: 'Portfolio de la familia'.
	collection add: 'Cuenta de Juan'.
	
	self assert: collection equals: (familyPortfolio makeReport: PortfolioTreePrinter).
	
	! !

!SpecialReportsTest methodsFor: 'test' stamp: 'JM 6/14/2022 16:53:54'!
test03PortfolioWithPortfolioReturnsAllNames

	| familyPortfolio collection johnsAccount childrenPortfolio|
	
	johnsAccount _ ReceptiveAccount named: 'Cuenta de Juan'. 
	childrenPortfolio _ Portfolio named: 'Portfolio de hijos' with: johnsAccount.
	familyPortfolio _ Portfolio named: 'Portfolio de la familia' with: childrenPortfolio.
	
	collection _ OrderedCollection with: 'Portfolio de la familia'.
	collection add: 'Portfolio de hijos'.
	collection add: 'Cuenta de Juan'.
	
	self assert: collection equals: (familyPortfolio makeReport: PortfolioTreePrinter).
	
	! !

!SpecialReportsTest methodsFor: 'test' stamp: 'JM 6/14/2022 16:54:10'!
test04EmptyPortfolioReturnsItsNameAnd0Balance

	| familyPortfolio collection |
	
	familyPortfolio _ Portfolio named: 'Portfolio de la familia'.
	
	collection _ OrderedCollection with: 'Portfolio de la familia'.
	collection add: 'Balance = 0 * pesos'.
	
	self assert: collection equals: (familyPortfolio makeReport: PortfolioDetailedTreePrinter).
	
	! !

!SpecialReportsTest methodsFor: 'test' stamp: 'JM 6/16/2022 14:17:54'!
test05PortfolioWithReceptiveAccountReturnsCorrectDetailedTreePrinter

	| myAccount familyPortfolio collection |
	
	myAccount _ ReceptiveAccount named: 'Cuenta mia'. 
	familyPortfolio _ Portfolio named: 'Portfolio de la familia' with: myAccount.
	
	collection _ OrderedCollection new.
	collection add: 'Portfolio de la familia'.
	collection add: 'Cuenta mia'.
	collection add: 'Balance = 0 * pesos'.
	collection add: 'Balance = 0 * pesos'.
	
	self assert: collection equals: (familyPortfolio makeReport: PortfolioDetailedTreePrinter).
	
	! !

!SpecialReportsTest methodsFor: 'test' stamp: 'JM 6/16/2022 14:18:21'!
test06PortfolioWithPortfolioReturnsCorrectDetailedTreePrinter

	| familyPortfolio collection cuentaMia children|
	
	cuentaMia _ ReceptiveAccount named: 'Cuenta Mia'.
	Deposit register: 100 * peso on: cuentaMia.
	Withdraw register: 80 * peso on: cuentaMia.
	children _ Portfolio named: 'Portfolio de hijos' with: cuentaMia.
	familyPortfolio _ Portfolio named: 'Portfolio de la familia' with: children.
	
	
	collection _ OrderedCollection with: 'Portfolio de la familia'.
	collection add: 'Portfolio de hijos'.
	collection add: 'Cuenta Mia'.
	collection add: 'Depósito por 100 * pesos'.
	collection add: 'Extracción por 80 * pesos'..
	collection add: 'Balance = 20 * pesos'.
	collection add: 'Balance = 20 * pesos'.
	collection add: 'Balance = 20 * pesos'.
	
	self assert: collection equals: (familyPortfolio makeReport: PortfolioDetailedTreePrinter).
	
	! !

!SpecialReportsTest methodsFor: 'test' stamp: 'JM 6/16/2022 14:18:17'!
test07DetailedTreePrinterWorkswithAPortfolioWithAccountsAndFilledPortfolios

	| familyPortfolio collection cuentaMia children other cuentaAngeles cuentaJuan |
	
	other _ ReceptiveAccount new.
	cuentaMia _ ReceptiveAccount named: 'Cuenta Mia'.
	Deposit register: 100 * peso on: cuentaMia.
	Withdraw register: 80 * peso on: cuentaMia.
	
	cuentaJuan _ ReceptiveAccount named: 'Cuenta de Juan'.
	Deposit register: 100 * peso on: cuentaJuan.
	Withdraw register: 60 * peso on: cuentaJuan.
	cuentaAngeles _ ReceptiveAccount named: 'Cuenta de Angeles'.
	Transfer amount: 20 * peso from: cuentaAngeles  to: other.
	
	children _ Portfolio named: 'Portfolio de hijos' with: cuentaJuan with: cuentaAngeles.
	familyPortfolio _ Portfolio named: 'Portfolio de la familia' with: cuentaMia with: children.
	
	
	collection _ OrderedCollection with: 'Portfolio de la familia'.
	collection add: 'Cuenta Mia'.
	collection add: 'Depósito por 100 * pesos'.
	collection add: 'Extracción por 80 * pesos'.
	collection add: 'Balance = 20 * pesos'.
	collection add: 'Portfolio de hijos'.
	collection add: 'Cuenta de Juan'.
	collection add: 'Depósito por 100 * pesos'.
	collection add: 'Extracción por 60 * pesos'.
	collection add: 'Balance = 40 * pesos'.
	collection add: 'Cuenta de Angeles'.
	collection add: 'Salida por transferencia de 20 * pesos'.
	collection add: 'Balance = -20 * pesos'.
	collection add: 'Balance = 20 * pesos'.
	collection add: 'Balance = 40 * pesos'.
	
	
	self assert: collection equals: (familyPortfolio makeReport: PortfolioDetailedTreePrinter).
	
	! !


!classDefinition: #TransferNetTest category: 'ServiciosFinancieros2'!
TestCase subclass: #TransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!TransferNetTest methodsFor: 'test' stamp: 'JM 6/16/2022 14:20:46'!
test01TransferNetReportWithEmptyAccountReturns0

	| account |

	account _ ReceptiveAccount new.
		
	self assert: (0 * peso) equals: (account makeReport: TransferNet).! !

!TransferNetTest methodsFor: 'test' stamp: 'JM 6/16/2022 14:20:41'!
test02TransferNetReportWithATransferDepositReturnsPositiveMoney

	| account accountAuxiliary |

	account _ ReceptiveAccount new.
	accountAuxiliary _ ReceptiveAccount new.
	
	Transfer amount: 30 * peso from: accountAuxiliary to: account.
		
	self assert: (30 * peso) equals: (account makeReport: TransferNet).! !

!TransferNetTest methodsFor: 'test' stamp: 'JM 6/16/2022 14:21:03'!
test03ReportWithTransferWithdrawReturnsNegativeMoney

	| account accountAuxiliary |

	account _ ReceptiveAccount new.
	accountAuxiliary _ ReceptiveAccount new.
	
	Transfer amount: 30 * peso from: account to: accountAuxiliary.
		
	self assert: (-30 * peso) equals: (account makeReport: TransferNet).! !

!TransferNetTest methodsFor: 'test' stamp: 'JM 6/16/2022 14:21:38'!
test04ReportToAccountWithBothTypesOfTransferWorksCorrectly

	| account accountAuxiliary |

	account _ ReceptiveAccount new.
	accountAuxiliary _ ReceptiveAccount new.
	
	Transfer amount: 40 * peso from: accountAuxiliary to: account.
	Transfer amount: 30 * peso from: account to: accountAuxiliary.
		
	self assert: (10 * peso) equals: (account makeReport: TransferNet).! !

!TransferNetTest methodsFor: 'test' stamp: 'JM 6/16/2022 14:22:05'!
test05ReportWithDifferentTransactionsAndTransferWorksAsIntended

	| account accountAuxiliary |

	account _ ReceptiveAccount new.
	accountAuxiliary _ ReceptiveAccount new.
	
	Deposit register: 1000 * peso on: account.
	Withdraw register: 100 * peso on: account.
	Transfer amount: 40 * peso from: accountAuxiliary to: account.
	Transfer amount: 30 * peso from: account to: accountAuxiliary.
		
	self assert: (10 * peso) equals: (account makeReport: TransferNet).! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros2'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!TransferTest methodsFor: 'testing' stamp: 'LL 9/20/2020 21:07:03'!
test01ATransferDecreasesBalanceFromOriginAccountAndIncreasesItForDestinationAccount

	| destinationAccount originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 8 * peso equals: originAccount balance.
	self assert: 12 * peso equals: destinationAccount balance.! !

!TransferTest methodsFor: 'testing' stamp: 'LL 9/20/2020 21:12:28'!
test02ATransferKnowsItsValue

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 2 * peso equals: transfer value.! !

!TransferTest methodsFor: 'testing' stamp: 'LL 9/20/2020 23:01:44'!
test03DepositLegKnowsItsWithdrawCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer withdrawLeg equals: transfer depositLeg withdrawLeg! !

!TransferTest methodsFor: 'testing' stamp: 'LL 9/20/2020 23:01:51'!
test04WithdrawLegKnowsItsDepositCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer depositLeg equals: transfer withdrawLeg depositLeg! !

!TransferTest methodsFor: 'testing' stamp: 'LL 9/20/2020 23:02:36'!
test05OriginAndDestinationAccountsCannotBeTheSame

	| originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	self should: [ Transfer amount: 2 * peso from: originAccount to: originAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferToOriginErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !

!TransferTest methodsFor: 'testing' stamp: 'LL 9/20/2020 23:02:44'!
test06CannotTransferAZeroAmount

	| originAccount destinationAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 5 * peso on: destinationAccount.
	
	self should: [ Transfer amount: 0 from: originAccount to: destinationAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferZeroErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !


!classDefinition: #Account category: 'ServiciosFinancieros2'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:45:50'!
addedTo: aPortfolio

	self subclassResponsibility! !

!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:46:48'!
isComposedBy: anAccount

	self subclassResponsibility! !


!Account methodsFor: 'private' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !


!Account methodsFor: 'report' stamp: 'MdC 6/13/2022 20:07:16'!
makeReport: aReport
	
	^(aReport initializeWith: self) report.! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros2'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents name account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'JM 6/14/2022 15:13:51'!
initializeWithName: aName 
	
	name _ aName.
	self initialize.! !


!Portfolio methodsFor: 'main protocol' stamp: 'JM 6/14/2022 15:44:33'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 * peso ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !


!Portfolio methodsFor: 'private' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'accessing' stamp: 'JM 6/14/2022 15:06:40'!
accounts

	^accounts! !

!Portfolio methodsFor: 'accessing' stamp: 'JM 6/14/2022 14:58:04'!
name

	^name! !


!Portfolio methodsFor: 'report' stamp: 'JM 6/14/2022 15:19:38'!
report: aReport

	aReport reportPortfolio: self.

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros2'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'initialization' stamp: 'JM 6/14/2022 15:09:14'!
named: aName

	^self new initializeWithName: aName! !

!Portfolio class methodsFor: 'initialization' stamp: 'JM 6/14/2022 15:14:53'!
named: aName with: anAccount

	^self new initializeWithName: aName; add: anAccount; yourself.! !

!Portfolio class methodsFor: 'initialization' stamp: 'JM 6/14/2022 16:06:37'!
named: aName with: anAccount with: anAccount2

	^self new initializeWithName: aName; add: anAccount; add: anAccount2; yourself.! !

!Portfolio class methodsFor: 'initialization' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'initialization' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!Portfolio class methodsFor: 'error handling' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros2'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'JM 6/14/2022 15:10:28'!
initializeWithName: aName

	name _ aName.
! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'MdC 6/13/2022 21:34:29'!
balance

	^transactions 
		inject: 0 * peso
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'private' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !


!ReceptiveAccount methodsFor: 'accessing' stamp: 'JM 6/14/2022 16:24:44'!
accounts

! !

!ReceptiveAccount methodsFor: 'accessing' stamp: 'JM 6/14/2022 14:58:11'!
name

	^name! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'report' stamp: 'JM 6/14/2022 15:19:51'!
report: aReport

	aReport reportReceptiveAccount: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'ServiciosFinancieros2'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'initialization' stamp: 'JM 6/14/2022 15:11:50'!
named: aName

	^self new initializeWithName: aName! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros2'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'report' stamp: 'MdC 6/13/2022 20:47:48'!
report: aReport

	self subclassResponsibility ! !


!classDefinition: #Deposit category: 'ServiciosFinancieros2'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'report' stamp: 'MdC 6/13/2022 20:36:37'!
report: aReport
	
	^aReport manageDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros2'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !

!Deposit class methodsFor: 'instance creation' stamp: 'LL 7/8/2021 21:45:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferLeg category: 'ServiciosFinancieros2'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!TransferLeg methodsFor: 'value' stamp: 'LL 9/20/2020 22:27:32'!
value

	^transfer value! !


!TransferLeg methodsFor: 'initialization' stamp: 'LL 9/20/2020 22:28:14'!
initializeWith: aTransfer

	transfer := aTransfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'ServiciosFinancieros2'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'instance creation' stamp: 'LL 9/20/2020 22:45:01'!
of: aTransfer on: anAccount

	| transaction |
	
	transaction := self new initializeWith: 	aTransfer.
	anAccount register: transaction.	
	
	^transaction! !


!classDefinition: #TransferDepositLeg category: 'ServiciosFinancieros2'!
TransferLeg subclass: #TransferDepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!TransferDepositLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:26:10'!
withdrawLeg

	^transfer withdrawLeg! !


!TransferDepositLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:49'!
affectBalance: aBalance

	^aBalance + self value! !


!TransferDepositLeg methodsFor: 'report' stamp: 'MdC 6/13/2022 20:38:03'!
report: aReport
	
	^aReport manageTransferDepositLeg: self.! !


!classDefinition: #TransferWithdrawLeg category: 'ServiciosFinancieros2'!
TransferLeg subclass: #TransferWithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!TransferWithdrawLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:25:47'!
depositLeg

	^transfer depositLeg! !


!TransferWithdrawLeg methodsFor: 'balance' stamp: 'JM 6/14/2022 16:46:40'!
affectBalance: aBalance

	^aBalance - (self value)! !


!TransferWithdrawLeg methodsFor: 'report' stamp: 'MdC 6/13/2022 20:38:17'!
report: aReport
	
	^aReport manageTransferWithdrawLeg: self.! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros2'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'report' stamp: 'MdC 6/13/2022 20:37:40'!
report: aReport
	
	^aReport manageWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros2'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !

!Withdraw class methodsFor: 'instance creation' stamp: 'LL 7/8/2021 21:45:05'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Report category: 'ServiciosFinancieros2'!
Object subclass: #Report
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!Report methodsFor: 'main protocol' stamp: 'MdC 6/13/2022 20:13:37'!
report

	self subclassResponsibility ! !


!Report methodsFor: 'initialization' stamp: 'MdC 6/13/2022 20:21:21'!
initializeWith: anAccount

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: 'ServiciosFinancieros2'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'instance creation' stamp: 'MdC 6/13/2022 20:16:50'!
initializeWith: anAccount

	^self new initializeWith: anAccount.! !


!classDefinition: #AccountSummary category: 'ServiciosFinancieros2'!
Report subclass: #AccountSummary
	instanceVariableNames: 'summaryCollection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!AccountSummary methodsFor: 'main protocol' stamp: 'MdC 6/13/2022 20:23:42'!
report
		
	account transactions do: [ :aTransaction | summaryCollection add: (aTransaction report: self) ].
	
	summaryCollection add: ('Balance = ' append: ((account balance) asString)).
	
	^summaryCollection.! !


!AccountSummary methodsFor: 'transaction manager' stamp: 'MdC 6/13/2022 20:29:28'!
manageDeposit: aDeposit

	^'Depósito por ' append: (aDeposit value) asString.! !

!AccountSummary methodsFor: 'transaction manager' stamp: 'MdC 6/13/2022 20:40:21'!
manageTransferDepositLeg: aTransferDepositLeg
	
	^'Entrada por transferencia de ' append: (aTransferDepositLeg value) asString.! !

!AccountSummary methodsFor: 'transaction manager' stamp: 'MdC 6/13/2022 20:40:04'!
manageTransferWithdrawLeg: aTransferWithdrawLeg

	^'Salida por transferencia de ' append: (aTransferWithdrawLeg value) asString.! !

!AccountSummary methodsFor: 'transaction manager' stamp: 'MdC 6/13/2022 20:39:42'!
manageWithdraw: aWithdraw

	^'Extracción por ' append: (aWithdraw value) asString.! !


!AccountSummary methodsFor: 'initialization' stamp: 'MdC 6/13/2022 20:20:14'!
initializeWith: anAccount

	account _ anAccount.
	summaryCollection _ OrderedCollection new.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'ServiciosFinancieros2'!
AccountSummary class
	instanceVariableNames: 'account'!


!classDefinition: #PortfolioDetailedTreePrinter category: 'ServiciosFinancieros2'!
Report subclass: #PortfolioDetailedTreePrinter
	instanceVariableNames: 'collection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!PortfolioDetailedTreePrinter methodsFor: 'main protocol' stamp: 'JM 6/14/2022 16:40:08'!
report

	collection add: account name.
	
	account accounts do: [:anAccount | 
		anAccount report: self].
	
	collection add: ('Balance = ' append: (account balance) asString).
	

	^collection.! !


!PortfolioDetailedTreePrinter methodsFor: 'transaction manager' stamp: 'JM 6/14/2022 16:49:33'!
reportPortfolio: aPortfolio

	collection add: aPortfolio name.
	
	aPortfolio accounts do: [: anAccount | (anAccount report: self)].
	
	collection add: ('Balance = ' append: (aPortfolio balance) asString).! !

!PortfolioDetailedTreePrinter methodsFor: 'transaction manager' stamp: 'JM 6/14/2022 16:43:58'!
reportReceptiveAccount: anAccount

	collection add: (anAccount name).
	
	collection addAllLast: (anAccount makeReport: AccountSummary).! !


!PortfolioDetailedTreePrinter methodsFor: 'initialization' stamp: 'JM 6/14/2022 15:35:49'!
initializeWith: anAccount

	account _ anAccount.
	collection _ OrderedCollection new.
! !


!classDefinition: #PortfolioTreePrinter category: 'ServiciosFinancieros2'!
Report subclass: #PortfolioTreePrinter
	instanceVariableNames: 'collection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!PortfolioTreePrinter methodsFor: 'main protocol' stamp: 'JM 6/14/2022 16:24:58'!
report
	
	collection add: account name.

	(account isKindOf: Portfolio) ifTrue:  [account accounts do: [:anAccount | anAccount report: self]].
	
	^collection! !


!PortfolioTreePrinter methodsFor: 'transaction manager' stamp: 'JM 6/14/2022 15:26:07'!
reportPortfolio: aPortfolio

	collection add: aPortfolio name.

	aPortfolio accounts do: [:anAccount | collection add: anAccount name].! !

!PortfolioTreePrinter methodsFor: 'transaction manager' stamp: 'JM 6/14/2022 15:24:45'!
reportReceptiveAccount: aReceptiveAccount

	collection add: (aReceptiveAccount name).! !


!PortfolioTreePrinter methodsFor: 'initialization' stamp: 'JM 6/14/2022 15:24:05'!
initializeWith: anAccount
	collection _ OrderedCollection new.
	account _ anAccount.

! !


!classDefinition: #TransferNet category: 'ServiciosFinancieros2'!
Report subclass: #TransferNet
	instanceVariableNames: 'transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!TransferNet methodsFor: 'main protocol' stamp: 'MdC 6/13/2022 20:46:52'!
report
	
	account transactions do: [ :aTransaction | transferNet _ transferNet + (aTransaction report: self) ].
		
	^transferNet.! !


!TransferNet methodsFor: 'transaction manager' stamp: 'MdC 6/13/2022 20:43:05'!
manageDeposit: aDeposit

	^0 * peso.! !

!TransferNet methodsFor: 'transaction manager' stamp: 'MdC 6/13/2022 20:43:26'!
manageTransferDepositLeg: aTransferDepositLeg
	
	^aTransferDepositLeg value.! !

!TransferNet methodsFor: 'transaction manager' stamp: 'MdC 6/13/2022 20:45:02'!
manageTransferWithdrawLeg: aTransferWithdrawLeg

	^aTransferWithdrawLeg value negated! !

!TransferNet methodsFor: 'transaction manager' stamp: 'MdC 6/13/2022 20:43:58'!
manageWithdraw: aWithdraw

	^0 * peso.! !


!TransferNet methodsFor: 'initialization' stamp: 'MdC 6/13/2022 20:20:57'!
initializeWith: anAccount

	account _ anAccount.
	transferNet _ 0 * peso.! !


!classDefinition: #Transfer category: 'ServiciosFinancieros2'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!Transfer methodsFor: 'value' stamp: 'LL 9/20/2020 21:13:00'!
value

	^value! !


!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:39:46'!
depositLeg

	^depositLeg! !

!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 21:25:56'!
withdrawLeg
	
	^withdrawLeg! !


!Transfer methodsFor: 'initialization' stamp: 'LL 9/20/2020 21:25:21'!
initializeWith: aValue withdrawLeg: aWithdraw depositLeg: aDeposit

	value := aValue.
	withdrawLeg := aWithdraw.
	depositLeg := aDeposit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros2'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:57:30'!
cannotTransferToOriginErrorDescription
	
	^'Transfer destionation cannot be the origin account'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:00:53'!
cannotTransferZeroErrorDescription

	^'Transfer amount should be positive'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:56:35'!
signalCannotTransferToOrigin
	
	self error: self cannotTransferToOriginErrorDescription! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:06:17'!
signalCannotTransferZero

	self error: self cannotTransferZeroErrorDescription! !


!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:05:22'!
assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount

	self assertCanTransferTo: destinationAccount from: originAccount.
	self assertCanTransfer: anAmountOfMoney! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:11:50'!
assertCanTransfer: anAmountOfMoney

	^ anAmountOfMoney isZero ifTrue: [ self signalCannotTransferZero ]! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:04:58'!
assertCanTransferTo: destinationAccount from: originAccount

	^ originAccount = destinationAccount ifTrue: [ self signalCannotTransferToOrigin ]! !


!Transfer class methodsFor: 'instance creation' stamp: 'LL 9/20/2020 23:11:34'!
amount: anAmountOfMoney from: originAccount to: destinationAccount 
	
	| transfer depositLeg withdrawLeg |
	
	self assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount.
	
	transfer := self new.
	
	withdrawLeg := TransferWithdrawLeg of: transfer on: originAccount.
	depositLeg := TransferDepositLeg of: transfer on: destinationAccount.
	
	^transfer initializeWith: anAmountOfMoney withdrawLeg: withdrawLeg depositLeg: depositLeg
	
	
	! !
