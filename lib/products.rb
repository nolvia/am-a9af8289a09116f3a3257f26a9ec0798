#!/usr/bin/env ruby
# coding: utf-8
STDOUT.sync = true
require 'pp'
require 'YAML'

# files = Dir[File.dirname(__FILE__)+'/products.en.txt']
files = Dir[File.dirname(__FILE__)+'/products.*.txt']
locale = nil

files.each do |file|
  puts
  puts '*' * 80
  puts

  category, categories = '', {}
  
  
  locale = file.scan(/products\.(.*?)\.txt/).flatten.first
  puts "Processig #{file} (#{locale})..."
  
  content = File.read(file)
  content.gsub!(/ +$/, '')
  content = content.split(/\s*\n\n[\s\n]*/)
  
  title = content.shift
  puts "Found title: #{title}"
  
  headers = content.shift
  content.each do |c|
    if (/^\#/ =~ c)
      puts
      category = c.downcase
      category.gsub!(/\W/, '')
      puts "Found category: #{category.inspect}"
      
      categories[category] = []
    else
      products = c.scan(/\d+\n§.*?\n.*?\n/)
      products.map! do |product|
        # puts '> '+product.inspect
        product_title, product_description = product.scan(/§(.*?)\n(.*?)\n/).first
        product_title = product_title.strip.downcase
        product_title.gsub!(/(\b)(\w)/) do |letter|
          letter.upcase
        end
        {'title' => product_title, 'description' => product_description}
      end
      print '.' * products.size
      categories[category] = products
    end
  end
  puts  
  
  yml_file_name = File.dirname(__FILE__)+"/products.#{locale}.yml"
  File.open(yml_file_name, 'w') do |yml_file|
    yml_file << categories.to_yaml
  end
  
  puts "Wrote: #{yml_file_name}" if File.exist? yml_file_name
end

