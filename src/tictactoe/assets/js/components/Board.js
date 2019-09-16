import * as React from 'react'
import PropTypes from 'prop-types'
import { GameRoundState } from '../actions'

class Board extends React.Component {
    constructor(props){
        super(props)
        this.state = {
            board: props.board
        }
    }

    onMove(e, index) {
        const board = this.state.board
        if(board[index] != 0) {
            return;
        }
        board[index] = 1
        this.setState({
            board: board
        })
    }

    mapSpaceSymbol(space) {
        switch(space){
            case 1: return "X"
            case 2: return "O"
        }
        return " "
    }

    mapSpaceClass(space){
        switch(space){
            case 1: return "grid-item players-space"
            case 2: return "grid-item opponents-space"
        }
        return "grid-item available-space"
    }

    render(){
        const { gameState, gameId, _board, updateRound } = this.props
        setInterval(() => {
            if(gameState == GameRoundState.WAITING_UPDATE) updateRound(gameId)}
            , 1000);

        const MoveInfo = () => (<h3>Click empty cell to make your move</h3>)
        const isPlayersTurn = gameState == GameRoundState.PLAYER_1_MOVES

        const spaces = this.state.board.map((space, index) => 
            <div key={index} className={this.mapSpaceClass(space)} onClick={e => this.onMove(e, index)}>
                <div className="space-symbol">{this.mapSpaceSymbol(space)}</div>
            </div>)

        return (
            <div className="">
                {isPlayersTurn && <MoveInfo />}
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
    updateRound: PropTypes.func.isRequired
}

export default Board;