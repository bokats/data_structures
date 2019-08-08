cache = {}

def make_change(target, coins, level = 0)
  queue = Queue.new
  queue << [target, [], level]
  
  coins = coins.sort.reverse
  
  while !queue.empty?
    current_node = queue.deq()
    coins.each do |coin|
      remainder = current_node[0] - coin
      if remainder > 0
        queue << [remainder, current_node[1] + [coin], current_node[2] + 1]
      elsif remainder == 0
        return [current_node[1] + [coin], current_node[2] + 1]
      end
    end
  end
  nil
end

p make_change(25, [2,1])