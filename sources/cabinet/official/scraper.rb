#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    field :position do
      position_and_name[1].to_s.gsub('Hon.', '')
    end

    field :name do
      position_and_name[2]
    end

    def empty?
      name.to_s.empty?
    end

    private

    def position_and_name
      noko.text.tidy.split(/^(President|Prime Minister|Vice President|Attorney General|Hon\.) /)
    end
  end

  class Members
    def member_container
      noko.css('figure img/@data-image-title')
    end

    def member_items
      super.reject(&:empty?)
    end
  end
end

file = Pathname.new 'official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
