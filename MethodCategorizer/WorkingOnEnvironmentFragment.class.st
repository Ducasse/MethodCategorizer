"
just a bunch of method to manage environment. 
"
Class {
	#name : #WorkingOnEnvironmentFragment,
	#superclass : #Object,
	#instVars : [
		'environment'
	],
	#category : #'MethodCategorizer-Model'
}

{ #category : #utils }
WorkingOnEnvironmentFragment >> allClasses [

	^ environment allClasses
]

{ #category : #utils }
WorkingOnEnvironmentFragment >> allClassesAndTraits [

	^ environment allClassesAndTraits
]

{ #category : #accessing }
WorkingOnEnvironmentFragment >> environment: anEnvironment [

	environment := anEnvironment 
]

{ #category : #initialization }
WorkingOnEnvironmentFragment >> initialize [

	super initialize.
	environment := Smalltalk globals
]
