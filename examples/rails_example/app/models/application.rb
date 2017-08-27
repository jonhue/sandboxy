class Application < ApplicationRecord
    before_create :create_access_tokens

    private

    def create_access_tokens
        begin
            self.access_token = SecureRandom.hex(32)
        end while self.class.where(access_token: self.access_token, sandbox_access_token: self.access_token).exists?
        begin
            self.sandbox_access_token = SecureRandom.hex(32)
        end while self.class.where(sandbox_access_token: self.sandbox_access_token, access_token: self.sandbox_access_token).exists?
    end
end
