import React from 'react';
import { connect } from 'react-redux'
import Form from './form';
import Confirmation from './confirmation';
import Success from './success';
import { updateTime } from '../actions'

class Register extends React.Component {
  setTime() {
    const { dispatch } = this.props
    dispatch(updateTime())
  }

  componentWillMount() {
    this.setTime()
  }

  componentDidMount(){
     window.setInterval(function () {
      this.setTime();
    }.bind(this), 1000);
  }

  render() {
    const { isFetching, currentStep } = this.props

    return (
      <div className="container">
        { isFetching && (
          <span>Загрузка</span>
        )}
        { currentStep == 'form' && <Form /> }
        { currentStep == 'confirmation' && <Confirmation /> }
        { currentStep == 'success' && <Success /> }
      </div>
    )
  }
}

const mapStateToProps = state => {
  const { register: { isFetching, currentStep } } = state
  return {
    isFetching, currentStep
  }
}

export default connect(mapStateToProps)(Register)
