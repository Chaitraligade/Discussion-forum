module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags 'ActionCable', current_user.email
    end

    private

    def find_verified_user
      logger.info "Cookies available in ActionCable: #{cookies.to_hash}"
      logger.info "Encrypted user_id: #{cookies.encrypted[:user_id]}"
    
      if (verified_user = User.find_by(id: cookies.encrypted[:user_id]))
        logger.info "Verified User: #{verified_user.email}"
        verified_user
      else
        logger.warn "Unauthorized connection attempt: User is nil"
        reject_unauthorized_connection
      end
    end
    
  end
end

