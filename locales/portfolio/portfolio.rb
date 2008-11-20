# raise  Rails.root.inspect 

built_translations = %w'it-IT en-US'.inject({}) do |translations, locale|
  
  text = File.read(File.dirname(__FILE__)+"/portfolio.#{locale}.txt")

  def digest(splitted)
    raise splitted.inspect unless splitted.kind_of?(Array) and splitted.size > 3
    title   = splitted.first
    groups  = splitted[1..-1].in_groups_of(3)
    return {:client => title, :works => groups}
  end

  def strong_underscore string
    underscored = string.downcase.scan(/\w+/).flatten.join('_')
    # raise string if underscored.empty?
    underscored
  end

  grouped = text.split("\n\n").map {|a| a.split "\n"}.map{|b| digest b}


  structure   = []
  translation = {}
  
  
  translation['clients'] = grouped.inject({}) do |client_hash, group|
    
    client_key       = strong_underscore(group[:client])
    client_structure = []
    
    client_hash[client_key] = {}
    client_hash[client_key][:client_name] = group[:client]
    
    client_hash[client_key][:works] = group[:works].inject({}) do |work_hash, work|
      title                 = strong_underscore(work.first)
      raise work.inspect if title.blank?
      client_structure << title.to_sym

      work_hash[title] = {
        'title'       => work.first,
        'note'        => work.second,
        'description' => work.third
      }
      work_hash
    end

    structure << [client_key.to_sym, client_structure]
    client_hash
  end


  File.open(File.dirname(__FILE__)+"/portfolio.structure.#{locale}.txt", 'w') do |structure_file|
    structure_file << structure.map{|v| v.inspect}.join( ', ' )
  end
  
  translations[locale] ||= {}
  translations[locale]['portfolio'] = translation
  translations
end

File.open(Rails.root / 'locales' / 'portfolio' / 'portfolio.yml.dump', 'w') do |file|
  file << built_translations.to_yaml
end
File.open(Rails.root / 'locales' / 'portfolio' / 'portfolio.rb.dump', 'w') do |file|
  file << built_translations.inspect
end

built_translations