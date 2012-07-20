ROOT_PATH = File.expand_path(File.dirname(__FILE__))

require "cuba"
require "cuba/render"
require "haml"
require "feedzirra"
# require "json"
require "debugger"

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
        puts ">> RSS Link: #{link}"
        puts ">> RSS Response: #{feed.entries.last} \n"
        puts ">> RSS Response JSON: #{feed.entries.last.to_json} \n"
        res.write( feed.entries.to_json )
        # res.write( feed.to_json )
      end

      on true do
        # debugger
        res.write({a: 1, b: 2}.to_json)
      end
    end
  end
end