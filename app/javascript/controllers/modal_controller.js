// modal_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["typeDisplay", "typeInput", "dialog"]
  static values = { type: String }

  connect() {
    this.modal = this.dialogTarget
  }

  open(e) {

    this.typeDisplayTarget.textContent = e.currentTarget.dataset.modalTypeValue
    this.modal.parentElement.classList.remove('hidden')
  }

  close() {
    this.modal.parentElement.classList.add('hidden')
  }
}