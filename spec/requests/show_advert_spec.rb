# frozen_string_literal: true

describe 'Show advert' do
  let(:advert) { create :advert, :with_attached_picture }

  before { get advert_path(advert), headers: authorization_header, as: :json }

  it 'responds with success' do
    expect(response.code).to eq '200'
  end

  it 'responds with content type application/json; charset=utf-8' do
    expect(response.content_type).to eq 'application/json; charset=utf-8'
  end
end
