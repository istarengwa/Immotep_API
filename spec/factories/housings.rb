FactoryBot.define do
  factory :housing do
    ad_price { 254512 }
    localization { "test" }
    property_category { "Studio" }
    project_id { Project.first.id || association(:project) }
  end
end


