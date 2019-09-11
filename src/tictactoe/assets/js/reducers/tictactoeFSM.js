
import { GameRoundState, GameActions } from '../actions'

const initialState = {
    gameState: GameRoundState.NOT_STARTED
}

const tictactoeFSM = function(state = initialState, action) {
    switch(action.type) {
        case GameActions.START_ROUND:
            return { gameState: GameRoundState.PLAYER_MOVES }
    }
    return state
}

export default tictactoeFSM