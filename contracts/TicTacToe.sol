//SPDX-License-Identifier: Unlicense
pragma solidity ^0.4.24;

/**
 * @title TicTacToe contract
 **/
contract TicTacToe {
    address[2] public players;

    /**
     turn
     1 - players[0]'s turn
     2 - players[1]'s turn
     */
    uint public turn = 1;

    /**
     status
     0 - ongoing
     1 - players[0] won
     2 - players[1] won
     3 - draw
     */
    uint public status;

    /**
    board status
     0    1    2
     3    4    5
     6    7    8
     */
    uint[9] private board;

    /**
      * @dev Deploy the contract to create a new game
      * @param opponent The address of player2
      **/
    constructor(address opponent) public {
        require(msg.sender != opponent, "No self play");
        players = [msg.sender, opponent];
    }

    /**
      * @dev Check a, b, c in a line are the same
      * _threeInALine doesn't check if a, b, c are in a line
      * @param a position a
      * @param b position b
      * @param c position c
      **/    
    function _threeInALine(uint a, uint b, uint c) private view returns (bool){
        /*Please complete the code here.*/
        return ((a == b) && (a == c));
    }

    /**
     * @dev get the status of the game
     * @param pos the position the player places at
     * @return the status of the game
     */
    uint private moves = 0;
    function _getStatus(uint pos) private view returns (uint) {
        /*Please complete the code here.*/
        moves += 1;

        if (_threeInALine(board[0], board[1], board[2])) {
          return board[0];
        }

        if (_threeInALine(board[3], board[4], board[5])) {
          return board[3];
        }

        if (_threeInALine(board[6], board[7], board[8])) {
          return board[6];
        }

        if (_threeInALine(board[0], board[3], board[6])) {
          return board[0];
        }

        if (_threeInALine(board[1], board[4], board[7])) {
          return board[1];
        }

        if (_threeInALine(board[2], board[5], board[8])) {
          return board[2];
        }

        if (_threeInALine(board[2], board[4], board[6])) {
          return board[2];
        }

        if (_threeInALine(board[0], board[4], board[8])) {
          return board[0];
        }

        if (moves == board.length) {
          return 3;
        }
        else {
          return 0;
        }
    }

    /**
     * @dev ensure the game is still ongoing before a player moving
     * update the status of the game after a player moving
     * @param pos the position the player places at
     */
    modifier _checkStatus(uint pos) {
        /*Please complete the code here.*/
        require(status == 0);
        _;
        status = _getStatus(pos);
    }

    /**
     * @dev check if it's msg.sender's turn
     * @return true if it's msg.sender's turn otherwise false
     */
    function myTurn() public view returns (bool) {
       /*Please complete the code here.*/
      if (msg.sender == players[0]) {
        return (turn == 1);
      }
      if (msg.sender == players[1]) {
        return (turn == 2);
      }
    }

    /**
     * @dev ensure it's a msg.sender's turn
     * update the turn after a move
     */
    modifier _myTurn() {
      /*Please complete the code here.*/
      require(myTurn());
      _;
      if (turn == 1) {
        turn = 2;
      } 
      else {
        turn = 1;
      }
    }

    /**
     * @dev check a move is valid
     * @param pos the position the player places at
     * @return true if valid otherwise false
     */
    function validMove(uint pos) public view returns (bool) {
      /*Please complete the code here.*/
      bool onBoard = (pos >= 0) && (pos < board.length);
      bool isEmptySlot = (board[pos] == 0);
      return (onBoard && isEmptySlot);
    }

    /**
     * @dev ensure a move is valid
     * @param pos the position the player places at
     */
    modifier _validMove(uint pos) {
      /*Please complete the code here.*/
      require(validMove(pos));
      _;
    }

    /**
     * @dev a player makes a move
     * @param pos the position the player places at
     */
    function move(uint pos) public _validMove(pos) _checkStatus(pos) _myTurn {
      board[pos] = turn;
    }

    /**
     * @dev show the current board
     * @return board
     */
    function showBoard() public view returns (uint[9]) {
      return board;
    }
}
