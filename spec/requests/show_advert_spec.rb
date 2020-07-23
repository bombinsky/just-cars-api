# frozen_string_literal: true

describe 'Show advert' do
  let(:advert) { create :advert, :with_attached_picture }

  it 'responds with advert' do
    get advert_path(advert), as: :json

    expect(response.code).to eq '200'
  end
end
