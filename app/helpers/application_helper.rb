module ApplicationHelper
  include Pagy::Frontend

  def pagination(pagy)
    {
      per_page: pagy.items,
      pages: pagy.pages,
      count: pagy.count
    }
  end
end
