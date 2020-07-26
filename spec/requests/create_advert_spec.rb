# frozen_string_literal: true

describe 'Create advert' do
  let(:user) { create :user }
  let(:advert_attributes) { attributes_for(:advert) }
  let(:headers) { authorization_header.merge authentication_header(user) }

  before { post adverts_path, params: { advert: advert_attributes }, headers: headers }

  it 'responds with created advert' do
    expect(response.code).to eq '201'
  end

  it 'serializes returned object using proper serializer and root key' do
    expect(parsed_body_of_response).to serialize_object(Advert.last).with(AdvertSerializer).using_root_key(:advert)
  end

  it 'responds with content type application/json; charset=utf-8' do
    expect(response.content_type).to eq 'application/json; charset=utf-8'
  end
end
