Class {
	#name : #AutomaticMethodCategorizerTest,
	#superclass : #TestCase,
	#instVars : [
		'categorizationRules'
	],
	#category : #'MethodCategorizer-Tests'
}

{ #category : #'test support' }
AutomaticMethodCategorizerTest >> assertCategorizationOfAllMethodsWith: anAutomaticMethodCategorizer [ 
	| mockClassOrganization |
	mockClassOrganization := self mockClass organization.
	mockClassOrganization 
		classify: #selectorForTesting
		under: 'any'.
	self assert: (mockClassOrganization categoryOfElement: #selectorForTesting) = 'any'.
	anAutomaticMethodCategorizer categorizeAllMethodsOf: self mockClass.
	self assert: (mockClassOrganization categoryOfElement: #selectorForTesting) = self protocolForTesting
]

{ #category : #'test support' }
AutomaticMethodCategorizerTest >> categorizationRules [
	
	^categorizationRules
]

{ #category : #'test support' }
AutomaticMethodCategorizerTest >> globalWithTestingRules [

	^'AutoMethodCatTestGlobal'
]

{ #category : #'test support' }
AutomaticMethodCategorizerTest >> mockClass [

	^AMCMockClass
]

{ #category : #'test support' }
AutomaticMethodCategorizerTest >> protocolForTesting [

	^#'categorizer test'
]

{ #category : #running }
AutomaticMethodCategorizerTest >> setUp [

	Smalltalk globals at: self globalWithTestingRules asSymbol put: self.
	self mockClass uncategorizeAllMethods.
	self setUpCategorizationRules
]

{ #category : #running }
AutomaticMethodCategorizerTest >> setUpCategorizationRules [

	categorizationRules := OrderedCollection new
		add: (MethodCategorizationRule whenSelectorMatches: #selectorForTesting asString categorizeIn: self protocolForTesting);
		add: (MethodCategorizationRule whenSelectorMatches: #otherSelectorForTesting asString categorizeIn: self protocolForTesting);
		yourself
]

{ #category : #running }
AutomaticMethodCategorizerTest >> tearDown [

	Smalltalk globals removeKey: self globalWithTestingRules asSymbol
]

{ #category : #tests }
AutomaticMethodCategorizerTest >> testCategorizationRuleFor [
	"Get a categorization rule for a given method definition"

	| returnedCategorizationRule methodCategorizer |
	methodCategorizer := AutomaticMethodCategorizer usingRules: categorizationRules.
	returnedCategorizationRule := methodCategorizer categorizationRuleFor: (RGMethodDefinition class: self mockClass selector: #selectorForTesting).
	self assert: categorizationRules first = returnedCategorizationRule.	
	returnedCategorizationRule := methodCategorizer categorizationRuleFor: (RGMethodDefinition class: self mockClass selector: #otherSelectorForTesting).
	self assert: (categorizationRules at: 2) = returnedCategorizationRule.
	returnedCategorizationRule := methodCategorizer categorizationRuleFor: (RGMethodDefinition class: self mockClass selector: #printString).
	self assert: returnedCategorizationRule = NullMethodCategorizationRule new

]

{ #category : #tests }
AutomaticMethodCategorizerTest >> testCategorizeAll [
	"Categorize all methods (including those already categorized) - DF"
	self assertCategorizationOfAllMethodsWith: (AutomaticMethodCategorizer usingRules: categorizationRules)
]

{ #category : #'tests for system extensions' }
AutomaticMethodCategorizerTest >> testHasProtocolFor [

	| mockClassOrganization |
	mockClassOrganization := self mockClass organization.
	mockClassOrganization classify: #otherSelectorForTesting under: 'any'.

	self assert: (mockClassOrganization hasProtocolFor: #otherSelectorForTesting).
	self deny: (mockClassOrganization hasProtocolFor: #NOtclaisiisifyuiiedMethodSelector).
	
	"verifies that we if classified in unclassified we get the unclassified classification."
	mockClassOrganization classify: #otherSelectorForTesting under: Protocol unclassified.
	self deny: (mockClassOrganization hasProtocolFor: #otherSelectorForTesting)
]

{ #category : #'tests for system extensions' }
AutomaticMethodCategorizerTest >> testProtocolsFor [

	| mockClassOrganization |
	mockClassOrganization := self mockClass organization.
	mockClassOrganization classify: #otherSelectorForTesting under: 'any'.
	
	self assert: (mockClassOrganization protocolsOfSelector: #otherSelectorForTesting) first name equals: #any.
	self assert: (mockClassOrganization protocolsOfSelector: #NOtclaisiisifyuiiedMethodSelector) isEmpty.

	"verifies that we if classified in unclassified we get the unclassified classification."
	self assert: (mockClassOrganization protocolsOfSelector: #otherSelectorForTesting) first name equals: #any.
	mockClassOrganization classify: #otherSelectorForTesting under: Protocol unclassified.
	self assert: (mockClassOrganization protocolsOfSelector: #otherSelectorForTesting) first name equals: Protocol unclassified.
]
