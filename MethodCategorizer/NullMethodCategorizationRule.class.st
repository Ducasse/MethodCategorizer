"
This is a null rule that does nothing.

See also:
Search on the web for ""Null Object Pattern"".
"
Class {
	#name : #NullMethodCategorizationRule,
	#superclass : #MethodCategorizationRule,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'MethodCategorizer-Model'
}

{ #category : #initialization }
NullMethodCategorizationRule class >> initialize [

	self initializeUniqueInstance
]

{ #category : #initialization }
NullMethodCategorizationRule class >> initializeUniqueInstance [

	uniqueInstance := super new
]

{ #category : #'instance creation' }
NullMethodCategorizationRule class >> new [

	^self uniqueInstance
]

{ #category : #initialization }
NullMethodCategorizationRule class >> uniqueInstance [

	uniqueInstance isNil ifTrue: [ self initializeUniqueInstance ].
	
	^uniqueInstance
]

{ #category : #testing }
NullMethodCategorizationRule >> canBeAppliedTo: aMethodReference [

	^true
]

{ #category : #evaluating }
NullMethodCategorizationRule >> categorizeMethod: aMethodReference [

	^nil
]
