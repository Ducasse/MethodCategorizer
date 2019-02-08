"
- Returns occurences based on the current situation in the image.
- Handles carefully extensions. 
"
Class {
	#name : #ImageProtocolFinder,
	#superclass : #ProtocolFinder,
	#category : #'MethodCategorizer-Model'
}

{ #category : #'finding protocols' }
ImageProtocolFinder >> findProtocolsFor: aMethodDefinition [
	"self new findProtocolsFor: Object>>#printOn:"
	| selector result|
	selector := aMethodDefinition selector.
	result := Bag new. 
	environment allClasses
		do: [ :eachClass | (eachClass includesSelector: selector)
									ifTrue: [ | protocol |
									       protocol := (eachClass whichCategoryIncludesSelector: selector).
											(protocol beginsWith: '*')
													ifFalse: [result add: protocol]]].
	^ result
]

{ #category : #'finding protocols' }
ImageProtocolFinder >> fromClasses [
	^ environment allClasses
		
]
