export const GameRoundState = Object.freeze({
  NOT_STARTED: 'NOT_STARTED',
  PLAYER_1_MOVES: 'PLAYER_1_MOVES',
  PLAYER_2_MOVES: 'PLAYER_2_MOVES',
  WAITING_UPDATE: 'WAITING_UPDATE',
  PLAYER_WON: 'PLAYER_WON',
  DRAW: 'DRAW',
})

export const GameEvents = Object.freeze({
  START_ROUND: 'START_ROUND',
  GET_ROUND_STATE: 'GET_ROUND_STATE',
  MAKE_MOVE: 'MAKE_MOVE',
  SHOW_RESULT: 'SHOW_RESULT'
})