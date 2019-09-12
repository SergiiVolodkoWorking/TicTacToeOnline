import { connect } from 'react-redux'
import { GameActions } from '../actions'
import GameMenu from '../components/GameMenu'

const mapStateToProps = state => ({
  gameState: state.tictactoeFSM.gameState
})

const mapDispatchToProps = dispatch => ({
  startGame: () =>  {
    var body = {game_id: new Date().getTime()}
    const settings = {
      method: 'POST',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(body)
    }

    fetch('api/start_game', settings)
        .then(response => { return response.json(); })
        .then(data => {console.log(data); return dispatch({type: GameActions.START_ROUND})} )
    }
})

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(GameMenu)
