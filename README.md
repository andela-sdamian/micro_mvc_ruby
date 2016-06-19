# MicroMvcRuby
[![Coverage Status](https://coveralls.io/repos/github/andela-sdamian/micro_mvc_ruby/badge.svg?branch=master)](https://coveralls.io/github/andela-sdamian/micro_mvc_ruby?branch=master) [![Build Status](https://travis-ci.org/andela-sdamian/micro_mvc_ruby.svg?branch=master)](https://travis-ci.org/andela-sdamian/micro_mvc_ruby) [![Code Climate](https://codeclimate.com/github/andela-sdamian/micro_mvc_ruby/badges/gpa.svg)](https://codeclimate.com/github/andela-sdamian/micro_mvc_ruby)


MicroMvcRuby is an MVC framework built with Rack & Ruby that allows you to build modern day MVC applications. Like most Ruby web frameworks, MicroMvcRuby follows convention over configuration. 

>Please note that you cannot use this framework for large scale MVC applications but use it to fully grasp the concept of MVC and how to build one yourself. If you need a large scale MVC web framework then you should consider [Rails](http://rubyonrails.org/) or [Sinatra](http://www.sinatrarb.com/) (for a minimalist web application).

# Features  
This framework offers the following

1. Object Relational Mapper(ORM) - makes it easy for you to access database records in an object-oriented fashion

2. Templating Engine - you don't have to worry about templating 

3. Routes - enables you to create user-friendly URL that maps to controller actions

## Getting Started

Add this line to your application's Gemfile:

```ruby
gem 'micro_mvc_ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install micro_mvc_ruby

## Usage

After completion of the above steps, you would want to create a folder structure like so. 
```
app 
 | assets 
 |  - css
 |  - js
 | controllers
 | models
 | views
config
 - application.rb
 - routes.rb 
Gemfile
config.ru 
```

## Note

To use files in the assests directory, you will have to include the rack middleware in your `config.ru` file 

`use Rack::Static, urls: ["/css"], root: "app/assets"`

# Folder Structure & Usage
As you see the folder structure above mimics the rails folder structure, if you have built a rails app, working with this framework should be trivial. Now let us work through each folder and file. 
Before your proceed, ensure you adhere to this naming convention found [Here](http://itsignals.cascadia.com.au/?p=7).

## app 
This folder contains four sub-folders 
##### assets
This is where you put all your css and javascript files for your application.

##### controllers 
Your controllers should be kept in this folder and it  should inherit from `MicroMVCRuby::BaseController`. Only users endpoints should be made public all other actions should be private. An example is shown below 
```
class TaskController < MicroMvcRuby::BaseController 
    def index 
      @tasks = Task.all 
    end
    
    def show
      @task = Task.find(params["id"]) 
    end 
    
    private 
    def check
       #code goes here
    end
end
```
As you may know, controllers are the mediators between your views and models, ensure you have a corresponding template for each public endpoints (action) in your `views` folder. In rails for instance, you can either call `render` explicitly or leave it to the framework to do it implicitly - the same applies to MicroMvcRuby calling `render` is optional.

##### models
This folder is where you keep all models for your application. All your models should inherit from `MicroRubyMvc::BaseRecord` 

```
class Task < MicroRubyMvc::BaseRecord  
    to_table :tasks 
    property :task_id, type: :integer, primary_key: true 
    property :name, type: :text, nullable: false
    property :description, type: :text 
    create_table

end
```
Inheriting from `MicroRubyMvc::BaseRecord` enables you to store instances of all model object in a database, and access this record later in an object oriented fashion. Now, lets go through each of the available methods in our `Task` model above. 

The `to_table` method is responsible for converting your class into its database equivalent. Ensure all nouns are set to its plural form when passing an argument. For instance, if  your have model `Event` then pass `events` to `to_table` method. 

The `property` method helps you specify the attributes for your class, in this case, columns for your database. The first parameter is the `column_name`, the second is a hash of property used to provide more information about the column.  

The `type` option is the datatype for the column, this could be (text, integer, booleans) 

The `primary_key` option is used to set the column as the primary key 

The `nullable` options are used to specify whether a column should have null values, or not.

Ensure you call `create_table` to save the table and all its specified properties to the database. 

##### views
This is where all corresponding views for each endpoint are kept. Ensure each of your controllers has its own folder in the view folder. For our `TaskController` for instance, we would have to create a `tasks` folder inside view and each method should have is corresponding view file ending with `.html.erb` so your `index` action in your `TaskController` will have a corresponding template `index.html.erb` in `app/views/tasks/index.html.erb`    

##### routes 
MicroMvcRuby allows you to easily create a custom route with available `HTTP verbs` that maps `routes` to controller actions. A simple route file should look like this

```
TaskApplication.routes.draw do 
    get "/", to: "task#index"
    post "/create_task", to: "task#create"
    put "/update_task/:id", to: "task#update"
    delete "/delete/:id", to: "task#destroy"
end 

```
# Dependecies 
The following gems made this framework a reality 

1. [Rack](http://rack.github.io/)

2. [Tilt](https://github.com/rtomayko/tilt)

3. [Rack-Test](https://github.com/brynary/rack-test)

4. [Rspec](http://rspec.info/documentation/) 

5. [Rake](https://github.com/ruby/rake) 

# Limitations
Being a minimalist framework, MicorMvcRuby has its own set of shortcomings which includes 

1. Lack of generators: there are currently no generators in the application as present in frameworks like rails. You would have to manually create the folder structure yourself 

2. Caching and precompiling of assets in also not available in this framework 

3. This framework does not support database migration 

4. No error logging to console

5. Mini helpers: this framework falls short of helpers which include but to mention a few (form_helpers, Date helpers, and a whole lot more) 

# Running the test 
Test files are placed inside the spec folder and have been split into two sub folders, one for unit tests and the other for integration tests. To run the test, `cd` into the framework directory and type `bundle exec rspec`

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/andela-sdamian/micro_mvc_ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
