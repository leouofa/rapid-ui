[![Test](https://github.com/leouofa/rapid-ui/actions/workflows/test.yml/badge.svg)](https://github.com/leouofa/rapid-ui/actions/workflows/test.yml)

# Rapid UI 🥋
RapidUI is a modern Ruby framework that addresses linguistic complexity of designing user interfaces.


### Features
- Clean and readable code reduces cognitive load and improves developer happiness.
- Unlike css classes, misspelled functions throw errors, drastically reducing the debug time.
- CSS Framework agnostic. It can be configured to work with your existing CSS framework.

### Background
- Rapid UI is a successor to [GoodUI](https://github.com/realstorypro/good-ui), a UI meta-programming framework for [Fomantic-UI](https://fomantic-ui.com/).
- It's battle tested and has been used in production by [StoryPRO](https://www.storypro.io) for many years.

### Installation
1. Add this line to your application Gemfile:

```ruby
    gem 'rapid_ui'
```

2. run and `bundle install`.


3. Copy the initializer, render monkey-patch, and ui.yml

```bash
rake rapid_ui:install
```

----

### What It Looks Like
Rapid UI works best with [slim templating](https://github.com/slim-template/slim-rails) langauge, drastically reducing
the amount of boilerplate code.

```ruby

=r ux.container

  =r ux.grid

    =r ux.row
      =r ux.column size: 16
          =r ux.h1 text: "Full Size"

    =r ux.row
      =r ux.column computer: 8, tablet: 7, mobile: 16
        =r ux.h2 text: 'Left Column'

      =r ux.column computer: 8, tablet: 9, mobile: 16
        =r ux.h1 text: 'Right Column'
```
