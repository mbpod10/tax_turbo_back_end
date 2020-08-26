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
