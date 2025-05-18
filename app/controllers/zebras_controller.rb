class ZebrasController < ApplicationController
  def index
    matching_zebras = Zebra.all

    @list_of_zebras = matching_zebras.order({ :created_at => :desc })

    render({ :template => "zebras/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_zebras = Zebra.where({ :id => the_id })

    @the_zebra = matching_zebras.at(0)

    render({ :template => "zebras/show" })
  end

  def create
    the_zebra = Zebra.new
    the_zebra.name = params.fetch("query_name")
    the_zebra.age = params.fetch("query_age")

    if the_zebra.valid?
      the_zebra.save
      redirect_to("/zebras", { :notice => "Zebra created successfully." })
    else
      redirect_to("/zebras", { :alert => the_zebra.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_zebra = Zebra.where({ :id => the_id }).at(0)

    the_zebra.name = params.fetch("query_name")
    the_zebra.age = params.fetch("query_age")

    if the_zebra.valid?
      the_zebra.save
      redirect_to("/zebras/#{the_zebra.id}", { :notice => "Zebra updated successfully."} )
    else
      redirect_to("/zebras/#{the_zebra.id}", { :alert => the_zebra.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_zebra = Zebra.where({ :id => the_id }).at(0)

    the_zebra.destroy

    redirect_to("/zebras", { :notice => "Zebra deleted successfully."} )
  end
end
