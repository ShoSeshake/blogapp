json.array! @searched_articles do |article|
  json.id article.id
  json.title article.title
  json.content article.content.truncate(200)
  json.time article.created_at.strftime("%Y/%m/%d %H:%M")
end