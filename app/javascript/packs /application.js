import { Turbo } from "@hotwired/turbo-rails";  // Turboをインポート

document.addEventListener("turbo:load", () => {
  const form = document.querySelector(".chat-room-form");  // クラス名でフォームを特定
  const body = document.body;

  // チャットルームページのみフォームをリセット
  if (body.classList.contains("chat-room-show") && form) {
    form.reset();  // フォームリセット
  }

  // CSSの再適用を強制
  const styleSheets = document.querySelectorAll('link[rel="stylesheet"]');
  styleSheets.forEach((styleSheet) => {
    styleSheet.href = styleSheet.href; // CSSの強制再読み込み
  });
});

// Turboでページが更新された際にCSSを再適用する処理
document.addEventListener("turbo:render", () => {
  const styleSheetLink = document.querySelector('link[rel="stylesheet"]');
  if (styleSheetLink) {
    const clonedStyleSheetLink = styleSheetLink.cloneNode(true);
    styleSheetLink.parentNode.replaceChild(clonedStyleSheetLink, styleSheetLink);
  }
});

// Turboがページをキャッシュする前にCSSを再適用
document.addEventListener("turbo:before-cache", () => {
  const styleSheets = document.querySelectorAll("link[rel='stylesheet']");
  styleSheets.forEach((styleSheet) => {
    styleSheet.href = styleSheet.href; // 強制的に再ロード
  });
});
