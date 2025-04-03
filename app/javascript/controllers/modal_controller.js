import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["typeDisplay", "typeInput", "dialog"]
  static values = { type: String }

  connect() {
    this.modal = this.dialogTarget
  }

  open(e) {
    const type = e.currentTarget.dataset.modalTypeValue
    this.typeDisplayTarget.textContent = type
    this.typeInputTarget.value = type
    this.modal.parentElement.classList.remove('hidden')
    this.checkType(type)
  }

  checkType(type) {
    const form = document.getElementById(type.toString().toLowerCase() + "_form")
    form.classList.remove('hidden')
  }

  close() {
    this.modal.parentElement.classList.add('hidden')
  }
}