import { createStore, combineReducers, applyMiddleware } from 'redux';
import { reducer as reduxFormReducer } from 'redux-form';
import { register } from './reducers'
import thunk from 'redux-thunk'

const middleware = [ thunk ]

const reducer = combineReducers({
  register,
  form: reduxFormReducer,
});

const store = (window.devToolsExtension
  ? window.devToolsExtension()(createStore)
  : createStore)(reducer, applyMiddleware(...middleware));

export default store;
