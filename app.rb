ROOT_PATH = File.expand_path(File.dirname(__FILE__))

require 'cuba'
require 'cuba/render'
require 'haml'
#require "feedzirra"
require 'threetaps-client'
require 'debugger'

Cuba.use Rack::Session::Cookie
Cuba.use Rack::Static, urls: ["/images", "/javascripts", "/stylesheets"], root: File.join(ROOT_PATH, "public")
Cuba.plugin Cuba::Render

Cuba.define do
  on get do
    on param("sample") do
      res.write 'You can set up weird rules!'
    end

    on root do
      # res.redirect "/hello"
      #res.write render("index.haml", headline: "Feed Me!!! I want to eat Craig's List RSS!!!");
      res.write render("index.haml", headline: "Let's Find An Instrument via Craig's List!");
    end
  end

  on post do
    on "search", param("Instrument"), param("MinPrice"), param("MaxPrice") do |inst, price_min, price_max|
      search_req = SearchRequest.new
      #We're only allowing searches for instruments, in NYC, with pictures.
      search_req.location = 'NYC'
      search_req.category = 'SMUS'
      search_req.image = 'yes'
      search_req.text = inst
      search_req.price_min = price_min
      search_req.price_max = price_max

      #debugger
      search_resp = SearchClient.new.search search_req

      res.write( {results: search_resp.results}.to_json )
    end

    on "process_rss" do
      on param("RSSLink") do |link|
        feed = Feedzirra::Feed.fetch_and_parse link
        entries_hash = {entries: feed.entries.map{|ee| ee.hasherize}}
        # debugger
        res.write( entries_hash.to_json )
      end

      on true do
        default_obj = [{title: "love wins", size: 200}, {title: "hate wins", size: 300}].to_json
        # debugger
        res.write(default_obj)
      end
    end
  end
end

