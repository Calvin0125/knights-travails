class Node

    attr_accessor :value, :previous_node
    
    def initialize(value, previous_node = nil)
        @value = value
        @previous_node = previous_node
    end
end
#I wasn't sure what to call this. Backwards_Tree seems right because the root is not connected to 
#anything but each node thereafter is connected to its previous node. Although this would not be
#very useful for storing data, it works perfectly for the problem at hand. 
class Backwards_Tree
    attr_reader :nodes
    def initialize 
        @nodes = {}
    end

    def add_node(value, previous_node = nil)
        @nodes[value] = Node.new(value)
        @nodes[value].previous_node = previous_node
    end
end



class Board 
    attr_reader :spaces  
    def initialize
        @spaces = []
        # x and y represent the x and y coordinates of the chess board
        x = 0
        y = 0
        #creates an array that represents every possible space on the board
        8.times do
            y = 0
            8.times do
            spaces << [x,y]
            y += 1 
            end
            x += 1
        end
    end
end

class Knight
    attr_accessor :space, :moves
    def initialize(space = [0,0])
        @space = space
        @moves = get_moves(space)
    end

    def get_moves(space)
        if space.is_a?(Array) == false
            return nil
        elsif space.length != 2
            return nil
        end
        chess_board = Board.new
        unless chess_board.spaces.include? space
            return nil
        end
        moves = []
        # here x and y represent the x and y coordinate of the original space
        x = space[0]
        y = space[1]
        first_move = [x + 2, y + 1]
        moves << first_move if chess_board.spaces.include? first_move
        second_move = [x + 1, y + 2]
        moves << second_move if chess_board.spaces.include? second_move
        third_move = [x - 1, y + 2]
        moves << third_move if chess_board.spaces.include? third_move
        fourth_move = [x - 2, y + 1]
        moves << fourth_move if chess_board.spaces.include? fourth_move
        fifth_move = [x - 2, y - 1]
        moves << fifth_move if chess_board.spaces.include? fifth_move
        sixth_move = [x - 1, y - 2]
        moves << sixth_move if chess_board.spaces.include? sixth_move
        seventh_move = [x + 1, y - 2]
        moves << seventh_move if chess_board.spaces.include? seventh_move
        eighth_move = [x + 2, y - 1]
        moves << eighth_move if chess_board.spaces.include? eighth_move
        return moves
    end
end

def knights_moves(start, destination)
    board = Board.new
    if board.spaces.include?(start) == false || board.spaces.include?(destination) == false
        return nil
    end
    knight = Knight.new(start)
    possible_moves = Backwards_Tree.new
    possible_moves.add_node(knight.space)
    #the queue functions as a breadth-first search of the graph while it is being created
    queue = [possible_moves.nodes[knight.space]]
    #the already_created array ensures that no duplicate nodes will be created so excess memory is not used
    #the queue cannot be used for this because the first values will be popped off as more are added
    already_created = [possible_moves.nodes[knight.space].value]
    #After checking if we have arrived at the destination, the knight is set to the space at the
    #beginning of the queue. Then, all possible moves are added to the end of the queue as well as
    #the already checked array. Finally, the first value in the queue is removed. 
    while queue[0].value != destination
        knight.space = queue[0].value
        knight.moves = knight.get_moves(knight.space)
        index = 0
        knight.moves.length.times do
            unless already_created.include?(knight.moves[index])
                possible_moves.add_node(knight.moves[index], possible_moves.nodes[knight.space])
                already_created.push(possible_moves.nodes[knight.moves[index]].value)
                queue.push(possible_moves.nodes[knight.moves[index]])
                index += 1
            end
        end
        queue.shift
    end
    path = []
    current_node = queue[0]
    #The 'Backwards Tree' is traversed from the current space(destination) back to the starting point.
    while current_node.previous_node != nil
        path.unshift(current_node.value)
        current_node = current_node.previous_node
    end 
    #the previous_node of the starting space is nil, so this adds the starting space to the path
    path.unshift(current_node.value)
    return path  
end

p knights_moves([0,0], [7,7])
