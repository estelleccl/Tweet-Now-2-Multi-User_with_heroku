def login?
  if session[:username].nil?
    return false
  else
    return true
  end
end

def username
  return session[:username]
end

helpers do
  def admin?
    session[:admin]
  end
end