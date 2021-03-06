# CarrierWaveの設定呼び出し
require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

CarrierWave.configure do |config|

  if Rails.env.production?
    config.storage = :fog
    config.fog_provider = 'fog/aws'
    config.fog_directory  = ENV['AMAZONS3_BUCKET']
    config.fog_credentials = {
        provider: 'AWS',
        # credentialsで管理する場合
        aws_access_key_id: ENV['ACCESS_KEY_ID'],
        aws_secret_access_key: ENV['SECRET_ACCESS_KEY'],
        region: 'ap-northeast-1' #東京リージョン
    }
    # キャッシュをS3に保存
    # config.cache_storage = :fog
  else
    # 開発環境はlocalに保存
    config.storage :file
    config.enable_processing = false if Rails.env.test? #test:処理をスキップ
  end
end