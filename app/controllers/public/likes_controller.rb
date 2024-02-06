class Public::LikesController < ApplicationController
  before_action :authenticate_customer!
end
