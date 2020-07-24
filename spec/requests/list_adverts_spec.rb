# frozen_string_literal: true

describe 'List adverts' do
  before do
    create_list :advert, 2, :with_attached_picture

    Advert.reindex

    get adverts_path, as: :json
  end

  it 'responds with success' do
    expect(response.code).to eq '200'
  end

  it 'responds with all adverts' do
    expect(parsed_body_of_response['adverts'].size).to eq Advert.count
  end
end
