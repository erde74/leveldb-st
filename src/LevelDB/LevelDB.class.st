Class {
	#name : #LevelDB,
	#superclass : #Object,
	#instVars : [
		'db',
		'error',
		'leveldbOptions',
		'readOptions',
		'writeOptions',
		'errorMessage'
	],
	#category : #LevelDB
}

{ #category : #'db operations' }
LevelDB >> close [
	db isNull
		ifTrue: [ ^ self ].
	LevelDBFFI close: db.
	db := ExternalAddress new.
]

{ #category : #accessing }
LevelDB >> db [
	^ db
]

{ #category : #accessing }
LevelDB >> delete: aKey [
	error := ExternalAddress new.
	db isNull
		ifTrue: [ ^ self ].
	LevelDBFFI
		delete: db
		withWriteOptions: writeOptions options
		key: aKey
		keylen: aKey size
		errptr: error.
	errorMessage := error readString
]

{ #category : #'db operations' }
LevelDB >> destroy: aFilename [
	LevelDBFFI
		destroy: aFilename
		withOptions: leveldbOptions options
		andError: error.
	errorMessage := error readString
]

{ #category : #'error handling' }
LevelDB >> errorMessage [
	^ errorMessage.
]

{ #category : #'db operations' }
LevelDB >> get: aKey [
	| vallen value |
	db isNull
		ifTrue: [ ^ self ].
	vallen := 0.
	value := LevelDBFFI
		get: db
		withReadOptions: readOptions options
		key: aKey
		keylen: aKey size
		vallen: vallen
		errptr: error.
	errorMessage := error readString.
	^ value
]

{ #category : #options }
LevelDB >> getReadOptions [
	^ readOptions
]

{ #category : #options }
LevelDB >> getWriteOptions [
	^ writeOptions
]

{ #category : #initialization }
LevelDB >> initialize [
	db := ExternalAddress new.
	error := ExternalAddress new.
	leveldbOptions := LevelDBOptions new.
	readOptions := LevelDBReadOptions new.
	writeOptions := LevelDBWriteOptions new
]

{ #category : #testing }
LevelDB >> isExternalAddress [
	^ false
]

{ #category : #'as yet unclassified' }
LevelDB >> iterator [
	| it |
	db isNull
		ifFalse: [ it := LevelDBIterator new.
			it db: db.
			it create]
		ifTrue: [ ^ nil ].
		
	^it.
]

{ #category : #'db operations' }
LevelDB >> open: aFilename [
	db isNull
		ifFalse: [ LevelDBFFI close: db ].
	db := LevelDBFFI open: aFilename withOptions: leveldbOptions options andError: error.
	errorMessage := error readString
]

{ #category : #options }
LevelDB >> options [
	^ leveldbOptions
]

{ #category : #'db operations' }
LevelDB >> put: aKey withValue: aValue [
	| vallen |
	db isNull
		ifTrue: [ ^ self ].
	vallen := aValue size + 1.
	LevelDBFFI
		put: db
		withWriteOptions: writeOptions options
		key: aKey
		keylen: aKey size
		val: aValue
		vallen: vallen
		errptr: error.
	errorMessage := error readString
]

{ #category : #'db operations' }
LevelDB >> repair: aFilename [
	LevelDBFFI repair: aFilename withOptions: leveldbOptions options andError: error.
	errorMessage := error readString.
]
