class GroupsController < ApplicationController
  before_filter :require_user
  
  # GET /groups
  # GET /groups.xml
  def index
    @active_groups = Group.find(:all, :conditions => {:active => true })
    @inactive_groups = Group.find(:all, :conditions => {:active => false })

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.xml
  def show
    @group = Group.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @group }
    end
  end

  # GET /groups/new
  # GET /groups/new.xml
  def new
    @group = Group.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
  end

  def mark_inactive
    group_id = params[:id]
    g = Group.find_by_id(group_id)
    g.active = false

    respond_to do |format|
      if g.save
        flash[:notice] = 'Group was successfully updated.'
        format.html { redirect_to(groups_url) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def mark_active
    group_id = params[:id]
    g = Group.find_by_id(group_id)
    g.active = true

    respond_to do |format|
      if g.save
        flash[:notice] = 'Group was successfully updated.'
        format.html { redirect_to(groups_url) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # POST /groups
  # POST /groups.xml
  def create
    @group = Group.new(params[:group])

    respond_to do |format|
      if @group.save
        flash[:notice] = 'Group was successfully created.'
        format.html { redirect_to(@group) }
        format.xml  { render :xml => @group, :status => :created, :location => @group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.xml
  def update
    @group = Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        flash[:notice] = 'Group was successfully updated.'
        format.html { redirect_to(@group) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.xml
  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to(groups_url) }
      format.xml  { head :ok }
    end
  end
end
