"
A dummy class to check that the selector is well categorized based on superclass
"
Class {
	#name : #AMCMockParentClass,
	#superclass : #Object,
	#category : #'MethodCategorizer-Tests'
}

{ #category : #'test setup' }
AMCMockParentClass class >> applySelectorMap: aMap [
	
	aMap do: [ :each  | 
			(self includesSelector: each first)
				ifTrue: [ self organization classify: each first under: each second suppressIfDefault: true ] ]
]

{ #category : #'test setup' }
AMCMockParentClass class >> categorizeAllMethods [
	"Categorized all methods to be used in test setup"
	"self categorizeAllMethods"
	
	self applySelectorMap: self categorizedSelectorProtocolMaps 
]

{ #category : #'test setup' }
AMCMockParentClass class >> categorizedSelectorProtocolMaps [
	"Returns pairs selector -> category, that the class should have when the class is decategorized (typically for running tests)"
	"self selectors" 
	
	^ {  {#selectorForTesting  . #'test support'} .
		 { #otherSelectorForTesting . #'test support' } .
		  {#messageWhoseSuperclassCategorizedItInAnotherPackage . #'*AMC'}.
		{  #uncategorizedMethod .  #'test support'}}
]

{ #category : #'test setup' }
AMCMockParentClass class >> decategorizedSelectorProtocolMaps [
	"Returns pairs selector -> category, that the class should have when the class is decategorized (typically for running tests)"
	"self selectors" 
	
	^ {  {#selectorForTesting  . Protocol defaultName} .
	       { #otherSelectorForTesting . Protocol defaultName } .
		  {#messageWhoseSuperclassCategorizedItInAnotherPackage . #'*AMC'}.
		{  #uncategorizedMethod .  Protocol defaultName}}
]

{ #category : #'test setup' }
AMCMockParentClass class >> uncategorizeAllMethods [
	"Uncategorized all methods to be used in test setup"
	"self uncategorizeAllMethods"
	
	self applySelectorMap: self decategorizedSelectorProtocolMaps 
]

{ #category : #'test support' }
AMCMockParentClass >> selectorForTesting [

	"This method is classified and unclassified by the tests, don't remove it.
	If you classify it in another category.. it doesn't matter the classification will be lost each time
	that you run the tests"
]

{ #category : #'test support' }
AMCMockParentClass >> unclassifiedMethod [


	
]
