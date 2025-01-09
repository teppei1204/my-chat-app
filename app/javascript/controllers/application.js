// app/javascript/controllers/application.js
import { Application } from "@hotwired/stimulus"
import DisableSubmitButtonController from "./disable_submit_button_controller"  // 追加

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

// DisableSubmitButtonController を登録
application.register("disable-submit-button", DisableSubmitButtonController)

export { application }
