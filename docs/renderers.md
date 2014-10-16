## Renderers

There are three primary ways to use MCMarkdown renderers:
- by using the `MCMarkdown.render` method
- by pulling a renderer with `MCMarkdown::Renderers.use`
- by creating your own

### MCMarkdown.render

This will directly render the given input string with the given options. Initialized renderers are stored in a cache, so if given the same options it won't initialize a new one.

**Params**

`input`  
The string to be rendered

`renderer`  
The symbolized version of a renderer to be used [default: :base]

This is looked up in the `MCMarkdown` namespace, so `:base` uses the `MCMarkdown::Base` renderer.

`options`  
Options to pass to the renderer as it's initialized. These will be the same options/extensions that are defined in [Redcarpet](https://github.com/vmg/redcarpet#and-its-like-really-simple-to-use) or specific to some formatters.

Examples:

```ruby
MCMarkdown.render '==highlight==', :html, extensions: { highlight: true }
# => "<p><mark>highlight</mark></p>"

MCMarkdown.render '# Hello World', header_with_ids: { slug: 'wut' }
# => '<h1 id="wut-hello-world">Hello World</h1>'
```


### MCMarkdown::Renderers.use

This is what `MCMarkdown.render` uses internally to retrieve a renderer. If you need to pull a specific renderer, it takes the same options as the `::render` method minus the input.

Examples:

```ruby
rndrr = MCMarkdown::Renderers.use :html, extensions: { highlight: true }
# => a Redcarpet::Markdown object using the MCMarkdown::HTML renderer and
# => with the highlight extension turned on

rndrr.render '==highlight=='
# => '<p><mark>highlight</mark></p>'
```


### Build your own

You can use the included formatters to build your own renderer for use with MCMarkdown or seperately. If you want to use it with MCMarkdown, keep in mind how the renderers are looked up based as a constant in `MCMarkdown`

Examples:

```ruby
module MCMarkdown
  class Foorenderer < MCMarkdown::HTML
    # it is recomended to extend off of MCMarkdown::HTML
    # as it includes some class methods that some of our
    # formatters expect

    include MCMarkdown::Formatters::EscapeMergeTags
    # Now our renderer can escape MailChimp merge tags
  end
end

MCMarkdown.render '*|MERGE:TAG|*', :foorenderer
# => '<p>*|MERGE:TAG|*</p>'
```


```ruby
class Nope < MCMarkdown::HTML
  include MCMarkdown::Formatters::EscapeMergeTags
end

MCMarkdown.render '# Hello', :nope
# this will fail as Nope can't be found inside the MCMarkdown namespace
# but if you prefer you can use it yourself

nope = Redcarpet::Markdown.new Nope
nope.render '*|MERGE:TAG|*'
# => '<p>*|MERGE:TAG|*</p>'
```
