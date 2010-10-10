class Admin::PackagesController < ApplicationController
  # GET /admin/packages
  # GET /admin/packages.xml
  def index
    @admin_packages = Package.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_packages }
    end
  end

  # GET /admin/packages/1
  # GET /admin/packages/1.xml
  def show
    @admin_package = Package.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @admin_package }
    end
  end

  # GET /admin/packages/new
  # GET /admin/packages/new.xml
  def new
    @admin_package = Package.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @admin_package }
    end
  end

  # GET /admin/packages/1/edit
  def edit
    @admin_package = Package.find(params[:id])
  end

  # POST /admin/packages
  # POST /admin/packages.xml
  def create
    @admin_package = Package.new(params[:package])

    respond_to do |format|
      if @admin_package.save
        format.html { redirect_to(admin_package_path(@admin_package), :notice => 'Package was successfully created.') }
        format.xml  { render :xml => @admin_package, :status => :created, :location => @admin_package }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @admin_package.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/packages/1
  # PUT /admin/packages/1.xml
  def update
    @admin_package = Package.find(params[:id])

    respond_to do |format|
      if @admin_package.update_attributes(params[:package])
        format.html { redirect_to(admin_package_path(@admin_package), :notice => 'Package was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @admin_package.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/packages/1
  # DELETE /admin/packages/1.xml
  def destroy
    @admin_package = Package.find(params[:id])
    @admin_package.destroy

    respond_to do |format|
      format.html { redirect_to(admin_packages_url) }
      format.xml  { head :ok }
    end
  end
end
