# frozen_string_literal: true

shared_examples 'unsuccessful response' do |response_code, invalid_attribute|
  it { is_expected.to respond_with response_code }

  it 'responds with content type application/json; charset=utf-8' do
    expect(response.content_type).to eq 'application/json; charset=utf-8'
  end

  it 'transmits error message' do
    expect(parsed_body_of_response['errors'][invalid_attribute]).to be_present
  end
end
