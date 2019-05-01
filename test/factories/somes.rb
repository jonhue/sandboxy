# frozen_string_literal: true

FactoryBot.define do
  factory :post, class: Some do |b|
    b.name { 'Post' }
  end

  factory :purchase, class: Some do |b|
    b.name { 'Purchase' }
  end

  factory :book, class: Some do |b|
    b.name { 'Book' }
  end

  factory :receipt, class: Some do |b|
    b.name { 'Receipt' }
  end
end
