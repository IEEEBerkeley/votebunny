class AdminController < ApplicationController
  before_filter :set_current_user, :only_admin
  before_filter :set_election, :only => [:show, :new_position, :create_position, :new_candidate, :create_candidate, :create_user]
  before_filter :set_position, :only => [:new_candidate, :create_candidate]

  def index
    @elections = Election.all
  end

  def show
    @positions = {}
    @num_ranks = {}
    @election.positions.each do |position|
      @positions[position.title] = Vote.count_votes(position)
      @num_ranks[position.title] = [3,position.candidates.count].min
    end
  end

  def new_election
  end

  def new_position
  end

  def new_candidate
  end

  def create_election
    e = Election.new(params[:election])
    if e.save
      @user.elections << e
      flash[:notice] = "New election created!"
      redirect_to election_path(e.id) and return
    else
      flash[:error] = "Whoops, couldn't create a new election!"
      redirect_to new_election_path and return
    end
  end

  def create_position
    p = Position.new(params[:position])
    p.election = @election
    if p.save
      flash[:notice] = "New position created!"
      redirect_to election_path(@election.id) and return
    else
      flash[:error] = "Whoops, couldn't create a new position!"
      redirect_to new_position_path and return
    end
  end

  def view_users
    @users=User.for_election(params[:eid]).non_admins
  end

  # this does not create a candidate that allows for other positions
  def create_candidate
    c = Candidate.new(params[:candidate])
    c.election = @election
    c.positions << @position
    if c.save
      flash[:notice] = "New candidate created!"
      redirect_to position_path(@election.id, @position.id) and return
    else
      flash[:error] = "Whoops, couldn't create a new position!"
      redirect_to new_position_path and return
    end
  end

  def create_user
    u = User.new
    pwd = ""
    5.times{pwd << (65 + rand(50)).chr}
    u.password = pwd
    u.elections << @election
    if u.save
      flash[:notice] = "New user created with password " + pwd
      redirect_to election_path(@election.id) and return
    else
      flash[:error] = "Whoops, couldn't create a new user!"
      redirect_to new_position_path and return
    end
  end
end
