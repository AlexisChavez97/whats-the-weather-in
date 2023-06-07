import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.modal = this.element.querySelector(".modal")
  }

  close(e) {
    e.preventDefault() 
    const modal = document.getElementById("modal");
    modal.innerHTML = "";
    modal.removeAttribute("src");
    modal.removeAttribute("complete");
  }

  submitEnd(e) {
    if (e.detail.success) {
      this.close(e)
    }
  }
}