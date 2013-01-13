require_relative "../lib/anp_prices"

describe ANP do
  it "missing parameters" do
    expect { anp = ANP.new }.to raise_error(ArgumentError)
  end

  context "Find city code" do
    before do
      fixture = File.open("spec/fixture/city_sao_paulo.html").read
      parser = Nokogiri::HTML(fixture).xpath "//div[@id='divMunicipios']/select[@name='selMunicipio']/option"

      @anp = ANP.new "Sao Paulo", :gasolina
      @anp.stub(:request_city).and_return parser
    end

    it "check city code" do
      @anp.city.should == "9668*SAO@PAULO"
    end
  end

  context "Informations" do
    before do
      fixture = File.open("spec/fixture/anp_sao_paulo.html").read
      parser = Nokogiri::HTML(fixture).xpath "//div[@class='multi_box3']/table[@class='table_padrao scrollable_table']"

      @anp = ANP.new "Sao Paulo", :gasolina
      @anp.stub(:request_page).and_return parser
    end

    it "check object types" do
      @anp.prices.should be_an(Array)
      @anp.prices.first.should be_a(Hash)
    end

    it "check hash keys" do
      hash = @anp.prices.first

      hash.should have_key(:razao_social)
      hash.should have_key(:endereco)
      hash.should have_key(:bairro)
      hash.should have_key(:bandeira)
      hash.should have_key(:preco_venda)
      hash.should have_key(:preco_compra)
      hash.should have_key(:modalidade)
      hash.should have_key(:fornecedor)
      hash.should have_key(:coleta)
    end
  end
end
