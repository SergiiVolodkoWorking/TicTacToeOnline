
import { GameRoundState, GameEvents } from '../actions'

const empty = "EMPTY"
const initialState = {
    round_state: GameRoundState.NOT_STARTED,
    board: [empty, empty, empty, empty, empty, empty, empty, empty, empty]
}

const tictactoeFSM = function (state = initialState, action) {
    const event = action.type;
    const currentGameRound = state;
    const currentState = state.round_state;
    const gameRoundFromServer = action.game_round;

    switch (true) {

        case event == GameEvents.START_ROUND &&
            currentState == GameRoundState.NOT_STARTED:
            return {
                round_state: GameRoundState.WAITING_UPDATE,
                game_id: gameRoundFromServer.game_id,
                board: gameRoundFromServer.board
            }

        case event == GameEvents.ROUND_STATE_FETCHED &&
            currentState == GameRoundState.WAITING_UPDATE:
            return {
                round_state: gameRoundFromServer.round_state,
                game_id: gameRoundFromServer.game_id,
                board: gameRoundFromServer.board
            }

        case event == GameEvents.PLAYER_MOVED &&
            currentState == GameRoundState.PLAYER_1_MOVES:
            return {
                round_state: GameRoundState.WAITING_UPDATE,
                game_id: gameRoundFromServer.game_id,
                board: currentGameRound.board
            }

        default: return currentGameRound;

        // Will be available once issue with multiple timers is resolved
        // { event: GameEvents.START_ROUND, from: GameRoundState.PLAYER_1_WON, to: GameRoundState.WAITING_UPDATE },
        // { event: GameEvents.START_ROUND, from: GameRoundState.PLAYER_2_WON, to: GameRoundState.WAITING_UPDATE },
        // { event: GameEvents.START_ROUND, from: GameRoundState.DRAW, to: GameRoundState.WAITING_UPDATE },

    }
}

export default tictactoeFSM