# ANP Prices

[![Gem Version](https://badge.fury.io/rb/anp_prices.png)](http://badge.fury.io/rb/anp_prices)
[![Build Status](https://travis-ci.org/rogeriozambon/anp_prices.png?branch=master)](https://travis-ci.org/rogeriozambon/anp_prices)
[![Code Climate](https://codeclimate.com/github/rogeriozambon/anp_prices.png)](https://codeclimate.com/github/rogeriozambon/anp_prices)

Get fuel prices of the ANP (Agência Nacional do Petróleo, Gás Natural e Biocombustíveis) Brazil.

## Installation

~~~.ruby
gem install anp_prices
~~~

## Usage

Don't use accentuation in city parameter!

~~~.ruby
require "rubygems"
require "anp_prices"

anp = ANP.new "Sao Paulo", :gasolina
anp.prices.each do |row|
  puts row[:razao_social]
end
~~~

### Fuel types
~~~
:gasolina
:etanol
:diesel
:gnv
:glp
~~~

## Returned values
~~~
:razao_social
:endereco
:bairro
:bandeira
:preco_venda
:preco_compra
:modalidade
:fornecedor
:coleta
~~~

Simple [post about](http://rogerio.me/gem-para-consulta-de-precos-de-combustiveis) this gem.

## Maintainer

* Rogério Zambon (http://rogerio.me)

## Collaborators

* Willian Oizumi (http://willianoizumi.com)
* Pedro Felipe (http://pedrofelipe.com.br)

## License

(The MIT License)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
