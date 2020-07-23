# frozen_string_literal: true

describe AdvertsController do
  describe 'POST create' do

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
      allow_service_call(CreateAdvert, to_return: service_result)

      post :create, params: { advert: advert_attributes }
    end

    context 'when service object responds with not persisted invalid object' do
      let(:service_result) { build(:advert, title: nil).tap { |advert| advert.valid? } }

      it { is_expected.to respond_with :unprocessable_entity }

      it 'responds with content type application/json; charset=utf-8' do
        expect(response.content_type).to eq 'application/json; charset=utf-8'
      end

      it 'transmits errors' do
        expect(JSON.parse(response.body)['errors']['title']).to be_present
      end

      it 'calls service object with proper params' do
        expect(CreateAdvert).to have_received(:new).with(attributes: hash_including(expected_service_attributes))
      end
    end

    context 'when service object responds with persisted object' do
      let(:service_result) { create(:advert, :with_attached_picture) }

      it { is_expected.to respond_with :created }

      it 'responds with content type application/json; charset=utf-8' do
        expect(response.content_type).to eq 'application/json; charset=utf-8'
      end

      it 'serializes returned object using proper serializer and root key' do
        expect(parsed_body_of_response).to serialize_object(service_result).with(AdvertSerializer).using_root_key(:advert)
      end
    end
  end
end
