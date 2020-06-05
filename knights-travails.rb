class Node

    attr_reader :value, :adjacent_nodes
    
    def initialize(value)
        @value = value
        @adjacent_nodes = []
    end

    def add_edge(adjacent_node)
        @adjacent_nodes << adjacent_node
    end
end

class Graph
    attr_reader :nodes
    def initialize 
        @nodes = {}
    end

    def add_node(value)
        @nodes[value] = Node.new(value)
    end

    def add_edge(value1, value2)
        @nodes[value1].add_edge(@nodes[value2])
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
    attr_accessor :possible_moves, :first_space
    def initialize(space = [0,0])
        @first_space = space
        @possible_moves = find_possible_moves(space)
    end

    def find_possible_moves(space)
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

def knights_moves(space1)
    knight = Knight.new(space1)
    all_possible_moves = Graph.new
    all_possible_moves.add_node(knight.first_space)
    index = 0
    p knight.possible_moves
    knight.possible_moves.length.times do
        all_possible_moves.add_node(knight.possible_moves[index])
        all_possible_moves.add_edge(space1, knight.possible_moves[index])
        index += 1
    end
    return all_possible_moves
end

p knights_moves([3,3])
