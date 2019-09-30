import { makeGetRequest } from '../api'
import { GameRoundState, GameEvents } from '.'

let interval = null;

export const gameRoundPoolingMiddleware = function(store) {
    // Called when calling applyMiddleware so
    // our middleware can have access to the store

    const updateRound = () => {
        const currentRoundState = store.getState().tictactoeFSM.round_state;

        if (currentRoundState === GameRoundState.WAITING_UPDATE) {
            const game_id = store.getState().tictactoeFSM.game_id;
            makeGetRequest( 
                'api/game/' + game_id,
                data => store.dispatch({ type: GameEvents.ROUND_STATE_FETCHED, game_round: data })
            );
        }
    };

    if (!interval) {
        interval = setInterval(updateRound, 1000);
    }

    return next => action => next(action);
}