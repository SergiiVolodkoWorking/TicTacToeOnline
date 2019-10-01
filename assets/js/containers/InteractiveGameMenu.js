import { connect } from 'react-redux'
import { GameEvents } from '../actions'
import GameMenu from '../components/GameMenu'

import { makePostRequest } from '../api'

const mapStateToProps = state => ({
  roundState: state.tictactoeFSM.roundState
})

const mapDispatchToProps = dispatch => ({
  startGame: () => {
    const body = { game_id: new Date().getTime() }
    makePostRequest(
      'api/start_game',
      body,
      data => dispatch({ type: GameEvents.START_ROUND, gameRound: data }))
  }
})

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(GameMenu)
