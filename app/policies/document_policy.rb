class DocumentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    @user.has_role?(:admin) || @user.has_role?(:staff) || @user.has_role?(:instructor) || @user.has_role?(:mentor)
  end

  def create?
    @user.has_role?(:admin) || @user.has_role?(:staff) || @user.has_role?(:instructor) || @user.has_role?(:mentor)
  end

  def edit?
    @user.has_role?(:admin) || @user.has_role?(:staff) || @user.has_role?(:instructor) || @user.has_role?(:mentor)
  end

  def update?
    @user.has_role?(:admin) || @user.has_role?(:staff) || @user.has_role?(:instructor) || @user.has_role?(:mentor)
  end

  def destroy?
    @user.has_role?(:admin) || @user.has_role?(:staff)
  end
end
