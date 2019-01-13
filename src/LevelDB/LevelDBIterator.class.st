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

{ #category : #iterating }
LevelDBIterator >> create [
	iterator := LevelDBFFI createIterator: db withReadOptions: readOptions options.
]

{ #category : #iterating }
LevelDBIterator >> destroy [
	iterator isNotNil
		ifFalse: [ ^ self ].
	LevelDBFFI iteratorDestroy: iterator.
	iterator := nil
]

{ #category : #initialization }
LevelDBIterator >> initializeWithDb: aDB [
	db := aDB.
	readOptions := LevelDBReadOptions new.
]

{ #category : #testing }
LevelDBIterator >> isValid [
	^LevelDBFFI isIteratorValid: iterator.
]

{ #category : #iterating }
LevelDBIterator >> key [
	| klen |
	klen := 0.
	^LevelDBFFI iteratorKey: iterator andKeyLen: klen
]

{ #category : #iterating }
LevelDBIterator >> next [
	iterator := LevelDBFFI iteratorNext: iterator.
]

{ #category : #iterating }
LevelDBIterator >> previous [
	iterator := LevelDBFFI iteratorPrev: iterator.
]

{ #category : #iterating }
LevelDBIterator >> seekToFirst [
	iterator := LevelDBFFI iteratorSeekToFirst: iterator.
]

{ #category : #iterating }
LevelDBIterator >> seekToLast [
	iterator := LevelDBFFI iteratorSeekToLast: iterator.
]

{ #category : #iterating }
LevelDBIterator >> value [
	| klen |
	klen := 0.
	^LevelDBFFI iteratorValue: iterator andValueLen: klen.
]
