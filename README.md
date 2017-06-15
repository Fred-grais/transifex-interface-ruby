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

### Formats

It represents all the formats available on Transifex:

```ruby
Transifex::Formats.fetch
```

### Languages

It represents all the languages available on Transifex:

#### Fetch

You can fetch all the languages:

```ruby
Transifex::Languages.fetch
```

Or specify a language:

```ruby
Transifex::Languages.fetch('en')
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

### Project Languages ( to fetch all languages of a project and create a new one)


#### Instantiation

```ruby
project_languages = transifex_project.languages
```

#### Fetch

You can retrieve informations about all the languages of a project:

```ruby
project_languages.fetch
```

#### Create

You can create a new language for a project:

```ruby
params = {:language_code => "el", :coordinators => ['username']}
project_languages.create(params)
```

### Project Language (Symbolize a single language of a project)

#### Instantiation

```ruby
project_language = transifex_project.language('en')
```

#### Fetch

You can retrieve informations for a project's specified language:

```ruby
project_language.fetch
```

with details:

```ruby
project_language.fetch_with_details
```

#### Update

You can update the information of a project's specified language:

```ruby
params = {:coordinators => ['username1', 'username2'], :translators => ['username'], :reviewers => ['username']}
project_language.update(params)
```

#### Delete

You can delete a project's specified language:

```ruby
project_language.delete
```

### Project language management

You have access to the differents teams of a language: coordinators, reviewers and translators.

#### Instantiation:

```ruby
project_language_coordinators_team = project_language.coordinators
project_language_reviewers_team = project_language.reviewers
project_language_translators_team = project_language.translators
```

#### Fetch

```ruby
project_language_xxx_team.fetch
```

#### Update

```ruby
project_language_xxx_team.update(['username1', 'username2'])
```

### Resources ( to fetch all resources of a project and create a new one)

First, instantiate a project (see Project/instantiation)

#### Fetch

You can fetch all the resources of projects:

```ruby
transifex_project.resources.fetch
```

#### Create

You can create a new resource for the specified project:

Without a file (you have to send the content as a string) :

```ruby
params = {:slug => "resource_slug", :name => "Resource created with content as a string", :i18n_type => "TXT", :content => "test"}
transifex_project.resources.create(params)
```

With a file: (YAML currently supported)

```ruby
params = {:slug => "resource_slug", :name => "Resource created with a file", :i18n_type => "YAML", :content => 'path/to/your/file.yml'}
options = {:trad_from_file => true}
transifex_project.resources.create(params, options)
```

### Resource (Symbolize a single resource of a project)

#### Instantiation

You can instantiate a resource as follow:

```ruby
project_resource = transifex_project.resource("resource_slug")
```

#### Fetch

You can retrieve informations of the specified resource:

```ruby
project_resource.fetch
```
with more details:

```ruby
project_resource.fetch_with_details
```

#### Update

You can update a resource: (see documentation for allowed fields)

```ruby
project_resource.update({name: "new_name", categories: ["cat1", "cat2"]})
```

#### Delete

You can delete the specified resource:

```ruby
project_resource.delete
```

### Resource Content ( Source language content)

You can manage the resource's source language 

#### Fetch

You can retrieve the source language content:

As a hash: (content is encoded as a string)

```ruby
project_resource.content.fetch
```

Or as a file
Here for a YAML file:

```ruby
project_resource.content.fetch_with_file("path/where/file/will/be/saved.yml")
```
The source language content will be copied in the specified file.

#### Update

You can update the source language content (add new traductions for example):
Attention: the source language content will be overrided.

You must update the source language content with the same method used to create the resource.

So if you used a YAML file, you must provide a new YAML file.

With the content as a string:

```ruby
project_resource.content.update({:i18n_type => "TXT", :content => 'new_content'})
```

With a file:

```ruby
params = {:i18n_type => "YAML", :content => 'path/to/your/file.yml'}
options = {:trad_from_file => true}
project_resource.content.update(params, options)
```

### Resource Translations

The following will explain how you can fetch the different translations of a resource and update them.

You have to specify the language you want to work on.
For example to work on the english translation:

```ruby
resource_translation = project_resource.translation('en')
```

#### Fetch

You can fetch the translation content of a resource:

As a Hash: (content encoded as a string)

```ruby
resource_translation.fetch
```

As a file: (file saved to the specified location)

```ruby
options = {:path_to_file => path_to_file}
resource_translation.fetch_with_file(options)
```

You can use some options (as defined in the transifex documentations)

For example to retrieve only reviewed translations:

```ruby
options = {:path_to_file => path_to_file, :mode => "reviewed"}
resource_translation.fetch_with_file(options)
```

#### Update

You can update the translation content:

```ruby
options = {:i18n_type => "YAML", :content => "/path/to/the/file/to/upload.yml"}
resource_translation.update(options)
```

### Resource Translations Strings

Resource translations strings allow you to retrieve meta-informations about translations strings (translation key, context, content, and so on)

#### Instantiation

```ruby
resource_translation_strings = resource_translation.strings
```

#### Fetch

You can fetch informations of all the strings of a translation:

```ruby
resource_translation_strings.fetch
```

With details:

```ruby
resource_translation_strings.fetch_with_details
```

You can specify a key and/or a context to search a particular string

```ruby
options = {:key => "welcome", :context => "context"}
resource_translation_strings.fetch_with_details(options)
```

#### Update

You can update some informations of a translation string (see documentation for available fields):

You must specify at least the key of the translation, and can add a context(by default empty).

```ruby
params = {:key => "welcome", :context => "", :translation => "new_translation"}
resource_translation_strings.update(params)
```
### Resource Translations String (Symbolize a single string)

#### Instantiation

Context is empty by default.

```ruby
resource_translation_string = resource_translation.string(key, context)
```

#### Fetch

You can fetch the informations about the specified string:

```ruby
resource_translation_string.fetch
```

#### Update

You can update the informations of the specified string: (available fields in the documentation)

```ruby
params = {:reviewed => true, :translation => "new translation"}
resource_translation_string.update(params)
```

### Resource Source String 

It allow you to retrieve meta-data on a source language string and update them.

#### Instantiation

Context is empty by default.

```ruby
resource_source_string = project_resource.source('key', 'context')
```

#### Fetch

You can fetch meta-data about the specified source string:

```ruby
resource_source_string.fetch
```

#### Update

You can update the meta-data of the specified source string

```ruby
params = {:comment => "my comment", :character_limit => 140, :tags => ["tag1", "tag2"]}
resource_source_string.update(params)
```

### Resource Statistics

It allow you to retrieve some transifex stats about a resource.

#### Instantiation

```ruby
resource_stats = project_resource.statistics
```

#### Fetch

You can fetch the statistics:

Of all the the resource languages:

```ruby
resource_stats.fetch
```

Of a specified language:

```ruby
resource_stats.fetch('en')
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
