# == Schema Information
#
# Table name: company_people
#
#  id         :integer          not null, primary key
#  company_id :integer          not null, primary key
#  person_id  :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe CompanyPerson, type: :model do
  it { is_expected.to belong_to :company }
  it { is_expected.to belong_to :person }
end
