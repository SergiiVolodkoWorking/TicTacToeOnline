import * as React from 'react'
import PropTypes from 'prop-types'
import { GameRoundState } from '../actions'

const GameMenu = ({ roundState, startGame }) => {
    const isGameEnded =
        [GameRoundState.PLAYER_1_WON, GameRoundState.PLAYER_2_WON, GameRoundState.DRAW]
            .includes(roundState)
    const isMenuVisible =
        isGameEnded || roundState == GameRoundState.NOT_STARTED

    if (!isMenuVisible) {
        return (null)
    }
    let menuTitle = 'Menu'
    let cardStyle = 'card large '
    switch (roundState) {
        case GameRoundState.PLAYER_1_WON: {
            menuTitle = 'Victory !';
            cardStyle += 'menu-victory';
        } break;
        case GameRoundState.PLAYER_2_WON: {
            menuTitle = 'Defeat';
            cardStyle += 'menu-defeat';
        } break;
        case GameRoundState.DRAW: {
            menuTitle = 'Draw';
            cardStyle += 'menu-draw';
        } break;
        default: cardStyle += 'menu-not-started';
    }

    const btnStartEasyStyle = isGameEnded ? "btn-lg btn-light btn disabled" : "btn-lg btn-success"
    const btnStartHardStyle = isGameEnded ? "btn-lg btn-light btn disabled" : "btn-lg btn-danger"

    return (
        <div className='card-img-overlay bg-gradient-light menu-as-popup mt-5'>
            <div className={cardStyle}>
                <div className="card-header">
                    <h4>{menuTitle}</h4>
                </div>
                <div className="card-body text-secondary">
                    <button id='start-easy-btn' className={btnStartEasyStyle}
                        onClick={() => { if (!isGameEnded) startGame("bot_easy") }}>
                        <i className="fas fa-play-circle"></i> Start VS Easy bot
                    </button>
                    <br />
                    <button id='start-hard-btn' className={btnStartHardStyle}
                        onClick={() => { if (!isGameEnded) startGame("bot_hard") }}>
                        <i className="fas fa-play-circle"></i> Start VS Hard bot
                    </button>
                </div>
            </div>
        </div>
    )
}

GameMenu.propTypes = {
    roundState: PropTypes.string.isRequired,
    startGame: PropTypes.func.isRequired
}

export default GameMenu;