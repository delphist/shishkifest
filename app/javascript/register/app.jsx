import React from 'react';
import { Provider } from 'react-redux'
import store from './store';
import Register from './components/register';

export default class App extends React.Component {
  render() {
    return (
      <Provider store={store}>
        <Register />
      </Provider>
    )
  }
}
