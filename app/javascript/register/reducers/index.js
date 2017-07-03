import { combineReducers } from 'redux'
import {
  FETCH, FETCH_FAILED, RECIEVE_CONFIRMATION, RECIEVE_REGISTRATION,
  EDIT_FORM, VIEW_CONFIRMATION, UPDATE_TIME
} from '../actions'

export const register = (state = {
  isFetching: false,
  currentStep: 'form',
  currentTime: Date.now(),
  memberId: null,
  confirmation: {
    token: null,
    phone: null,
    receivedAt: null
  },
  error: null
}, action) => {
  switch (action.type) {
    case UPDATE_TIME:
      return {
        ...state,
        currentTime: Date.now()
      }
    case FETCH:
      return {
        ...state,
        isFetching: true
      }
    case RECIEVE_REGISTRATION:
      return {
        ...state,
        isFetching: false,
        currentStep: 'success',
        memberId: action.id
      }
    case RECIEVE_CONFIRMATION:
      return {
        ...state,
        isFetching: false,
        currentStep: 'confirmation',
        confirmation: {
          token: action.token,
          phone: action.phone,
          receivedAt: action.receivedAt
        }
      }
    case FETCH_FAILED:
      return {
        ...state,
        isFetching: false,
        error: action.error
      }
    case EDIT_FORM:
      return {
        ...state,
        currentStep: 'form',
        isFetching: false,
        error: null
      }
    case VIEW_CONFIRMATION:
      return {
        ...state,
        currentStep: 'confirmation',
        isFetching: false
      }
    default:
      return state
  }
}
