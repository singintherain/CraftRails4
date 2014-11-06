require 'test_helper'

class SqlTemplateTest < ActiveSupport::TestCase
  test 'resovler returns a template with the saved body' do
    #resolver = SqlTemplate::Resolver.new
    resolver = SqlTemplate::Resolver.instance
    details = { formats: [:html], locale: [:en], handlers: [:erb] }

    assert resolver.find_all('index', 'posts', false, details).empty?

    SqlTemplate.create!(
      body: "<%= 'Hi from SqlTemplate!' %>",
      path: "posts/index",
      format: "html",
      locale: "en",
      handler: "erb",
      partial: false
    )

    template = resolver.find_all('index', 'posts', false, details).first
    assert_kind_of ActionView::Template, template

    assert_equal "<%= 'Hi from SqlTemplate!' %>", template.source
    assert_kind_of ActionView::Template::Handlers::ERB, template.handler
    assert_equal "<%= 'Hi from SqlTemplate!' %>", template.source
    assert_equal [:html], template.formats
    assert_match %r[SqlTemplate - \d+ - "posts/index"], template.identifier
  end

  test 'sql_template expires the cache on update' do
    cache_key = Object.new
    resolver = SqlTemplate::Resolver.instance
    details = { formats: [:html], locale: [:en], handlers: [:erb] }

    t = resolver.find_all('index', 'users', false, details, cache_key).first
    assert_equal '<h1>Listing users</h1>', t.source

    sql_template = sql_templates(:users_index)
    sql_template.update_attributes(body: 'New body for templates')

    t = resolver.find_all('index', 'users', false, details, cache_key).first
    assert_equal 'New body for templates', t.source
  end
end
