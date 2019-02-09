Class {
	#name : #BaselineOfMethodCategorizer,
	#superclass : #BaselineOf,
	#category : #BaselineOfMethodCategorizer
}

{ #category : #baselines }
BaselineOfMethodCategorizer >> baseline: spec [
	<baseline>
	spec for: #'pharo' do: [
		spec package: 'MethodCategorizer']
]
