class Users
  attr_accessor :users

  def initialize
    @users = []
  end

  def addUser(user)
    if !users.include?(user)
      users.push(user)
    end
  end

end