require_relative '../../env'

class FrequencyReady
  include Mongoid::Document
  store_in collection: "frequency_ready"

  field :word,      :type => String
  field :source,    :type => String
  field :year,      :type => Integer
  field :month,     :type => Integer
  field :mentions,  :type => Integer
end
