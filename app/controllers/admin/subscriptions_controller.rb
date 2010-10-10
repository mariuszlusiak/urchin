class Admin::SubscriptionsController < ApplicationController
  # GET /admin/subscriptions
  # GET /admin/subscriptions.xml
  def index
    @admin_subscriptions = Subscription.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_subscriptions }
    end
  end

  # GET /admin/subscriptions/1
  # GET /admin/subscriptions/1.xml
  def show
    @admin_subscription = Subscription.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @admin_subscription }
    end
  end

  # GET /admin/subscriptions/new
  # GET /admin/subscriptions/new.xml
  def new
    @admin_subscription = Subscription.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @admin_subscription }
    end
  end

  # GET /admin/subscriptions/1/edit
  def edit
    @admin_subscription = Subscription.find(params[:id])
  end

  # POST /admin/subscriptions
  # POST /admin/subscriptions.xml
  def create
    @admin_subscription = Subscription.new(params[:subscription])

    respond_to do |format|
      if @admin_subscription.save
        format.html { redirect_to(admin_subscription_path(@admin_subscription), :notice => 'Subscription was successfully created.') }
        format.xml  { render :xml => @admin_subscription, :status => :created, :location => @admin_subscription }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @admin_subscription.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/subscriptions/1
  # PUT /admin/subscriptions/1.xml
  def update
    @admin_subscription = Subscription.find(params[:id])

    respond_to do |format|
      if @admin_subscription.update_attributes(params[:subscription])
        format.html { redirect_to(admin_subscription_path(@admin_subscription), :notice => 'Subscription was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @admin_subscription.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/subscriptions/1
  # DELETE /admin/subscriptions/1.xml
  def destroy
    @admin_subscription = Subscription.find(params[:id])
    @admin_subscription.destroy

    respond_to do |format|
      format.html { redirect_to(admin_subscriptions_url) }
      format.xml  { head :ok }
    end
  end
end
