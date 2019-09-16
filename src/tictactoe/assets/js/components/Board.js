import * as React from 'react'
import PropTypes from 'prop-types'
import { GameRoundState } from '../actions'

const Board = ({ gameState, gameId, board, updateRound }) => {
    setInterval(() => {
        if(gameState == GameRoundState.WAITING_UPDATE) updateRound(gameId)}
        , 1000);

    const MoveInfo = () => (<h3>Click empty cell to make your move</h3>)
    const isPlayersTurn = gameState == GameRoundState.PLAYER_1_MOVES

    const mapSpaceSymbol = function(space){
        switch(space){
            case 1: return "X"
            case 2: return "O"
        }
        return " "
    }
    const spaces = board.map((space, index) => 
        <div key={index} className="grid-item">{mapSpaceSymbol(space)}</div>)
    return (
        <div className="">
            {isPlayersTurn && <MoveInfo />}
            <div className="grid-container">
                {spaces}
            </div>
        </div>
    )
}

Board.propTypes = {
    gameState: PropTypes.string.isRequired,
    gameId: PropTypes.any,
    board: PropTypes.array,
    updateRound: PropTypes.func.isRequired
}

export default Board;