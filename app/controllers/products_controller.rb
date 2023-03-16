require 'open-uri'

class ProductsController < ApplicationController
  def index
    products = URI.open('https://api.omens.com.br/single-item/open').read
    products_parsed = JSON.parse(products)

    filtered_data = products_parsed

    filtered_data = filtered_data.select { |item| item['name'] == params[:name] } if params[:name].present?
    filtered_data = filtered_data.select { |item| item['price'] == params[:price].to_i } if params[:price].present?
    filtered_data = filtered_data.select { |item| item['variantId'] == params[:variantId].to_i } if params[:variantId].present?
    filtered_data = filtered_data.select { |item| item['type'] == params[:type] } if params[:type].present?
    filtered_data = filtered_data.select { |item| item['presentation'] == params[:presentation] } if params[:presentation].present?
    filtered_data = filtered_data.select { |item| item['credits'] == params[:credits].to_i } if params[:credits].present?
    filtered_data = filtered_data.select { |item| item['id'] == params[:id] } if params[:id].present?

    render json: (params[:products].present? ? products_parsed : filtered_data)
  end
end
