require 'set'

# Define a Knight class to represent the knight's position on the chess board
class Knight
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def ==(other)
    @x == other.x && @y == other.y
  end
end

# Define the knight_traversal function
def knight_traversal(start, target)
  # Define the possible moves a knight can make
  moves = [
    [-1, -2], [-2, -1], [-2, 1], [-1, 2],
    [1, -2], [2, -1], [2, 1], [1, 2]
  ]

  # Create a queue for BFS
  queue = []
  queue.push(start)

  # Create a set to keep track of visited positions
  visited = Set.new
  visited.add(start)

  # Create a hash to keep track of the path from each position
  path = {}
  path[start] = nil

  # Perform BFS
  while !queue.empty?
    current = queue.shift

    # If the current position is the target, we've found the shortest path
    return reconstruct_path(path, current) if current == target

    # Generate all possible next moves from the current position
    moves.each do |move|
      next_x = current.x + move[0]
      next_y = current.y + move[1]
      next_pos = Knight.new(next_x, next_y)

      # Check if the next move is within the chess board boundaries and not visited
      if within_boundaries?(next_pos) && !visited.include?(next_pos)
        queue.push(next_pos)
        visited.add(next_pos)
        path[next_pos] = current
      end
    end
  end

  # If no path is found, return nil
  return nil
end

# Helper function to check if a position is within the chess board boundaries
def within_boundaries?(pos)
  pos.x >= 0 && pos.x < 8 && pos.y >= 0 && pos.y < 8
end

# Helper function to reconstruct the path from the start to the current position
def reconstruct_path(path, current)
  result = []
  while current
    result.unshift(current)
    current = path[current]
  end
  result
end

# Example usage
start = Knight.new(3, 3)
target = Knight.new(0, 0)
shortest_path = knight_traversal(start, target)

if shortest_path.nil?
  puts "No path found."
else
  puts "Shortest path from #{start.x},#{start.y} to #{target.x},#{target.y}:"
  shortest_path.each { |pos| puts "#{pos.x},#{pos.y}" }
end
