class ANP
  attr_reader :city, :fuel

  def initialize(city = nil, fuel = nil)
    raise if city.nil? || fuel.nil?

    @city = city
    @fuel = fuel
  end

  def prices
    lines = []

    request.page.each do |node|
      node.inner_html.each_line.with_index do |line, index|
        next if index < 34

        line.encode! "ISO-8859-1", "UTF-8", :invalid => :replace, :replace => "?"
        line.gsub! /<(.*?)>/, ""

        lines << line.strip
      end
    end

    create_values_with lines
  end

  private
  def create_values_with(lines)
    line = []
    values = []

    0.upto(lines.size - 1) do |index|
      line << lines[index]

      if lines[index].match /([0-9]{2})\/([0-9]{2})\/([0-9]{4})/
        values << create_hash(line)

        line = []
      end
    end

    values
  end

  def create_hash(line)
    {
      :razao_social => line[0],
      :endereco => line[1],
      :bairro => line[2],
      :bandeira => line[3],
      :preco_venda => line[4],
      :preco_compra => line[5],
      :modalidade => line[6],
      :fornecedor => line[7],
      :coleta => line[8]
    }
  end

  def request(request_anp = RequestANP)
    request_anp.new @city, @fuel
  end
end

