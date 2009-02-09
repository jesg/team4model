class Bug < ActiveRecord::Base

  Statuses = ["Open", "Assigned", "Fixed", 
              "Verified", "Closed", "Reopen"].map do |s|
    [s, s]
  end

  validates_presence_of :description

  def initialize(args=nil)
    super
    self.status = "Open"
  end

end
