module SittersHelper

  def current_sitter
    if (current_user && user_id = current_user.id)
        @current_sitter ||= Sitter.find_by(user_id: user_id)
    end
  end

  def is_sitter?
    !current_sitter.nil?
  end

end
