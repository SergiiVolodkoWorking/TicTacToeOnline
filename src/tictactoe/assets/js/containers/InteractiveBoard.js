import { connect } from 'react-redux'
import { GameRoundState } from '../actions'
import Board from '../components/Board'


const mapStateToProps = state => ({
  gameState: state.tictactoeFSM.gameState
})

const mapDispatchToProps = dispatch => ({
  makeMove: () =>  dispatch({type: GameRoundState.PLAYER_MOVES})
})

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Board)
