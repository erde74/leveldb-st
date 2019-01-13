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
		ifFalse: [ LevelDBFFI close: db ]
]

{ #category : #accessing }
LevelDB >> db [
	^db.
]

{ #category : #accessing }
LevelDB >> deleteKey: aKey [
	db isNull
		ifFalse: [ LevelDBFFI
				delete: db
				withWriteOptions: writeOptions options
				key: aKey
				keylen: aKey size
				errptr: error.
			errorMessage := error readString ]
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
LevelDB >> getKey: aKey [
	db isNull
		ifFalse: [ | vallen value |
			vallen := 0.
			value := LevelDBFFI
				get: db
				withReadOptions: readOptions options
				key: aKey
				keylen: aKey size
				vallen: vallen
				errptr: error.
			errorMessage := error readString.
			^ value ]
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
LevelDB >> putKey: aKey withValue: aValue [
	db isNull
		ifFalse: [ | vallen |
			vallen := aValue size + 1.
			LevelDBFFI
				put: db
				withWriteOptions: writeOptions options
				key: aKey
				keylen: aKey size
				val: aValue
				vallen: vallen
				errptr: error.
			errorMessage := error readString ]
]

{ #category : #'db operations' }
LevelDB >> repair: aFilename [
	LevelDBFFI repair: aFilename withOptions: leveldbOptions options andError: error.
	errorMessage := error readString.
]
