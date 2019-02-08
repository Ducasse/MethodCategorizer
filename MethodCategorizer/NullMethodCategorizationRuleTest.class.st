"
A NullMethodCategorizationRuleTest is not a really exciting test. It just test that the nullMethodCategorisation strategy does nothing.
"
Class {
	#name : #NullMethodCategorizationRuleTest,
	#superclass : #TestCase,
	#instVars : [
		'rule'
	],
	#category : #'MethodCategorizer-Tests'
}

{ #category : #'test support' }
NullMethodCategorizationRuleTest >> mockClass [

	^AMCMockClass
]

{ #category : #'setup/teardown' }
NullMethodCategorizationRuleTest >> setUp [

	rule := NullMethodCategorizationRule new
]

{ #category : #tests }
NullMethodCategorizationRuleTest >> testAppliesTo [

	self 
		assert: (rule canBeAppliedTo: 
					(RGMethodDefinition 
							class: self mockClass 
							selector: #selectorForTesting)) 
		description: 'Always returns true'
]

{ #category : #tests }
NullMethodCategorizationRuleTest >> testCategorize [

	self 
		shouldnt: [ rule categorizeMethod: 
							(RGMethodDefinition class: self mockClass selector: #selectorForTesting) ] 
		raise: Exception
	

]
