require 'rails_helper'

describe Business do
  it { validate_presence_of :name }
  it { validate_uniqueness_of :name }


end