class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.search_for(content, method)
    if method == 'perfect'
      Course.where(name: content)
    elsif method == 'forward'
      Course.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      Course.where('name LIKE ?', '%' + content)
    else
      Course.where('name LIKE ?', '%' + content + '%')
    end
  end
end
