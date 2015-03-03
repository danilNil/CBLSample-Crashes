# CBLSample-Crashes
Different use cases described how you should NOT use couchbase lite framework



Here's the typical sequence of events that creates an update conflict:

1. Your code reads the document's current properties, and constructs a modified copy  to save
2. Another thread (perhaps the replicator) updates the document, creating a new revision with different properties
3. Your code updates the document with its modified properties
