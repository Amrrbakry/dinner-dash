module ItemsHelper
  def admin_role?
    current_user.try(:admin)
  end

  # item has a parent item?
  def a_varation?(item)
    !item.parent_item_id.nil?
  end
end
