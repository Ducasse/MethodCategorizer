Class {
	#name : #MethodCategorizationRuleTest,
	#superclass : #TestCase,
	#category : #'MethodCategorizer-Tests'
}

{ #category : #'test support' }
MethodCategorizationRuleTest >> accessorMethod [
	
	^RGMethodDefinition class: self mockClass selector: #accessor

]

{ #category : #'test support' }
MethodCategorizationRuleTest >> methodForTesting [
	
	^RGMethodDefinition class: self mockClass selector: #selectorForTesting

]

{ #category : #'test support' }
MethodCategorizationRuleTest >> mockClass [

	^AMCMockClass
]

{ #category : #'test support' }
MethodCategorizationRuleTest >> otherMethodForTesting [
	
	^RGMethodDefinition class: self mockClass selector: #otherSelectorForTesting

]

{ #category : #'test support' }
MethodCategorizationRuleTest >> protocolForTesting [

	^#'test category'
]

{ #category : #'test support' }
MethodCategorizationRuleTest >> selectorForTesting [

	"Used in tests (see local senders of this method) - DF"
]

{ #category : #setup }
MethodCategorizationRuleTest >> setUp [

	self mockClass uncategorizeAllMethods.
	self mockClass superclass uncategorizeAllMethods.
]

{ #category : #'test support' }
MethodCategorizationRuleTest >> superClassCategory [

	^#'category in super class'
]

{ #category : #setup }
MethodCategorizationRuleTest >> tearDown [

	self mockClass categorizeAllMethods.
	self mockClass superclass categorizeAllMethods.
]

{ #category : #tests }
MethodCategorizationRuleTest >> testAppliesTo [

	| rule |
	rule := MethodCategorizationRule 
				when: [ :aMethod | aMethod = self methodForTesting ]	
				categorizeIn: self protocolForTesting.
	self
		assert: (rule canBeAppliedTo: self methodForTesting);
		deny: (rule canBeAppliedTo: self otherMethodForTesting)
]

{ #category : #tests }
MethodCategorizationRuleTest >> testAppliesToAccessors [

	| rule |
	rule := MethodCategorizationRule accessorsInAccessing.
	self
		assert: (rule canBeAppliedTo: self accessorMethod);
		deny: (rule canBeAppliedTo: self methodForTesting)
]

{ #category : #tests }
MethodCategorizationRuleTest >> testAppliesToWhenCreatedForSelector [
	
	| ruleForSelector |
	ruleForSelector := MethodCategorizationRule 
				whenSelectorMatches: #selectorForTesting
				categorizeIn: self protocolForTesting.
	self
		assert: (ruleForSelector canBeAppliedTo: self methodForTesting);
		deny: (ruleForSelector canBeAppliedTo: self otherMethodForTesting)
]

{ #category : #tests }
MethodCategorizationRuleTest >> testAppliesToWhenCreatedForSelectorAndClassInheritsFrom [

	| ruleForSelector |

	ruleForSelector := MethodCategorizationRule 
				whenSelectorMatches: #selectorForTesting
				andClassInheritsFrom: self mockClass superclass 
				categorizeIn: self protocolForTesting.
	self
		assert: (ruleForSelector canBeAppliedTo: self methodForTesting);
		deny: (ruleForSelector canBeAppliedTo: self otherMethodForTesting);
		deny: (ruleForSelector canBeAppliedTo: (RGMethodDefinition class: self class selector: #selectorForTesting))
]

{ #category : #tests }
MethodCategorizationRuleTest >> testAppliesToWhenUsingSuperClassCategory [

	| rule |
	rule := MethodCategorizationRule usingMostUsedProtocolInSuperClasses.
	self mockClass superclass organization 
		classify: #selectorForTesting 
		under: self superClassCategory.
	self
		assert: (rule canBeAppliedTo: self methodForTesting);
		deny: (rule canBeAppliedTo: self otherMethodForTesting).
	
	self mockClass superclass uncategorizeAllMethods.
	
	self deny: (rule canBeAppliedTo: self methodForTesting)
		description: 'The rule applies only when the super class method is classified'
]

{ #category : #tests }
MethodCategorizationRuleTest >> testCategorize [
	| rule |

	rule := MethodCategorizationRule 
				when: [:aMethodReference | aMethodReference = self methodForTesting ]
				categorizeIn: self protocolForTesting.

	rule categorizeMethod: self methodForTesting.

	self assert: (self mockClass organization categoryOfElement: #selectorForTesting) = self protocolForTesting
]

{ #category : #tests }
MethodCategorizationRuleTest >> testCategorizeWhenUsingSuperClassCategory [

	| rule |

	rule := MethodCategorizationRule usingMostUsedProtocolInSuperClasses.

	self mockClass superclass organization classify: #selectorForTesting under: self superClassCategory.
	
	rule categorizeMethod: self methodForTesting.
	
	self assert: (self mockClass organization categoryOfElement: #selectorForTesting) = self superClassCategory
]
