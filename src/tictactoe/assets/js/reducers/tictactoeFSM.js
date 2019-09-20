
import { GameRoundState, GameEvents } from '../actions'

const initialState = {
    gameState: GameRoundState.NOT_STARTED,
    board: [0, 0, 0, 0, 0, 0, 0, 0, 0]
}

const allTransitions = [
    { event: GameEvents.START_ROUND, from: GameRoundState.NOT_STARTED, to: GameRoundState.WAITING_UPDATE },
    { event: GameEvents.ROUND_STATE_FETCHED, from: GameRoundState.WAITING_UPDATE, to: GameRoundState.PLAYER_TURN_FROM_SERVER },
    { event: GameEvents.PLAYER_MOVED, from: GameRoundState.PLAYER_1_MOVES, to: GameRoundState.WAITING_UPDATE },
    
    { event: GameEvents.START_ROUND, from: GameRoundState.PLAYER_1_WON, to: GameRoundState.WAITING_UPDATE },
    { event: GameEvents.START_ROUND, from: GameRoundState.PLAYER_2_WON, to: GameRoundState.WAITING_UPDATE },
    { event: GameEvents.START_ROUND, from: GameRoundState.DRAW, to: GameRoundState.WAITING_UPDATE },
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
    
    const game_round = mapGameRound(action.game_round, state)
    const transition_to = mapNewState(game_round, transition.to)
    return { 
        gameState: transition_to,
        game_id: game_round.game_id,
        board: game_round.board
    }
}

const mapGameRound = function(gameRoundData, currentState){
    let gameRound = {}

    if(gameRoundData.game_id){
        gameRound.game_id = gameRoundData.game_id
    }

    if(gameRoundData.round_state){
        gameRound.round_state = gameRoundData.round_state
    }
    
    if(gameRoundData.board){
        gameRound.board = gameRoundData.board
    }
    else{
        gameRound.board = currentState.board
    }

    return gameRound
}

const mapNewState = function(game_round, transition_to){
    
    if(!game_round.round_state){
        return transition_to
    }
    if(transition_to == GameRoundState.PLAYER_TURN_FROM_SERVER){
        switch(game_round.round_state){
            case 1: return GameRoundState.PLAYER_1_MOVES
            case 2: return GameRoundState.PLAYER_2_MOVES
            case 3: return GameRoundState.PLAYER_1_WON
            case 4: return GameRoundState.PLAYER_2_WON
            case 5: return GameRoundState.DRAW
        }
    }
    return transition_to
}

export default tictactoeFSM