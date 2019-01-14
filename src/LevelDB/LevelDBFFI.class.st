Class {
	#name : #LevelDBFFI,
	#superclass : #FFILibrary,
	#category : #LevelDB
}

{ #category : #'as yet unclassified' }
LevelDBFFI class >> close: db [

^ self 
		ffiCall: #(void leveldb_close(void* db)) 
		module: LevelDBFFI.
]

{ #category : #iteration }
LevelDBFFI class >> createIterator: aDB withReadOptions: readOptions [

^ self 
		ffiCall: #(void * leveldb_create_iterator(void* aDB, void* readOptions)) 
		module: LevelDBFFI.
]

{ #category : #'as yet unclassified' }
LevelDBFFI class >> createOptions [
^ self 
		ffiCall: #(void * leveldb_options_create()) 
		module: LevelDBFFI.
]

{ #category : #'as yet unclassified' }
LevelDBFFI class >> createReadOptions [
^ self 
		ffiCall: #(void * leveldb_readoptions_create()) 
		module: LevelDBFFI.
]

{ #category : #'as yet unclassified' }
LevelDBFFI class >> createWriteOptions [
^ self 
		ffiCall: #(void * leveldb_writeoptions_create()) 
		module: LevelDBFFI.
]

{ #category : #'as yet unclassified' }
LevelDBFFI class >> delete: aDB withWriteOptions: writeOptions key: aKey keylen: aKeylen errptr: aError [

^ self 
		ffiCall: #(void leveldb_delete(void* aDB, void* writeOptions, char * aKey, size_t aKeylen, char ** aError))
		module: LevelDBFFI.
]

{ #category : #'as yet unclassified' }
LevelDBFFI class >> destroy: aName withOptions: options andError: errptr [

^ self 
		ffiCall: #(void leveldb_destroy_db(void* options, String* aName, char ** errptr)) 
		module: LevelDBFFI.
]

{ #category : #'as yet unclassified' }
LevelDBFFI class >> free: aPtr [

^ self 
		ffiCall: #(void leveldb_free(void* aPtr)) 
		module: LevelDBFFI.
]

{ #category : #'as yet unclassified' }
LevelDBFFI class >> get: aDB withReadOptions: readOptions key: aKey keylen: aKeylen vallen: aVallen errptr: aError [

^ self 
		ffiCall: #(char * leveldb_get(void* aDB, void* readOptions, String* aKey, size_t aKeylen, size_t * aVallen, char ** aError)) 
		module: LevelDBFFI.
]

{ #category : #iteration }
LevelDBFFI class >> isIteratorValid: aIterator [
	^ self ffiCall: #(uchar leveldb_iter_valid #(void * aIterator)) module: LevelDBFFI
]

{ #category : #iteration }
LevelDBFFI class >> iteratorDestroy: aDB [
	^ self 
		ffiCall: #(void leveldb_iter_destroy(void* aDB)) 
		module: LevelDBFFI.
]

{ #category : #iteration }
LevelDBFFI class >> iteratorGetError: errptr with: aIterator [
	^ self
		ffiCall: #(void leveldb_iter_get_error #(void * aIterator , char ** errptr))
		module: LevelDBFFI
]

{ #category : #iteration }
LevelDBFFI class >> iteratorKey: aIterator andKeyLen: klen [

^ self 
		ffiCall: #(String * leveldb_iter_key(void* aIterator, size_t * klen)) 
		module: LevelDBFFI.
]

{ #category : #iteration }
LevelDBFFI class >> iteratorNext: aIterator [

^ self 
		ffiCall: #(void leveldb_iter_next(void* aIterator)) 
		module: LevelDBFFI.
]

{ #category : #iteration }
LevelDBFFI class >> iteratorPrev: aIterator [

^ self 
		ffiCall: #(void leveldb_iter_prev(void* aIterator)) 
		module: LevelDBFFI.
]

{ #category : #iteration }
LevelDBFFI class >> iteratorSeek: aIterator toKey: aKey [
	| klen |
	klen := 0.

^ self 
		ffiCall: #(void leveldb_iter_seek(void* aIterator, char* aKey, size_t klen)) 
		module: LevelDBFFI.
]

{ #category : #iteration }
LevelDBFFI class >> iteratorSeek: aIterator toKey: aKey klen: klen [
	^ self
		ffiCall: #(void leveldb_iter_seek #(void * aIterator , char * aKey , size_t klen))
		module: LevelDBFFI
]

{ #category : #iteration }
LevelDBFFI class >> iteratorSeekToFirst: aIterator [
	self ffiCall: #(void leveldb_iter_seek_to_first #(void * aIterator)) module: LevelDBFFI
]

{ #category : #iteration }
LevelDBFFI class >> iteratorSeekToLast: aIterator [

^ self 
		ffiCall: #(void leveldb_iter_seek_to_last(void* aIterator)) 
		module: LevelDBFFI.
]

{ #category : #iteration }
LevelDBFFI class >> iteratorValue: aIterator andValueLen: vlen [

^ self 
		ffiCall: #(char * leveldb_iter_value(void* aIterator, size_t * vlen)) 
		module: LevelDBFFI.
]

{ #category : #'as yet unclassified' }
LevelDBFFI class >> open: aName withOptions: options andError: errptr [

^ self 
		ffiCall: #(void* leveldb_open(void* options, String* aName, char ** errptr)) 
		module: LevelDBFFI.
]

{ #category : #'as yet unclassified' }
LevelDBFFI class >> optionsDestroy: option [
^ self 
		ffiCall: #(void leveldb_options_destroy(void* option)) 
		module: LevelDBFFI.
]

{ #category : #'as yet unclassified' }
LevelDBFFI class >> optionsSetCreateIfMissing: aOption value: value [
^ self 
		ffiCall: #(void leveldb_options_set_create_if_missing(void* aOption, uchar value)) 
		module: LevelDBFFI.
]

{ #category : #'as yet unclassified' }
LevelDBFFI class >> optionsSetErrorIfExists: aOption value: value [
^ self 
		ffiCall: #(void leveldb_options_set_error_if_exists(void* aOption, uchar value)) 
		module: LevelDBFFI.
]

{ #category : #'as yet unclassified' }
LevelDBFFI class >> optionsSetParanoidChecks: aOption value: value [
^ self 
		ffiCall: #(void leveldb_options_set_paranoid_checks(void* aOption, uchar value)) 
		module: LevelDBFFI.
]

{ #category : #'as yet unclassified' }
LevelDBFFI class >> put: aDB withWriteOptions: writeOptions key: aKey keylen: aKeylen val: aValue vallen: aVallen errptr: aError [

^ self 
		ffiCall: #(void leveldb_put(void* aDB,	void* writeOptions, String* aKey, size_t aKeylen, String* aValue, size_t aVallen, char ** aError)) 
		module: LevelDBFFI.
]

{ #category : #'as yet unclassified' }
LevelDBFFI class >> readOptionsDestroy: option [
^ self 
		ffiCall: #(void leveldb_readoptions_destroy(void* option)) 
		module: LevelDBFFI.
]

{ #category : #'as yet unclassified' }
LevelDBFFI class >> repair: aName withOptions: options andError: errptr [

^ self 
		ffiCall: #(void leveldb_repair_db(void* options, String* aName, char ** errptr)) 
		module: LevelDBFFI.
]

{ #category : #'as yet unclassified' }
LevelDBFFI class >> writeOptionsDestroy: option [
^ self 
		ffiCall: #(void leveldb_writeoptions_destroy(void* option)) 
		module: LevelDBFFI.
]

{ #category : #'as yet unclassified' }
LevelDBFFI class >> writeOptionsSetSync: option value: aChar [
^ self 
		ffiCall: #(void leveldb_writeoptions_set_sync(void* option, uchar aChar)) 
		module: LevelDBFFI.
]

{ #category : #'accessing platform' }
LevelDBFFI >> macModuleName [
	^ 'libleveldb.so'
]

{ #category : #'accessing platform' }
LevelDBFFI >> unixModuleName [
	^ 'libleveldb.so'
]

{ #category : #'accessing platform' }
LevelDBFFI >> win32ModuleName [ 
	^ 'libleveldb.dll'
]
