require 'test/unit'
require File.dirname(__FILE__) + '/../../lib/action_view/helpers/text_helper'
require File.dirname(__FILE__) + '/../../../activesupport/lib/active_support/core_ext/numeric'  # for human_size

class TextHelperTest < Test::Unit::TestCase
  include ActionView::Helpers::TextHelper
  
  def test_simple_format
    assert_equal "<p>crazy\n<br /> cross\n<br /> platform linebreaks</p>", simple_format("crazy\r\n cross\r platform linebreaks")
    assert_equal "<p>A paragraph</p>\n\n<p>and another one!</p>", simple_format("A paragraph\n\nand another one!")
    assert_equal "<p>A paragraph\n<br /> With a newline</p>", simple_format("A paragraph\n With a newline")
  end

  def test_truncate
    assert_equal "Hello World!", truncate("Hello World!", 12)
    assert_equal "Hello Worl...", truncate("Hello World!!", 12)
  end

  def test_strip_links
    assert_equal "on my mind", strip_links("<a href='almost'>on my mind</a>")
  end

  def test_highlighter
    assert_equal(
      "This is a <strong class=\"highlight\">beautiful</strong> morning",
      highlight("This is a beautiful morning", "beautiful")
    )

    assert_equal(
      "This is a <strong class=\"highlight\">beautiful</strong> morning, but also a <strong class=\"highlight\">beautiful</strong> day",
      highlight("This is a beautiful morning, but also a beautiful day", "beautiful")
    )

    assert_equal(
      "This is a <b>beautiful</b> morning, but also a <b>beautiful</b> day",
      highlight("This is a beautiful morning, but also a beautiful day", "beautiful", '<b>\1</b>')
    )
  end

  def test_highlighter_with_regexp
    assert_equal(
      "This is a <strong class=\"highlight\">beautiful!</strong> morning",
      highlight("This is a beautiful! morning", "beautiful!")
    )

    assert_equal(
      "This is a <strong class=\"highlight\">beautiful! morning</strong>",
      highlight("This is a beautiful! morning", "beautiful! morning")
    )

    assert_equal(
      "This is a <strong class=\"highlight\">beautiful? morning</strong>",
      highlight("This is a beautiful? morning", "beautiful? morning")
    )
  end
  
  def test_human_size
    assert_equal("0 Bytes", human_size(0))
    assert_equal("3 Bytes", human_size(3.14159265))
    assert_equal("123 Bytes", human_size(123.0))
    assert_equal("123 Bytes", human_size(123))
    assert_equal("1.2 KB", human_size(1234))
    assert_equal("12.1 KB", human_size(12345))
    assert_equal("1.2 MB", human_size(1234567))
    assert_equal("1.1 GB", human_size(1234567890))
    assert_equal("1.1 TB", human_size(1234567890123))
    assert_equal("444.0 KB", human_size(444.kilobytes))
    assert_equal("1023.0 MB", human_size(1023.megabytes))
    assert_equal("3.0 TB", human_size(3.terabytes))
    assert_nil human_size('x')
  end

  def test_excerpt
    assert_equal("...is a beautiful morni...", excerpt("This is a beautiful morning", "beautiful", 5))
    assert_equal("This is a...", excerpt("This is a beautiful morning", "this", 5))
    assert_equal("...iful morning", excerpt("This is a beautiful morning", "morning", 5))
    assert_equal("...iful morning", excerpt("This is a beautiful morning", "morning", 5))
    assert_nil excerpt("This is a beautiful morning", "day")
  end

  def test_pluralization
    assert_equal("1 count", pluralize(1, "count"))
    assert_equal("2 counts", pluralize(2, "count"))
  end

  def test_auto_linking
    assert_equal %(hello <a href="mailto:david@loudthinking.com">david@loudthinking.com</a>), auto_link("hello david@loudthinking.com", :email_addresses)
    assert_equal %(Go to <a href="http://www.rubyonrails.com">http://www.rubyonrails.com</a>), auto_link("Go to http://www.rubyonrails.com", :urls)
    assert_equal %(Go to http://www.rubyonrails.com), auto_link("Go to http://www.rubyonrails.com", :email_addresses)
    assert_equal %(Go to <a href="http://www.rubyonrails.com">http://www.rubyonrails.com</a> and say hello to <a href="mailto:david@loudthinking.com">david@loudthinking.com</a>), auto_link("Go to http://www.rubyonrails.com and say hello to david@loudthinking.com")
  end
  
end
