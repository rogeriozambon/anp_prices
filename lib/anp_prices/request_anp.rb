class RequestANP
  def initialize(city, fuel)
    RestClient.proxy = ENV["http_proxy"]

    @city = find_city_by_code city
    @fuel = fuel_types[fuel]
  end

  def page
    request = RestClient.post "http://www.anp.gov.br/preco/prc/Resumo_Ultimas_Coletas_Posto.asp", {
      :Tipo => "2",
      :Cod_Combustivel => @fuel,
      :selMunicipio => @city,
      :BAIRRO => "0"
    }

    Nokogiri::HTML(request.body).xpath "//div[@class='multi_box3']/table[@class='table_padrao scrollable_table']"
  end

  private
  def fuel_types
    {
      :gasolina => "487*Gasolina",
      :etanol => "643*Etanol",
      :diesel => "532*Diesel",
      :gnv => "476*GNV",
      :glp => "462*GLP"
    }
  end

  def city(name)
    request = RestClient.post "http://www.anp.gov.br/preco/prc/Resumo_Ultimas_Coletas_Index.asp", :txtMunicipio => name

    Nokogiri::HTML(request.body).xpath "//div[@id='divMunicipios']/select[@name='selMunicipio']/option"
  end

  def find_city_by_code(city_name)
    city(city_name).each do |node|
      node.each_with_index do |code, index|
        next if index == 0

        return code[1]
      end
    end
  end
end
