import * as React from 'react'
import PropTypes from 'prop-types'
import { GameRoundState } from '../actions'

const Board = ({ gameState, gameId, updateRound }) => {
    setInterval(() => {
        if(gameState == GameRoundState.WAITING_UPDATE) updateRound(gameId)}
        , 1000);

    const MoveInfo = () => (<h3>Click empty cell to make your move</h3>)
    const isPlayersTurn = gameState == GameRoundState.PLAYER_1_MOVES
    return (
        <div className="">
            {isPlayersTurn && <MoveInfo />}
            <div className="grid-container">
                <div className="grid-item"> </div>
                <div className="grid-item"> </div>
                <div className="grid-item"> </div>
                <div className="grid-item"> </div>
                <div className="grid-item"> </div>
                <div className="grid-item"> </div>
                <div className="grid-item"> </div>
                <div className="grid-item"> </div>
                <div className="grid-item"> </div>
            </div>
        </div>
    )
}

Board.propTypes = {
    gameState: PropTypes.string.isRequired,
    gameId: PropTypes.any,
    updateRound: PropTypes.func.isRequired
}

export default Board;