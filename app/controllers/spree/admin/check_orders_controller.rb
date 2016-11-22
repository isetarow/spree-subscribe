class Spree::Admin::CheckOrdersController < Spree::Admin::BaseController
  respond_to :html

  def index
    @date = Time.zone.parse(params[:date]) if params[:date].present?
    @date ||= 0.days.since.next_week(:monday)
    @orders = Spree::Subscription.next_week(@date).map(&:order)
    @products = []
    @orders.each do |o|
      o.products.each do |p|
        if p.assemblies_parts.present?
          p.assemblies_parts.each do |part|
            part.count.times do
              @products << part.part.product
            end
          end
        else
          @products << p
        end
      end
    end
    @products = @products.group_by{|p| p.suppliers.first}
  end

  def confirm
    errors = Spree::Subscription.check_products_stocks(params[:date])
    if errors.present?
      flash[:error] = errors.map{|k, v| "#{k.name} の在庫がたりません。 在庫数： #{v[:stock]} 必要数: #{v[:count]}"}.join('<br>').html_safe
    else
      if Spree::Subscription.reorder_next_week!(params[:date])
        flash[:notice] = '注文の作成が完了しました'
      else
        flash[:error] = '何らかのエラーが発生しました'
      end
    end

    @date = Time.zone.parse(params[:date]) if params[:date].present?
    @date ||= 0.days.since.next_week(:monday)
    @orders = Spree::Subscription.next_week(@date).map(&:order)
    @products = []
    @orders.each do |o|
      o.products.each do |p|
        if p.assemblies_parts.present?
          p.assemblies_parts.each do |part|
            part.count.times do
              @products << part.part.product
            end
          end
        else
          @products << p
        end
      end
    end
    @products = @products.group_by{|p| p.suppliers.first}
    render :index
  end

end
