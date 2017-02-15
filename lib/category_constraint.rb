class CategoryConstraint
  def self.matches?(request)
    %w(all development design).include?(request.params[:category])
  end
end
