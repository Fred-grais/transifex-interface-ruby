# Transifex::Interface::Ruby

This gem is designed to interact easily with the Transifex API. You can perform all the actions allowed by the API. Documentation located here : http://docs.transifex.com/developer/api/

## Installation

Add this line to your application's Gemfile:

    gem 'transifex-interface-ruby'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install transifex-interface-ruby

## Usage

### Initialization

To initialize the gem, you will have to create an initializer like follow:

```ruby
Transifex.configure do |c|
  c.client_login = 'your_client_login'
  c.client_secret = 'your_secret'    
end
```
Then restart the server.

If you don't do this you will end up with the following error:

```ruby
#<Transifex::TransifexError: Authorization Required>
```

### Projects (to fetch all projects and create a new one)

#### Fetch

To fetch all the projects owned by the account specified in the initializer:

```ruby
Transifex::Projects.fetch
```

#### Create

To create a new project, you can proceed as following:

For a private project:

```ruby
private_project_params = {:slug => "private_project", :name => "Private Project", :description => "description", :source_language_code => "en", :private => true}

Transifex::Projects.create(private_project_params)
```
For a public project:

```ruby
public_project_params = {:slug => "public_project", :name => "Public Project", :description => "description", :source_language_code => "en", :repository_url => "http://example.com"}

Transifex::Projects.create(public_project_params)
```

The complete list of the allowed parameters is located in the Transifex documentation.

### Project (symbolize an existing project)

#### Instantiation 

```ruby
transifex_project = Transifex::Project.new('project_slug')
```
or 

```ruby
transifex_project = Transifex::Projects.create(params) 
```
#### Fetch

You can fetch the project informations from transifex:

```ruby
transifex_project_informations = transifex_project.fetch
```

with more details:

```ruby
transifex_project_informations = transifex_project.fetch_with_details
```

#### Update

You can update the project: (see documentation for available fields)

```ruby
transifex_project.update({:description => "new description"})
```
 #### Destroy

You can destroy a project:

```ruby
transifex_project.delete
```
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
