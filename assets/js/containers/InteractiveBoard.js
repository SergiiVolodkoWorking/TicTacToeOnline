import { connect } from 'react-redux'
import { GameEvents } from '../actions'
import Board from '../components/Board'
import { makePutRequest } from '../api'

const mapStateToProps = state => ({
  roundState: state.tictactoeFSM.roundState,
  gameId: state.tictactoeFSM.gameId,
  board: state.tictactoeFSM.board
})

const mapDispatchToProps = dispatch => ({
  makeMove: (gameId, space) => {
    const url = 'api/make_move/' + gameId
    const body = {
      game_id: gameId,
      taken_space: space
    }
    makePutRequest(
      url,
      body,
      data => dispatch({ type: GameEvents.PLAYER_MOVED, gameRound: data }))
  }
})

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Board)
