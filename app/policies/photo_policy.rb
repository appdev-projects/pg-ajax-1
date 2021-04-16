class PhotoPolicy < ApplicationPolicy
  attr_reader :user, :photo

  def initialize(user, photo)
    @user = user
    @photo = photo
  end

  def show?
    UserPolicy.new(user, photo.owner).show?
  end

  def update?
    user == photo.owner
  end

  def edit?
    update?
  end

  def destroy?
    user == photo.owner
  end
end
