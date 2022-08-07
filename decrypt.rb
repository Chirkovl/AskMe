require 'cgi'
require 'json'
require 'active_support'

def verify_and_decrypt_session_cookie(cookie, secret_key_base = Rails.application.secret_key_base)
  config = Rails.application.config
  cookie = CGI::unescape(cookie)
  salt   = config.action_dispatch.authenticated_encrypted_cookie_salt
  encrypted_cookie_cipher = config.action_dispatch.encrypted_cookie_cipher || 'aes-256-gcm'
  # serializer = ActiveSupport::MessageEncryptor::NullSerializer # use this line if you don't know your serializer
  serializer = ActionDispatch::Cookies::JsonSerializer

  key_generator = ActiveSupport::KeyGenerator.new(secret_key_base, iterations: 1000)
  key_len = ActiveSupport::MessageEncryptor.key_len(encrypted_cookie_cipher)
  secret = key_generator.generate_key(salt, key_len)
  encryptor = ActiveSupport::MessageEncryptor.new(secret, cipher: encrypted_cookie_cipher, serializer: serializer)

  session_key = config.session_options[:key].freeze
  encryptor.decrypt_and_verify(cookie, purpose: "cookie.#{session_key}")
end

puts "Получаем сессию в Рэйлс 7"

puts "Вставляем куку которую нужно расшифровать"

cookie = gets.chomp

puts "Вставте ключ"

result = verify_and_decrypt_session_cookie(cookie, session_key)

puts result.inspect

