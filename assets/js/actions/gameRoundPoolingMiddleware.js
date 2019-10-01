import { makeGetRequest } from '../api'
import { GameRoundState, GameEvents } from '.'

let interval = null;

export const gameRoundPoolingMiddleware = function (store) {
    const updateRound = () => {
        const currentRoundState = store.getState().tictactoeFSM.roundState;
        if (currentRoundState !== GameRoundState.WAITING_UPDATE) {
            return;
        }

        const game_id = store.getState().tictactoeFSM.gameId;
        makeGetRequest(
            'api/game/' + game_id,
            data => store.dispatch({ type: GameEvents.ROUND_STATE_FETCHED, gameRound: data })
        );
    };

    if (!interval) {
        interval = setInterval(updateRound, 600);
    }

    return next => action => next(action);
}