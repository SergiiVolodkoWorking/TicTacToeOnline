import * as React from 'react'
import PropTypes from 'prop-types'
import { GameRoundState } from '../actions'
import { connect } from 'react-redux'

const Spinner = ({ roundState }) => {
    const isLoading = roundState == GameRoundState.WAITING_UPDATE
    if (!isLoading) {
        return (null)
    }
    return (
        <div className="spinner-blocker">
            <p className="spinner-text">Waiting for response...</p>
            <div className="spinner-circle fa-spin"></div>
        </div>
    )
}

Spinner.propTypes = {
    roundState: PropTypes.string.isRequired
}

const mapStateToProps = state => ({ roundState: state.tictactoeFSM.roundState })

export default connect(
    mapStateToProps,
    null
)(Spinner)