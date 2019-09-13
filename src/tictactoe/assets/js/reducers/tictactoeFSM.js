
import { GameRoundState, GameEvents } from '../actions'

const initialState = {
    gameState: GameRoundState.NOT_STARTED
}

const allTransitions = [
    {event: GameEvents.START_ROUND, from: GameRoundState.NOT_STARTED, to: GameRoundState.WAITING_UPDATE }
    // WAITING_UPDATE + GET_ROUND_STATE => PLAYER_1_MOVES / PLAYER_2_MOVES / PLAYER_WON / DRAW
    // PLAYER_1_MOVES + MAKE_MOVE => WAITING_UPDATE
    // PLAYER_2_MOVES + GET_ROUND_STATE => PLAYER_1_MOVES / PLAYER_2_MOVES / PLAYER_WON / DRAW
    // PLAYER_WON / DRAW + SHOW_RESULT => ROUND_COMPLETED
]

const tictactoeFSM = function(state = initialState, action) {
    var event = action.type

    var currentState = state.gameState;
    var transition = allTransitions.find(function(t) {
        return t.event === event &&
                t.from === currentState;
    });

    if (!transition) {
        return state;
    }
    return { gameState: transition.to }
}

export default tictactoeFSM