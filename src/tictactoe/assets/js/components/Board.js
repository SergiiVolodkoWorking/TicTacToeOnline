import * as React from 'react'
import { GameRoundState } from '../actions'

const Board = ({ gameState }) => {
    const isPlayersTurn = gameState == GameRoundState.PLAYER_MOVES

    const MoveInfo = () => (<h3>Click empty cell to make your move</h3>)

    return(
        <div className="">
            {isPlayersTurn && <MoveInfo/>}
            <div class="grid-container">
                <div class="grid-item"> </div>
                <div class="grid-item"> </div>
                <div class="grid-item"> </div>
                <div class="grid-item"> </div>
                <div class="grid-item"> </div>
                <div class="grid-item"> </div>
                <div class="grid-item"> </div>
                <div class="grid-item"> </div>
                <div class="grid-item"> </div>
            </div>
        </div>
    )
}

export default Board;