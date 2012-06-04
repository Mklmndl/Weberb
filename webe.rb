#!/usr/bin/env ruby

module Weberb
  @indent_level = 0

  def self.make_page(params = {})
    puts "<!DOCTYPE html>"
    self.tag "html", nil do
      self.make_header params
      self.make_body { yield }
    end
  end

  def self.make_header(params)
    self.tag "head", nil do
      self.tag "title", nil do
        self.display params[:title] if params.has_key? :title
      end
      if params.has_key? :css
        # If the parameter is just a string, we put it in an array
        if params[:css].is_a? String then params[:css] = [params[:css]] end
        # We can now display the content as an array, no matter what it whas at first
        params[:css].each do |current|
          self.ctag "link", :rel => "stylesheet", :type => "text/css", :href => current
        end
      end
    end
  end

  def self.make_body
    self.tag "body", nil do
      puts
      yield
      puts
    end
  end

  # <tag param="value">
  def self.tag(name, data, params = {})
    self.block_tag name, params do
      if data.nil? then yield
      else self.display data end
    end
  end

  # <tag param="value" />
  def self.ctag(name, params = {})
    self.tag_opener name, params, true
  end

  # Generates and displays a tag:
  #    <tagname param="value" />
  #    <tagname param="value">
  def self.tag_opener(name, params, closed = false)
    ret = "<#{name}"
    params.each { |name, value| ret << " #{name}=\"#{value}\"" }
    ret << " /" unless !closed
    ret << ">"
    self.display ret
  end

  # Generates and displays a tag:
  #    </tagname>
  def self.block_tag(name, params)
    self.tag_opener(name, params)
    @indent_level += 2
    yield
    @indent_level -= 2
    self.display "</#{name}>"
  end

  # Simply displays the data with the right indentation
  def self.display(data)
    (@indent_level).times { print ' ' }
    puts data
  end
end
