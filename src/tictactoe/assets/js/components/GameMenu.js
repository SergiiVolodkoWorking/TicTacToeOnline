import * as React from 'react'
import PropTypes from 'prop-types'

const GameMenu = ({ gameState, startGame }) => (
    <div>
        <h2>Game Menu will be here</h2>
        <button id='start-easy-btn' className="btn-lg btn-success" onClick ={() => startGame()}>
            <i className="fas fa-play-circle"></i> Start VS Easy bot
        </button>
    </div>
  )
  
GameMenu.propTypes = {
    gameState: PropTypes.string.isRequired,
    startGame: PropTypes.func.isRequired
}

export default GameMenu;