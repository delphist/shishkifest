import request from 'superagent'
import { SubmissionError } from 'redux-form';

export const FETCH = 'FETCH'
export const FETCH_FAILED = 'FETCH_FAILED'
export const UPDATE_TIME = 'UPDATE_TIME'
export const EDIT_FORM = 'EDIT_FORM'
export const VIEW_CONFIRMATION = 'VIEW_CONFIRMATION'
export const RECIEVE_CONFIRMATION = 'RECIEVE_CONFIRMATION'
export const RECIEVE_REGISTRATION = 'RECIEVE_REGISTRATION'

export const fetch = () => ({
  type: FETCH,
})

export const fetchFailed = (error) => ({
  type: FETCH_FAILED,
  error: error
})

export const updateTime = () => ({
  type: UPDATE_TIME,
})

export const editForm = () => ({
  type: EDIT_FORM,
})

export const viewConfirmation = () => ({
  type: VIEW_CONFIRMATION,
})

export const recieveConfirmation = (phone, response) => ({
  type: RECIEVE_CONFIRMATION,
  phone: phone,
  token: response.token,
  receivedAt: Date.now()
})

export const recieveRegistration = (response) => ({
  type: RECIEVE_REGISTRATION,
  id: response.id
})

export const fetchRegistration = (token, code, values) => dispatch => {
  dispatch(fetch())
  var { photos, ...rest } = values
  return request
    .post('/api/members')
    .send({
      token: token,
      code: code,
      photos: Array.isArray(photos) ? photos.map((e) => (
        { id: e.id }
      )) : [],
      ...rest
    })
    .end((error, response) => {
      if (error || !response.ok) {
        return dispatch(fetchFailed())
      } else {
        return dispatch(recieveRegistration(response.body))
      }
    })
}

const fetchConfirmation = phone => dispatch => {
  dispatch(fetch())
  return request
    .post('/api/sms_confirmations')
    .send({ phone: phone })
    .end((error, response) => {
      if (error || !response.ok) {
        return dispatch(fetchFailed())
      } else {
        return dispatch(recieveConfirmation(phone, response.body))
      }
    })
}

const shouldFetchConfirmation = (state, phone) => {
  return state.register.confirmation.phone != phone
}

export const fetchConfirmationIfNeeded = phone => (dispatch, getState) => {
  if (shouldFetchConfirmation(getState(), phone)) {
    return dispatch(fetchConfirmation(phone))
  } else {
    return dispatch(viewConfirmation(phone))
  }
}
