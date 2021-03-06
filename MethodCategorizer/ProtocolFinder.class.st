"
This abstract class defines the protocol of an object that given a method definition returns a bag of the possible categories for that method.

The returned bag contains categories and their occurrences (if it's applicable).

The main API is findProtocolsFor: aMethodReference  and it is invoked by  a Method Categorization Rule.
"
Class {
	#name : #ProtocolFinder,
	#superclass : #WorkingOnEnvironmentFragment,
	#category : #'MethodCategorizer-Model'
}

{ #category : #'finding protocols' }
ProtocolFinder >> findProtocolsFor: aMethodDefinition [
	"self new findProtocolsFor: Object>>#printOn:"

	| selector result |
	selector := aMethodDefinition selector.
	result := Bag new.
	(self fromClasses: aMethodDefinition)
		do: [ :eachClass | 
			(eachClass includesSelector: selector)
				ifTrue: [ | protocol |
					protocol := eachClass whichCategoryIncludesSelector: selector.
					((protocol beginsWith: '*') or: [ protocol = 'as yet unclassified' ])
						ifFalse: [ result add: protocol ] ] ].
	^ result
]

{ #category : #'finding protocols' }
ProtocolFinder >> fromClasses: aMethodDefinition [
	^ environment allClasses
]
