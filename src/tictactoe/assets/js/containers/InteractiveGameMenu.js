import { connect } from 'react-redux'
import { GameRoundState } from '../actions'
import GameMenu from '../components/GameMenu'


const mapStateToProps = state => ({
  gameState: state.tictactoeFSM.gameState
})

const mapDispatchToProps = dispatch => ({
  startGame: () =>  dispatch({type: GameRoundState.NOT_STARTED})
})

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(GameMenu)
