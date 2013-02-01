require "rest_client"
require "nokogiri"

class ANP
  attr_reader :city, :fuel

  def initialize(city = nil, fuel = nil)
    raise ArgumentError if city.nil? or fuel.nil?

    RestClient.proxy = ENV["http_proxy"]

    @city = find_code_of(city)
    @fuel = fuel
  end

  def prices
    lines = []

    request_page.each do |node|
      node.inner_html.each_line.with_index do |line, index|
        next if index < 34

        line.encode! "ISO-8859-1", "UTF-8", :invalid => :replace, :replace => "?"
        line.gsub! /<(.*?)>/, ""

        lines << line.strip
      end
    end

    push_values_with lines
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

  def request_page
    request = RestClient.post "http://www.anp.gov.br/preco/prc/Resumo_Ultimas_Coletas_Posto.asp", {
      :Tipo => "2",
      :Cod_Combustivel => fuel_types[@fuel],
      :selMunicipio => @city,
      :BAIRRO => "0"
    }

    Nokogiri::HTML(request.body).xpath "//div[@class='multi_box3']/table[@class='table_padrao scrollable_table']"
  end

  def request_city(name)
    request = RestClient.post "http://www.anp.gov.br/preco/prc/Resumo_Ultimas_Coletas_Index.asp", :txtMunicipio => name

    Nokogiri::HTML(request.body).xpath "//div[@id='divMunicipios']/select[@name='selMunicipio']/option"
  end

  def find_code_of(name)
    request_city(name).each do |node|
      node.each_with_index do |code, index|
        next if index == 0

        return code[1]
      end
    end
  end

  def push_values_with(lines)
    entry = []
    entries = []

    0.upto(lines.size - 1) do |index|
      entry << lines[index]

      if lines[index].match /([0-9]{2})\/([0-9]{2})\/([0-9]{4})/
        entries << {
          :razao_social => entry[0],
          :endereco => entry[1],
          :bairro => entry[2],
          :bandeira => entry[3],
          :preco_venda => entry[4],
          :preco_compra => entry[5],
          :modalidade => entry[6],
          :fornecedor => entry[7],
          :coleta => entry[8]
        }

        entry = []
      end
    end

    entries
  end
end
