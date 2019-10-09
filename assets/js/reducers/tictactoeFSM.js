
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
            [GameRoundState.NOT_STARTED,
             GameRoundState.PLAYER_1_WON,
             GameRoundState.PLAYER_2_WON,
             GameRoundState.DRAW]
                .includes(currentState):
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

        case event === GameEvents.START_ROUND &&
            currentState === GameRoundState.PLAYER_1_WON:
            return {
                roundState: GameRoundState.WAITING_UPDATE,
                gameId: gameRoundFromServer.game_id,
                board: gameRoundFromServer.board
            }

        default: return currentGameRound;
    }
}

export default tictactoeFSM