import { connect } from 'react-redux'
import { GameEvents } from '../actions'
import Board from '../components/Board'


const mapStateToProps = state => ({
  gameState: state.tictactoeFSM.gameState
})

const mapDispatchToProps = dispatch => ({
  makeMove: () =>  dispatch({type: GameEvents.MAKE_MOVE})
})

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Board)
