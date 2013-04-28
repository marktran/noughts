# This Bot class implements a form of Negamax to calculate optimal moves
# http://en.wikipedia.org/wiki/Negamax

class Bot
  constructor: (board) ->
    @board = board

  # Search for the next best move using Negamax and return an index
  nextMove: ->
    bestScore = -Infinity
    bestMove = 0

    for i in @board.getOpenPositions()
      @board.mark(i, @board.BOT)
      score = -@negamax(@board.HUMAN)
      @board.undo(i)
      if score > bestScore
        bestScore = score
        bestMove = i

    bestMove

  # returns 0 for a draw
  # 1 if player is winner
  # -1 if opponent is winner
  checkGameState: (player) ->
    marker = if player is @board.HUMAN then 'X' else 'O'
    return 0 if @board.draw
    return 1 if @board.winner is marker
    -1

  negamax: (player) =>
    score = -Infinity

    return @checkGameState(player) if @board.isGameOver()

    for i in @board.getOpenPositions()
      @board.mark(i, player)
      score = _.max([score, -@negamax(-player)])
      @board.undo(i)

    score
  
angular.module('noughts').factory 'Bot', ->
  return Bot
