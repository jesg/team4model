class BugsController < ApplicationController
  # GET /bugs
  # GET /bugs.xml
  def index
    @bugs = Bug.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bugs }
    end
  end

  # GET /bugs/1
  # GET /bugs/1.xml
  def show
    @bug = Bug.find(params[:id])

    respond_to do |format|
      format.html  { render :layout => false }
      format.xml  { render :xml => @bug }
    end
  end

  # GET /bugs/new
  # GET /bugs/new.xml
  def new
    @bug = Bug.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bug }
    end
  end

  # POST /bugs
  # POST /bugs.xml
  def create
    @bug = Bug.new(params[:bug])

    respond_to do |format|
      if @bug.save
        flash[:notice] = 'Bug was successfully created.'
        format.html { redirect_to(bugs_url) }
        format.xml  { render :xml => @bug, :status => :created, :location => @bug }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bug.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /bugs/1/edit
  def edit
    @bug = Bug.find(params[:id])
  end

  # PUT /bugs/1
  # PUT /bugs/1.xml
  def update
    @bug = Bug.find(params[:id])

    respond_to do |format|
      if @bug.update_attributes(params[:bug])
        format.html { render :nothing => true }
        format.xml  { head :ok }
      else
        format.html { render :nothing => true, :status => :unprocessable_entity }
        format.xml  { render :xml => @bug.errors, :status => :unprocessable_entity }
      end
    end
  end
end
