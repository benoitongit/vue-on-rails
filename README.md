# VueOnRails

Simple and fast way to use Vue.js with Ruby on Rails and Turbolinks 5.

This gem is fantastic to sprinkle your web page with Vue components. Lightweight script (1KB minified) that mounts and destroys Vue components on demand.

It works nicely with:
- Turbolinks rendering and caching system
- Javascript loaded asynchronously with defer or async script attribute

It's fully Google PageSpeed friendly since you can use it with defer or async, no need for render-blocking JavaScript :)

If you are building a pure SPA app with Vue and Rails without Turbolinks, you will be better off looking into:
https://github.com/adambutler/vuejs-rails

## Requirements

- [Vue.js](https://vuejs.org/v2/guide/installation.html) >= 2.0
- [Turbolinks](https://github.com/turbolinks/turbolinks) >= 5.0

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'vue_on_rails'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vue_on_rails


## Usage

Require vue_on_rails in application.js
```
//= require vue_on_rails
```

Mount and destroy Vue components:
```
# Mount Vue components
document.addEventListener('turbolinks:load', function() {
  VueOnRails.mountComponents();
});

# Destroy Vue components
document.addEventListener('turbolinks:before-render', function() {
  VueOnRails.destroyComponents();
});
```
VueOnRails.mountComponents() will scan the page and mount components using data-vue-component and data-vue-props.

Example Vue component in my_component.js
```
MyComponent = {
  props: ['myProp'],
  template: '<div>A custom component with {{myProp}}</div>'
};
```

Add component in view.html.erb
```
<%= vue_component 'MyComponent', my_prop: 'awesome prop!' %>
<!-- This will output -->
<div data-vue-component="MyComponent" data-vue-props="{&quot;my-prop&quot;:&quot;awesome prop!&quot;}">
   <div>A custom component with awesome prop!</div>
</div>
```

## View Helper
A view helper generate a div with component and props:
```
def vue_component(component_name, props = {}, html_options = {})
```
Example with html tag:
```
<%= vue_component 'UserComponent', { user_id: 1 }, { class: 'd-inline-block align-middle' } %>
<!-- Becomes: -->
<div data-vue-component="UserComponent" data-vue-props="{'user-id': 1}" class="d-inline-block align-middle">
...
</div>
```

## Props

### Kebab-case (hyphen-delimited)

Props are automatically hyphen-delimited to follow vuejs and HTML5 standard.

### Dynamic props
```
<%= vue_component 'MessageComponent', ':my_object': { title: 'Test', subtitle: 'Sweet!' } %>
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/benoitontgit/vue-on-rails.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

