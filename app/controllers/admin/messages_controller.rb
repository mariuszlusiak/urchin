class Admin::MessagesController < ApplicationController
  # GET /admin/messages
  # GET /admin/messages.xml
  def index
    @admin_messages = Message.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_messages }
    end
  end

  # GET /admin/messages/1
  # GET /admin/messages/1.xml
  def show
    @admin_message = Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @admin_message }
    end
  end

  # GET /admin/messages/new
  # GET /admin/messages/new.xml
  def new
    @admin_message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @admin_message }
    end
  end

  # GET /admin/messages/1/edit
  def edit
    @admin_message = Message.find(params[:id])
  end

  # POST /admin/messages
  # POST /admin/messages.xml
  def create
    @admin_message = Message.new(params[:admin_message])

    respond_to do |format|
      if @admin_message.save
        format.html { redirect_to(@admin_message, :notice => 'Message was successfully created.') }
        format.xml  { render :xml => @admin_message, :status => :created, :location => @admin_message }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @admin_message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/messages/1
  # PUT /admin/messages/1.xml
  def update
    @admin_message = Message.find(params[:id])

    respond_to do |format|
      if @admin_message.update_attributes(params[:admin_message])
        format.html { redirect_to(@admin_message, :notice => 'Message was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @admin_message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/messages/1
  # DELETE /admin/messages/1.xml
  def destroy
    @admin_message = Message.find(params[:id])
    @admin_message.destroy

    respond_to do |format|
      format.html { redirect_to(admin_messages_url) }
      format.xml  { head :ok }
    end
  end
end
