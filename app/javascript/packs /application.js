// app/javascript/packs/application.js
document.addEventListener("turbo:load", () => {
  const form = document.querySelector("form");
  if (form) {
    form.reset();
  }
});
