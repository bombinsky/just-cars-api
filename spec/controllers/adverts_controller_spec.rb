# frozen_string_literal: true

describe AdvertsController do
  include UserAuthenticationHelper

  describe 'GET show' do
    let(:advert) { create :advert }

    before do
      get :show, params: { id: advert.id }
    end

    it_behaves_like 'successful response', :success

    it 'serializes returned object using proper serializer and root key' do
      expect(parsed_body_of_response).to serialize_object(advert).with(AdvertSerializer).using_root_key(:advert)
    end
  end

  describe 'GET index' do
    let(:adverts) { build_list :advert, 3 }
    let(:adverts_filter) { build :adverts_filter }
    let(:params) { attributes_for :adverts_filter }

    context 'with valid filtering params' do
      before do
        allow(AdvertsFilter).to receive(:new).and_return(adverts_filter)
        allow_service_call(FilterAdverts, with: adverts_filter, to_return: adverts)

        get :index, params: params
      end

      it_behaves_like 'successful response', :success

      it 'initializes advert filter with all transmitted params' do
        expect(AdvertsFilter).to have_received(:new).with(hash_including(params))
      end

      it 'calls FilterAdverts with proper params' do
        expect(FilterAdverts).to have_received(:new).with(adverts_filter)
      end

      it 'serializes returned collection using proper serializer and root key' do
        expect(parsed_body_of_response).to serialize_object(adverts)
          .with(AdvertOnListSerializer).using_root_key(:adverts)
      end
    end

    context 'with invalid filtering params' do
      before do
        get :index, params: params
      end

      let(:params) { { order: 'unknown_order_type' } }

      it_behaves_like 'unsuccessful response', :unprocessable_entity, 'order'
    end
  end

  describe 'POST create' do
    let(:user) { create :user }
    let(:advert_attributes) { attributes_for :advert }
    let(:expected_service_attributes) do
      {
        title: advert_attributes[:title],
        description: advert_attributes[:description],
        price: advert_attributes[:price],
        picture: kind_of(ActionDispatch::Http::UploadedFile)
      }
    end

    before do
      authenticate(user)
      allow_service_call(CreateAdvert, to_return: service_result)

      post :create, params: { advert: advert_attributes }
    end

    context 'when service object responds with not persisted invalid object' do
      let(:service_result) { build(:advert, title: nil).tap(&:valid?) }

      it_behaves_like 'unsuccessful response', :unprocessable_entity, 'title'

      it 'calls service object with proper params' do
        expect(CreateAdvert).to have_received(:new)
          .with(user: user, attributes: hash_including(expected_service_attributes))
      end
    end

    context 'when service object responds with persisted object' do
      let(:service_result) { create(:advert, :with_attached_picture) }

      it_behaves_like 'successful response', :created

      it 'serializes returned object using proper serializer and root key' do
        expect(parsed_body_of_response).to serialize_object(service_result)
          .with(AdvertSerializer).using_root_key(:advert)
      end
    end
  end
end
