Extension { #name : #ClassOrganization }

{ #category : #'*MethodCategorizer-testing' }
ClassOrganization >> hasProtocolFor: aSelector [
	"Return whether the receiver has the selector, aSelector, nicely classified in a protocol or if it is still unclassified."
	
	| protocols |
	protocols := (self protocolOrganizer protocolsOfSelector: aSelector).
	protocols size = 0 	
		ifTrue: [ ^ false ].
	protocols first name = Protocol defaultName
			ifTrue: [ 
			"we take the assumption that if there is one at yet... then the selector is not classified in another one. "
									^ false].
		^ true						
	
		
		
				 
]

{ #category : #'*MethodCategorizer-testing' }
ClassOrganization >> protocolsOfSelector: aSelector [
	"Return the protocols of the selector"
		
	^ (self protocolOrganizer protocolsOfSelector: aSelector)
]

{ #category : #'*MethodCategorizer-testing' }
ClassOrganization >> uncategorizedSelectors [

	^ self listAtCategoryNamed: Protocol unclassified
]
