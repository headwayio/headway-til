CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     ENV['aws_access_key_id'],     # required
    aws_secret_access_key: ENV['aws_secret_access_key'], # required
    region:                ENV.fetch('aws_region', 'eu-west-1'), # optional, defaults to 'us-east-1'
    host:                  ENV.fetch('aws_host', nil),             # optional, defaults to nil
    endpoint:              ENV.fetch('aws_endpoint', nil) # optional, defaults to nil
  }
  config.fog_directory  = ENV.fetch('aws_fog_directory', 'hw-til-production') # required
  config.fog_public     = true # optional, defaults to true
  config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" } # optional, defaults to {}
  config.storage = Rails.env.production? ? :fog : :file
end
