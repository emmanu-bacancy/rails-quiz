json.extract! person, :email
json.partial! "shared/pagination", collection: @people
