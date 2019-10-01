
import { GameRoundState, GameEvents } from '../actions'

const empty = "EMPTY"
const initialState = {
    roundState: GameRoundState.NOT_STARTED,
    board: [empty, empty, empty, empty, empty, empty, empty, empty, empty]
}

const tictactoeFSM = function (state = initialState, action) {
    const event = action.type;
    const currentGameRound = state;
    const currentState = state.roundState;
    const gameRoundFromServer = action.gameRound;

    switch (true) {

        case event === GameEvents.START_ROUND &&
            currentState === GameRoundState.NOT_STARTED:
            return {
                roundState: GameRoundState.WAITING_UPDATE,
                gameId: gameRoundFromServer.game_id,
                board: gameRoundFromServer.board
            }

        case event === GameEvents.ROUND_STATE_FETCHED &&
            currentState === GameRoundState.WAITING_UPDATE:
            return {
                roundState: gameRoundFromServer.round_state,
                gameId: gameRoundFromServer.game_id,
                board: gameRoundFromServer.board
            }

        case event === GameEvents.PLAYER_MOVED &&
            currentState === GameRoundState.PLAYER_1_MOVES:
            return {
                roundState: GameRoundState.WAITING_UPDATE,
                gameId: gameRoundFromServer.game_id,
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