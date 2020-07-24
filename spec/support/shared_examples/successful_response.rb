# frozen_string_literal: true

shared_examples 'successful response' do |response_code|

  it { is_expected.to respond_with response_code }

  it 'responds with content type application/json; charset=utf-8' do
    expect(response.content_type).to eq 'application/json; charset=utf-8'
  end
end
