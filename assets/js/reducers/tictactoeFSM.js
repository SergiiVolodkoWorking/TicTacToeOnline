
import { GameRoundState, GameEvents, setGameId, updateGameRound, cloneCurrentGameRound } from '../actions'

const empty = "EMPTY"
const initialState = {
    gameState: GameRoundState.NOT_STARTED,
    board: [empty, empty, empty, empty, empty, empty, empty, empty, empty]
}

const allTransitions = [
    { event: GameEvents.START_ROUND, from: GameRoundState.NOT_STARTED, to: GameRoundState.WAITING_UPDATE, onEvent: setGameId },
    { event: GameEvents.ROUND_STATE_FETCHED, from: GameRoundState.WAITING_UPDATE, to: GameRoundState.PLAYER_TURN_FROM_SERVER, onEvent: updateGameRound },
    { event: GameEvents.PLAYER_MOVED, from: GameRoundState.PLAYER_1_MOVES, to: GameRoundState.WAITING_UPDATE },

    // Will be available once issue with multiple timers is resolved
    // { event: GameEvents.START_ROUND, from: GameRoundState.PLAYER_1_WON, to: GameRoundState.WAITING_UPDATE },
    // { event: GameEvents.START_ROUND, from: GameRoundState.PLAYER_2_WON, to: GameRoundState.WAITING_UPDATE },
    // { event: GameEvents.START_ROUND, from: GameRoundState.DRAW, to: GameRoundState.WAITING_UPDATE },
]

const tictactoeFSM = function (state = initialState, action) {
    const event = action.type
    const currentState = state.gameState;

    const transition = allTransitions.find(function (t) {
        return t.event === event &&
            t.from === currentState;
    });
    if (!transition) {
        return state;
    }

    const currentGameRound = state;
    const gameRoundFromServer = action.game_round;
    
    let newGameRound = currentGameRound;
    if(transition.onEvent) {
        newGameRound = transition.onEvent(gameRoundFromServer, currentGameRound)
    }
    const transition_to = mapNewState(newGameRound, transition.to)

    return {
        gameState: transition_to,
        game_id: newGameRound.game_id,
        board: newGameRound.board
    }
}

const mapNewState = function (game_round, transition_to) {
    if (!game_round.round_state) {
        return transition_to
    }
    if (transition_to == GameRoundState.PLAYER_TURN_FROM_SERVER) {
        return game_round.round_state
    }
    return transition_to
}

export default tictactoeFSM