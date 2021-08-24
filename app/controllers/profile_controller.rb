class ProfileController < ApplicationController
  def profile
    @user = current_user
  end
end
