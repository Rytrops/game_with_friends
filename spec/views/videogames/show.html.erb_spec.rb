require 'rails_helper'

RSpec.describe "videogames/show", type: :view do
  before(:each) do
    @videogame = assign(:videogame, Videogame.create!(
      game_: "Game ",
      name: "Name",
      developer: "Developer",
      game_type: "Game Type",
      number_of_players: ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Game /)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Developer/)
    expect(rendered).to match(/Game Type/)
    expect(rendered).to match(//)
  end
end
