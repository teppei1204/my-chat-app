// Turboをインポート
import { Turbo } from "@hotwired/turbo-rails";

// Turboを無効にして、通常のHTMLリダイレクトを使用
Turbo.session.drive = false;

// その他のインポート
import "controllers"
import "channels"
