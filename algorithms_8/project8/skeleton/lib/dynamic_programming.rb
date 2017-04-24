# Dynamic Programming practice
# NB: you can, if you want, define helper functions to create the necessary caches as instance variables in the constructor.
# You may find it helpful to delegate the dynamic programming work itself to a helper method so that you can
# then clean out the caches you use.  You can also change the inputs to include a cache that you pass from call to call.

class DPProblems
  def initialize
    @cache_fib = { 1 => 1, 2 => 1 }
    @make_change_level = 0
  end

  # Takes in a positive integer n and returns the nth Fibonacci number
  # Should run in O(n) time
  def fibonacci(n)
    return @cache_fib[n] if @cache_fib[n]
    result = fibonacci(n - 1) + fibonacci(n - 2)
    @cache_fib[n] = result
    result
  end

  # Make Change: write a function that takes in an amount and a set of coins.  Return the minimum number of coins
  # needed to make change for the given amount.  You may assume you have an unlimited supply of each type of coin.
  # If it's not possible to make change for a given amount, return nil.  You may assume that the coin array is sorted
  # and in ascending order.
  def make_change(amt, coins, coin_cache = {0 => 0})
    return coin_cache[amt] if coin_cache[amt]
    return 0.0/0.0 if amt < coins[0]

    min_change = amt
    found_zero = false
    idx = 0
    while idx < coins.length && coins[idx] <= amt
      num_change = 1 + make_change(amt - coins[idx], coins, coin_cache)
      if num_change.is_a?(Integer)
        min_change = num_change if num_change < min_change
        found_zero = true
      end
      idx += 1
    end

    if found_zero
      coin_cache[amt] = min_change
    else
      coin_cache[amt] = 0.0/0.0
    end
  end

  # Knapsack Problem: write a function that takes in an array of weights, an array of values, and a weight capacity
  # and returns the maximum value possible given the weight constraint.  For example: if weights = [1, 2, 3],
  # values = [10, 4, 8], and capacity = 3, your function should return 10 + 4 = 14, as the best possible set of items
  # to include are items 0 and 1, whose values are 10 and 4 respectively.  Duplicates are not allowed -- that is, you
  # can only include a particular item once.
  def knapsack(weights, values, capacity)
    return 0 if capacity == 0 || weights.length == 0
    table = knapsack_table(weights, values, capacity)
    table[capacity][weights.length - 1]
  end

  def knapsack_table(weights, values, capacity)
    table = []
    (0..capacity).each do |i|
      table[i] = []
      (0..weights.length - 1).each do |j|
        if i == 0
          table[i][j] = 0
        elsif j == 0
          table[i][j] = weights[0] > i ? 0 : values[0]
        else
          option1 = table[i][j - 1]
          option2 = i < weights[j] ? 0 : table[i - weights[j]][j - 1] + values[j]
          optimum = [option1, option2].max
          table[i][j] = optimum
        end
      end
    end

    table
  end

  # Stair Climber: a frog climbs a set of stairs.  It can jump 1 step, 2 steps, or 3 steps at a time.
  # Write a function that returns all the possible ways the frog can get from the bottom step to step n.
  # For example, with 3 steps, your function should return [[1, 1, 1], [1, 2], [2, 1], [3]].
  # NB: this is similar to, but not the same as, make_change.  Try implementing this using the opposite
  # DP technique that you used in make_change -- bottom up if you used top down and vice versa.
  def stair_climb(n)
    jumps = [[[]], [[1]], [[1, 1], [2]]]

    return jumps[n] if n < 3

    (3..n).each do |i|
      new_jump_set = []
      (1..3).each do |first_step|
        jumps[i - first_step].each do |way|
          new_path = [first_step]
          way.each do |step|
            new_path << step
          end
          new_jump_set << new_path
        end
      end
      jumps << new_jump_set
    end

    jumps.last
  end

  # String Distance: given two strings, str1 and str2, calculate the minimum number of operations to change str1 into
  # str2.  Allowed operations are deleting a character ("abc" -> "ac", e.g.), inserting a character ("abc" -> "abac", e.g.),
  # and changing a single character into another ("abc" -> "abz", e.g.).
  def str_distance(str1, str2)

  end

  # Maze Traversal: write a function that takes in a maze (represented as a 2D matrix) and a starting
  # position (represented as a 2-dimensional array) and returns the minimum number of steps needed to reach the edge of the maze (including the start).
  # Empty spots in the maze are represented with ' ', walls with 'x'. For example, if the maze input is:
  #            [['x', 'x', 'x', 'x'],
  #             ['x', ' ', ' ', 'x'],
  #             ['x', 'x', ' ', 'x']]
  # and the start is [1, 1], then the shortest escape route is [[1, 1], [1, 2], [2, 2]] and thus your function should return 3.
  def maze_escape(maze, start)
  end
end
