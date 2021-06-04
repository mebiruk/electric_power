class AuthenticateUser
    prepend SimpleCommand
  
    def initialize(username, password_digest)
      @username = username
      @password_digest = password_digest
    end
  
    private
  
    attr_accessor :username, :password_digest
  
    # def customer
    #   user = User.find_by_username(username)
    #   return user if user && user.authenticate(password)
  
    #   errors.add :customer_authentication, 'invalid credentials'

    # end
    
    def customer
        if user = User.find_by(username: @username)&.authenticate(@password_digest)
          return user
        else
          errors.add(:base, :failure)
        end
        nil
    end
end