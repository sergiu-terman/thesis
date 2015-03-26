require 'mongoid'
require_relative 'mr_helper'

Mongoid.load!("mongoid.yml", :development)

MRHelper.new.execute_mr(["Voronin"])
