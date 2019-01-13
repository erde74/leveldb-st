"
| opt |
opt := LevelDBOptions new autorelease.

Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	options:		<Object>


    Implementation Points
"
Class {
	#name : #LevelDBOptions,
	#superclass : #Object,
	#instVars : [
		'options'
	],
	#category : #LevelDB
}

{ #category : #releasing }
LevelDBOptions >> autorelease [
	self class finalizationRegistry add: self
]

{ #category : #settings }
LevelDBOptions >> createIfMissing: aBoolean [
	LevelDBFFI optionsSetCreateIfMissing: self options value: aBoolean.
]

{ #category : #finalization }
LevelDBOptions >> finalize [
	LevelDBFFI optionsDestroy: options.
	super finalize
]

{ #category : #initialization }
LevelDBOptions >> initialize [ 
	super initialize .
	self autorelease.
	options := LevelDBFFI createOptions 
]

{ #category : #initialization }
LevelDBOptions >> options [
	^ options
]

{ #category : #settings }
LevelDBOptions >> setErrorIfExists: aBoolean [
	LevelDBFFI optionsSetErrorIfExists: self options value: aBoolean.
]

{ #category : #settings }
LevelDBOptions >> setParanoidChecks: aBoolean [
	LevelDBFFI optionsSetParanoidChecks: self options value: aBoolean 
]
