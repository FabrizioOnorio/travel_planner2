class Trip < ApplicationRecord
  belongs_to :user

  belongs_to :inbound, class_name: "Flight"
  belongs_to :outbound, class_name: "Flight"

  
end
