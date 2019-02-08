Extension { #name : #RGMethodDefinition }

{ #category : #'*MethodCategorizer' }
RGMethodDefinition >> printOn: aStream [

	super printOn: aStream.
	aStream 
		nextPutAll: ' ';
		nextPutAll: self parentName;
		nextPutAll: '>>';
		nextPutAll: self selector. 
	protocol ifNotNil: [ :p |  aStream nextPutAll: ' - (', p, ')']
]
