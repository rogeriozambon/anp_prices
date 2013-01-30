require_relative "../lib/anp_prices"
require "fakeweb"

describe ANP do
  it "missing parameters" do
    expect { anp = ANP.new }.to raise_error(ArgumentError)
  end

  context "Find city code" do
    before do
      fixture = File.open("spec/fixture/city_sao_paulo.html").read
      FakeWeb.register_uri(:any, "http://www.anp.gov.br/preco/prc/Resumo_Ultimas_Coletas_Index.asp", :body => fixture)

      @anp = ANP.new "Sao Paulo", :gasolina
    end

    it "check city code" do
      @anp.city.should == "9668*SAO@PAULO"
    end
  end

  context "Informations" do
    before do
      fixture = File.open("spec/fixture/anp_sao_paulo.html").read
      FakeWeb.register_uri(:any, "http://www.anp.gov.br/preco/prc/Resumo_Ultimas_Coletas_Posto.asp", :body => fixture)

      @anp = ANP.new "Sao Paulo", :gasolina
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
