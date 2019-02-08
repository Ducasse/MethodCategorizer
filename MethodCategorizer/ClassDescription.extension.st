Extension { #name : #ClassDescription }

{ #category : #'*MethodCategorizer-testing' }
ClassDescription >> hasProtocolFor: aSelector [
	"Return whether the receiver has the selector, aSelector, nicely classified in a protocol or if it is still unclassified. We take the hypothesis that as yet unclassified = not classified and that a selector can belong to a single protocol."
	
	^ self organization hasProtocolFor: aSelector
]

{ #category : #'*MethodCategorizer-testing' }
ClassDescription >> protocolsOfSelector: aSelector [
	"Return the protocols of the selector"
		
	^ self organization protocolsOfSelector: aSelector
]
