```ruby
ActiveRecord::Base.establish_connection :adapter=>'sqlite3', :database=>'blaz.db'
ActiveRecord::Schema.define do
    tables = ActiveRecord::Base.connection.tables
    unless tables.include? 'users'
        create_table(:users) do |t|
            t.column :name, :string
        end
    end

    unless tables.include? 'sites'
        create_table(:sites) do |t|
            t.column :name, :string
            t.column :uid, :integer
            t.column :data, :string
        end
    end

    unless tables.include? 'pages'
        create_table(:pages) do |t|
            t.column :id, :id
            t.column :name, :string
            t.column :site, :integer
            t.column :data, :text
        end
    end
end

class User < ActiveRecord::Base
    has_many :site
end

class Site < ActiveRecord::Base
    has_many :page
end

class Page < ActiveRecord::Base
end

#simple active record cosnole!
require 'irb'
require 'irb/completion'

IRB.setup nil
IRB.conf[:MAIN_CONTEXT] = IRB::Irb.new.context
IRB.conf[:PROMPT_MODE] = :SIMPLE
require 'irb/ext/multi-irb'
IRB.irb nil, self
```
