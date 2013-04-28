// Generated by CoffeeScript 1.5.0
(function() {
  var Board;

  Board = (function() {
    var WINNING_POSITIONS;

    WINNING_POSITIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]];

    function Board() {
      var i, _ref;
      _ref = [1, -1], this.HUMAN = _ref[0], this.BOT = _ref[1];
      this.cells = (function() {
        var _i, _results;
        _results = [];
        for (i = _i = 0; _i < 9; i = ++_i) {
          _results.push('');
        }
        return _results;
      })();
      this.count = 0;
    }

    Board.prototype.mark = function(index, player) {
      if (!this.isMarkable(index)) {
        return;
      }
      this.cells[index] = player === this.HUMAN ? 'X' : 'O';
      this.finalizeTurn(index, player);
      return true;
    };

    Board.prototype.undo = function(index) {
      this.cells[index] = '';
      this.count--;
      return this.winner = this.draw = false;
    };

    Board.prototype.finalizeTurn = function(index, player) {
      this.count++;
      return this.isGameOver();
    };

    Board.prototype.isMarkable = function(index) {
      if (this.cells[index] !== '') {
        return;
      }
      if (this.winner) {
        return;
      }
      return true;
    };

    Board.prototype.isFull = function() {
      return this.count === 9;
    };

    Board.prototype.isGameOver = function() {
      if (this.winner = this.hasWinner()) {
        return this.winner;
      }
      if (this.isFull()) {
        return this.draw = true;
      }
    };

    Board.prototype.hasWinner = function() {
      var i, sequence, uniques, _i, _len;
      for (_i = 0, _len = WINNING_POSITIONS.length; _i < _len; _i++) {
        i = WINNING_POSITIONS[_i];
        sequence = [this.cells[i[0]], this.cells[i[1]], this.cells[i[2]]];
        uniques = _.uniq(sequence, false, function(i, idx) {
          if (i === '') {
            return idx;
          } else {
            return i;
          }
        });
        if (uniques.length === 1) {
          return _.first(uniques);
        }
      }
      return false;
    };

    Board.prototype.getOpenPositions = function() {
      var positions;
      positions = [];
      _.each(this.cells, function(item, index) {
        if (item === '') {
          return positions.push(index);
        }
      });
      return positions;
    };

    return Board;

  })();

  angular.module('noughts').factory('Board', function() {
    return Board;
  });

}).call(this);