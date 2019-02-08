Extension { #name : #TraitDescription }

{ #category : #'*MethodCategorizer' }
TraitDescription >> hasProtocolFor: aSelector [
	"Return whether the receiver has the selector, aSelector, nicely classified in a protocol or if it is still unclassified."
	^ self organization hasProtocolFor: aSelector
]
