import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "clearButton", "form"]

  connect() {
    this.timeout = null
    this.toggleClearButton()
  }

  search(e) {
    console.log("search call")
    clearTimeout(this.timeout)

    this.toggleClearButton()

    this.timeout = setTimeout(() => {
      if (this.formTarget) this.formTarget.requestSubmit()
    }, 300)
  }


  clear() {
    this.inputTarget.value = ""
    this.toggleClearButton()
    this.formTarget.requestSubmit()
  }

  toggleClearButton() {
    this.clearButtonTarget.classList.toggle("hidden", !(this.inputTarget?.value?.trim()))
  }
}