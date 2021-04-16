class UserPolicy < ApplicationPolicy
  attr_reader :user, :user_record

  def initialize(user, user_record)
    @user = user
    @user_record = user_record
  end

  def show?
    user == user_record ||
      !user_record.private? ||
      user_record.followers.include?(user)
  end

  def update?
    user == user_record
  end

  def edit?
    update?
  end

  def destroy?
    user == user_record
  end
end
