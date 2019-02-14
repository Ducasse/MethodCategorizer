"
I'm a tool to collect some analyses on selectors categorisation.


!! First some simple statistics

The following shows that in the image in which this comment was written most of the printOn: messages are all categorized in printing. 

[[[ 			
ProtocolAnalyzer new statisticFor: #printOn:  

>>> {377->#printing. 3->#accessing. 1->#ui. 1->#private. 1->#transmitting}
]]]

Now for initialize we see that it is not the case. 
[[[  
ProtocolAnalyzer new statisticFor: #initialize  {

>>> {867->#initialization. 85->#'initialize-release'. 12->#'as yet unclassified'. 8->#initializing. 6->#accessing. 3->#'instance initalization'. 1->#'initalize-release'. 1->#testing. 1->#'class initialization'. 1->#'updating screen'. 1->#actions. 1->#drawing. 1->#displaying. 1->#tests. 1->#shout}
]]]

!! Miscategorized methods

Now we can  get a list of all miscategorized method definitions.
[[[  
ProtocolAnalyzer new findInconsistenciesForASelector: #initialize thatIsNotInProtocol: 'initialization'
]]]

!! Fixing miscategorized methods 

[[[ 
ProtocolAnalyzer new fixInconsistenciesOf: #printOn: toBeInProtocol: 'printing'		
]]]



!! Possible Enhancements
	- Analyse selectors based on the superclass.... and check inconsistencies. 
	- Class variables






"
Class {
	#name : #ProtocolAnalyzer,
	#superclass : #WorkingOnEnvironmentFragment,
	#category : #'MethodCategorizer-Tools'
}

{ #category : #analyses }
ProtocolAnalyzer >> findClassHavingProtocolNamed: aString [ 
	"self new findClassHavingProtocolNamed: #'initialize-release'"

	^ self allClassesAndTraits select: [ :each | 
		each organization allProtocolsNames includes: aString ].
	
]

{ #category : #analyses }
ProtocolAnalyzer >> findInconsistenciesForASelector: aSymbol thatIsNotInProtocol: aString [
	"Pay attention it filters extensions."
	"self new findInconsistenciesForASelector: #initialize thatIsNotInProtocol: 'initialization'"

	| implementingClasses resultingMethods |
	implementingClasses := self allClassesAndTraits select: [ :each | 
		each includesSelector: aSymbol ].
	resultingMethods := OrderedCollection new: implementingClasses size. 
	implementingClasses do: [ :each | 
			| cat |
			cat := each whichCategoryIncludesSelector: aSymbol.
			((cat beginsWith: '*') or: [ (cat = aString) ])
				ifFalse: [ resultingMethods add: ((RGMethodDefinition class: each selector: aSymbol ) protocol: cat; yourself) ] 
			 ].
	^ resultingMethods
]

{ #category : #analyses }
ProtocolAnalyzer >> fix: aClass withProtocol: source toBeNamed: target [
	"Watch out, does not pay attention to extensions!"
	"self new fix: RBMetaclass withProtocol: 'initialize-release' toBeNamed: 'initialize'"
	
	| selectorsToReclassify | 
	selectorsToReclassify := (aClass organization protocolOrganizer methodsInProtocolNamed: source).
	selectorsToReclassify do: [ :s | 
	aClass organization 
				classify: s
				under: target].
]

{ #category : #analyses }
ProtocolAnalyzer >> fixAllProtocol: source toBeNamed: target [

		self shouldBeImplemented 
	
]

{ #category : #analyses }
ProtocolAnalyzer >> fixInconsistenciesOf: aSelector toBeInProtocol: aProtocol [
	"Changes the protocol to all the methods of selector, aSelector, to be aProtocol"
	"self new fixInconsistenciesOf: #printOn: toBeInProtocol: 'printing'"
	
	(self findInconsistenciesForASelector: aSelector thatIsNotInProtocol: aProtocol)
		do: [ :aMethodDefinition|
				aMethodDefinition realClass organization 
					classify: aMethodDefinition selector
					under: aProtocol ]

	
]

{ #category : #analyses }
ProtocolAnalyzer >> fixProtocol: source toBeNamed: target [

	
	
]

{ #category : #'may be useless' }
ProtocolAnalyzer >> methodDefinitionsFor: aSelector thatIsInProtocol: aString [
	"Pay attention it filters extensions."
	"self new methodDefinitionFor: #initialize thatIsInProtocol: #shout"

	| implementingClasses resultingMethods |
	implementingClasses := self allClassesAndTraits select: [ :each | each includesSelector: aSelector ].
	resultingMethods := OrderedCollection new: implementingClasses size. 
	implementingClasses do: [ :each | 
			| cat |
			cat := each whichCategoryIncludesSelector: aSelector.
			cat = aString
				ifTrue: [ resultingMethods add: ((RGMethodDefinition class: each selector: aSelector ) protocol: cat; yourself) ] 
			 ].
	^ resultingMethods
]

{ #category : #queries }
ProtocolAnalyzer >> mostCommonlyDefinedSelectors [
	"Return the list of selectors sorted according to the their usage. Higher first"
	"self new mostCommonlyDefinedSelectors 
	>>> {1073->#initialize. 366->#printOn:. 286->#setUp. 253->#name. 220->#=. 197->#hash. 172->#accept:. 152->#label"
	
	| result |
	result := Bag new.
	self allClassesAndTraits do: [ :each | result addAll: each selectors].
	^ result sortedCounts
]

{ #category : #analyses }
ProtocolAnalyzer >> statisticFor: aSymbol [
	"self new statisticFor: #printOn:"
	"self new statisticFor: #initialize"
	"self new statisticFor: #storeOn:"

	| result |
	result := Bag new.
	self allClassesAndTraits
		do: [ :eachClass | 
			(eachClass includesSelector: aSymbol)
				ifTrue: [ | cat |	
					cat := eachClass whichCategoryIncludesSelector: aSymbol.
					(cat beginsWith: '*')
						ifFalse: [ result add: cat ] ] ].
	^ result sortedCounts
]
