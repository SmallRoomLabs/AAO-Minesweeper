require "byebug"
require 'colorize'
require_relative "./tile.rb"

class Board
    attr_reader :board

    def initialize
        @board = Array.new(9) { Array.new(9) }
        self.fill_with_Tiles
        self.seed_bombs
    end

    def fill_with_Tiles
        @board.map! { |row| row.map! { |square| Tile.new(@board) } }            
    end
    
    def seed_bombs
        bomb_count = 0
        until bomb_count == 10 do 
            random_row_num = rand(0...@board.length)
            random_tile_num = rand(0...@board.length)
            unless @board[random_row_num][random_tile_num].value == "B"
                @board[random_row_num][random_tile_num].set_bomb 
                bomb_count += 1
            end
        end
    end

    def reveal_board
        print "  "
        (0...@board.length).each { |num| print "#{num.to_s.colorize(:yellow)} " }
        puts
        @board.each_with_index do |row, idx|
            print "#{idx.to_s.colorize(:yellow)} "
            row.each do |square|
                print "#{square.value} "
            end
            puts
        end
    end
end