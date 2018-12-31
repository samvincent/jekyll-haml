# Jekyll::Haml

This gem provides a [Jekyll](http://github.com/mojombo/jekyll) converter for
[Haml](http://haml.info) files.

## Installation

If using [Bundler](http://gembundler.com), add these lines to your application's Gemfile:

```rb
group :jekyll_plugins do
  gem 'jekyll-haml'
end
```

Alternatively, if you don't use Bundler, just update your Jekyll project's `_config.yml`:

```yml
plugins:
- jekyll-haml
```

## Usage

You'll be able to use all of Haml's tricks to write some really clean markup. You can use liquid filters easily by just rendering the liquid tags as shown below. Have fun!

```haml
---
title: Story Time
permalink: page/
---
.container
  %h3= "{% title %}"
  
:javascript
  $(document).ready(function(){});
```

### Markdown blocks

For clean content blocks, I find it helps to use Haml's `:markdown` filter if I can get away with it.

```haml
.content
  :markdown
    *Dec 4, 2012* - [Author](http://github.com)

    Once upon a time, in a village by the sea...
```
    
### Partials

The gem adds the liquid filter `haml` so you can render `_includes` that are written in Haml as well. 

```liquid
{% haml comments.haml %}
```

 ```haml
-# _includes/meta.haml
%meta{property: 'og:type', content: 'website'}
%meta{name: 'viewport', content: 'width=device-width'}
 ```
 
## About

I originally searched around the internet for a quick way to integrate HAML into my jekyll workflow and found a few around the internet to convert haml in different cases (layouts, partials, and posts). This gem is really just a collection of those techniques so they're easy to find and you can get back to creating your site using the slickest markup. It's made to drop in to your `Gemfile` just as easily as [jekyll-sass](https://github.com/noct/jekyll-sass).

If you're using this stuff, you may also be interested in [Octopress](http://octopress.org). I believe it includes support for Haml/Sass out of the gate.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
