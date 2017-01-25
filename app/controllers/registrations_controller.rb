class RegistrationsController < Devise::RegistrationsController

  def update_resource(resource, params)
    if current_user.provider.present? and [:facebook, :google_oauth2].include? current_user.provider.to_sym
      params.delete("current_password")
      resource.update_without_password(params)
    else
      resource.update_with_password(params)
    end
  end

end
