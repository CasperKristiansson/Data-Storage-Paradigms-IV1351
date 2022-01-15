# Lesson Notes

## **Module 1 - Relations, SQL**
The SELECT DISTINCT statement is used to return only distinct (different) values.

Relational model = sets

OLTP workloads more often involve updates, inserts and retrievals with low selectivity rather than aggregations across many records in a database.

|Super Key|Primary Key|
|-|-|
|Super Key is an attribute (or set of attributes) that is used to uniquely identifies all attributes in a relation.|Primary Key is a minimal set of attribute (or set of attributes) that is used to uniquely identifies all attributes in a relation|
|All super keys can’t be primary keys.|Primary key is a minimal super key.|
|Various super keys together makes the criteria to select the candidate keys.|We can choose any of the minimal candidate key to be a primary key.|
|In a relation, number of super keys are more than number of primary keys.|While in a relation, number of primary keys are less than number of super keys.
|Super key’s attributes can contain NULL values.|Primary key’s attributes cannot contain NULL values.

Project operator is denoted by ∏ symbol and it is used to select desired columns (or attributes) from a table (or relation). Project operator in relational algebra is similar to the Select statement in SQL.

Commutative algebra is essentially the study of the rings occurring in algebraic number theory and algebraic geometry.

https://www.gatevidyalay.com/relationship-sets/

<br>

## **Module 2 - Normalisation**
Decompose your schema into an equivalent schema which preserves core properties while avoiding anomalies and using less data.

- Objective: Generate tables whose attributes depend on the complete primary key and nothing else.
- Constraint: Maintain all dependencies between attributes in a database decomposition.

<br>
Functional dependencies (FDs): also known as attribute dependencies

Examples of functional dependencies are personumber -> address, ISBN -> title

Armstrong’s axioms: A set of rules that are used to compose any possible FD from an existing set of FDs

<br>

Reflexive: A rule that applies to any attribute set (to itself or to a subset of itself)
Example: If you have a subset Y from an attribute set X, then X can always derive Y since Y is part of itself.Y can also be replaced by X so that X derives itself using the reflexive property 

Augmentation
- A rule used to add more attributes to our dependency set
- Example: You already have a functional dependency from X to Y. You can also add Z 	both sides and derive a new functional dependency that includes Z on both sides.

Transitive
- A rule that says you can chain functional dependencies together and derive a transitive closure of those dependencies.
- Example: If we have a dependency from X to Y, then another dependency from Y to 	Z, we can derive a new dependency from X to Z.

<br>

### Normalisation forms:

*1st normal form:* Has nothing to do with dependencies, is mainly about attributes. No sets as attributes, no multiple values, only unique rows in the tables.

*2nd normal form*: Is mostly about keys. No partial dependency on keys, pretty much every non-prime attribute in the tables depend on the full key.

*3rd normal form:* Tables are further decomposed into a form without transitive functional dependencies within a table. If there is a functional dependency of non prime attributes then we split this into several tables. (Instead of having address and zip code in lesson, make another table maybe called location that holds them)

<br>

Pro-Tips in Good Database Design
- Each table schema describes one entity or relationship between entities with a PK each.
- Further split schemas (and conquer) until no anomalies are possible.
- Avoid attributes which can be often NULL.
- Link schemas via PK and FK attributes only.

<br>

Candidate key is a single key or a group of multiple keys that uniquely identify rows in a table. A Candidate key is a subset of Super keys and is devoid of any unnecessary attributes that are not important for uniquely identifying tuples. The value for the Candidate key is unique and non-null for all tuples

What this functional dependency tells us is in fact the opposite: For every two tuples with the same value for X we will also have the same value of Y since X identifies Y but not vice versa.

<br>

A minimal cover of a set of functional dependencies (FD) E is a minimal set of dependencies F that is equivalent to E.

The formal definition is: A set of FD F to be minimal if it satisfies the following conditions:
- Every dependency in F has a single attribute for its right-hand side.
- We cannot replace any dependency X->A in F with a dependency Y->A, where Y is a proper subset of X, and still have a set of dependencies that is equivalent to F.
- We cannot remove any dependency from F and still have a set of dependencies that are equivalent to F.

**Example**

Consider an example to find canonical cover of F. The given functional dependencies are as follows
- A -> BC
- B -> C
- A -> B
- AB -> C

Minimal cover: The minimal cover is the set of FDs which are equivalent to the given FDs.
Canonical cover: In canonical cover, the LHS (Left Hand Side) must be unique.

<br>

## **Module 3 - Storage**
DBMS: Minimizes time for reads/writes between volatile and non-volatile memory, to shorten execution time

The DBMS has two modules:
- Buffer manager: Decides how data moves between volatile and non volatile memory
- Storage manager: Maintains/organizes files of a database

<br>

The OS can give the illusion of “infinite” memory through memory mapping (mmap). OS can swap pages on disk automatically. BUT:
- The OS is agnostic of page access patterns (reads,writes).
- The DBMS can do better page prefetching knowing what it needs next
- The DBMS knows which thread/process is using which page and thus it can apply an optimal buffer replacement policy.
- Virtual Memory is scarcely used for in-memory databases only ‣ Disk-oriented databases do memory management manually.

<br>

![](/Lesson%20Notes/Images/image5.png)


A dirty bit or modified bit is a bit that is associated with a block of computer memory and indicates whether or not the corresponding block of memory has been modified.[1] The dirty bit is set when the processor writes to (modifies) this memory.

- The relational model makes no assumptions on the physical data structure.
- Each DBMS is free to make its own file management
- Typically a file per relation or database (risk of file limit)
- Key to good performance: Minimum IO -> Depends on workload
- best organisation when queries access related attributes only (file paged by relation arranged by row?)
- best organisation when queries need OLAP aggregates? (file paged by relation arranged by column?) etc…

<br>

In RAID 5 there is no need to duplicate each block since the parity blocks can be used to reconstruct any lost block

The cost of data access in a hard disk drive is dominated by the seek time which is the time it takes for the head to move to the right cylinder

In the Least Recently Used (LRU) page replacement policy, the page that is used least recently will be replaced.

Implementation:
- Add a register to every page frame - contain the last time that the page in that frame was accessed
- Use a "logical clock" that advance by 1 tick each time a memory reference is made.
Each time a page is referenced, update its register

https://blog.stratifylabs.dev/device/2013-10-02-A-FIFO-Buffer-Implementation/

## **Module 4 - Transactions**
Transaction can be handled both by the internal database system and by programming(for example parts that need to be executed atomically).

![](/Lesson%20Notes/Images/image3.png)

Transactions are important for DBs because: recovery/rollback, isolation guarantees.
Dirty reads can be solved with locks.

**Lock(Q)** - Before each read/write operation on an object Q acquire the appropriate lock. If another transaction holds the lock block until it is available.

**Unlock(Q)** - After each read/write operation of an object Q release the lock. 

**W-lock(Q)** - Called Write or Exclusive lock : Required to perform a write operation on Q

**R-lock(Q)** - Called Read or Shared lock : Suffices to perform a read operation on Q

**Shared lock** = read lock

**Exclusive lock** = write lock

![](/Lesson%20Notes/Images/image15.png)

Two Phase Locking - 2PL - Each transaction should acquire all necessary locks first and then release them:
- Growing phase - Locks are acquired/upgraded and no locks are released.
- Shrinking phase - Locks are released/downgraded but no locks are acquired. 

<br>

A dirty read (aka uncommitted dependency) occurs when a transaction is allowed to read data from a row that has been modified by another running transaction and not yet committed.

A lost update occurs when two transactions read the same object and then modify this object independently.

A Phantom read occurs when one user is repeating a read operation on the same records, but has new records in the results set: READ UNCOMMITTED. Also called a Dirty read. When this isolation level is used, a transaction can read uncommitted data that later may be rolled back.

![](/Lesson%20Notes/Images/image16.png)

Strict 2-PL –
This requires that in addition to the lock being 2-Phase all Exclusive(X) locks held by the transaction be released until after the Transaction Commits. 
Following Strict 2-PL ensures that our schedule is:
- Recoverable
- Cascadeless

Hence, it gives us freedom from Cascading Abort which was still there in Basic 2-PL and moreover guarantee Strict Schedules but still, Deadlocks are possible! 

### Wait-Die Scheme
In this scheme, If a transaction requests a resource that is locked by another transaction, then the DBMS simply checks the timestamp of both transactions and allows the older transaction to wait until the resource is available for execution.

<br>

**Wait-Die:** High priority requesters wait, lower priority requesters abort
Wound-Wait: High priority requesters make holder abort and steal the lock, Lower priority requesters wait.

concurrency control ensures that correct results for concurrent operations are generated, while getting those results as quickly as possible.

https://www.geeksforgeeks.org/deadlock-in-dbms/

## Module 5 - Indexing, Query Optimization
Given an ordered file on a primary key (unique).
- Sparse Index - entry per block (not per record/value) .
- Default index for primary key attributes of a table. Can be only one Primary Index

Hash-tables
- Space: O(n)
- Access: Average: O(1), Worst: O(n)
- Updates: Better suited for few/no updates (inserts deletes)
- Best data structure for point queries (select ..where field=“foo”)

B-Trees
- Access: O(logn)
- Always balanced (e.g., B+ Tree)
- Updates: Well-Suited for any dynamic updates (inserts deletes)
- Good performance for: point and range queries (select ..where field>10)

![](/Lesson%20Notes/Images/image2.png)

There are two types of operators in query execution:
- Non-Blocking - Pipelined
- executed incrementally - per block/tuple
- e.g., select, project ‣ intermediate results can be “streamed”
- Blocking - Staged ‣ e.g., JOIN, UNION, INTERSECTION, DISTINCT
- intermediate results materialised (and sorted) in files

Strategies to execute R ⋈ S
- Nested Loop Join
- Index-Based Nested Loop Join
- Sort-Merge Join
- Partition Hash Join

![](/Lesson%20Notes/Images/image12.png)

A primary key is a logical concept - it's the unique identifier for a row in a table. As such, it has a bunch of attributes - it may not be null, and it must be unique. Of course, as you're likely to be searching for records by their unique identifier a lot, it would be good to have an index on the primary key.

![](/Lesson%20Notes/Images/image23.png)

A clustered index is a physical concept - it's an index that affects the order in which records are stored on disk. This makes it a very fast index when accessing data, though it may slow down writes if your primary key is not a sequential number.
 
A dense index in databases is a file with pairs of keys and pointers for every record in the data file. Every key in this file is associated with a particular pointer to a record in the sorted data file.

<br>

**Nested Loop Join**
- Nested Loop Join is a join algorithm that performs a nested loop join on two relations.
- Worst join performance. Scans all pages of S for every tuple in R.
- Complexity: BR + (tR * Bs)
```python
R ⋈ S
for r in R:
    for s in S:
        if r.key == s.key:
            yield r, s
```

**Block Nested Loop Join**
- Block Nested Loop Join is a join algorithm that performs a block nested loop join on two relations.
- Complexity: BR + (Br * Bs)
```python
R ⋈ S
for r in R:
    for s in S:
        for r_block in r.blocks:
            for s_block in s.blocks:
                if r_block.key == s_block.key:
                    yield r, s
```

#### **Block Nested Loop Join**
With M buffers we can
- Assign M-2 buffers to outer join relation (R)
- Assign 1 buffer to store a page of inner relation S
- Assign 1 buffer to output (R ⋈ S)
- Complexity: BR + (⌈BR/(M − 2)⌉ * BS)

#### **Index-Based Nested Loop Join**
Inner table matching can be executed on an index (hash, b+tree).
i.e., R ⋈ Index(S) or S ⋈ Index(R)

We avoid each sequential scan of the indexed relation. If an existing index exists for either relation use that otherwise create a new one for the join (yes sometimes this is worth it!)

**Hash Join**
- Partitioning Phase : Use hashing function h on R (outer relation) to
re-partition tuples to b buckets (should fit in memory).
- Probing Phase: Use h on S to map tuples to b and check for matches.
- Cost ~ 3 * (BR + Bs)

#### **Sort-Merge Join**
If R and S are both already sorted we can perform the join in a “merge” phase
- Complexity (no sorting): BR + Bs
Otherwise perform external merge-sort on unsorted relation on join attribute.
- Worst case: sort(R) + sort(S) + BR + Bs

<br>

Best 2-Way Join
- If appropriate primary index - secondary index exists: ***sort-merge join***
- If data is non-uniform / duplicated: ***sort-merge join***
- Otherwise: ***partition hash join***
