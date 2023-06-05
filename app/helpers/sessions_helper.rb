module SessionsHelper
  # Redirects to stored location (or to the fallback).
  def redirect_back_or(namespace, fallback_url)
    key = "redirect_url_#{namespace.to_s}".to_sym

    redirect_to(session[key] || fallback_url)
    session.delete(key)
  end

  # Stores the URL trying to be accessed.
  def store_redirect_url(namespace)
    key = "redirect_url_#{namespace.to_s}".to_sym

    session[key] = request.original_url if request.get?
  end
end
