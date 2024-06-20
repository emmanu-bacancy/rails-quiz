json.array! @companies do |company|
  json.extract! company, :id, :name, :created_at, :updated_at
end

json.partial! "shared/pagination", collection: @companies
