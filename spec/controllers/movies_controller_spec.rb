require 'spec_helper'

describe MoviesController do
  describe 'edit' do
    before :each do
      @fake_results = [mock('Movie')]
    end
    it 'should get the data for the movie from the Movie table' do
      Movie.should_receive(:find).with('3').and_return(@fake_results)
      post :edit, {:id => 3}      
    end
    describe 'after getting the data for the movie' do
      before :each do
        Movie.stub(:find).and_return(@fake_results)
        post :edit, {:id => 3}
      end
      it 'should select the edit template for rendering' do
        response.should render_template('edit')
      end
      it 'should make the data for the movie available to that template' do
        assigns(:movie).should == @fake_results
      end
    end    
  end 
end