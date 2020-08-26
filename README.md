```
rails new $APP_NAME -d postgresql --skip-git
```

```
rails db:create
```

- add these two gems to gemfile

```
gem 'bcrypt', '~> 3.1', '>= 3.1.15'
gem "rack-cors", :require => 'rack/cors'
```

run `bundle`

# Create Sessions Store

- allow for http cookie
  create `sessions_store.rb`in config/initializers and within

```
if Rails.env == "production"
    Rails.application.config.session_store :cookie_store,
    key: "_tax_turbo_app", domain: "http://localhost:3000",
    same_site: :none, secure: true
else
    Rails.application.config.session_store :cookie_store,
    key: "_tax_turbo_app"
end

```

# Create Cors

- this allows front end permission to communicate with the backend
  create `cors.rb` in config/initializers and withtin

```

Rails.application.config.middleware.insert_before 0, Rack::Cors do

    allow do
        origins 'http://localhost:3001'
        resource '*',
        headers: :any,
        methods: [:get, :post, :put, :patch, :delete, :options, :head],
        credentials: true
    end

    allow do
        origins ''
        resource '*',
        headers: :any,
        methods: [:get, :post, :put, :patch, :delete, :options, :head],
        credentials: true
    end
end
```

# Create Home Route

in `config/routes`
#Create Static Controller
#Create function called Home

```
Rails.application.routes.draw do
  root to: "static#home"
end
```

create route called `static_controller.rb` within `app/controllers`

```
class StaticController < ActionController::Base
    def home
        render json: {status: 200, message: "It's Working!"}
    end
end

```

# Create User Model

run in console:

```
rails g model User email password_digest

```

run

```
rails db:migrate
```

User schema should look like this

```
class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end

```

within app/models/user.rb

```
class User < ApplicationRecord
    has_secure_password

    validates_presence_of :email
    validates_uniqueness_of :email
end

```

# Create User With Rails Console

runs `rails c`

```
User.create!(email: "hack@gmail.com", password: "101010", password_confirmation: "101010")
```

- confirmation of created user

```
 (0.2ms)  BEGIN
  User Exists? (3.5ms)  SELECT 1 AS one FROM "users" WHERE "users"."email" = $1 LIMIT $2  [["email", "hack@gmail.com"], ["LIMIT", 1]]
  User Create (0.8ms)  INSERT INTO "users" ("email", "password_digest", "created_at", "updated_at") VALUES ($1, $2, $3, $4) RETURNING "id"  [["email", "hack@gmail.com"], ["password_digest", "$2a$12$rd6JFpuO.xEURRNXWy3ov.60zKKx6SeB5AXNccoyQFXZVuDD8mnfa"], ["created_at", "2020-08-26 19:47:41.279048"], ["updated_at", "2020-08-26 19:47:41.279048"]]
   (2.9ms)  COMMIT
=> #<User id: 1, email: "hack@gmail.com", password_digest: [FILTERED], created_at: "2020-08-26 19:47:41", updated_at: "2020-08-26 19:47:41">
```

# Create User Controller

in `config/routes`

```
resources :users
```

create `app/controllers/users_controller.rb`

```
class UsersController < ApplicationController
    def index
        @users = User.all
        render json: @users
    end
end

```

go to `http://localhost:3000/users`

```
[
  {
    id: 1,
    email: "hack@gmail.com",
    password_digest: "$2a$12$rd6JFpuO.xEURRNXWy3ov.60zKKx6SeB5AXNccoyQFXZVuDD8mnfa",
    created_at: "2020-08-26T19:47:41.279Z",
    updated_at: "2020-08-26T19:47:41.279Z",
  },
];

```
