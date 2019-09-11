import React from 'react'
import InteractiveGameMenu from '../containers/InteractiveGameMenu'
import InteractiveBoard from '../containers/InteractiveBoard'
import Footer from './Footer'

class App extends React.Component {
    render(){
        return(
            <div>
                <h1>Welcome to Tic Tac Toe online!</h1>
                <InteractiveGameMenu />
                <InteractiveBoard />
                <hr />
                <Footer />
            </div>
    )}
}

export default App
