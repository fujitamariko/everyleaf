FactoryBot.define do
  factory :label do
    name {'KPOP'}
  end

  factory :label2, class: Label do
    name {'CPOP'}
  end

  factory :label3, class: Label do
    name {'JPOP'}
  end
end