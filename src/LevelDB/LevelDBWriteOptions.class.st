Class {
	#name : #LevelDBWriteOptions,
	#superclass : #Object,
	#instVars : [
		'options'
	],
	#category : #LevelDB
}

{ #category : #'as yet unclassified' }
LevelDBWriteOptions >> autorelease [
	^ self class finalizationRegistry add: self
]

{ #category : #finalization }
LevelDBWriteOptions >> finalize [
	LevelDBFFI writeOptionsDestroy: options
]

{ #category : #initialization }
LevelDBWriteOptions >> initialize [ 
	super initialize .
	self autorelease.
	options := LevelDBFFI createWriteOptions 
]

{ #category : #accessing }
LevelDBWriteOptions >> options [
	^ options
]
