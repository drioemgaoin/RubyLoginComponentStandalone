# require 'carrierwave/orm/activerecord'

class NullStorage
  attr_reader :uploader

  def initialize(uploader)
    @uploader = uploader
  end

  def identifier
    uploader.filename
  end

  def store!(_file)
    true
  end

  def retrieve!(_identifier)
    true
  end
end

if Rails.env.test?
  CarrierWave.root = Rails.root.join('test/fixtures/files')
  
  CarrierWave.configure do |config|
    config.storage = NullStorage
    config.enable_processing = false
  end
end
