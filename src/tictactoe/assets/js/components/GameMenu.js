import * as React from 'react'
import PropTypes from 'prop-types'
import { GameRoundState } from '../actions'

const GameMenu = ({ gameState, startGame }) => {
    const menuIsVisible = 
        gameState == GameRoundState.NOT_STARTED ||
        gameState == GameRoundState.PLAYER_1_WON ||
        gameState == GameRoundState.PLAYER_2_WON ||
        gameState == GameRoundState.DRAW
    if (!menuIsVisible) {
        return (null)
    }
    let header = (<h4>Menu</h4>)
    switch (gameState){
        case GameRoundState.PLAYER_1_WON: header = (<h4>Victory !</h4>); break;
        case GameRoundState.PLAYER_2_WON: header = (<h4>Defeat</h4>); break;
        case GameRoundState.DRAW: header = (<h4>DRAW</h4>); break;
    }

    return (
        <div className='card-img-overlay bg-gradient-light menu-as-popup mt-5'>
            <div className='card border-success large'>
                <div className="card-header">
                    {header}
                </div>
                <div className="card-body text-secondary">
                    <br />
                    <button id='start-easy-btn' className="btn-lg btn-success" 
                        onClick={startGame}>
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