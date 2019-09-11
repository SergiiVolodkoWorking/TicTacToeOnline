import { connect } from 'react-redux'
import { GameActions } from '../actions'
import GameMenu from '../components/GameMenu'

const mapStateToProps = state => ({
  gameState: state.tictactoeFSM.gameState
})

const mapDispatchToProps = dispatch => ({
  startGame: () =>  {
    dispatch({type: GameActions.START_ROUND})

    fetch('api/start_game', {method: 'POST'})
        .then(response => { return response.json(); })
        .then(data => dispatch({type: GameActions.START_ROUND}) )
    }
})

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(GameMenu)
