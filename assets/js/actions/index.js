export const GameRoundState = Object.freeze({
  NOT_STARTED: 'NOT_STARTED',
  PLAYER_TURN_FROM_SERVER: 'PLAYER_TURN_FROM_SERVER',
  PLAYER_1_MOVES: 'PLAYER_1_MOVES',
  PLAYER_2_MOVES: 'PLAYER_2_MOVES',
  WAITING_UPDATE: 'WAITING_UPDATE',
  PLAYER_1_WON: 'PLAYER_1_WON',
  PLAYER_2_WON: 'PLAYER_2_WON',
  DRAW: 'DRAW',
})

export const GameEvents = Object.freeze({
  START_ROUND: 'START_ROUND',
  ROUND_STATE_FETCHED: 'ROUND_STATE_FETCHED',
  PLAYER_MOVED: 'PLAYER_MOVED',
  SHOW_RESULT: 'SHOW_RESULT'
})

export const transitToNewGameRound = function (gameRoundFromServer, transition_to) {
  if (transition_to === GameRoundState.PLAYER_TURN_FROM_SERVER) {
    transition_to = gameRoundFromServer.round_state
  }
  return {
      game_id: gameRoundFromServer.game_id,
      board: gameRoundFromServer.board,
      gameState: transition_to
  }
}