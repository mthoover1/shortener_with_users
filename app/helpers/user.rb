helpers do
  # This will return the current user, if they exist
  # Replace with code that works with your application
  def current_user
    if session[:user]
      @current_user ||= User.find(session[:user])
    end
  end

  # Returns true if current_user exists, false otherwise
  def logged_in?
    !current_user.nil?
  end

  def request_url
    @request_url ||= request.env['HTTP_ORIGIN']
  end
end
