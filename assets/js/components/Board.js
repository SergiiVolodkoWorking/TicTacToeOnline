import * as React from 'react'
import PropTypes from 'prop-types'
import { GameRoundState } from '../actions'

class Board extends React.Component {
    
    startInterval(updateRound){
        this.interval = setInterval(() => {
            console.log("Update? ", this.props.gameState)
            if(this.props.gameState === GameRoundState.WAITING_UPDATE) {updateRound(this.props.gameId); this.forceUpdate()}}
            , 1000);
    }

    mapSpaceSymbol(space) {
        switch(space) {
            case "PLAYER_1": return "X"
            case "PLAYER_2": return "O"
        }
        return ""
    }
    mapSpaceClass(space) {
        switch(space) {
            case "PLAYER_1": return "grid-item players-space"
            case "PLAYER_2": return "grid-item opponents-space"
        }
        return "grid-item available-space"
    }

    mapSpaceId(index) {
        return "space-"+index
    }

    render() {
        const { gameState, gameId, board, updateRound, makeMove } = this.props

        if(!this.interval) {
            console.log("inits")
            this.startInterval(updateRound);
        }

        const onMove = function(gameId, board, index, makeMove) {
            if(board[index] !== "EMPTY") {
                return;
            }
            board[index] = "PLAYER_1";
            makeMove(gameId, index);
        }

        const isHintToDisplay = gameState != GameRoundState.NOT_STARTED
        const MoveInfo = () => (<h3 className='board-hint'>Click empty cell to make your move</h3>)
        const spaces = board.map((space, index) => 
            <div id={this.mapSpaceId(index)} key={index} className={this.mapSpaceClass(space)} 
                onClick={() => onMove(gameId, board, index, makeMove)}>
                <div className="space-symbol">{this.mapSpaceSymbol(space)}</div>
            </div>)

        return (
            <div className="">
                {isHintToDisplay && <MoveInfo />}
                <div className="grid-container">
                    {spaces}
                </div>
            </div>)
    }
}

Board.propTypes = {
    gameState: PropTypes.string.isRequired,
    gameId: PropTypes.any,
    board: PropTypes.array,
    updateRound: PropTypes.func.isRequired,
    makeMove: PropTypes.func.isRequired
}

export default Board;