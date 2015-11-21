class Game
  attr_reader :codemaker, :codebreaker, :board

  def initialize(args)
    @codemaker, @codebreaker = args.fetch(:players) {
      raise ArgumentError, "Game.new requires :player key" }
    @board = args.fetch(:board) {
      raise ArgumentError, "Game.new requires :board key" }
  end

  def play
    begin_game
    while true
      reset_game
      board.set_secret_code(codemaker.supply_secret_code)
      until winner
        codebreaker.submit_guess(board)
      end
      break unless play_again?
      swap_players
    end
    finish_game
  end

  def winner
    return codebreaker if board.code_guessed?
    return codemaker unless board.attempts_left?
  end

  private

    def begin_game
      puts "INTRODUCTION WILL BE PRINTED HERE"
    end

    def reset_game
      board.clear
      print_introduction
    end

    def end_game
      puts "Thanks for playing!"
    end

    def play_again?
      puts "/nDo you want to swap sides and play again? (Y)"
      gets.chomp.upcase == 'Y'
    end

    def swap_players
      @codemaker, @codebreaker = @codebreaker, @codemaker
    end
end