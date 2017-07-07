import React from 'react';
import { connect } from 'react-redux'
import request from 'superagent'
import { Field, FieldArray, reduxForm, formValueSelector } from 'redux-form';
import Dropzone from 'react-dropzone';
import RenderField from './render-field'
import * as validations from './validations'
import { fetchConfirmation } from '../actions'

export default class Confirmation extends React.Component {
  render() {
    const { error, handleSubmit, pristine, reset, submitting } = this.props

    return (
      <div>
        <h2>Поздравляем!</h2>
        <h6>Ваша заявка отправлена на рассмотрение. Вы получите ответ на ваш смс-номер о результате.</h6>
      </div>
    )
  }
}
