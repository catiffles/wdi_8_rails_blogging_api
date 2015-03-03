class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :author, :created_at

  def created_at
    object.created_at.strftime('%d-%m-%Y')
  end
end