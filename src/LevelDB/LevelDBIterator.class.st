Class {
	#name : #LevelDBIterator,
	#superclass : #Object,
	#instVars : [
		'iterator',
		'db',
		'readOptions'
	],
	#category : #LevelDB
}

{ #category : #releasing }
LevelDBIterator >> autorelease [
	self class finalizationRegistry add: self
]

{ #category : #iterating }
LevelDBIterator >> create [
	iterator := LevelDBFFI createIterator: db withReadOptions: readOptions options.

]

{ #category : #initialization }
LevelDBIterator >> db: aDB [
	db := aDB.
	readOptions := LevelDBReadOptions new.
]

{ #category : #iterating }
LevelDBIterator >> destroy [
	iterator isNull
		ifTrue: [ ^ self ].
	LevelDBFFI iteratorDestroy: iterator.
	iterator := nil
]

{ #category : #accessing }
LevelDBIterator >> errorMessage [
	| errorMsg |
	errorMsg := ExternalAddress new.
	LevelDBFFI iteratorGetError: errorMsg with: iterator. 
	^ errorMsg readString.
]

{ #category : #finalization }
LevelDBIterator >> finalize [
	self destroy.
	super finalize
]

{ #category : #testing }
LevelDBIterator >> isValid [
	(LevelDBFFI isIteratorValid: iterator) = 0
		ifTrue: [ ^ false ]
		ifFalse: [ ^ true ]
]

{ #category : #iterating }
LevelDBIterator >> key [
	| klen |
	klen := 0.
	^ LevelDBFFI iteratorKey: iterator andKeyLen: klen.
	
]

{ #category : #iterating }
LevelDBIterator >> next [
	LevelDBFFI iteratorNext: iterator.
]

{ #category : #iterating }
LevelDBIterator >> previous [
	LevelDBFFI iteratorPrev: iterator.
]

{ #category : #iterating }
LevelDBIterator >> seekTo: aKey [
	| klen |
	klen := 0.
	LevelDBFFI iteratorSeek: iterator toKey: aKey klen: klen.
]

{ #category : #iterating }
LevelDBIterator >> seekToFirst [
	LevelDBFFI iteratorSeekToFirst: iterator.
]

{ #category : #iterating }
LevelDBIterator >> seekToLast [
	iterator := LevelDBFFI iteratorSeekToLast: iterator.
]

{ #category : #iterating }
LevelDBIterator >> value [
	| str klen |
	klen := 0.
	^ LevelDBFFI iteratorValue: iterator andValueLen: klen
]
