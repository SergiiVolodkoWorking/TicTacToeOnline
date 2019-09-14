import { connect } from 'react-redux'
import { GameEvents } from '../actions'
import GameMenu from '../components/GameMenu'

import { makePostRequest } from '../api'

const mapStateToProps = state => ({
  gameState: state.tictactoeFSM.gameState
})

const mapDispatchToProps = dispatch => ({
  startGame: () => {
    const body = { game_id: new Date().getTime() }
    makePostRequest(
      'api/start_game',
      body,
      data => dispatch({ type: GameEvents.START_ROUND }))
  }
})

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(GameMenu)
