import * as React from 'react'
import PropTypes from 'prop-types'
import { GameRoundState } from '../actions'

const Board = ({ gameState, gameId, board, updateRound, makeMove }) => {
    const mapSpaceSymbol = function(space) {
        switch(space){
            case 1: return "X"
            case 2: return "O"
        }
        return ""
    }
    const mapSpaceClass = function(space){
        switch(space){
            case 1: return "grid-item players-space"
            case 2: return "grid-item opponents-space"
        }
        return "grid-item available-space"
    }
    const visualizeMove = function(board, index){
        board[index] = 1
    }

    setInterval(() => {
        if(gameState == GameRoundState.WAITING_UPDATE) updateRound(gameId)}
        ,1000);


    const MoveInfo = () => (<h3>Click empty cell to make your move</h3>)
    const isHintToDisplay = gameState != GameRoundState.NOT_STARTED
    const spaces = board.map((space, index) => 
        <div key={index} className={mapSpaceClass(space)} 
            onClick={() => 
                {visualizeMove(board, index);
                makeMove(gameId, index)}
            }>
            <div className="space-symbol">{mapSpaceSymbol(space)}</div>
        </div>)

    return (
        <div className="">
            {isHintToDisplay && <MoveInfo />}
            <div className="grid-container">
                {spaces}
            </div>
        </div>)
}

Board.propTypes = {
    gameState: PropTypes.string.isRequired,
    gameId: PropTypes.any,
    board: PropTypes.array,
    updateRound: PropTypes.func.isRequired,
    makeMove: PropTypes.func.isRequired
}

export default Board;