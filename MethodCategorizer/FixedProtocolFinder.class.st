"
Instances of this class always returns a given protocol for a method.
Such behavior is used for system wide categorisation such as all printOn: methods should be categorized into  the given protocol.
"
Class {
	#name : #FixedProtocolFinder,
	#superclass : #ProtocolFinder,
	#instVars : [
		'protocol'
	],
	#category : #'MethodCategorizer-Model'
}

{ #category : #'instance creation' }
FixedProtocolFinder class >> categorizeIn: aProtocolNameString [ 

	^self new initializeWithFixedProtocol: aProtocolNameString
]

{ #category : #'finding protocols' }
FixedProtocolFinder >> findProtocolsFor: aMethodReference [ 

	^ Bag with: protocol
]

{ #category : #initialization }
FixedProtocolFinder >> initializeWithFixedProtocol: aProtocolNameString [ 
	protocol := aProtocolNameString
]

{ #category : #printing }
FixedProtocolFinder >> printOn: aStream [

	aStream nextPutAll: 'Into protocol ', protocol asString
]
