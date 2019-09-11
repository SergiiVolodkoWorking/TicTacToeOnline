import * as React from 'react'
import PropTypes from 'prop-types'
import { GameRoundState } from '../actions'

const GameMenu = ({ gameState, startGame }) => {
    const menuIsVisible = gameState == GameRoundState.NOT_STARTED
    if(!menuIsVisible){
        return (null)
    }
    return(
        <div className='card-img-overlay bg-gradient-light menu-as-popup mt-5'>
            <div className='card border-success large'>
                <div className="card-header">
                    <h4>Menu</h4>
                </div>
                <div className="card-body text-secondary">
                    <br />
                    <button id='start-easy-btn' className="btn-lg btn-success" onClick ={() => startGame()}>
                        <i className="fas fa-play-circle"></i> Start VS Easy bot
                    </button>
                    <br /><br />
                </div>
            </div>
        </div>
    )
}
  
GameMenu.propTypes = {
    gameState: PropTypes.string.isRequired,
    startGame: PropTypes.func.isRequired
}

export default GameMenu;