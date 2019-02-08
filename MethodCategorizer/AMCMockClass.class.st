"
A child class to check that the categorizer is working well.
"
Class {
	#name : #AMCMockClass,
	#superclass : #AMCMockParentClass,
	#instVars : [
		'accessor'
	],
	#category : #'MethodCategorizer-Tests'
}

{ #category : #'test support' }
AMCMockClass >> accessor [

	^accessor
]

{ #category : #'test support' }
AMCMockClass >> otherSelectorForTesting [

	"This method is classified and unclassified by the tests, don't remove it.
	If you classify it in another category.. it doesn't matter the classification will be lost each time
	that you run the tests - DF"
]

{ #category : #'test support' }
AMCMockClass >> selectorForTesting [

	"This method is classified and unclassified by the tests, don't remove it.
	If you classify it in another category.. it doesn't matter the classification will be lost each time
	that you run the tests"
]
