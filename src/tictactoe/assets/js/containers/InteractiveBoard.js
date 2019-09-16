import { connect } from 'react-redux'
import { GameEvents } from '../actions'
import Board from '../components/Board'
import { makeGetRequest } from '../api'

const mapStateToProps = state => ({
  gameState: state.tictactoeFSM.gameState,
  gameId: state.tictactoeFSM.game_id,
  board: state.tictactoeFSM.board
})

const mapDispatchToProps = dispatch => ({
  updateRound: game_id => {
    makeGetRequest(
      'api/game/' + game_id,
      data => dispatch({ type: GameEvents.ROUND_STATE_FETCHED, game_round: data }))
  }
})

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Board)
