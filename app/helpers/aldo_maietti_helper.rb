module AldoMaiettiHelper
  def sheet_url path
    Pathname.new(path).relative_path_from(Pathname.new(Rails.root / 'public')).to_s
  end
  
  def sheet_name sheet
    File.basename(sheet, '.pdf')[3..-1].humanize
  end
end