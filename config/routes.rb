Rails.application.routes.draw do
  # Routes for the Zebra resource:

  # CREATE
  post("/insert_zebra", { :controller => "zebras", :action => "create" })
          
  # READ
  get("/zebras", { :controller => "zebras", :action => "index" })
  
  get("/zebras/:path_id", { :controller => "zebras", :action => "show" })
  
  # UPDATE
  
  post("/modify_zebra/:path_id", { :controller => "zebras", :action => "update" })
  
  # DELETE
  get("/delete_zebra/:path_id", { :controller => "zebras", :action => "destroy" })

  #------------------------------

  get("/", { :controller => "quizzes", :action => "index" })


  # Routes for the Message resource:

  # CREATE
  post("/insert_message", { :controller => "messages", :action => "create" })
          
  # READ
  get("/messages", { :controller => "messages", :action => "index" })
  
  get("/messages/:path_id", { :controller => "messages", :action => "show" })
  
  # UPDATE
  
  post("/modify_message/:path_id", { :controller => "messages", :action => "update" })
  
  # DELETE
  get("/delete_message/:path_id", { :controller => "messages", :action => "destroy" })

  #------------------------------

  # Routes for the Quiz resource:

  # CREATE
  post("/insert_quiz", { :controller => "quizzes", :action => "create" })
          
  # READ
  get("/quizzes", { :controller => "quizzes", :action => "index" })
  
  get("/quizzes/:path_id", { :controller => "quizzes", :action => "show" })
  
  # UPDATE
  
  post("/modify_quiz/:path_id", { :controller => "quizzes", :action => "update" })
  
  # DELETE
  get("/delete_quiz/:path_id", { :controller => "quizzes", :action => "destroy" })

  #------------------------------

  # This is a blank app! Pick your first screen, build out the RCAV, and go from there. E.g.:

  # get "/your_first_screen" => "pages#first"
  
end
