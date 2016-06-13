FactoryGirl.define do
  factory :task do
    created_at { Time.now.to_s }
    title 'Climb Everest'
    body 'I will one day climb Mount Everest'
    status 'pending'

    factory :new_task do
      title 'Visit NewYork'
      body 'I will like to touch the statue of liberty'
      status 'done'
    end
  end
end
