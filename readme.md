FancySql
========

After writing a couple of loops that process the results of ActiveRecord::Base.connection.execute, I got tired of it and made a plugin out of it.

This plugin does the following for you:

* Execute your SQL on the class's database connection.
* Convert each result row into a hash with symbolized keys. Doing data lookups with Array indices is so C.
* Free the result set after usage. I did not know this either, but now I won't have to remember it, either.

Example
=======

Basic example:

    Post.fancy_sql("SELECT name, id FROM posts WHERE id < 3")
    # => [{:name=>"First post", :id=>"1"}, {:name=>"Second post", :id=>"2"}]

Copyright (c) 2010 Wes Oldenbeuving, released under the MIT license
