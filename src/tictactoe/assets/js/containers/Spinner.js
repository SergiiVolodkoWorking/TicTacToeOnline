import * as React from 'react'
import PropTypes from 'prop-types'
import { GameRoundState } from '../actions'
import { connect } from 'react-redux'

const Spinner = ({ gameState }) => {
    const isLoading = gameState == GameRoundState.WAITING_UPDATE
    if(!isLoading){
        return (null)
    }
    return(
        <div className="spinner-blocker">
            <p className="spinner-text">Waiting for response...</p>
            <div className="spinner-circle fa-spin"></div>
        </div>
    )
}
  
Spinner.propTypes = {
    gameState: PropTypes.string.isRequired
}

const mapStateToProps = state => (
    { gameState: state.tictactoeFSM.gameState })
  
export default connect(
    mapStateToProps,
    null
)(Spinner)