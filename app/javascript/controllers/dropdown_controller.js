import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["menu", "type"]

    toggle(e) {
        this.menuTarget.classList.toggle("hidden")
    }
}