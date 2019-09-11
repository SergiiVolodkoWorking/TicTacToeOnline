import { connect } from 'react-redux'
import { GameActions } from '../actions'
import Board from '../components/Board'


const mapStateToProps = state => ({
  gameState: state.tictactoeFSM.gameState
})

const mapDispatchToProps = dispatch => ({
  makeMove: () =>  dispatch({type: GameActions.MAKE_MOVE})
})

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Board)
