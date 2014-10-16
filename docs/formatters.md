## Formatters

Formatters are modules that get included into a Renderer class to modify the base Redcarpet behavior in different ways.

For example lets create a Renderer that fixes common misspellings and escapes merge tags:

```ruby
class ExampleRenderer < MCMarkdown::HTML
  include MCMarkdown::Formatter::EscapeMergeTags
  include MCMarkdown::Formatter::CommonMisspellings
end
```


### Images

This formatter brings two features to images
- add classes to the image tags
- create figure / figcaptions

In general it takes this format:
```markdown
![alt text {class}](/path/to/img.jpg "caption text")
```

**Adding Classes**

```markdown
![screenshot {ghost-browser}](/path/to/img.jpg)

<img src="/path/to/img.jpg" class="ghost-browser" alt="screenshot" />
```

**Figure / Figcaption**

```markdown
![screenshot](/path/to/img.jpg "An example figure")

<figure class='img'>
  <img src="/path/to/img.jpg" alt="screenshot" />
  <figcaption><p>An example figure</p></figcaption>
</figure>
```


### Links

Additional features:
- add classes
- specify the target attribute
- add arbitrary attributes

Formats:
```markdown
[Link Text {class} _target](/link/path)
[Link Text {class: foo, aria-role: link}](/link/path)
```

**Adding Classes**

```markdown
[Link Text {class_name}](/link/path)

<a href="/link/path" class="class_name">Link Text</a>
```

**Target Attributes**

```markdown
[Link Text _blank](/link/path)

<a href="/link/path" target="_blank">Link Text</a>
```

**Arbitrary Attributes**

```markdown
[Link Text {class: btn, target: _blank}](/link/path)

<a href="/link/path" class="btn" target="_blank">Link Text</a>
```



### Lists

Adds the ability to create definition lists

Example:

```markdown
- one
  :
  the definition

- two
  :
  second definition
```

```html
<dl class='list markers'>

  <dt><p>one</p></dt>
  <dd><p>the definition</p></dd>

  <dt><p>two</p></dt>
  <dd><p>second definition</p></dd>

</dl>
```


### Blockquote

Fixes some "broken" default behavior of Redcarpet blockquotes, it allows two block quotes to be next to each other (where Redcarpet by default would run them in the same blockquote)

Example:

```markdown
> One quote

> Another Quote

> A quote that
>
> Has multiple lines
```

```html
<blockquote><p>One quote</p></blockquote>
<blockquote><p>Another Quote</p></blockquote>
<blockquote><p>A quote that</p><p>Has multiple lines</p></blockquote>
```



### Common Misspellings

Takes some common mistakes and fixes them.

Example
```markdown
Freddie&rsqou;s jokes
```
```html
<p>Freddie&rsquo;s jokes
```



### Escape Merge Tags

By default [MailChimp merge tags](http://kb.mailchimp.com/merge-tags/all-the-merge-tags-cheatsheet) get italicized or bolded. This module escapes them from processing.

Example:
```markdown
*|MERGE:TAG|*

*|MERGE_TAG_FOO|*
```

```html
<p>*|MERGE:TAG|*</p>

<p>*|MERGE_TAG_FOO|*</p>
```



### Header with ID

Adds an id to headers with a few options that can be passed to the renderer.

**Creating a Renderer**

Here we use the defaults for `level` and `slug`:

```ruby
MCMarkdown.use(:base, header_with_id: { level: 1, slug: 'section' })
```

`level` sets the heading level that will receive the ids. It will accept an array if you'd like to add IDs to multiple header levels.

`slug` sets the prepended text to each heading's id.

**Examples**

Using the renderer we created above:

```markdown
# Hello World
```

```html
<h1 id="section-hello-world">Hello World</h1>
```


### Wistia

Adds "shortcode" to add embeded wistia videos.

Example:

```markdown
{{video id='edfrtg' video_width='640' video_height='480'}}
```

```html
<iframe src='http://fast.wistia.com/embed/iframe/edfrtg?version=v1&videoWidth=640&videoHeight=480&controlsVisibleOnLoad=true' allowtransparency='true' frameborder='0' scrolling='no' class='wistia_embed' name='wistia_embed' width='640' height='480'></iframe>
```

The options available to the tag:

`version` set the api version for wistia [default: v1]

`video_width` set the width of the video [default: 600]

`video_height` set the video's height [default: 400]

`controls_visible_on_load` set the visibility bolean [default: true]
