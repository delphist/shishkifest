import React from 'react';
import { Field } from 'redux-form';

export default class RenderField extends React.Component {
  renderInput() {
    const { input, meta, placeholder, type } = this.props

    if(type == 'textarea') {
      return (
        <textarea {...input} placeholder={placeholder} />
      )
    } else {
      return (
        <input {...input} placeholder={placeholder} type={type} />
      )
    }
  }

  render() {
    const { meta } = this.props

    return (
      <label data-add-placeholder="">
        {this.renderInput()}
        {meta.touched && meta.error && <span className="mfValidation show error" data-index="0">{meta.error}</span>}
        {meta.touched && !meta.error && meta.warning && <span className="mfValidation show warn" data-index="0">{meta.warning}</span>}
      </label>
    )
  }
}
