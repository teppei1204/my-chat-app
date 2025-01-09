// app/javascript/controllers/disable_submit_button_controller.js
import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["submitButton"];

  disableSubmitButton() {
    this.submitButton.disabled = true;
  }

  enableSubmitButton() {
    this.submitButton.disabled = false;
  }
}
