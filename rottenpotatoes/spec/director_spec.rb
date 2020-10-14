require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  	let(:movie) { Movie.create(director: 'match') }
  	let(:nilMovie) { Movie.create }

  	describe "GET similar" do
  		before(:each) do
	    	movie
    		5.times { Movie.create(director: 'match') }
  		end
		context "when we run the same director method five times" do
	    	it "should not crash" do
	      		expect(Movie).to receive(:find).with(movie.id.to_s).and_return(movie)
	      		get :similar, id: movie.id
	    	end
	    	it "should finds the other 5 movies we created" do
	      		get :similar, id: movie.id
	      		expect(assigns(:movies).size).to eq(5)
	    	end
	    end
		context "when we run the similar method for a movie witout director" do
	    	it "it will yield an error" do
	      		get :similar, id: nilMovie.id
	      		expect(flash[:notice]).to eq('\'\' has no director info')
	   		end
	   	end
  	end
  	
  	describe "Create movie" do
  		let(:post_create_movie) { post :create, movie: {title: "Testing", rating: "R", description: "dummy", release_date: 10.years.ago, director: "Someone"} }
  		context "when we try to create a valid movie" do
	    	it "should be redirected to in the index page" do
	      		expect(post_create_movie).to redirect_to('/movies')
	    	end
	    	it "should show a success message in flash" do
	    		post_create_movie
	    		expect(flash[:notice]).to eq('Testing was successfully created.')
	    	end
	    end
  	end
  	
  	describe "Destroy movie" do
  		let(:post_create_movie) {post :create, movie: {title: "Testing", rating: "R", description: "dummy", release_date: 10.years.ago, director: "Someone"} }
  		let(:delete_destroy_movie) {delete :destroy, id:1}
  		context "when we create a movie and delete it immediately" do
  			it "should redirect to the index page" do
	      		post_create_movie
	      		expect(delete_destroy_movie).to redirect_to('/movies')
	    	end
	    	it "should show a failed message in flash" do
	    		post_create_movie
	    		delete_destroy_movie
	    		expect(flash[:notice]).to eq('Movie \'Testing\' deleted.')
	    	end
  		end
  	end
end