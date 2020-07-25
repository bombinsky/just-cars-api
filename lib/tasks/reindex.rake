# frozen_string_literal: true

namespace :reindex do
  desc 'reindexing adverts'
  task adverts: :environment do
    Advert.reindex
  end
end
