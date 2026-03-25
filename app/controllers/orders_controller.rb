class OrdersController < ApplicationController
  before_action :set_orders_scope

  def index
    # Performance: Eager load :client to prevent N+1 queries in the index view
    @orders = @orders_scope.includes(:client).order(created_at: :desc)
  end

  def new
    # Pre-set the client for @order if client_id is present in params
    @order = @orders_scope.new(client_id: params[:client_id])
    @clients = current_tenant.users.where(role: :client)
  end

  def create
    # Always initialize through the scoped association for security
    @order = @orders_scope.new(order_params)
    @order.coach = current_user
    
    if @order.save
      # [Future Work]: Trigger ActiveJob for email notifications here
      redirect_to @order, notice: "Order created and sent successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_orders_scope
    # Essential for Multi-tenancy: users can never access data outside their tenant
    @orders_scope = current_tenant.orders
  end

  def order_params
    params.require(:order).permit(:client_id, :amount, :description)
  end
end