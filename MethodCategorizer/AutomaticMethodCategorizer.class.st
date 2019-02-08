"
Instances of this class categorize methods based on a set of rules. The first version of this package was developed by Diego Fernandez and Stéphane Ducasse continued to work on it. 


!! Example 
Here is a typical example:

[[[
| myRule |
myRule := MethodCategorizationRule 
				whenSelectorMatches: 'initialize*' 
				categorizeIn: #initialization.
								
(AutomaticMethodCategorizer using: myRule) categorizeAllMethodsOf: MyClass
]]]

!! API
You can categorize at different levels of granularity.

- categorizeAllMethodsOf: aClass
- categorizeAllUncategorizedMethodsOf: aClass
- categorizeMethod: aMethod
- categorizeMethods: methods

!! Rule access

You can customize the AutomaticMethodCategorizer to access specific class to hold rules as follows: 
	AutomaticMethodCategorizer 
		ruleMapAt: 'RuleRepository'
	
	or even specify the selector to be sent to get access to rules
		
	AutomaticMethodCategorizer 
		rulesAccessSelector: #mySpecificRules	
		
	The easiest approach is to define a subclass to AutomaticMethodCategorizer and customize the method defaultCategorizationRules which is invoked by default. 
		




See also:
AutomaticMethodCategorizerTest for more examples
AutomaticMethodCategorizer defaultCategorizationRules



	


"
Class {
	#name : #AutomaticMethodCategorizer,
	#superclass : #WorkingOnEnvironmentFragment,
	#instVars : [
		'categorizationRules'
	],
	#classVars : [
		'RuleMaps'
	],
	#category : #'MethodCategorizer-Model'
}

{ #category : #compatibility }
AutomaticMethodCategorizer class >> classify: aMethodDefinition [

	^ self new categorizeMethod: aMethodDefinition
]

{ #category : #compatibility }
AutomaticMethodCategorizer class >> classifyAll: methodDefinitions [

	^ self new categorizeMethods: methodDefinitions
]

{ #category : #defaults }
AutomaticMethodCategorizer class >> defaultCategorizationRules [
	"The order is relevant, the categorizer uses the first rule matching"

	^OrderedCollection new
		add: MethodCategorizationRule accessorsInAccessing;
		"initialize"
		add: MethodCategorizationRule initStarInInitialization;
		add: MethodCategorizationRule defaultStartInDefaults;
		add: MethodCategorizationRule asStarInPrinting;
		
		add: (MethodCategorizationRule hashInComparing);
		"order is important"		
		"testing"
		add: (MethodCategorizationRule isStarInInitialization);
		add: (MethodCategorizationRule hasStarInTesting);
		add: (MethodCategorizationRule equalInComparing);		
		add: (MethodCategorizationRule newStarInInstanceCreation);
		add: (MethodCategorizationRule settingInSettings);
		add: (MethodCategorizationRule printStarInPrinting);
		add: (MethodCategorizationRule storeOnInPrinting);
		
		add: (MethodCategorizationRule starCopyStarInCopying);
		add: (MethodCategorizationRule drawStarInDrawing);
		add: (MethodCategorizationRule benchStarInbenchmarks);
		add: (MethodCategorizationRule removeStarInAddRemove);
		add: (MethodCategorizationRule addStarInAddRemove);
		
		add: (MethodCategorizationRule openStarInOpening);
		add: (MethodCategorizationRule updateStarInUpdating);
		add: (MethodCategorizationRule changeStarInUpdating);
		
		add: (MethodCategorizationRule acceptStarInVisitor);
		add: (MethodCategorizationRule visitStarInVisiting);

		add: (MethodCategorizationRule menuStarInMenus);
		
		add: (MethodCategorizationRule exampleStarInExamples);
		
		"test cases"
		add: (MethodCategorizationRule testInTestCaseInTests);
		add: (MethodCategorizationRule setUpTestCaseInSetup);
		add: (MethodCategorizationRule tearDownTestCaseInSetup);
		
		"baselines, versions..."
		add: (MethodCategorizationRule versionConfigurationOfInVersions);
		add: (MethodCategorizationRule baselineConfigurationOfInbaselines);
		add: (MethodCategorizationRule devConfigurationOfInSymbolic);
		add: (MethodCategorizationRule stableConfigurationOfInSymbolic);
					
		add: MethodCategorizationRule usingMostUsedProtocolInSuperClasses;
		add: MethodCategorizationRule usingMostUsedProtocolInImage;
		yourself
]

{ #category : #defaults }
AutomaticMethodCategorizer class >> defaultMapName [
	^ #defaultRuleMap
]

{ #category : #'installation to test' }
AutomaticMethodCategorizer class >> deinstall [
	"Nautilus should have a class var that points to the class to use!"
	"self deinstall"

	Nautilus methodClassifierClass: MethodClassifier
]

{ #category : #initialization }
AutomaticMethodCategorizer class >> initialize [
	"self initialize"
	
	self ruleMapAt: self defaultMapName put: self defaultCategorizationRules.

]

{ #category : #'installation to test' }
AutomaticMethodCategorizer class >> install [
	"Nautilus should have a class var that points to the class to use!"
	"self install"

	Nautilus methodClassifierClass: self
]

{ #category : #'instance creation' }
AutomaticMethodCategorizer class >> new [ 
	"By default take the default rules"
	^ super new categorizationRules: (self ruleMapAt: self defaultMapName) ; yourself
]

{ #category : #'managing rule map' }
AutomaticMethodCategorizer class >> resetRuleMaps [
	"self resetRuleMaps"
	RuleMaps := nil
]

{ #category : #'managing rule map' }
AutomaticMethodCategorizer class >> ruleMapAt: aSymbol [ 

	^ self ruleMaps at: aSymbol 
]

{ #category : #'managing rule map' }
AutomaticMethodCategorizer class >> ruleMapAt: aSymbol put: aListOfRules [

	self ruleMaps at: aSymbol put: aListOfRules
]

{ #category : #'managing rule map' }
AutomaticMethodCategorizer class >> ruleMaps [

	^ RuleMaps ifNil: [ RuleMaps := IdentityDictionary new ]
]

{ #category : #'instance creation' }
AutomaticMethodCategorizer class >> usingRule: aMethodCategorizationRule [
	
	^self usingRules: (Array with: aMethodCategorizationRule)
]

{ #category : #'instance creation' }
AutomaticMethodCategorizer class >> usingRules: aCollection [
	
	^self new categorizationRules: aCollection ; yourself
]

{ #category : #query }
AutomaticMethodCategorizer >> categorizationRuleFor: aMethodDefinition [
	"Find the first rule that matches for a given method definition"
	
	^ categorizationRules 
		detect: [ :eachRule | eachRule canBeAppliedTo: aMethodDefinition ]
		ifNone: [ NullMethodCategorizationRule new ]

]

{ #category : #initialization }
AutomaticMethodCategorizer >> categorizationRules: aCollection [ 

	categorizationRules := aCollection
]

{ #category : #'categorize environments' }
AutomaticMethodCategorizer >> categorizeAllMethodsNamed: aSelector [ 
	"categorize all the methods named aSelector using existing rules."
	"self new categorizeAllMethodsNamed: #storeOn:"

	(self identifyClassesWithNonExtendingMethod: aSelector)
		do: [ :each | self categorizeMethod: (RGMethodDefinition class: each selector: aSelector ) ]
]

{ #category : #'categorize environments' }
AutomaticMethodCategorizer >> categorizeAllMethodsNamed: aSelector inProtocol: aString [
	"Categorize all methods named aSelector into the protocol aString. Do not use predefined rules."
	"self new categorizeAllMethods: #storeOn: inProtocol: #'printing'"

	self usingRules: { (MethodCategorizationRule whenSelectorMatches: aSelector categorizeIn:  aString)}.
	(self identifyClassesWithNonExtendingMethod: aSelector)
		do: [ :each | 
			self categorizeMethod: (RGMethodDefinition class: each selector: aSelector ) ]
]

{ #category : #categorize }
AutomaticMethodCategorizer >> categorizeAllMethodsOf: aClass [ 

	| methodDefs |
	methodDefs := aClass selectors collect: [ :eachSelector | RGMethodDefinition class: aClass selector: eachSelector ].
	self categorizeMethods: methodDefs
]

{ #category : #categorize }
AutomaticMethodCategorizer >> categorizeAllUncategorizedMethodsOf: aClass [ 

	| referencesToUncategorizedMethods |
	referencesToUncategorizedMethods := aClass organization uncategorizedSelectors 
		collect: [ :eachSelector | RGMethodDefinition class: aClass selector: eachSelector ].
	self categorizeMethods: referencesToUncategorizedMethods
]

{ #category : #categorize }
AutomaticMethodCategorizer >> categorizeMethod: aMethodDefinition [
	
	(self categorizationRuleFor: aMethodDefinition) categorizeMethod: aMethodDefinition
]

{ #category : #categorize }
AutomaticMethodCategorizer >> categorizeMethods: methodDefinitions [
	
	methodDefinitions do: [ :each | 
		(self categorizationRuleFor: each) categorizeMethod: each]
]

{ #category : #compatibility }
AutomaticMethodCategorizer >> classify: aMethodDefinition [
	"to be compatible with the MethodClassifier"
	
	^ self categorizeMethod: aMethodDefinition
]

{ #category : #compatibility }
AutomaticMethodCategorizer >> classifyAll: methodDefinitions [

	^ self categorizeMethods: methodDefinitions
]

{ #category : #'categorize environments' }
AutomaticMethodCategorizer >> identifyClassesWithNonExtendingMethod: aSymbol [ 
	"self new identifyClassesWithNonExtendingMethod: #initialize"
	
	| implementors |
	implementors := self allClassesAndTraits select: [ :each | each includesSelector: aSymbol ].
	implementors := implementors
		reject: [ :each | 
			| cat |
			cat := each whichCategoryIncludesSelector: aSymbol.
			(cat beginsWith: '*')].
	^ implementors
]
