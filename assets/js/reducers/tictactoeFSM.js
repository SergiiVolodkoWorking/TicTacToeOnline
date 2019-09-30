
import { GameRoundState, GameEvents, transitToNewGameRound } from '../actions'

const empty = "EMPTY"
const initialState = {
    gameState: GameRoundState.NOT_STARTED,
    board: [empty, empty, empty, empty, empty, empty, empty, empty, empty]
}

const allTransitions = [
    { event: GameEvents.START_ROUND,         from: GameRoundState.NOT_STARTED,    to: GameRoundState.WAITING_UPDATE,          aggregateGameRound: transitToNewGameRound },
    { event: GameEvents.ROUND_STATE_FETCHED, from: GameRoundState.WAITING_UPDATE, to: GameRoundState.PLAYER_TURN_FROM_SERVER, aggregateGameRound: transitToNewGameRound },
    { event: GameEvents.PLAYER_MOVED,        from: GameRoundState.PLAYER_1_MOVES, to: GameRoundState.WAITING_UPDATE },

    // Will be available once issue with multiple timers is resolved
    // { event: GameEvents.START_ROUND, from: GameRoundState.PLAYER_1_WON, to: GameRoundState.WAITING_UPDATE },
    // { event: GameEvents.START_ROUND, from: GameRoundState.PLAYER_2_WON, to: GameRoundState.WAITING_UPDATE },
    // { event: GameEvents.START_ROUND, from: GameRoundState.DRAW, to: GameRoundState.WAITING_UPDATE },
]

const tictactoeFSM = function (state = initialState, action) {
    console.log(action)
    const event = action.type
    const currentState = state.gameState;

    const transition = allTransitions.find(function (t) {
        return t.event === event &&
            t.from === currentState;
    });

    const currentGameRound = state;
    console.log("Current", currentGameRound)
    if (!transition) {
        return currentGameRound;
    }
    const gameRoundFromServer = action.game_round;

    let newGameRound = currentGameRound;
    if(transition.aggregateGameRound) {
        newGameRound = transition.aggregateGameRound(gameRoundFromServer, transition.to)
    }
    console.log("New", newGameRound)
    return newGameRound;
}

export default tictactoeFSM