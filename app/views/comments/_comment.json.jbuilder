json.extract! comment, :id, :author_id, :photo_id, :body, :created_at, :updated_at
json.url comment_url(comment, format: :json)
