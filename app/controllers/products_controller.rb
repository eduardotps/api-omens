require 'open-uri'

class ProductsController < ApplicationController
  def index
    products = URI.open('https://api.omens.com.br/single-item/open').read
    products_parsed = JSON.parse(products)
    filtered_data = products_parsed

    if params[:name].present?
      filtered_data = filtered_data.select { |item| item['name'] == params[:name] }
    end

    if params[:price].present?
      filtered_data = filtered_data.select { |item| item['price'] == params[:price].to_i }
    end

    if params[:variantId].present?
      filtered_data = filtered_data.select { |item| item['variantId'] == params[:variantId].to_i }
    end

    if params[:type].present?
      filtered_data = filtered_data.select { |item| item['type'] == params[:type] }
    end

    if params[:presentation].present?
      filtered_data = filtered_data.select { |item| item['presentation'] == params[:presentation] }
    end

    if params[:credits].present?
      filtered_data = filtered_data.select { |item| item['credits'] == params[:credits].to_i }
    end

    if params[:id].present?
      filtered_data = filtered_data.select { |item| item['id'] == params[:id] }
    end

    if params[:products].blank?
      render json: filtered_data
    else
      render json: products_parsed
    end

  end
end
