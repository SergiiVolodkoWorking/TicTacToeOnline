export const GameRoundState = Object.freeze({
  NOT_STARTED: 'NOT_STARTED',
  PLAYER_TURN_FROM_SERVER: 'PLAYER_TURN_FROM_SERVER',
  PLAYER_1_MOVES: 'PLAYER_1_MOVES',
  PLAYER_2_MOVES: 'PLAYER_2_MOVES',
  WAITING_UPDATE: 'WAITING_UPDATE',
  PLAYER_WON: 'PLAYER_WON',
  DRAW: 'DRAW',
})

export const GameEvents = Object.freeze({
  START_ROUND: 'START_ROUND',
  ROUND_STATE_FETCHED: 'ROUND_STATE_FETCHED',
  MAKE_MOVE: 'MAKE_MOVE',
  SHOW_RESULT: 'SHOW_RESULT'
})