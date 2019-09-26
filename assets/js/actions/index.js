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


export const setGameId = function (gameRoundFromServer, currentGameRound){
  return {
      game_id: gameRoundFromServer.game_id,
      board: currentGameRound.board
  }
}

export const updateGameRound = function (gameRoundFromServer){
  return {
      game_id: gameRoundFromServer.game_id,
      round_state: gameRoundFromServer.round_state,
      board: gameRoundFromServer.board
  }
}