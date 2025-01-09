require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MyChatApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # 日本語設定
    config.i18n.default_locale = :ja

    # タイムゾーン設定 (日本時間)
    config.time_zone = 'Asia/Tokyo'  # アプリケーション内でのタイムゾーンを日本時間に設定

    # データベースはUTCで保存する設定（推奨）
    config.active_record.default_timezone = :utc  # データベースに保存される日時はUTCのまま

    # その他の設定があればここに追加
  end
end
