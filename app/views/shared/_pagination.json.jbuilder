json.pagination do
  current, per_page = collection.current_page, collection.limit_value

  json.page current
  json.per_page per_page
end
