import React from 'react'
import ReactDOM from 'react-dom'

import GameMenu from './components/GameMenu'
import Board from './components/Board'
import Footer from './components/Footer'


// const Footer = class Footer extends React.Component {
//     componentDidMount() {alert("ok")}

//     render() {
//         return(
//         <div>Version:</div>)
//       }
// }

const Main = () => 
    <div>
        <header>
            <h1>Tic Tac Toe will be here soon!</h1>
            <GameMenu />
            <Board />
        </header>
        <Footer />
    </div>

ReactDOM.render(<Main />, document.getElementById('react-root'))