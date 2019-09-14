import React from 'react'
import Spinner from '../containers/Spinner'
import InteractiveGameMenu from '../containers/InteractiveGameMenu'
import InteractiveBoard from '../containers/InteractiveBoard'
import Footer from './Footer'

class App extends React.Component {
    render() {
        return (
            <div>
                <h1 className='tictactoe-header'>Welcome to Tic Tac Toe online!</h1>
                <Spinner />
                <InteractiveBoard />
                <InteractiveGameMenu />
                <hr />
                <Footer />
            </div>
        )
    }
}

export default App
