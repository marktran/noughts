angular.module('noughts').controller 'GameCtrl', ($scope, Board, Bot) ->
  $scope.board = @board = new Board()
  @bot = new Bot(@board)

  # Place a marker on the board and then allow bot to play
  $scope.mark = (index, player) =>
    marked = @board.mark(index, @board.HUMAN)
    botTurn() if marked

  # Get the next move from the bot and place a marker
  botTurn = =>
    @board.mark(@bot.nextMove(), @board.BOT)
