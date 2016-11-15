class Spree::Admin::CheckOrdersController < Spree::Admin::BaseController
  respond_to :html

  def index
    @date = Time.zone.parse(params[:date]) if params[:date].present?
    @date ||= 0.days.since.next_week(:monday)
    @orders = Spree::Subscription.next_week(@date).map(&:order)
    @products = []
    @orders.each do |o|
      o.products.each do |p|
        if p.parts.present?
          p.parts.each do |part|
            @products << part.product
          end
        else
          @products << p
        end
      end
    end
    @products = @products.group_by{|p| p.suppliers.first}
  end

end
