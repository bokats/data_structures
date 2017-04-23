# Dijkstra's Algorithm

Dijkstra's Algorithm is an algorithm for finding the shortest paths between nodes in a weighted graph.

#### Assumptions

We'll need a graph for this problem. The `Edge` and `Vertex` classes have been provided for you, inside of the `graph.rb` file.

## Phase 1: The Original Algorithm

`dijkstra1.rb`

##### Objective
For our first version of Dijkstra's algorithm, write a method that takes in a source vertex and finds the shortest distance to every other vertex.

##### Approach
In this function, use hashes to keep track of `possible_paths` (a changing collection) and `shortest_paths` (confirmed shortest paths) to each vertex.  Use the vertex itself as a key, and set the value to a hash with keys for `cost` and `last_edge`, i.e. `{ nodeA: {cost: 3, last_edge: edgeB}, ... }`.

Next, until there are no more `possible_paths`, begin by selecting lowest cost vertex (the one that is the shortest distance from the source). We've found the fastest way to get to it, so add it to `shortest_paths` and remove it from `possible_paths`. Go through this vertex's out edges, and add each of them to `possible_paths` hash, as well with the total cost to get to that vertex and the edge you took to get there.

Once there are no more possible_paths, return `shortest_paths`. This should now be a hash that returns the minimum cost to get to each vertex in the graph from the source.

Test out your solution with the specs. What is this version of Dijkstra's time complexity?

## Phase 2: Optimizations

#### Objective

The solution from phase 1 is good for dense graphs, but we can do better for sparse graphs. In our first solution, we must iterate through possible paths and take the minimum cost vertex each time, which causes a bottleneck. We can do better by using a Priority Map, which uses the heap data structure that we learned previously.

***BinaryMinHeap - Provided!***

The `BinaryMinHeap` class has been provided for you. This is an advanced version of the heap code from before with a `reduce!` method. Effectively this just maintains an `index_map` that associates values with indices in the heap. Take a look at the code and make sure you understand how the `index_map` works.


### Step 1: PriorityMap

`priority_map.rb`

We need to store the vertices in the heap, but we want to heapify them based on the cost that it takes to reach them. In order to do this, let's create the `PriorityMap` class. The `PriorityMap` class will take in a Proc for sorting.  We will need to store a hash (with vertices as the keys and the cost to reach them as the values) and a `BinaryMinHeap` as instance variables. Name these variables `map` and `queue`, respectively.  Make sure to initialize your `BinaryMinHeap` with a proc that sorts elements based on their values in the map.  

Now let's fill out the rest of the class.  When vertices are added to the priority map, we will:

1. Add the vertex to the map with the cost to reach it as the value
2. If the vertex was not already in the map, push it onto the heap. (write this in the `#insert` method)
3. If the value was already in the map, it is also already on the heap. Update its position in the heap by using the heap's `#reduce!` method. (write this in the `#update` method)

Lastly, write the `#extract!` method. This method is the means for removing the top priority vertex from our priority map. Make sure to remove the vertex from both the map and the heap, and return an array the vertex and its cost.

Now that we are using a priority map, what will be the time complexity for extracting the lowest cost vertex?

### Step 2: Improved Dijkstra

`dijkstra2.rb`

Finally, with these tools in hand, we can return to write our second implementation of Dijkstra's algorithm. It should work in a similar manner to our first implementation; the only major difference is that now, rather than searching through the next round of possible paths to find the minimum cost vertex, we can simply extract from the Priority Map. When we need to add to possible paths, we can use our `PriorityMap#[]=` method.

Make sure you pass all of the specs!

What is the time complexity (in terms of vertices and edges) for our second implementation of Dijkstra's?
