# This Bot class implements a form of Negamax to calculate optimal moves
# http://en.wikipedia.org/wiki/Negamax

class Bot
  constructor: (board) ->
    @board = board

  # Returns index of best move
  nextMove: ->
    @findMove(@board.BOT)

  # returns 0 for a draw
  # 1 if player is winner
  # -1 if opponent is winner
  checkGameState: (player) ->
    marker = if player is @board.HUMAN then 'X' else 'O'
    return 0 if @board.draw
    return 1 if @board.winner is marker
    -1

  # Search for the next best move using Negamax
  findMove: (player) ->
    [bestScore, bestMove] = [-Infinity, null]

    for i in @board.getOpenPositions()
      @board.mark(i, player)
      score = -@negamax(-player)
      @board.undo(i)
      if score > bestScore
        bestScore = score
        bestMove = i

    bestMove

  # Depth-limited negamax search with alpha-beta pruning
  negamax: (player, depth = 6, alpha = -Infinity, beta = Infinity) =>
    return @checkGameState(player) if @board.isGameOver() or depth is 0

    for i in @board.getOpenPositions()
      @board.mark(i, player)
      score = _.max([score, -@negamax(-player, depth - 1, -beta, -alpha)])
      @board.undo(i)

      return score if score >= beta
      alpha = score if score > alpha

    alpha
  
angular.module('noughts').factory 'Bot', ->
  return Bot
