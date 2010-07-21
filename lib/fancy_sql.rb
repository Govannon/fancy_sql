class ActiveRecord::Base
  # Execute sql on the ActiveRecord connection, but do a couple of extra's:
  # * Convert each result row into a hash with the given +attributes+ as keys. Array indices are so C.
  # * Free the result set after usage. Did not know you had to free results from ActiveRecord::Base.connnection.execute? Now you don't have to remember it, either.
  # Note: the order of attributes must match the order of the columns resulting from the SQL. Pass a nil attribute to ignore that column.
  #
  # Basic example:
  #   Post.fancy_sql("SELECT name, id FROM posts WHERE id < 3", :name, :created_at)
  #   # => [{:name=>"First post", :id=>"1"}, {:name=>"Second post", :id=>"2"}]
  #
  # Example that ignores the +id+ column:
  #   Post.fancy_sql("SELECT id, name FROM posts WHERE id < 3", nil, :created_at)
  #   # => [{:name=>"First post"}, {:name=>"Second post"}]
  def self.fancy_sql(sql, *attributes)
    attributes = attributes.flatten
    rows = self.connection.execute sql
    results = Array.new
    rows.each do |row|
      fancy_row = Hash.new
      attributes.each_with_index do |attribute, index|
        next if attribute.nil?
        fancy_row[attribute] = row[index]
      end
      results << fancy_row
    end
    rows.free
    results
  end
end
