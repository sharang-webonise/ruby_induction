module ProductActions

  def list_all_products
    result 'No results' if !File.exists?('inventory')
    result = File.read('inventory') 
    result ? result : 'No results'
  end

  def search_product_by_name
    print 'Enter name of the product you wish to search for: '
    name = gets.strip
    return 'No results' if !File.exists?('inventory')
    result = ''
    File.open('inventory', 'r') do |file|
      until(file.eof?)
        file.readline
        line = file.readline
        temp_name = line.match(/^name: (.*)/)[1]
        if temp_name.casecmp(name).zero?
          result << line 
          3.times { result << file.readline }
          break
        else
          3.times { file.readline }
        end
      end
    end
    result == '' ? 'No results' : result
  end

  def id_exists?(id)
    return false if !File.exists?('inventory')
    File.open('inventory', 'r') do |file|
      until(file.eof?)
        line = file.readline
        temp_id = line.match(/^id: (.*)/)[1]
        if temp_id.to_i == id
          return true
        else
          4.times { file.readline }
        end
      end
    end 
    false
  end
  
end