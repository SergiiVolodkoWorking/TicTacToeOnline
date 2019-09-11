import * as React from 'react'
import PropTypes from 'prop-types'
import { GameRoundState } from '../actions'

const GameMenu = ({ gameState, startGame }) => {
    const menuIsVisible = gameState == GameRoundState.NOT_STARTED
    if(!menuIsVisible){
        return (null)
    }
    return(
        <div>
            <br />
            <button id='start-easy-btn' className="btn-lg btn-success" onClick ={() => startGame()}>
                <i className="fas fa-play-circle"></i> Start VS Easy bot
            </button>
            <br /><br />
        </div>
    )
}
  
GameMenu.propTypes = {
    gameState: PropTypes.string.isRequired,
    startGame: PropTypes.func.isRequired
}

export default GameMenu;