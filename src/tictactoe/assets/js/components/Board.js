import * as React from 'react'
import { GameRoundState } from '../actions'

const Board = ({ gameState }) => {
    const boardIsVisible = gameState != GameRoundState.NOT_STARTED
    if(!boardIsVisible){
        return (null)
    }
    
    return(
        <div>
            <h2>Board will be here</h2>
        </div>
    )
}

export default Board;