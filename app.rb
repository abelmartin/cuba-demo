ROOT_PATH = File.expand_path(File.dirname(__FILE__))

require "cuba"
require "cuba/render"
require "haml"
require "feedzirra"
require "debugger"

Cuba.use Rack::Session::Cookie
Cuba.use Rack::Static, urls: ["/images", "/javascript", "/stylesheets"], root: File.join(ROOT_PATH, "public")
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
      # debugger
      on param("RSSLink") do |link|
        feed = Feedzirra::Feed.fetch_and_parse link
        res.write feed.entries.to_json
      end
    end
  end
end