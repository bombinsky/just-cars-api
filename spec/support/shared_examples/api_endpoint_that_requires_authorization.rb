# frozen_string_literal: true

shared_examples 'api endpoint that requires authorization' do
  it { is_expected.to respond_with :unauthorized }

  it 'responds with content type application/json; charset=utf-8' do
    expect(response.content_type).to eq 'application/json; charset=utf-8'
  end

  it 'transmits error message' do
    expect(parsed_body_of_response['errors'].first).to eq 'Unauthorized'
  end
end
