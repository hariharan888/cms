class Stock < ApplicationRecord
  has_many :stock_codes
  has_many :stock_group_junctions
  has_many :stock_groups, through: :stock_group_junctions
  has_many :stock_values

  def nse_code
    stock_codes.nse.first&.value
  end

  def bse_code
    stock_codes.bse.first&.value
  end

  def mc_code
    stock_codes.mc.first&.value
  end

  def data_available(resolution = 'day')
    stock_values.where(resolution:).order(time: :desc).limit(1)[0]&.time
  end

  def update_mc_code!(value)
    code = stock_codes.find_or_initialize_by(code_type: :mc)
    code.value = value
    code.save!
  end

  class << self
    def ransackable_attributes(_auth_object = nil)
      %w[name]
    end

    def ransackable_associations(_auth_object = nil)
      []
    end

    def ransackable_scopes(_auth_object = nil)
      %i[]
    end
  end
end
