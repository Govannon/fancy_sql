class ActiveRecord::Base
  # Execute sql on the ActiveRecord connection, but do a couple of extra's:
  # * Convert each result row into a hash with symbolized keys. Array indices are so C.
  # * Free the result set after usage. Did not know you had to free results from ActiveRecord::Base.connnection.execute? Me neither, but now the both of us can forget about it.
  #
  # Basic example:
  #   Post.fancy_sql("SELECT name, id FROM posts WHERE id < 3")
  #   # => [{:name=>"First post", :id=>"1"}, {:name=>"Second post", :id=>"2"}]
  def self.fancy_sql(sql)
    query_results = self.connection.execute sql
    results = Array.new
    while row = query_results.fetch_hash
      results << row.symbolize_keys
    end
    query_results.free
    results
  end
end
