"
Instances of this class returns all the categories found in the super-classes of a method.
"
Class {
	#name : #SuperClassProtocolFinder,
	#superclass : #ProtocolFinder,
	#category : #'MethodCategorizer-Model'
}

{ #category : #'finding protocols' }
SuperClassProtocolFinder >> fromClasses: aMethodDefinition [

	^ aMethodDefinition realClass allSuperclasses
]
