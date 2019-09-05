import React from 'react'
import ReactDOM from 'react-dom'

import GameMenu from './components/GameMenu'
import Board from './components/Board'

const Main = () => 
    <div>
        <h1>Tic Tac Toe will be here soon!</h1>
        <GameMenu />
        <Board />
    </div>

ReactDOM.render(<Main />, document.getElementById('react-root'))