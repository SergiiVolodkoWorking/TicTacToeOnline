import React from 'react'
import { render } from 'react-dom'
import { createStore, applyMiddleware } from 'redux'
import { Provider } from 'react-redux'

import App from './components/App'
import {gameRoundPoolingMiddleware} from './actions/gameRoundPoolingMiddleware'
import rootReducer from './reducers'
import appCss from './../css/app.css'

const store = createStore(rootReducer, applyMiddleware(gameRoundPoolingMiddleware))

render(
  <Provider store={store}>
    <App />
  </Provider>,
  document.getElementById('root')
)