# VueOnRails

Easy and simple way to use Vue.js with Ruby on Rails and Turbolinks 5.

This gem was made to sprinkle your Rails app with Vue components. 
It's compatible with Turbolinks caching system.

If you are building a SPA app with Vue and Rails, please look into:
https://github.com/adambutler/vuejs-rails

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

Init and destroy Vue components:
```
# Load Vue components
document.addEventListener 'turbolinks:load', ->
  VueOnRails.init()

# Destroy Vue components
document.addEventListener 'turbolinks:before-render', ->
  VueOnRails.destroy()
```

Add component in view.html.erb 
```
<%= vue_component 'MyComponent', my_prop: 'awesome prop!' %>
```

Your Vue component in my_component.coffee
```
@MyComponent =
  props: ['myProp']
  template: '<div>A custom component with {{myProp}}</div>'
```

Will output:
```
<div data-vue-component="MyComponent" data-vue-props="{&quot;my-prop&quot;:&quot;awesome prop!&quot;}">
   <div>A custom component with awesome prop!</div>
</div>
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/benoitontgit/vue-on-rails.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

