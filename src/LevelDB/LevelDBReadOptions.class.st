Class {
	#name : #LevelDBReadOptions,
	#superclass : #Object,
	#instVars : [
		'options'
	],
	#category : #LevelDB
}

{ #category : #'as yet unclassified' }
LevelDBReadOptions >> autorelease [
	^ self class finalizationRegistry add: self
]

{ #category : #finalization }
LevelDBReadOptions >> finalize [
	LevelDBFFI readOptionsDestroy: options 
]

{ #category : #initialization }
LevelDBReadOptions >> initialize [ 
	super initialize .
	self autorelease.
	options := LevelDBFFI createReadOptions 
]

{ #category : #accessing }
LevelDBReadOptions >> options [
	^ options
]
