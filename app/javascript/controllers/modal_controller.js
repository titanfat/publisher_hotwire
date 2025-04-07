import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["typeDisplay", "typeInput", "dialog", "formField", "submit"]
  static values = { type: String }

  connect() {
    this.modalElement = this.dialogTarget.parentElement
    this.forms = {
      article: this.element.querySelector('#article_form'),
      chapter: this.element.querySelector('#chapter_form'),
      report: this.element.querySelector('#report_form')
    }
  }

  submitHandler(e) {
    console.log(e)

    if(e.detail.success) {
      this.resetForm(e.target)
      this.close()
    }
  }

  resetForm(form) {
    form.reset()

    const selects = form.querySelectorAll('select[multiple]')
    selects.forEach(select => {
      Array.from(select.options).forEach(option => option.selected = false)
    })
  }

  open(e) {
    const type = e.params.type
    this.typeValue = type
    this.updateModal()
    this.showModal(type)
  }

  showModal(type) {
    Object.values(this.forms).forEach(f => f?.classList.add("hidden"))

    const formKey = type.toLowerCase();
    if(this.forms[formKey]) {
      this.forms[formKey].classList.remove("hidden")
    }
  }

  updateModal() {
    this.modalElement.classList.remove('hidden')
  }

  close() {
    this.modalElement.classList.add('hidden')
    this.typeValue = ''
    this.element.querySelector('#dropdown_menu').classList.add('hidden')
  }

  typeValueChanged(newVal) {
    this.typeDisplayTarget.textContent = newVal
    this.typeInputTarget.value = newVal
  }

  submit() {
    this.element.querySelector('#dropdown_menu').classList.add('hidden')
    this.typeValue = ''
  }
}