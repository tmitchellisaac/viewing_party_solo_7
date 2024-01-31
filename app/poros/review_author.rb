class ReviewAuthor 
  def initialize(data)
    @name = data[:name]
    @username = data[:username]
    @avatar_path = data[:avatar_path]
    @rating = data[:rating]
  end
end