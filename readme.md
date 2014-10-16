Our chimpy flavour of [Redcarpet](https://github.com/vmg/redcarpet) Markdown with a few escaping tricks for merge tags and content writer friendly extensions.

# Use

### Installation

In your Gemfile:

```ruby
gem "mc_markdown", git: 'git@github.com:mailchimp/mc_markdown.git'
```

Then `bundle install`


### Quick Examples

Rendering with the Base renderer

```ruby
MCMarkdown.render "# Hello World"
# => '<h1>Hello World</h1>'

MCMarkdown.render "*|MERGE_TASTIC|*"
# => '<p>*|MERGE_TASTIC|*</p>'

MCMarkdown.render "[Sign Up {btn}](/signup)"
# => '<a href="/signup" class="btn">Sign Up</a>'
```


Getting a renderer to use

```ruby
html = MCMarkdown::Renderers.use :html
# => MCMarkdown::HTML initialized for Redcarpet::Markdown

html.render '# Hello World'
# => '<h1>Hello World</h1>'
```


### Full Docs

**[Renderers](doc/renderers.md)**  
Our "top level" objects, they coordinate collections of formatters and take the `#render` method to render our input markdown.

**[Formatters](doc/formatters.md)**  
Formatters are the individual parts that differ from the base [Redcarpet](https://github.com/vmg/redcarpet) implementation. Some implement something like "shortag" codes in markdown.


# Testing

```bash
$ rspec
# => runs the test suite
```
