# frozen_string_literal: true

FactoryBot.define do
  factory :sam, class: User do |u|
    u.name { 'Sam' }
  end
end
