# raise  Rails.root.inspect 

%w'it-IT en-US'.inject({}) do |translations, locale|
  
  text = File.read(File.dirname(__FILE__)+"/portfolio.#{locale}.txt")

  def digest(splitted)
    raise splitted.inspect unless splitted.kind_of?(Array) and splitted.size > 3
    title   = splitted.first
    groups  = splitted[1..-1].in_groups_of(3)
    return {:vendor => title, :works => groups}
  end

  def strong_underscore string
    underscored = string.downcase.scan(/\w+/).flatten.join('_')
    # raise string if underscored.empty?
    underscored
  end

  grouped = text.split("\n\n").map {|a| a.split "\n"}.map{|b| digest b}


  structure   = []
  translation = grouped.inject({}) do |vendor_hash, group|
    vendor           = strong_underscore(group[:vendor])
    vendor_structure = []
    
    vendor_hash[vendor] = group[:works].inject({}) do |work_hash, work|
      title             = strong_underscore(work.first)
      raise work.inspect if title.blank?
      vendor_structure << title.to_sym

      work_hash[title] = {
        :title       => work.first,
        :note        => work.second,
        :description => work.third
      }
      work_hash
    end

    structure << [vendor.to_sym, vendor_structure]
    vendor_hash
  end

  File.open(File.dirname(__FILE__)+"/portfolio.structure.#{locale}.txt", 'w') do |structure_file|
    structure_file << structure.map{|v| v.inspect}.join( ', ' )
  end

  translations[locale] = translation
end
