require 'rails_helper'

RSpec.describe "videogames/show", type: :view do
  before(:each) do
    @videogame = assign(:videogame, Videogame.create!(
      game_name: "Game Name",
      developer: "Developer",
      number_of_players: 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Game Name/)
    expect(rendered).to match(/Developer/)
    expect(rendered).to match(/2/)
  end
end
