# frozen_string_literal: true

# Adverts Controller provides actions to create, list and show adverts
class AdvertsController < ApplicationController

  def create
    if created_advert.persisted?
      render json: created_advert, status: :created
    else
      render json: { errors: created_advert.errors }, status: :unprocessable_entity
    end
  end

  def created_advert
    @created_advert ||= CreateAdvert.new(attributes: created_advert_params).call
  end

  def created_advert_params
    params.require(:advert).permit(:title, :description, :price, :picture)
  end
end
