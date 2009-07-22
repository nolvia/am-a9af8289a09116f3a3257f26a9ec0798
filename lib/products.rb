#!/usr/bin/env ruby
# coding: utf-8
STDOUT.sync = true
require 'pp'
require 'YAML'

# files = Dir[File.dirname(__FILE__)+'/products.en.txt']
files = Dir[File.dirname(__FILE__)+'/products.*.txt']
locale = nil


videos = {}
YAML.load_file(File.dirname(__FILE__)+'/product_videos.yml').each do |video|
  category_id = video['category'].to_i
  product_id  = video['product'].to_i
  videos[category_id] ||= {}
  videos[category_id][product_id] ||= []
  videos[category_id][product_id] << video
  puts "video: #{video['title']} (#{category_id.inspect}:#{product_id.inspect})"
end

pp videos

files.each do |file|
  puts
  puts '*' * 80
  puts

  category, categories, categories_list = '', {}, []
  category_index = 0
  product_index  = 0
  
  
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
      category_index += 1
      product_index   = 0
      category = c.downcase
      category.gsub!(/\W/, '')
      puts "Found category: #{category.inspect}"
      categories_list << category
      puts "CATEGORY: #{category} (#{category_index.inspect})"
      categories[category] = []
    else
      products = c.scan(/\d+\n§.*?\n.*?\n/)
      products.map! do |product|
        product_index += 1
        puts "> #{product_index.inspect}"
        product_title, product_description = product.scan(/§(.*?)\n(.*?)\n/).first
        product_title = product_title.strip.downcase
        product_title.gsub!(/(\b)(\w)/) do |letter|
          letter.upcase
        end
        hash = {'title' => product_title, 'description' => product_description}
        if videos[category_index] and videos[category_index][product_index]
          puts "VIDEO: #{videos[category_index][product_index].inspect}"
          hash['video'] = videos[category_index][product_index]
        end
        hash
      end
      categories[category] = products
    end
  end
  puts  
  
  yml_file_name = File.dirname(__FILE__)+"/products.#{locale}.yml"
  File.open(yml_file_name, 'w') do |yml_file|
    yml_file << {
      'per_category' => categories, 
      'categories_list' => categories_list
    }.to_yaml
  end
  
  puts "Wrote: #{yml_file_name}" if File.exist? yml_file_name
end

