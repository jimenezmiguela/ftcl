class MeasuresController < ApplicationController
  def index
    require 'nokogiri'
    require 'uri'
    require 'net/http'
    require 'csv'


    name = params[:name]
    @name = name 

    uri = URI("https://leginfo.legislature.ca.gov/faces//billSearchClient.xhtml?session_year=20232024&house=Both&author=All&lawCode=#{@name}")

    res = Net::HTTP.get_response(uri)

    document = Nokogiri::HTML4(res.body)

    table = document.at('table')

    all_measures = []

    table.search('tr').each do |tr|
      cells = tr.search('th, td')
      all_measures << CSV.generate_line(cells)
    end

    all_measures.each do |i|
      i.gsub!("\n", "")
      i.gsub!('"', "")
      i.gsub!(/\s{10}/, "")
      i.gsub!(/\s{8}/, "" )
      i.gsub!(",", ", ")
      i.gsub!("-", "")
    end

    @all_measures = all_measures.drop(1)
  end

end
