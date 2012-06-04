#!/usr/bin/env ruby

load "webe.rb"

Weberb.make_page :css => "style.css", :title => "Awesome Webpage" do
  Weberb.tag "div", nil, :id => "post" do
    Weberb.tag "h1", "Test", :class => "header-title"
    Weberb.tag "p", nil, :id => "post-content" do
      Weberb.display "This is an example."
      Weberb.ctag "br"
      Weberb.display "It seems to be working, right?"
    end
  end
end
