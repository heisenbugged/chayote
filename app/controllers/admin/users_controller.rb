class Admin::UsersController < ApplicationController
  inherit_resources
  actions :index, :edit, :update, :delete, :destroy
  def update
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
    update! { admin_users_path }
  end
end
