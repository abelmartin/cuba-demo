ROOT_PATH = File.expand_path(File.dirname(__FILE__))

require "cuba"
require "cuba/render"
require "haml"
require "feedzirra"
require "debugger"

require './extender'

Cuba.use Rack::Session::Cookie
Cuba.use Rack::Static, urls: ["/images", "/javascripts", "/stylesheets"], root: File.join(ROOT_PATH, "public")
Cuba.plugin Cuba::Render

Cuba.define do
  on get do
    on root do
      # res.redirect "/hello"
      res.write render("index.haml", headline: "Feed Me!!! I want to eat RSS!!!");
    end
  end

  on post do
    on "process_rss" do
      on param("RSSLink") do |link|
        feed = Feedzirra::Feed.fetch_and_parse link
        entries_hash = {entries: feed.entries.map{|ee| ee.hasherize}}
        # debugger
        res.write( entries_hash.to_json )
      end

      on true do
        ha = [{title: "love wins", size: 200}, {title: "hate wins", size: 300}].to_json
        # debugger
        res.write(ha)
      end
    end
  end
end

