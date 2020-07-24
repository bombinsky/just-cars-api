# frozen_string_literal: true

# Adverts Controller provides actions to create, list and show adverts
class AdvertsController < ApplicationController
  include UserAuthorizationMethods

  before_action :authenticate_user!, only: :create

  def create
    if created_advert.persisted?
      render json: created_advert, status: :created
    else
      render json: { errors: created_advert.errors }, status: :unprocessable_entity
    end
  end

  def show
    render json: Advert.find(params[:id])
  end

  def index
    if adverts_filter.valid?
      render json: FilterAdverts.new(adverts_filter).call, each_serializer: AdvertOnListSerializer, root: 'adverts'
    else
      render json: { errors: adverts_filter.errors }, status: :unprocessable_entity
    end
  end

  private

  def created_advert
    @created_advert ||= CreateAdvert.new(user: current_user, attributes: created_advert_params).call
  end

  def adverts_filter
    @adverts_filter ||= AdvertsFilter.new(params.permit(AdvertsFilter::ATTRIBUTES))
  end

  def created_advert_params
    params.require(:advert).permit(:title, :description, :price, :picture)
  end
end
