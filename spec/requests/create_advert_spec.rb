# frozen_string_literal: true

describe 'Create advert' do
  it 'responds with created advert' do
    post adverts_path, params: { advert: attributes_for(:advert) }, as: :json

    expect(response.code).to eq '201'
  end
end
