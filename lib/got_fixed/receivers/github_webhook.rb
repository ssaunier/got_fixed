module GotFixed
  module Receivers
    class GithubWebhook
      HMAC_DIGEST = OpenSSL::Digest::Digest.new('sha1')
      class SignatureError < StandardError; end

      def initialize(options = {})
        @secret = options[:secret]
      end

      # Incoming request:
      # https://github.com/github/github-services/blob/14f4da01ce29bc6a02427a9fbf37b08b141e81d9/lib/services/web.rb#L48
      def check_hub_signature!(header, body)
        expected_signature = "sha1=#{OpenSSL::HMAC.hexdigest(HMAC_DIGEST, @secret, body)}"
        if header != expected_signature
          raise SignatureError.new "#{header} != #{expected_signature}"
        end
      end
    end
  end
end