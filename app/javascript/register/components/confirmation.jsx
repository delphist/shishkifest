import React from 'react';
import { connect } from 'react-redux'
import request from 'superagent'
import { Field, FieldArray, reduxForm, formValueSelector } from 'redux-form';
import Dropzone from 'react-dropzone';
import RenderField from './render-field'
import * as validations from './validations'
import { editForm, fetchRegistration } from '../actions'

class Confirmation extends React.Component {
  backToForm = e => {
    const { dispatch } = this.props
    e.preventDefault()
    dispatch(editForm())
  }

  submit(values) {
    const { dispatch, register, confirmation: { token } } = this.props
    const { code } = values
    dispatch(fetchRegistration(token, code, register))
  }

  formatNumber2Digit(number) {
    return ('0' + number).slice(-2)
  }

  resendAgainDifference() {
    const { receivedAt } = this.props.confirmation
    const { currentTime } = this.props
    return 120 - Math.ceil(Math.abs(currentTime - receivedAt) / 1000)
  }

  resendAgainLabel() {
    var difference = this.resendAgainDifference();

    if(difference > 0) {
      var minutes = Math.floor(difference / 60)
      var seconds = difference - (minutes * 60)
      return `Отправить еще раз (${this.formatNumber2Digit(minutes)}:${this.formatNumber2Digit(seconds)})`
    } else {
      return `Отправить еще раз`
    }
  }

  resendCode() {
    alert(1)
  }

  render() {
    const { error, handleSubmit, pristine, reset, submitting, confirmation: { phone } } = this.props

    var canResend = this.resendAgainDifference() <= 0

    return (
      <div>
        <h2>Подтвердите телефон</h2>
        <h6>Мы отправили вам смс на номер {phone} чтобы быть уверенными, что это ваш телефон</h6>
        <div className="rd-mailform-container">
          <form method="post" onSubmit={handleSubmit(::this.submit)} className="rd-mailform rd-mailform--skin-1">
            <fieldset className="input-container">
              <div>
                <Field
                  name="code"
                  component={RenderField}
                  type="text"
                  placeholder="Код подтверждения"
                  validate={[validations.required]}
                  />
              </div>
            </fieldset>
            <div className="mfControls text-center">
              <button
                className="btn btn-md btn-secondary"
                type="submit"
                disabled={submitting || !canResend}
                onClick={::this.resendCode}>
                {this.resendAgainLabel()}
              </button>
              <button className="btn btn-md btn-secondary-2" type="submit" disabled={submitting}>Подтвердить</button>
            </div>
            <div className="text-center">
              <a href="/" onClick={::this.backToForm}>Вернуться к редактированию</a>
            </div>
          </form>
        </div>
      </div>
    )
  }
}

const selector = formValueSelector('register')

Confirmation = reduxForm({
  form: 'confirmation'
})(Confirmation)

Confirmation = connect(
  state => ({
    confirmation: state.register.confirmation,
    currentTime: state.register.currentTime,
    register: selector(state, 'phone', 'name', 'license', 'photos', 'about'),
  })
)(Confirmation)

export default Confirmation
