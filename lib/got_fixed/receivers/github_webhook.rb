module GotFixed
  module Receivers
    class GithubWebhook
      HMAC_DIGEST = OpenSSL::Digest::Digest.new('sha1')
      class SignatureError < StandardError; end

      def initialize(options = {})
        @secret = options[:secret]
      end

      def check_hub_signature!(header, body)
        expected_signature = "sha1=#{OpenSSL::HMAC.hexdigest(HMAC_DIGEST, @secret, body)}"
        if header != expected_signature
          raise SignatureError.new "#{header} != #{expected_signature}"
        end
      end
    end
  end
end