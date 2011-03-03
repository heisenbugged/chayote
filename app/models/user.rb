class User
  include Mongoid::Document
  field :admin, :type => Boolean, :default => false
  field :base_rate, :type => Integer
  
  references_many :members, :dependent => :destroy
  references_many :rates, :dependent => :destroy
  references_many :tasks, :dependent => :destroy
  references_many :time_entries, :dependent => :destroy

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  def projects
    members.collect{ |member| member.project }
  end
  def rate_for(object)
    if object.instance_of? Project
      rates.where(:project_id => object.id).first
    end
  end
end
