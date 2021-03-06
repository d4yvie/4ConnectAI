from objects import Player
from objects cimport Player
import settings
cimport settings
from screens.game import Game
cimport screens.ai as ai
import screens.ai as ai
from cpython cimport bool
from screens.ai cimport Move as Move
from screens.ai cimport PotentialMove as PotentialMove
cimport cython

cdef class GameMinmaxAICopy(ai.AIGame):
    def __init__(self, app):
        self.turns_analyzed_by_ai = 0
        if (app is None):
            return
        print('Starting minmax game')
        ai.AIGame.__init__(self, app)

    cpdef Move min_max(self, list board, int depth, Player ai_player):
        """
        Returns the best move found by the minmax algorithm
        """
        self.turns_analyzed_by_ai = 0
        return self.max_turn(0, self.copy_board(board), ai_player, -1)

    @cython.boundscheck(False)
    @cython.wraparound(False)
    cdef Move max_turn(self, int depth, list board, Player ai_player, short first_round_column):
        self.turns_analyzed_by_ai += 1
        # make all possible moves for the current player
        cdef list child_board, potential_moves = []
        cdef int chip_row_stop = 0
        for column in range(len(board)):
            chip_row_stop = self.get_free_row(column, board=board)
            if chip_row_stop >= 0:
                child_board = self.copy_board(board)
                child_board[column][chip_row_stop] = ai_player.id
                potential_moves.append(PotentialMove(child_board, column, 0))
        # end recursion if depth is reached or no moves possible
        if depth == settings.MAX_DEPTH or len(potential_moves) == 0 or self.did_someone_win(board):
            return Move(self.evaluate_board(board, ai_player, depth), first_round_column)
        cdef Move move = Move(-self.BIG_VALUE, first_round_column)
        cdef Move min_move
        for potential_move in potential_moves:
            if depth == 0:
                min_move = self.min_turn(depth + 1, potential_move.board, ai_player,
                                         potential_move.column)
                min_move = self.increaseMoveScoreIfMiddleColumn(min_move)
                print('Top level score and column:', min_move.score, min_move.column)
            else:
                min_move = self.min_turn(depth + 1, potential_move.board, ai_player,
                                         first_round_column)
            if min_move.score > move.score:
                move = min_move
        return move

    @cython.boundscheck(False)
    @cython.wraparound(False)
    cdef Move min_turn(self, int depth, list board, Player ai_player, short first_round_column):
        self.turns_analyzed_by_ai += 1
        cdef list child_board, potential_moves = []
        cdef int chip_row_stop = 0
        for column in range(len(board)):
            chip_row_stop = self.get_free_row(column, board=board)
            if chip_row_stop >= 0:
                child_board = self.copy_board(board)
                child_board[column][chip_row_stop] = self.red_player.id
                potential_moves.append(PotentialMove(child_board, column, 0))
        # end recursion if depth is reached or no moves possible
        if depth == settings.MAX_DEPTH or len(potential_moves) == 0 or self.did_someone_win(board):
            #print('ret min', self.evaluate_board(board, print(min_move.column, min_move.score)uuuuuuuuuai_player, depth), first_round_column)
            return Move(self.evaluate_board(board, ai_player, depth), first_round_column)
        cdef Move move = Move(self.BIG_VALUE, first_round_column)
        cdef Move max_move
        for potential_move in potential_moves:
            max_move = self.max_turn(depth + 1, potential_move.board, ai_player, first_round_column)
            if max_move.score < move.score:
                move = max_move
        return move

if __name__ == "__main__":
    print(min(1, 2))
