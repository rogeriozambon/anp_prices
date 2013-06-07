require "spec_helper"

describe ANP do
  it "missing parameters" do
    expect { anp = ANP.new }.to raise_error
  end

  context "request information" do
    before do
      fixture = File.open("spec/fixture/anp_sao_paulo.html").read
      FakeWeb.register_uri(:any, "http://www.anp.gov.br/preco/prc/Resumo_Ultimas_Coletas_Posto.asp", :body => fixture)

      @anp = ANP.new "Sao Paulo", :gasolina
    end

    it "checking output" do
      @anp.prices.should be_an(Array)
      @anp.prices.first.should be_a(Hash)

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
