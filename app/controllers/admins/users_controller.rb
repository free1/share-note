#encoding: utf-8
class Admins::UsersController < ApplicationController
  def index
    @admins = User.where(admin: true)
  end
end