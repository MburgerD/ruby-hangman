require_relative '../controller.rb'


RSpec.describe GameController do 

  describe "#play" do
    it "continues until the game is over" do
      model_double = double("model_double", :setup => nil)
      allow(model_double).to receive(:game_over).and_return(false, false, false, true)
      view_double = double("view_double")

      controller = GameController.new(model_double, view_double)
      allow(controller).to receive(:take_turn)
      expect(controller).to receive(:take_turn).exactly(3).times

      controller.play
    end
  end

end 