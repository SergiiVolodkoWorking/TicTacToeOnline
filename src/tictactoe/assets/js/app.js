import React from 'react'
import ReactDOM from 'react-dom'

import GameMenu from './components/GameMenu'
import Board from './components/Board'
import Footer from './components/Footer'

// Important for bootstrap js to work
import $ from 'jquery';
window.jQuery = $;
window.$ = $;

const Main = () =>
    <div>
        <h1>Tic Tac Toe will be here soon!</h1>
        <GameMenu />
        <Board />
        <hr />
        <Footer />
    </div>

ReactDOM.render(<Main />, document.getElementById('react-root'))