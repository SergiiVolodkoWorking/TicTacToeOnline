import React from 'react'
import InteractiveGameMenu from '../containers/InteractiveGameMenu'
import Board from './Board'
import Footer from './Footer'

class App extends React.Component {
    render(){
        return(
            <div>
                <h1>Tic Tac Toe will be here soon!</h1>
                <InteractiveGameMenu />
                <Board />
                <hr />
                <Footer />
            </div>
    )}
}

export default App
