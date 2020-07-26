# frozen_string_literal: true

describe 'Filter adverts' do
  before do
    create :advert, title: 'Advert 1'
    create :advert, title: 'New advert 2'
    create :advert, title: 'New advert 3'

    Advert.reindex

    get '/adverts/?phrase=new%20advert', headers: authorization_header, as: :json
  end

  it 'responds with success' do
    expect(response.code).to eq '200'
  end

  it 'responds with matching adverts' do
    expect(parsed_body_of_response['adverts'].size).to eq 2
  end

  it 'responds with content type application/json; charset=utf-8' do
    expect(response.content_type).to eq 'application/json; charset=utf-8'
  end
end
