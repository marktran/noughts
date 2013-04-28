# This Board class contains all of the board's state as well as marker
# placement and end game logic

class Board
  # Hard-coded winning positions
  WINNING_POSITIONS = [
    [0,1,2],[3,4,5],[6,7,8], # rows
    [0,3,6],[1,4,7],[2,5,8], # columns
    [0,4,8],[2,4,6]          # diagonals
  ]

  constructor: ->
    [@HUMAN, @BOT] = [1, -1]

    # The board is represented with an array of 9 places
    @cells = ('' for i in [0...9])

    # Number of markers placed
    @count = 0

  # Place the marker
  mark: (index, player) ->
    return unless @isMarkable(index)
    @cells[index] = if player is @HUMAN then 'X' else 'O'
    @finalizeTurn(index, player)
    true

  # Undo a marker (needed for Negamax)
  undo: (index) ->
    @cells[index] = ''
    @count--
    @winner = @draw = false

  # Increment counts and check if it's game over
  finalizeTurn: (index, player) ->
    @count++
    @isGameOver()

  # Check if cell is already occupied or if we already have a winner
  isMarkable: (index) ->
    return if @cells[index] isnt ''
    return if @winner
    true

  # Board is full when all cells have been occupied
  isFull: ->
    @count is 9

  # True if there's a winner or if it's a draw
  isGameOver: ->
    return @winner if @winner = @hasWinner()
    return @draw = true if @isFull()

  # Iterate over our list of winning positions for a winner
  hasWinner: ->
    for i in WINNING_POSITIONS
      sequence = [@cells[i[0]], @cells[i[1]], @cells[i[2]]]
      uniques = _.uniq(sequence, false, (i, idx) -> if i is '' then idx else i)
      return _.first(uniques) if uniques.length is 1
    false

  # Returns an array of unoccupied cells
  getOpenPositions: ->
    positions = []
    _.each @cells, (item, index) -> positions.push(index) if item is ''
    positions

angular.module('noughts').factory 'Board', ->
  return Board
