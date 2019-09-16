import * as React from 'react'
import PropTypes from 'prop-types'
import { GameRoundState } from '../actions'

class Board extends React.Component {

    constructor(props){
        super(props)
        this.state = {
            board: props.board,
            symbolClass: ""
        }
    }

    onMove(e, index) {
        const board = this.state.board
        board[index] = 1
        this.setState({
            board: board,
            symbolClass: "grid-item-symbol"
        })
        console.log(e)
    }

    mapSpaceSymbol(space) {
        switch(space){
            case 1: return "X"
            case 2: return "O"
        }
        return " "
    }

    render(){
        const { gameState, gameId, _board, updateRound } = this.props
        setInterval(() => {
            if(gameState == GameRoundState.WAITING_UPDATE) updateRound(gameId)}
            , 1000);

        const MoveInfo = () => (<h3>Click empty cell to make your move</h3>)
        const isPlayersTurn = gameState == GameRoundState.PLAYER_1_MOVES

        const spaces = this.state.board.map((space, index) => 
            <div key={index} className="grid-item" onClick={e => this.onMove(e, index)}>
                <div className="grid-item-symbol">{this.mapSpaceSymbol(space)}</div>
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