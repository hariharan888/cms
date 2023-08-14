class ProfilesController < ApplicationController
  def my_profile
    @profile = current_user
  end
end
