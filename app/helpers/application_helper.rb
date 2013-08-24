module ApplicationHelper
  def signed_in?
    cookies[:player_number].present?
  end
end
