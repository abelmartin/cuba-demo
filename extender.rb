Feedzirra::Parser::RSSEntry.class_eval do
  def hasherize
    {
      title: title,
      url: url,
      summary: summary,
      published: published
    }
  end
end